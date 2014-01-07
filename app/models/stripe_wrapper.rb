  module StripeWrapper
    class Charge

      attr_reader :error_message, :response


      def initialize(options = {})
        @response = options[:response]
        @error_message = options[:error_message]
      end
      def self.create( options = {} )
        begin
          response = Stripe::Charge.create(
              amount: options[:amount],
              currency: 'usd',
              card: options[:card],
              description: options[:description]
          )
          Charge.new(response: response) # the same like just writing: new(response)
        rescue Stripe::CardError => e
          Charge.new(error_message: e.message)
        end
      end

      def successful?
        response.present?  # is this really necessary here?
      end

      #check attr_reader!

      #def error_message
      #  @error_message
      #end

    end
  end



  # the first version of this class
  #class Charge
  #  def initialize(response, error_message)
  #    @response = response
  #    @error_message = error_message
  #  end
  #  def self.create( options = {} )
  #    begin
  #      response = Stripe::Charge.create(
  #          amount: options[:amount],
  #          currency: 'usd',
  #          card: options[:card],
  #          description: options[:description]
  #      )
  #      Charge.new(response, nil) # the same like just writing: new(response)
  #    rescue Stripe::CardError => e
  #      Charge.new(nil, e.message)
  #    end
  #  end
  #
  #  def successful?
  #    @response.present?
  #  end
  #
  #  def error_message
  #    @error_message
  #  end
  #
  #end
