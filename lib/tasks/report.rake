require 'rake'

namespace :report do
  task :campaign_target, [:campaign_target_id] => :environment do |task, args|
    campaign_target = CampaignTarget.find(args[:campaign_target_id])
    campaign_target.phone_calls.each do |phone_call|
      next unless phone_call.call_duration
      puts "Call SID: #{phone_call.sid}"
      puts "Call duration(seconds): #{phone_call.call_duration}"
      puts "Call started at: #{phone_call.created_at}"
      puts "Call connected to: #{phone_call.from_number}" if phone_call.from_number
      if feedback = phone_call.feedback
        puts "Caller email: #{feedback.email_address}"
        puts "Caller comments: #{feedback.comments}"
      end
      puts "\n\n"
    end
  end
end
