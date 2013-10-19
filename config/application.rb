# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Chess
  class Application < Rails::Application
    config.generators do |g|    
      g.test_framework :rspec, :fixture => true
      g.fixture_replacement :factory_girl      
      g.view_specs false
      g.helper_specs false
    end
  end
end
