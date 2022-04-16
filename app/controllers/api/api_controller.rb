module Api
    class ApiController < ApplicationController
        include DeviseTokenAuth::Concerns::SetUserByToken

        before_action :set_active_storage_current_host

        helper_method :current_user

        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
        rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

        protected

        def current_user
            current_api_user
        end

        private

        def render_resource_error_message(resource, status = 422)
            render json: {
            errors: resource.errors.full_messages
            }, status: status
        end

        def render_error_message(errors = '', status = 422)
            render json: {
            errors: errors.is_a?(Array) ? errors : [errors]
            }, status: status
        end

        def render_message(message = '', status = 200)
            render json: {
            message: message
            }, status: status
        end

        def render_unprocessable_entity_response(exception)
            render_error_message(exception.record.errors)
        end

        def render_not_found_response(exception)
            render_error_message("Record not found with given ID")
        end

        def set_active_storage_current_host
            ActiveStorage::Current.host = request.base_url
        end
    end
   
end
  