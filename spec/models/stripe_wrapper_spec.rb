require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    #instance method u use the #the_method and for custom-method: .my_method
    describe '.create' do
      it 'makes a succesful charge', :vcr do
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = Stripe::Token.create(
            :card => {
                :number => "4242424242424242",
                :exp_month => 12,
                :exp_year => 2018,
                :cvc => "314"
            }
        ).id

        response = StripeWrapper::Charge.create(
            amount: 999,
            card: token,
            description: 'a valid charge'
        )

        #expect(response.amount).to eq(999)
        #expect(response.currency).to eq('usd')
        expect(response).to be_successful
      end

      it 'makes a card declined charges', :vcr do
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = Stripe::Token.create(
            :card => {
                :number => "4000000000000002",
                :exp_month => 12,
                :exp_year => 2018,
                :cvc => "314"
            }
        ).id

        response = StripeWrapper::Charge.create(
            amount: 999,
            card: token,
            description: 'a invalid charge'
        )

        expect(response).not_to be_successful

      end

      it 'returns the error-message for declined charges', :vcr do
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = Stripe::Token.create(
            :card => {
                :number => "4000000000000002",
                :exp_month => 12,
                :exp_year => 2018,
                :cvc => "314"
            }
        ).id

        response = StripeWrapper::Charge.create(
            amount: 999,
            card: token,
            description: 'a invalid charge'
        )

        expect(response.error_message).to eq('Your card was declined.')

      end

    end
  end
end