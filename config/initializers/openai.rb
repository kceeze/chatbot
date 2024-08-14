OpenAI.configure do |config|
    config.access_token = ENV.fetch("OPENAI_TOKEN")
    config.log_errors = true 
  end