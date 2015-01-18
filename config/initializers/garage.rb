Garage.configure {}
Garage::TokenScope.configure {}

Doorkeeper.configure do
  orm :active_record
  default_scopes :public
  optional_scopes(*Garage::TokenScope.optional_scopes)
end
