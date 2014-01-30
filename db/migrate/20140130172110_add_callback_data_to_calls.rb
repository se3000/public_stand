class AddCallbackDataToCalls < ActiveRecord::Migration
  def change
    add_column :phone_calls, :sid, :string
    add_column :phone_calls, :twilio_client_from, :string
    add_column :phone_calls, :twilio_client_to, :string
    add_column :phone_calls, :status, :string
    add_column :phone_calls, :direction, :string
    add_column :phone_calls, :api_version, :string
    add_column :phone_calls, :call_duration, :integer
    add_column :phone_calls, :minutes_billed, :integer
    add_column :phone_calls, :forwarded_from, :string
    add_column :phone_calls, :from_city, :string
    add_column :phone_calls, :from_state, :string
    add_column :phone_calls, :from_zip, :string
    add_column :phone_calls, :from_country, :string
    add_column :phone_calls, :to_city, :string
    add_column :phone_calls, :to_state, :string
    add_column :phone_calls, :to_zip, :string
    add_column :phone_calls, :to_country, :string
  end
end


# example's requests parameters
 # "CallSid"=>"CA2b888021b8dcb39ec38f1edea31b15c0"
 # "From"=>"client:Anonymous",
 # "To"=>"",
 # "CallStatus"=>"completed",
 # "Direction"=>"inbound",
 # "ApiVersion"=>"2010-04-01",
 # "Duration"=>"2",
 # "CallDuration"=>"76",
 # forwarded_from
 # FromCity	The city of the caller.
 # FromState	The state or province of the caller.
 # FromZip	The postal code of the caller.
 # FromCountry	The country of the caller.
 # ToCity	The city of the called party.
 # ToState	The state or province of the called party.
 # ToZip	The postal code of the called party.
 # ToCountry

# example's unused parameters
 # "AccountSid"=>"ACa7abd9d5c361db804d79974c1ca77bc7",
 # "ApplicationSid"=>"AP29b1afa5c923474d4e258a5fd7a70fa3",
 # "Caller"=>"client:Anonymous",
 # "Called"=>"",
