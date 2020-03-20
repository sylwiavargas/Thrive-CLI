class Tip < ActiveRecord::Base
  has_many :directories
  has_many :users, through: :directories

end
