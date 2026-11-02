local Parent = script.Parent
local SurfaceGui = Parent:WaitForChild("SurfaceGui")
local TimerLabel = SurfaceGui:WaitForChild("Timer")

local function UpdateTimer()
	local Time = Parent:GetAttribute("Time") or -1
	
	if Time > 0 then
		SurfaceGui.Enabled = true
		local Minutes = math.floor(Time / 60)
		local Seconds = Time % 60
		TimerLabel.Text = string.format("%s%ds",
			Minutes > 0 and (Minutes .. "m ") or "",
			Seconds
		)
	else
		SurfaceGui.Enabled = false
	end
end

UpdateTimer()
Parent:GetAttributeChangedSignal("Time"):Connect(UpdateTimer)

