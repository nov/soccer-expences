class Account::ViewersController < ApplicationController
  before_action :require_admin_access
  before_action :require_account_context

  def create
    @account.approve!
    redirect_to accounts_url, flash: {
      success: 'flash.update.success'.t
    }
  end
end
