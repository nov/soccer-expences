class AccountsController < ApplicationController
  def index
    @accounts = Account.order(:id)
  end
end
