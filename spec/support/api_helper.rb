module ApiHelper
  def sget(user, path)
    send(:get, path, headers: { 'Authorization' => "Bearer #{user.auth_token}" })
  end

  def spost(user, path, params)
    post path, params: params, headers: { 'Authorization' => "Bearer #{user.auth_token}" }
  end

  def json
    JSON.parse(response.body)
  end
end