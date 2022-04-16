module Api
    class PaymentsController < ApiController
    before_action :authenticate_api_user!

    def create
        @payment = current_user.payments.build(payment_params)
        @payment.set_expiration_date(params[:expiration_date])

        if @payment.save
            render json: @payment, status: :created
        else
            render_resource_error_message(@payment)
        end
    end

    private

    def payment_params
        params.permit(:name, :card_number)
    end

    end
   
end