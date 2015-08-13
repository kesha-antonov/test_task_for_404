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

  belongs_to :semester
  belongs_to :discipline

  validates :student_id,
            :semester_id,
            :mark,
    presence: true

end
