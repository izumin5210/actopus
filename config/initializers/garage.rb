Garage.configure {}

Garage::TokenScope.configure do
  register :public, desc: 'accessing publicly available data' do
    access :read, Lecture
    access :read, Klass
    access :read, Rescheduling
  end

  register :write_rescheduling, desc: 'writing rescheduling' do
    access :write, Rescheduling
  end
end

Doorkeeper.configure do
  orm :active_record
  default_scopes :public
  optional_scopes(*Garage::TokenScope.optional_scopes)

  resource_owner_authenticator do
    current_staff || warden.authenticate!(scope: :staff)
  end

  skip_authorization do |_resource_owner, client|
    client.uid == Settings.oauth.application.uid
  end

  grant_flows %w(implicit)
end
