# frozen_string_literal: true

# Mailgun configuration
# Configure Mailgun API client for sending emails
#
# Required environment variables:
# - MAILGUN_API_KEY: Your Mailgun API key
# - MAILGUN_DOMAIN: Your Mailgun domain
# - MAILGUN_API_BASE_URL: Mailgun API base URL (optional, defaults to US)

if Rails.env.production? || Rails.env.staging?
  # Configure Action Mailer to use Mailgun
  Rails.application.configure do
    config.action_mailer.delivery_method = :mailgun
    config.action_mailer.mailgun_settings = {
      api_key: ENV['MAILGUN_API_KEY'],
      domain: ENV['MAILGUN_DOMAIN'],
      # Use EU endpoint if needed: 'https://api.eu.mailgun.net'
      api_host: ENV.fetch('MAILGUN_API_BASE_URL', 'https://api.mailgun.net')
    }
  end

  # Initialize Mailgun client for direct API usage if needed
  if ENV['MAILGUN_API_KEY'].present? && ENV['MAILGUN_DOMAIN'].present?
    begin
      MAILGUN_CLIENT = Mailgun::Client.new(
        ENV['MAILGUN_API_KEY'],
        ENV.fetch('MAILGUN_API_BASE_URL', 'https://api.mailgun.net')
      )
      Rails.logger.info "Mailgun client initialized successfully"
    rescue => e
      Rails.logger.error "Failed to initialize Mailgun client: #{e.message}"
      MAILGUN_CLIENT = nil
    end
  else
    Rails.logger.warn "Mailgun credentials not found. Email delivery may not work in production."
    MAILGUN_CLIENT = nil
  end
else
  # Development/test environment - log emails instead of sending
  Rails.logger.info "Mailgun disabled in #{Rails.env} environment"
  MAILGUN_CLIENT = nil
end