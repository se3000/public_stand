Organization.all.each do |organization|
  next if organization.vanity_string.present?
  vanity_string = organization.name.downcase.gsub(/( ,\.\?!)/, '')
  organization.vanity_string = vanity_string
  puts "#{organization.name}: #{vanity_string}"
  organization.save!
end

Campaign.all.each do |campaign|
  next if campaign.vanity_string.present?
  vanity_string = campaign.name.downcase.gsub(/( ,\.\?!)/, '')
  campaign.vanity_string = vanity_string
  puts "#{campaign.name}: #{vanity_string}"
  campaign.save!
end
