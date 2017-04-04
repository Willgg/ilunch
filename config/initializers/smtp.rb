ActionMailer::Base.smtp_settings = {
  user_name: ENV['POSTMARK_API_KEY'],
  password: ENV['POSTMARK_API_TOKEN'],
  address: ENV['POSTMARK_SMTP_SERVER'],
  port: 25,
  domain: 'ilunch.fr',
  authentication: 'plain',
  enable_starttls_auto: true
}
