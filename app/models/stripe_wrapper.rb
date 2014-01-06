module StripeWrapper

  class Charge
    def initialize(response)
      @response = response
    end
    def self.create( options = {} )
      Stripe::Charge.create(
          amount: options[:amount],
          currency: 'usd',
          card: options[:card],
          description: options[:description]
      )
      new(response)

    def successful?
      @response.present?
    end
    end
  end
end