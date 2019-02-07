class User < ApplicationRecord
  include AASM

  has_one :activation, class_name: 'UserActivation'
  has_one :deactivation, class_name: 'UserDeactivation'
  has_one :ban, class_name: 'UserBan'
  has_one :active_suspension, lambda { where(removed_at: nil) }, class_name: 'UserSuspension'

  has_many :suspensions, class_name: 'UserSuspension'

  aasm do
    state :registered, :initial => true
    state :active, :suspended, :banned, :inactive

    # after内でのError発生時のロールバックは実装していない

    event :activate do
      transitions from: :registered, to: :active, guard: :build_activation
      after do
        create_activation!
      end
    end

    event :suspend do
      transitions from: :active, to: :suspended, guard: :without_active_suspension?
      after do
        suspensions.create!
      end
    end

    event :unsuspend do
      transitions from: :suspended, to: :active, guard: :active_suspension
      after do
        active_suspension.update!(removed_at: Time.current)
      end
    end

    event :ban do
      transitions from: [:active, :suspended], to: :banned, guard: :build_ban
      after do
        create_ban!
      end
    end

    event :deactivate do
      transitions from: [:active, :suspended], to: :inactive, guard: :build_deactivation
      after do
        create_deactivation!
      end
    end
  end

  def without_active_suspension?
    return false if active_suspension
    true
  end
end
