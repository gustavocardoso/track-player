# config/initializers/active_storage.rb
Rails.application.config.after_initialize do
  ActiveStorage::Current.url_options = {
    host: Rails.application.routes.default_url_options[:host],
    protocol: Rails.application.routes.default_url_options[:protocol]
  }
end
