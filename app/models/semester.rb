# == Schema Information
#
# Table name: semesters
#
#  id             :integer          not null, primary key
#  name           :integer          default(1)
#  characteristic :text             default("")
#  avg_mark       :float
#  student_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Semester < ActiveRecord::Base

  belongs_to :student
  has_many :semesters_disciplines, dependent: :destroy

  validates :name,
            :student_id,
    presence: true

end
