local player = game.Players.LocalPlayer

local function FormatTime(seconds)
	if seconds < 60 then
		return string.format("%ds", seconds)
	elseif seconds < 3600 then
		local minutes = math.floor(seconds / 60)
		return string.format("%dm", minutes)
	elseif seconds < 86400 then
		local hours = math.floor(seconds / 3600)
		return string.format("%dh", hours)
	else
		local days = math.floor(seconds / 86400)
		return string.format("%dd", days)
	end
end

local CurrentTime = 7200 -- 2h
local CurrentTime2 = 3600 -- 1h

while task.wait(1) do
	if player then
		if player:IsInGroup(33345909) then
			script.Parent.Parent.Title.Visible = false
			local TimeNeeded = 3600
			if CurrentTime2 <= 0 then
				CurrentTime2 = 3600
			end
			
			CurrentTime2 -= 1
			script.Parent.Text = "+1 Spin in: "..FormatTime(CurrentTime2)
		else
			script.Parent.Parent.Title.Visible = true
			local TimeNeeded = 7200
			if CurrentTime <= 0 then
				CurrentTime = 7200
			end
			CurrentTime -= 1
			script.Parent.Text = "+1 Spin in: "..FormatTime(CurrentTime)
		end
	end
end