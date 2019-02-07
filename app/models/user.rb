class User < ApplicationRecord
  has_one :activation, class_name: 'UserActivation'
  has_one :deactivation, class_name: 'UserDeactivation'
  has_one :ban, class_name: 'UserBan'

  def status
    return 'active' if active?
    return 'banned' if banned?
    return 'inactive' if active?
    return 'registered'
  end

  def active?
    return false unless activation.present?
    return false if banned? || deactive?
    true
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

  def ban!
    create_ban!
  end

  def deactivate!
    create_deactivation!
  end
end
