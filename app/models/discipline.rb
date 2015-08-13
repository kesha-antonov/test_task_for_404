# == Schema Information
#
# Table name: disciplines
#
#  id         :integer          not null, primary key
#  name       :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Discipline < ActiveRecord::Base

  has_many :semesters_disciplines, dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: true

end
