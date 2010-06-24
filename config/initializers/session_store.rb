# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lister_session',
  :secret      => '18e86ca49da6bc90ea517b2b34cd3095a6c2f5635b97b92dd8969b18ea3271f37bf2f30b243a8fd8d6b257eae7a77352f44bffafb50c788c42f6934376f951c2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
