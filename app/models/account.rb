class Account < ActiveRecord::Base
  has_one :facebook, class_name: 'Connect::Facebook'
end
