class Account < ActiveRecord::Base
  has_one :facebook, class_name: 'Connect::Facebook'
  has_one :google,   class_name: 'Connect::Google'
  validates :display_name, :email, presence: true

  def adminize!
    self.admin = true
    self.approve!
  end

  def approve!
    self.approved = true
    self.save!
  end

  def role
    case
    when admin?
      :admin
    when approved?
      :viewer
    else
      :pending
    end
  end
end
