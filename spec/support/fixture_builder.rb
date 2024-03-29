Dir[Rails.root.join("spec/factories/**/*.rb")].each { |f| require f }

FixtureBuilder.configure do |fbuilder|
  # rebuild fixtures automatically when these files change:
  fbuilder.files_to_check += Dir["spec/factories/*.rb", "spec/support/fixture_builder.rb"]

  fbuilder.factory do
    @clear_water_initiative = FactoryGirl.create(:organization, name: 'Clear Water Initaitive', description: 'Get wet.')
    @clear_water_campaign = Campaign.create(name: 'Clear Water for Africa', organization: @clear_water_initiative, vanity_string: 'clear-water-africa')

    @gillians_auth = Authentication.create(email: 'gcole@clearwater.org', password: 'claireDontCare', password_confirmation: 'claireDontCare')
    @gillian = User.create(name: "Gillian Cole", authentication: @gillians_auth)
    @gillians_membership = Membership.create(member: @gillian, organization: @clear_water_initiative)

    @zoes_auth = Authentication.create(email: 'zbarnes@slugline.com', password: 'frankyPanky', password_confirmation: 'frankyPanky')
    @zoe = User.create(name: "Zoe Barnes", phone_number: "5183346656", zip_code: 11211, authentication: @zoes_auth)

    @claire = Target.create(name: "Claire Underwood", phone_number: "5183346656")
    @claire_campaign_target = CampaignTarget.create(campaign: @clear_water_campaign, target: @claire, script: 'Call that B...')

    @unstarted_call = PhoneCall.create(campaign_target: @claire_campaign_target)

    @dougs_auth = Authentication.create(email: "dstamper@southcarolina.gov", password: 'AwwPeaches', password_confirmation: 'AwwPeaches')
    @doug = User.create(name: "Doug Stamper", authentication: @dougs_auth)

    @incriminating_photo = FactoryGirl.create(:picture)
  end
end
