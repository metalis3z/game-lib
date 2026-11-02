local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("CollectionService")
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
local promptDebounce = {}
local u25 = RaycastParams.new()
u25.FilterType = Enum.RaycastFilterType.Exclude
local function u30() 

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
		if u4:HasTag(v29, "KittyTreadmill") then
			return "Kitty"
		end
		if u4:HasTag(v29, "FranceTreadmill") then
			return "France"
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

	u24 = nil
	u21 = false
	u22 = nil
	promptDebounce = {}
end)
v2.Heartbeat:Connect(function()

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
			u20:FireServer(u21, u22)
			if not v33 then
				promptDebounce = {}
			end
		elseif v33 and v32 ~= u22 then
			u22 = v32
			u20:FireServer(true, u22)
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
						if not promptDebounce["Admin"] then
							promptDebounce["Admin"] = true
							u19:FireServer()
						end
					end
				elseif u22 == "Kitty" then
					-- Part de test perso : pas de gamepass requis, XP direct x150
					u15:FireServer("KittyTreadmill")
					u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 150, v35.BonusXPMultiplier or 1)
				elseif u22 == "France" then
					-- Part de test perso : pas de gamepass requis, XP direct x150
					u15:FireServer("FranceTreadmill")
					u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 180, v35.BonusXPMultiplier or 1)
				elseif u22 == "Candy" then
					if v35.CandyTreadmillActive then
						u15:FireServer("CandyTreadmill")
						u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 25, v35.BonusXPMultiplier or 1)
					else
						if not promptDebounce["Candy"] then
							promptDebounce["Candy"] = true
							u18:FireServer()
						end
					end
				elseif u22 == "Diamond" then
					if v35.DiamondTreadmillActive then
						u15:FireServer("DiamondTreadmill")
						u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 9, v35.BonusXPMultiplier or 1)
					else
						if not promptDebounce["Diamond"] then
							promptDebounce["Diamond"] = true
							u17:FireServer()
						end
					end
				elseif u22 == "Gold" then
					if v35.GoldTreadmillActive then
						u15:FireServer("GoldTreadmill")
						u7:ShowPlusOne(v35.StepBonus, v35.Multiplier, v35.SpeedBoostMultiplier, v39, 3, v35.BonusXPMultiplier or 1)
					else
						if not promptDebounce["Gold"] then
							promptDebounce["Gold"] = true
							u16:FireServer()
						end
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