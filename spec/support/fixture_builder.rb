FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]

  fbuilder.factory do
    @zoe = Authentication.create(email: 'zbarnes@slugline.com', password: 'frankyPanky', password_confirmation: 'frankyPanky')
  end
end
