class User < ApplicationRecord
  has_one :detail, class_name: 'UserDetail'
  has_one :close, class_name: 'UserClose'
  has_one :ban, class_name: 'UserBan'

  has_many :suspensions, class_name: 'UserSuspension'
  has_many :authentication_requests, class_name: 'UserAuthenticationRequest'


  def status
    return 'activated' if activated?
    return 'suspended' if suspended?
    return 'banned' if banned?
    return 'closed' if closed?
    return 'registered'
  end

  def activated?
    return false unless detail.present?
    return false if suspended? || banned? || closed?
    true
  end

  def not_authenticated?
    !authenticated?
  end

  def authentication_requested?
    authentication_requests.exists?
  end

  def authenticated?
    authentication_requests.where.not(authenticated_at: nil).exists?
  end

  def suspended?
    suspensions.where(removed_at: nil).exists?
  end

  def banned?
    ban.present?
  end

  def closed?
    ban.present?
  end
end
