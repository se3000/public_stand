FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]

  fbuilder.factory do
    @zoes_auth = Authentication.create(email: 'zbarnes@slugline.com', password: 'frankyPanky', password_confirmation: 'frankyPanky')
    @zoe = User.create(first_name: "Zoe", last_name: "Barnes", phone_number: "(518)334-6656", zip_code: 11211)
  end
end
