# Qwil Ruby Bindings

## Setup

Create an initializer: `config/initializers/qwil.rb`

```
require 'payment_processor/qwil'

PaymentProcessor::Qwil.api_email = ENV['QWIL_API_EMAIL']
PaymentProcessor::Qwil.api_password = ENV['QWIL_API_PASSWORD']
PaymentProcessor::Qwil.api_host = ENV['QWIL_API_HOST']
PaymentProcessor::Qwil.verify_ssl_certs = false if Rails.env.test? || Rails.env.development? || ENV['APP_ENV'] == 'staging'
```

