class ApplicationController < ActionController::API
  def secret_key
    'b3@utifu1_1ife'
  end

  def encode(payload)
    #returns a token
    JWT.encode(payload, secret_key, 'HS256')
  end

  def decode(token)
    #returns payload
    JWT.decode(token, secret_key, true, {algorithm: 'HS256'})[0]
  end

  def api_key
    key = Rails.application.credentials.development[:movies_secret_key_base]
  end
  
end
