class Account::AdminsController < ApplicationController
  before_filter :require_admin_access
  before_filter :require_account_context

  def create
    @account.adminize!
    redirect_to accounts_url, flash: {
      success: 'flash.update.success'.t
    }
  end
end
