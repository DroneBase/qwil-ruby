# Qwil Ruby Bindings

## Setup

Create an initializer: `config/initializers/qwil.rb`

```
require 'qwil'

Qwil.api_email = ENV['QWIL_API_EMAIL']
Qwil.api_password = ENV['QWIL_API_PASSWORD']
Qwil.api_host = ENV['QWIL_API_HOST']
Qwil.verify_ssl_certs = false if Rails.env.test? || Rails.env.development? || ENV['APP_ENV'] == 'staging'
```
