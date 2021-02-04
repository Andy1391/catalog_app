# object @user

# attributes :id, :email

object false

child(@user => :user) do
  attributes :id, :email
end
child(@access_token => :access_token) do
  attributes :token, :expires_in
end

# node(:access_token) { @access_token.token, expires_in}