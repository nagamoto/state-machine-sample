class User < ApplicationRecord
  has_one :detail, class_name: 'UserDetail'
  has_one :close, class_name: 'UserClose'
  has_one :ban, class_name: 'UserBan'

  has_many :suspensions, class_name: 'UserSuspension'
  has_many :authentication_requests, class_name: 'UserAuthenticationRequest'
end
