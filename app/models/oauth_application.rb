class OauthApplication < ApplicationRecord
  validates :redirect_url, :name, presence: true
  validates :uid, presence: true, uniqueness: true
end
