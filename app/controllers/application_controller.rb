class ApplicationController < ActionController::Base
        # before_action :authenticate_user!
        skip_before_action :verify_authenticity_token

        include DeviseTokenAuth::Concerns::SetUserByToken

        rescue_from CanCan::AccessDenied do |exception|
                redirect_to root_path, alert: "Access denied."
              end
              protected

              def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
              end
end
