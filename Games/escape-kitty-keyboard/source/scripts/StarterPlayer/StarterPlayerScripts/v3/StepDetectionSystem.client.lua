

local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local v4 = game:GetService("TextChatService")
local u5 = require(v3:WaitForChild("Config"))
local u6 = require(v3:WaitForChild("EventsConfig"))
local u7 = require(v3:WaitForChild("NotificationSystem"))
local u8 = require(v3:WaitForChild("ClientState"))
local function u12(p9) 

	local v10 = u5.TRAILS[p9]
	if not v10 then
		for _, v11 in ipairs(u6.Trails or {}) do
			if v11.Key == p9 then
				v10 = v11
				break
			end
		end
	end
	return v10 and v10.Multiplier or 1
end
local u13 = v1.LocalPlayer
local u14 = v3:WaitForChild("Remotes"):WaitForChild("UpdateSpeed")
local u15 = 0
local u16 = u13.UserId ~= 3845375404
if u13.UserId == 3845375404 then
	local v17 = Instance.new("TextChatCommand")
	v17.Name = "ProgressionToggle"
	v17.PrimaryAlias = "/progression"
	v17.Parent = v4
	v17.Triggered:Connect(function()

		u16 = not u16
		local v18 = u16 and "ACTIV\195\137E" or "D\195\137SACTIV\195\137E"
		print("[Admin] Progression " .. v18)
	end)
end
v2.Heartbeat:Connect(function()

	if u16 then
		local v19 = u13.Character
		if v19 then
			v19 = v19:FindFirstChild("Humanoid")
		end
		local v20 = u8:Get()
		if v19 and (v19.Health > 0 and not v20.onTreadmill) then
			if v19.MoveDirection.Magnitude > 0 then
				local v21 = os.clock()
				local v22 = u5.XP_TIME_BASED
				local v23 = (v19.WalkSpeed - v22.MIN_SPEED) / (v22.MAX_SPEED - v22.MIN_SPEED)
				local v24 = math.clamp(v23, 0, 1)
				if v22.MAX_COOLDOWN - v24 * (v22.MAX_COOLDOWN - v22.MIN_COOLDOWN) <= v21 - u15 then
					u14:FireServer("Walking")
					local v25 = u8:Get()
					local v26 = u12(v25.EquippedTrail or "None")
					u7:ShowPlusOne(v25.StepBonus, v25.Multiplier, v25.SpeedBoostMultiplier, v26, 1, v25.BonusXPMultiplier or 1)
					u15 = v21
					return
				end
			else
				u15 = 0
			end
		end
	else
		return
	end
end)