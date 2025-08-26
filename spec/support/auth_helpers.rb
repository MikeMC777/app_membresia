# spec/support/auth_helpers.rb
module AuthHelpers
  # Construye headers JSON + Devise‐Token‐Auth para el user dado
  def auth_headers_for(user)
    user.create_new_auth_token.merge(
      'Accept'       => 'application/json',
      'Content-Type' => 'application/json'
    )
  end
end

RSpec.configure do |config|
  # Lo incluimos solo en specs de request
  config.include AuthHelpers, type: :request
end
