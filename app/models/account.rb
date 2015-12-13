class Account < ActiveRecord::Base
  has_one :facebook, class_name: 'Connect::Facebook'

  def admin!
    self.admin = true
    self.approve!
  end

  def approve!
    self.approved = true
    self.save!
  end
end
