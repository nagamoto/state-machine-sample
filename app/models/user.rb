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

  def active?
    return false unless activation.present?
    return false if suspended? || banned? || deactive?
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
    create_activation!
  end

  def suspend!
    suspensions.create!
  end

  def ban!
    create_ban!
  end

  def deactivate!
    create_deactivation!
  end
end
