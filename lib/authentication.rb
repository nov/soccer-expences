module Authentication
  extend ActiveSupport::Concern

  class AuthenticationRequired  < StandardError; end
  class ApprovedAccessRequired  < StandardError; end
  class AdminAccessRequired     < StandardError; end
  class AnonymousAccessRequired < StandardError; end

  included do
    include Authentication::Helper
    before_action :optional_authentication
    rescue_from AuthenticationRequired,  with: :authentication_required!
    rescue_from ApprovedAccessRequired,  with: :approved_access_required!
    rescue_from AdminAccessRequired,     with: :admin_access_required!
    rescue_from AnonymousAccessRequired, with: :anonymous_access_required!
  end

  module Helper
    def current_account
      @current_account
    end

    def authenticated?
      current_account.present?
    end

    def approved_access?
      current_account.try(:approved?)
    end

    def admin_access?
      current_account.try(:admin?)
    end
  end

  def authentication_required!(e)
    redirect_to root_url, flash: {
      warning: e.message || 'Authentication Required'
    }
  end

  def approved_access_required!(e)
    redirect_to dashboard_url, flash: {
      warning: e.message || 'Access Approval Required'
    }
  end

  def admin_access_required!(e)
    redirect_to dashboard_url, flash: {
      warning: e.message || 'Admin Access Required'
    }
  end

  def anonymous_access_required!(e)
    redirect_to dashboard_url
  end

  def optional_authentication
    if session[:current_account]
      authenticate Account.find_by_id(session[:current_account])
    end
  rescue ActiveRecord::RecordNotFound
    unauthenticate!
  end

  def require_authentication
    unless authenticated?
      session[:after_logged_in_endpoint] = request.url if request.get?
      raise AuthenticationRequired.new
    end
  end

  def require_approved_access
    require_authentication
    raise ApprovedAccessRequired.new unless approved_access?
  end

  def require_admin_access
    require_authentication
    raise AdminAccessRequired.new unless admin_access?
  end

  def require_anonymous_access
    raise AnonymousAccessRequired.new if authenticated?
  end

  def authenticate(account)
    if account
      @current_account = account
      session[:current_account] = account.id
    end
  end

  def unauthenticate!
    @current_account = session[:current_account] = nil
  end

  def logged_in!
    current_account.update_attributes(last_logged_in_at: Time.now.utc)
    redirect_to after_logged_in_endpoint
  end

  def after_logged_in_endpoint
    session.delete(:after_logged_in_endpoint) || dashboard_url
  end
end