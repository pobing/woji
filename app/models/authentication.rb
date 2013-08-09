# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid
  validates :provider,:presence => true,:uniqueness => {:scope=> :user_id }
  validates :uid,:presence => true,:uniqueness => {:scope=> :provider }
  belongs_to :user
end
