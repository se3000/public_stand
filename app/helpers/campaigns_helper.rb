module CampaignsHelper
  def average_call_time_of(cmpgn_trgt)
    cmpgn_trgt.average_call_time || "0:00 (No calls completed yet)"
  end
end
