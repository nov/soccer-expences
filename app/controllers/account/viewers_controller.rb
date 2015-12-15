class Account::ViewersController < ApplicationController
  before_filter :require_admin_access
  before_filter :require_account_context

  def create
    @account.approve!
    redirect_to accounts_url, flash: {
      success: 'flash.update.success'.t
    }
  end
end
