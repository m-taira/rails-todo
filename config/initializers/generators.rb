Rails.application.config.generators do |g|
  g.test_framework :rspec
  g.view_spec false
  g.routing_specs false
  g.helper_specs false
  g.fixture_replacement :factory_girl, dir: 'spec/factories'
end
