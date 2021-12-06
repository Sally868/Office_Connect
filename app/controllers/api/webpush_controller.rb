module Api
  class WebpushController < ActionController::Base
    protect_from_forgery with: :null_session
    acts_as_token_authentication_handler_for User, fallback: :exception

    ActionController::Parameters.permit_all_parameters = true

    def subscribe
      subscription = WebpushSubscription.find_by(user: current_user)
      if subscription
        subscription.update(
          endpoint: params[:subscription][:endpoint],
          p256dh: params[:subscription][:keys][:p256dh],
          auth: params[:subscription][:keys][:auth]
        )
      else
        WebpushSubscription.create!(
          user_id: current_user.id,
          endpoint: params[:subscription][:endpoint],
          p256dh: params[:subscription][:keys][:p256dh],
          auth: params[:subscription][:keys][:auth]
        )
      end
      render plain: '""'
    end
  end
end
