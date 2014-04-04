require 'rake'

namespace :report do
  task :campaign_target, [:campaign_target_id] => :environment do |task, args|
    campaign_target = CampaignTarget.find(args[:campaign_target_id])

    puts "SID,duration,started at,connected to,email,comments"
    phone_calls = campaign_target.phone_calls
    phone_calls.each do |phone_call|
      sid = phone_call.sid
      duration = phone_call.call_duration_in_minutes
      started_at = phone_call.created_at
      connected_to = phone_call.from_number
      email = phone_call.feedback.try(:email_address)
      comments = phone_call.feedback.try(:comments)
      puts [sid, duration, started_at, connected_to, email, comments].join(',')
    end

    puts "\n\n\n"
    puts "call count: #{phone_calls.count}"
    puts "completed call count: #{phone_calls.completed.count}"
    duration = phone_calls.map(&:call_duration).compact.sum
    puts "total call duration: #{PhoneCall.call_duration_in_minutes(duration)}"
  end
end
