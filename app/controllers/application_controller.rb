class ApplicationController < ActionController::Base

    helper_method :admin?
    def admin?
      current_user && current_user.admin?
    end

end