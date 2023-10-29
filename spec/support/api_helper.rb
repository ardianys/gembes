module ApiHelper
  # secure get
  def sget(user, path)
    get path, headers: { 'Authorization' => "Bearer #{user.auth_token}" }
  end

  # secure post
  def spost(user, path, params)
    post path, params: params, headers: { 'Authorization' => "Bearer #{user.auth_token}" }
  end

  def json
    JSON.parse(response.body)
  end
end