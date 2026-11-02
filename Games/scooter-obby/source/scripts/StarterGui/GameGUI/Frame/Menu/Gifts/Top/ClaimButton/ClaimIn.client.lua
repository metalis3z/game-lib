local rewardTimersFolder = script.Parent.Parent.Parent.Parent.Parent.PlayTimeRewards.RewardTimers
local lowestValue = 120

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	if Hours ~= 0 then
		return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
	else
		return Format(Minutes)..":"..Format(Seconds)
	end
end

while true do
	lowestValue = 99999999999999
	for i,v in pairs(rewardTimersFolder:GetChildren()) do
		if v:IsA("NumberValue") and v.Value < lowestValue and v.Value > 0 then
			lowestValue = v.Value
		end
	end
	if lowestValue > 0 then
		script.Parent.Parent.Label.Text = "CLAIM IN " .. convertToHMS(lowestValue)
	else
		script.Parent.Parent.Label.Text = "ALL REWARDS COMPLETE"
	end
	wait(0.5)
end