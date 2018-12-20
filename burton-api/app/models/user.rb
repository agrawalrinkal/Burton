class User < ActiveRecord::Base
  # Include default devise modules.
  # devise :database_authenticatable, :registerable,
  #         :recoverable, :rememberable, :trackable, :validatable,
  #         :confirmable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  devise :rememberable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :books
  has_many :bookmarks


end
