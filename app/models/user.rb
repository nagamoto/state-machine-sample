class User < ApplicationRecord
  has_one :activation, class_name: 'UserActivation'
  has_one :deactivation, class_name: 'UserDeactivation'
  has_one :ban, class_name: 'UserBan'

  has_many :suspensions, class_name: 'UserSuspension'

  def status
    return 'active' if active?
    return 'suspended' if suspended?
    return 'banned' if banned?
    return 'inactive' if inactive?
    return 'registered'
  end

  def registered?
    return false if suspended? || banned? || inactive? || active?
    true
  end

  def active?
    return false if suspended? || banned? || inactive?
    return false unless activation.present?
    true
  end

  def suspended?
    suspensions.where(removed_at: nil).exists?
  end

  def banned?
    ban.present?
  end

  def inactive?
    deactivation.present?
  end

  def activate!
    raise StandardError unless registered? # 理想は独自例外
    create_activation!
  end

  def suspend!
    raise StandardError unless active? # 理想は独自例外
    suspensions.create!
  end

  def ban!
    raise StandardError unless active? # 理想は独自例外
    create_ban!
  end

  def deactivate!
    raise StandardError unless active? # 理想は独自例外
    create_deactivation!
  end
end
