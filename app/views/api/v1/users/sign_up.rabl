node(:access_token) { @access_token.token }

child @user => :user do
  attributes :id, :email
end
