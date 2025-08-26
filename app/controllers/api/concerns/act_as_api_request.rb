# app/controllers/api/concerns/act_as_api_request.rb
module Api
  module Concerns
    module ActAsApiRequest
      extend ActiveSupport::Concern

      included do
        include Pundit::Authorization
        before_action :authenticate_user!
        before_action :ensure_json_format
        # … el resto de rescue_from y demás …
      end

      private

      def ensure_json_format
        return if request.format.json?
        render json: { error: "Invalid format; only JSON is allowed" },
               status: :not_acceptable
      end
    end
  end
end
