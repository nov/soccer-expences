class Account < ActiveRecord::Base
  has_one :facebook, class_name: 'Connect::Facebook'
  validates :email, presence: true

  def admin!
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
