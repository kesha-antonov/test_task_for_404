# == Schema Information
#
# Table name: semesters_disciplines
#
#  id            :integer          not null, primary key
#  semester_id   :integer
#  discipline_id :integer
#  mark          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SemestersDiscipline < ActiveRecord::Base

  belongs_to :semester, counter_cache: :disciplines_count
  belongs_to :discipline

  validates :semester_id,
            :discipline_id,
            :mark,
    presence: true


  after_create :update_avg_mark,
    on: :commit
  after_update :update_avg_mark,
    on: :commit
  after_destroy :update_avg_mark,
    on: :commit

  protected

    def update_avg_mark
      SemestersDiscipline.transaction do
        semester.lock!
        semester.semesters_disciplines.lock(true)

        semester.avg_mark = if semester.disciplines_count.zero?
          0.0
        else
          semester.semesters_disciplines.map(&:mark).sum.to_f / semester.disciplines_count
        end
        semester.save!
      end
    end

end
