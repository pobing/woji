class Site < ActiveRecord::Base
  attr_accessible :category, :name, :url
  VALID_URL_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  validates :url, presence: true, format: {with: VALID_URL_REGEX},
            uniqueness: true
end
