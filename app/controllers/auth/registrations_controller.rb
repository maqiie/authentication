
# class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  

#   def create
#     super do |user|
#       # After creating the user, check if it's the first user and make them an admin
#       if User.count == 1
#         user.update(role: 'admin')
#       end
#     end
#   end
#   private

#   def sign_up_params
#     params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname)
#   end
  
#   end
  
class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  include Devise::Controllers::Helpers
  include Devise::Controllers::UrlHelpers
  
  # Override the create method to handle 2FA setup after registration
  def create
    super do |resource|
      # Check if the resource was successfully created
      if resource.persisted?
        # Initiate the 2FA setup process if it's required for login
        resource.send_new_otp if resource.otp_required_for_login
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname)
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :nickname])
  end
end
