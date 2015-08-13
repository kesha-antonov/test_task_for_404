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

end