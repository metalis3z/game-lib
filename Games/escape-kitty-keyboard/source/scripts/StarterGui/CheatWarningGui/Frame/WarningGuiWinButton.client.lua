

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("SoundService")
game:GetService("TweenService")
local u3 = script.Parent
local u4 = u3:WaitForChild("TextLabel")
local v5 = v1:WaitForChild("CheatWarningEvent")
local u6 = v2:WaitForChild("AnnouncementSound")
local u7 = false
u3.Visible = false
u4.Text = "You must complete the entire obby!"
v5.OnClientEvent:Connect(function()

	if not u7 then
		u7 = true
		u6:Play()
		u3.Visible = true
		u4.TextTransparency = 0
		u3.BackgroundTransparency = 0.3
		task.wait(3)
		for v8 = 0, 1, 0.1 do
			u4.TextTransparency = v8
			u3.BackgroundTransparency = v8 * 0.7 + 0.3
			task.wait(0.05)
		end
		u3.Visible = false
		u7 = false
	end
end)