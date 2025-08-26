module RequestAuthHelper
  # Siempre manda JSON real y acepta JSON
  def auth_headers_for(user)
    user.create_new_auth_token.merge(
      "ACCEPT"       => "application/json",
      "CONTENT_TYPE" => "application/json"
    )
  end
end