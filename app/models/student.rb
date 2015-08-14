# == Schema Information
#
# Table name: students
#
#  id            :integer          not null, primary key
#  first_name    :string
#  last_name     :string
#  study_group   :string
#  birthday      :date
#  email         :string
#  ip            :string
#  registered_at :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Student < ActiveRecord::Base

  has_many :semesters, dependent: :destroy
  accepts_nested_attributes_for :semesters, allow_destroy: true
  has_many :semesters_disciplines, through: :semesters
  has_many :disciplines, through: :semesters_disciplines

  validates :first_name,
            :last_name,
            :study_group,
            :birthday,
            :email,
            :ip,
            :registered_at,
    presence: true

  scope :with_name, lambda { |value| where("(lower(first_name) || ' ' || lower(last_name)) like ?", "%#{value}%".downcase) if value.present? }
  scope :with_group, lambda { |value| where('lower(study_group) like ?', "%#{value}%".downcase) if value.present? }
  scope :with_semester_name, lambda{ |value| joins(:semesters).where('lower(semesters.name) like ?', "%#{value}%".downcase) if value.present? }
  scope :with_avg_mark_down, lambda{ |value| joins(:semesters).where('semesters.avg_mark >= ?', value) if value.present? }
  scope :with_avg_mark_up, lambda{ |value| joins(:semesters).where('semesters.avg_mark <= ?', value) if value.present? }

end
