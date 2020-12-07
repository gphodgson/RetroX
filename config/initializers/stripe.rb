Rails.configuration.stripe = {
  P_KEY: ENV["P_KEY"],
  S_KEY: ENV["S_KEY"]
}

Stripe.api_key = Rails.configuration.stripe[:S_KEY]
