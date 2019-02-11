class Account < ApplicationRecord
  has_one :activation, class_name: 'AccountActivation'
  has_one :deactivation, class_name: 'AccountDeactivation'
  has_one :ban, class_name: 'AccountBan'
  has_one :active_suspension, lambda { where(removed_at: nil) }, class_name: 'AccountSuspension'

  has_many :suspensions, class_name: 'AccountSuspension'
end
