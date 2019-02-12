class Account < ApplicationRecord
  has_one :activation, class_name: 'AccountActivation'
  has_one :deactivation, class_name: 'AccountDeactivation'
  has_one :ban, class_name: 'AccountBan'
  has_one :active_suspension, lambda { where(removed_at: nil) }, class_name: 'AccountSuspension'

  has_many :suspensions, class_name: 'AccountSuspension'

  enum status: { registered: 0, active: 1, suspended: 2, banned: 3, inactive: 4 } do
    event :activate do
      before do
        create_activation!
      end
      transition :registered => :active
    end

    event :suspend do
      before do
        suspensions.create!
      end
      transition :active => :suspended, unless: -> { active_suspension }
    end

    event :unsuspend do
      before do
        active_suspension.update!(removed_at: Time.current)
      end
      transition :suspended => :active, if: -> { active_suspension }
    end

    event :ban do
      before do
        create_ban!
      end
      transition [:active, :suspended] => :banned
    end

    event :deactivate do
      before do
        create_deactivation!
      end
      transition [:active, :suspended] => :inactive
    end
  end
end
