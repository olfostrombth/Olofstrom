OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1050237569948-u2lbjttpbafobjd34bu9859aodhrftkc.apps.googleusercontent.com', 'yNKmshIuxNZGjQxuQ5k4q14A', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end