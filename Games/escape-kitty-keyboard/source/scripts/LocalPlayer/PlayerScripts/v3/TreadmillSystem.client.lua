-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("CollectionService")
local u5 = require(v3:WaitForChild("Config"))
local u6 = require(v3:WaitForChild("EventsConfig"))
local u7 = require(v3:WaitForChild("NotificationSystem"))
local u8 = require(v3:WaitForChild("ClientState"))
local function u12(p9) -- name: getTrailMult
	-- upvalues: (copy) u5, (copy) u6
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
local v14 = v3:WaitForChild("Remotes")
local u15 = v14:WaitForChild("UpdateSpeed")
local u16 = v14:WaitForChild("PromptGoldTreadmill")
local u17 = v14:WaitForChild("PromptDiamondTreadmill")
local u18 = v14:WaitForChild("PromptCandyTreadmill")
local u19 = v14:WaitForChild("PromptAdminTreadmill")
local u20 = v14:WaitForChild("TreadmillSignal")
local u21 = false
local u22 = nil
local u23 = 0
local u24 = nil
local u25 = RaycastParams.new()
u25.FilterType = Enum.RaycastFilterType.Exclude
local function u30() -- name: checkFloor
	-- upvalues: (copy) u13, (copy) u25, (copy) u4
	local v26 = u13.Character
	local v27
	if v26 then
		v27 = v26:FindFirstChild("HumanoidRootPart")
	else
		v27 = v26
	end
	if not v27 then
		return nil
	end
	u25.FilterDescendantsInstances = { v26 }
	local v28 = workspace:Raycast(v27.Position, Vector3.new(0, -7, 0), u25)
	if v28 and v28.Instance then
		local v29 = v28.Instance
		if u4:HasTag(v29, "AdminTreadmill") then
			return "Admin"
		end
		if u4:HasTag(v29, "CandyTreadmill") then
			return "Candy"
		end
		if u4:HasTag(v29, "DiamondTreadmill") then
			return "Diamond"
		end
		if u4:HasTag(v29, "GoldTreadmill") then
			return "Gold"
		end
		if u4:HasTag(v29, "Treadmill") then
			return "Normal"
		end
	end
	return nil
end
u13.CharacterAdded:Connect(function()
	-- upvalues: (ref) u24, (ref) u21, (ref) u22
	u24 = nil
	u21 = false
	u22 = nil
end)
v2.Heartbeat:Connect(function()
	-- upvalues: (copy) u13, (copy) u30, (ref) u21, (ref) u22, (copy) u20, (copy) u8, (copy) u5, (ref) u23, (copy) u12, (copy) u15, (copy) u7, (copy) u19, (copy) u18, (copy) u17, (copy) u16
	local v31 = u13.Character
	if v31 then
		v31 = u13.Character:FindFirstChildOfClass("Humanoid")
	end
	if v31 and v31.Health > 0 then
		local v32 = u30()
		local v33 = v32 ~= nil
		if v33 ~= u21 then
			u21 = v33
			u22 = v32
			u20:FireServer(u21)
		end
		if u21 then
			local v34 = os.clock()
			local v35 = u8:Get()
			local v36 = u5.XP_TIME_BASED
			local v37 = (v31.WalkSpeed - v36.MIN_SPEED) / (v36.MAX_SPEED - v36.MIN_SPEED)
			local v38 = math.clamp(v37, 0, 1)
			if v36.MAX_COOLDOWN - v38 * (v36.MAX_COOLDOWN - v36.MIN_COOLDOWN) <= v34 - u23 then
				local v39 = u12(v35.EquippedTrail or "None")
				if u22 == "Admin" then
					if v35.AdminTreadmillActive then
						u15:FireServer("AdminTreadmill")
						u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 100, v35.BonusXPMultiplier or 1)
					else
						u19:FireServer()
						u21 = false
					end
				elseif u22 == "Candy" then
					if v35.CandyTreadmillActive then
						u15:FireServer("CandyTreadmill")
						u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 25, v35.BonusXPMultiplier or 1)
					else
						u18:FireServer()
						u21 = false
					end
				elseif u22 == "Diamond" then
					if v35.DiamondTreadmillActive then
						u15:FireServer("DiamondTreadmill")
						u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 9, v35.BonusXPMultiplier or 1)
					else
						u17:FireServer()
						u21 = false
					end
				elseif u22 == "Gold" then
					if v35.GoldTreadmillActive then
						u15:FireServer("GoldTreadmill")
						u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 3, v35.BonusXPMultiplier or 1)
					else
						u16:FireServer()
						u21 = false
					end
				else
					u15:FireServer("Treadmill")
					u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 1, v35.BonusXPMultiplier or 1)
				end
				u23 = v34
			end
		end
	end
end)