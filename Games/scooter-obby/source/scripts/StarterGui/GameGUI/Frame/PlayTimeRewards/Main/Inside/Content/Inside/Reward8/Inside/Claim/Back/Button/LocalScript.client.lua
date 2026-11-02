local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local canClaim = false

repeat
	task.wait(0.1)
until player:GetAttribute("joinTime") ~= nil

local timeStart = player:GetAttribute("joinTime")
local timeEnd = script.Parent.SecondsToReward.Value + timeStart

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

script.Parent.Activated:Connect(function()
	if canClaim == true then
		replicatedStorage.RemoteEvents.claimPlaytimeReward:FireServer("8")
		script.Parent.Parent.Label.Text = "CLAIMED"
		script.Parent.Parent.Top.BackgroundColor3 = script.Parent.DoneColor.Value:Lerp(Color3.new(0,0,0), 0.5)
		script.Parent.Parent.BackgroundColor3 = script.Parent.DoneColor.Value:Lerp(Color3.new(0,0,0), 0.8)
		canClaim = false
		if script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.UnclaimedRewards:FindFirstChild("8") then
			script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.UnclaimedRewards:FindFirstChild("8"):Destroy()
		end
	end
end)

while true do
	local secondsRemaining = -(os.time() - timeEnd)
	script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.RewardTimers["8"].Value = secondsRemaining
	if secondsRemaining > 0 then
		script.Parent.Parent.Label.Text = convertToHMS(secondsRemaining)
		script.Parent.Parent.Top.BackgroundColor3 = script.Parent.CountdownColor.Value
		script.Parent.Parent.BackgroundColor3 = script.Parent.CountdownColor.Value:Lerp(Color3.new(0,0,0), 0.3)
	else
		canClaim = true
		script.Parent.Parent.Label.Text = "CLAIM"
		script.Parent.Parent.Top.BackgroundColor3 = script.Parent.DoneColor.Value
		script.Parent.Parent.BackgroundColor3 = script.Parent.DoneColor.Value:Lerp(Color3.new(0,0,0), 0.3)
		local numValue = Instance.new("NumberValue", script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.UnclaimedRewards)
		numValue.Name = "8"
		break
	end
	task.wait(1)
end
