# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      user = User.find_for_google_oauth2(request.env['omniauth.auth'])
      redirect_to 'http://google.com' if user.blank?

      flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                              kind: 'Google')
      sign_in_and_redirect user, event: :authentication
    end

    def after_omniauth_failure_path_for(_scope)
      'http://google.com'
    end
  end
end
