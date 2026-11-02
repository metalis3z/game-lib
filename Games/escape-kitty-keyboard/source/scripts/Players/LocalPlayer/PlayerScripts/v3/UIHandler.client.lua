-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local u1 = game:GetService("CollectionService")
local v2 = game:GetService("Players")
local u3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("TweenService")
local u5 = require(u3:WaitForChild("Config"))
local u6 = require(u3:WaitForChild("EventsConfig"))
local u7 = require(u3:WaitForChild("NotificationSystem"))
local u8 = require(u3:WaitForChild("ClientState"))
local u9 = v2.LocalPlayer
local u10 = u9:WaitForChild("PlayerGui")
local u11 = u3:WaitForChild("Remotes")
local v12 = u11:WaitForChild("UpdateUI")
local v13 = u11:WaitForChild("ShowWin")
local u14 = u11:WaitForChild("FunnelShop", 5)
local u15 = {}
require(game:GetService("ReplicatedStorage"):WaitForChild("SoundPackUISystem"))
local function u19(p16) -- name: getUI
	-- upvalues: (ref) u15, (copy) u1, (copy) u10
	if u15[p16] and u15[p16].Parent then
		return u15[p16]
	end
	local v17 = u1:GetTagged(p16)
	for _, v18 in ipairs(v17) do
		if v18:IsDescendantOf(u10) then
			u15[p16] = v18
			return v18
		end
	end
	return nil
end
local u20 = {
	{ 1e63, "Vg" },
	{ 1e60, "Nd" },
	{ 1e57, "Od" },
	{ 1e54, "Spd" },
	{ 1e51, "Sxd" },
	{ 1e48, "Qid" },
	{ 1e45, "Qad" },
	{ 1e42, "Td" },
	{ 1e39, "Dd" },
	{ 1e36, "Ud" },
	{ 1e33, "Dc" },
	{ 1e30, "No" },
	{ 1e27, "Oc" },
	{ 1e24, "Sp" },
	{ 1e21, "Sx" },
	{ 1e18, "Qi" },
	{ 1000000000000000, "Qa" },
	{ 1000000000000, "T" },
	{ 1000000000, "B" },
	{ 1000000, "M" },
	{ 1000, "K" }
}
local function u27(p21) -- name: formatNumber
	-- upvalues: (copy) u20
	local v22 = tonumber(p21) or 0
	for _, v23 in ipairs(u20) do
		local v24 = v23[1]
		local v25 = v23[2]
		if v24 <= v22 then
			return string.format("%.2f", v22 / v24):gsub("%.?0+$", "") .. v25
		end
	end
	local v26 = math.floor(v22)
	return tostring(v26)
end
local function u51() -- name: updateBaseUI
	-- upvalues: (copy) u8, (copy) u19, (copy) u5, (copy) u9, (copy) u27, (copy) u6, (copy) u4
	local v28 = u8:Get()
	local v29 = u19("WinsLabel")
	local v30 = u19("SpeedValue")
	local v31 = u19("LevelText")
	local v32 = u19("XPText")
	local v33 = u19("XPBarFill")
	local v34 = u19("GamepassMultiplierLabel")
	local v35 = u19("RebirthMultiplierLabel")
	local v36 = u19("TrailMultiplierLabel")
	local v37 = u19("CustomSpeedNow")
	local v38 = u19("MaxCustomSpeed")
	local v39 = u19("TextboxCustomSpeed")
	if v38 then
		local v40 = u5.CalculateMaxSpeed(v28.Level)
		v38.Text = "Your Max Speed: " .. math.floor(v40)
	end
	if v39 then
		local v41 = u5.CalculateMaxSpeed(v28.Level)
		v39.PlaceholderText = math.floor(v41)
	end
	if v37 then
		local v42 = u9.Character
		if v42 then
			v42 = v42:FindFirstChild("Humanoid")
		end
		local v43 = v42 and v42.WalkSpeed or (v28.CustomWalkSpeed or u5.DEFAULT_WALKSPEED)
		v37.Text = "Current speed: " .. math.floor(v43)
	end
	if v29 then
		v29.Text = u27(v28.Wins)
	end
	if v30 then
		v30.Text = u27(v28.TotalXP) .. " Speed"
	end
	if v31 then
		v31.Text = "Level " .. v28.Level
	end
	local v44 = v28.XP or 0
	local v45 = v28.XPRequired or 100
	if v32 then
		v32.Text = u27(v44) .. " / " .. u27(v45)
	end
	if v34 then
		v34.Text = "Multiplier x" .. u27(v28.SpeedBoostMultiplier or 1) .. " (Gamepass)"
	end
	if v35 then
		v35.Text = "Multiplier x" .. u27(v28.Multiplier or 1) .. " (Rebirth)"
	end
	if v36 then
		local v46 = v28.EquippedTrail or "None"
		local v47 = u5.TRAILS[v46]
		if not v47 then
			for _, v48 in ipairs(u6.Trails or {}) do
				if v48.Key == v46 then
					v47 = v48
					break
				end
			end
		end
		v36.Text = "Multiplier x" .. u27(v47 and v47.Multiplier or 1) .. " (Trail)"
	end
	if v33 then
		local v49 = v44 / v45
		local v50 = math.clamp(v49, 0, 1)
		u4:Create(v33, TweenInfo.new(0.15), {
			["Size"] = UDim2.new(v50, 0, 1, 0)
		}):Play()
	end
	if (v28.CustomWalkSpeed == nil or v28.CustomWalkSpeed == 0) and v39 then
		v39.Text = ""
	end
end
local function u56() -- name: updateSpeedBoostButton
	-- upvalues: (copy) u8, (copy) u5, (copy) u19
	local v52 = (u8:Get().CurrentSpeedTier or 0) + 1
	local v53 = u5.SPEED_UPGRADES[v52]
	local v54 = u19("SpeedTierLabel")
	local v55 = u19("SpeedPriceButton")
	if v53 then
		if v54 then
			v54.Text = v53.Multiplier .. "x Speed"
		end
		if v55 then
			v55.Text = "ONLY " .. v53.Price
			return
		end
	else
		if v54 then
			v54.Text = "MAX SPEED"
		end
		if v55 then
			v55.Text = "OWNED"
			v55.Active = false
		end
	end
end
local u57 = nil
local u58 = nil
v12.OnClientEvent:Connect(function(p59)
	-- upvalues: (copy) u8, (copy) u9, (copy) u5, (copy) u51, (ref) u58, (copy) u7, (ref) u57, (copy) u56
	if p59 then
		local v60 = u8:Get()
		local _ = v60.Rebirths or 0
		local _ = v60.Level
		u8:Update(p59)
		local v61 = u8:Get()
		local v62 = u9.Character
		if v62 then
			v62 = v62:FindFirstChild("Humanoid")
		end
		if v62 and (v61.CustomWalkSpeed == nil or v61.CustomWalkSpeed == 0) then
			v62.WalkSpeed = u5.CalculateMaxSpeed(v61.Level)
		end
		u51()
		if p59.StepBonus ~= nil or p59.Wins ~= nil then
			task.defer(function()
				if _G.RefreshAwardVisuals then
					_G.RefreshAwardVisuals()
				end
			end)
		end
		if p59.Rebirths then
			local v63 = p59.Rebirths
			if u58 == nil then
				u58 = v63
			elseif u58 < v63 then
				task.wait(0.5)
				u7:ShowRebirth(v63)
				u58 = v63
			end
		end
		if p59.Level then
			local v64 = p59.Level
			if u57 == nil or v64 < u57 then
				u57 = v64
			elseif u57 < v64 then
				u7:ShowLevelUp(u57, v64)
				u57 = v64
			end
		end
		if p59.CurrentSpeedTier ~= nil then
			u56()
		end
	end
end)
local u72 = {
	["SpeedBoost"] = function()
		-- upvalues: (copy) u11
		u11.PromptSpeedBoost:FireServer()
	end,
	["WinsBoost"] = function()
		-- upvalues: (copy) u11
		u11.PromptWinsBoost:FireServer()
	end,
	["Boost150K"] = function()
		-- upvalues: (copy) u11
		u11.Prompt150KSpeed:FireServer()
	end,
	["Boost1M"] = function()
		-- upvalues: (copy) u11
		u11.Prompt1MSpeed:FireServer()
	end,
	["Boost10M"] = function()
		-- upvalues: (copy) u11
		u11.Prompt10MSpeed:FireServer()
	end,
	["Boost50M"] = function()
		-- upvalues: (copy) u11
		u11.Prompt50MSpeed:FireServer()
	end,
	["Boost500M"] = function()
		-- upvalues: (copy) u11
		u11.Prompt500MSpeed:FireServer()
	end,
	["Boost1B"] = function()
		-- upvalues: (copy) u11
		u11.Prompt1BSpeed:FireServer()
	end,
	["Rebirth"] = function()
		-- upvalues: (copy) u3, (copy) u8, (copy) u19
		require(u3.RebirthUISystem):InitLogic()
		u8:ToggleModal(u19("RebirthModal"), require(u3.RebirthUISystem))
	end,
	["Gift"] = function()
		-- upvalues: (copy) u3, (copy) u8, (copy) u19
		require(u3.GiftUISystem):InitLogic()
		u8:ToggleModal(u19("GiftModal"), require(u3.GiftUISystem))
	end,
	["SoundPack"] = function()
		-- upvalues: (copy) u3, (copy) u8, (copy) u19
		local v65 = require(u3.SoundPackUISystem)
		v65:InitLogic()
		u8:ToggleModal(u19("SoundPackModal"), v65)
	end,
	["TrailsModal"] = function()
		-- upvalues: (copy) u3, (copy) u19, (copy) u8, (copy) u14
		local v66 = require(u3.TrailUISystem)
		v66:InitLogic()
		local v67 = u19("TrailsModal")
		if u8.ActiveModal ~= v67 and u14 then
			u14:FireServer("open")
		end
		u8:ToggleModal(v67, v66)
		v66:UpdateDisplay()
	end,
	["Checkpoint"] = function()
		-- upvalues: (copy) u19, (copy) u8, (copy) u14
		local v68 = u19("CheckpointModal")
		if u8.ActiveModal ~= v68 and u14 then
			u14:FireServer("open")
		end
		u8:ToggleModal(v68)
	end,
	["Shop"] = function()
		-- upvalues: (copy) u19, (copy) u8, (copy) u14
		local v69 = u19("ShopModal")
		if u8.ActiveModal ~= v69 and u14 then
			u14:FireServer("open")
		end
		u8:ToggleModal(v69)
	end,
	["EventShop"] = function()
		-- upvalues: (copy) u19, (copy) u8, (copy) u14
		local v70 = u19("EventShopModal")
		if u8.ActiveModal ~= v70 and u14 then
			u14:FireServer("open")
		end
		u8:ToggleModal(v70)
	end,
	["EventCurrency"] = function()
		-- upvalues: (copy) u19, (copy) u8, (copy) u14
		local v71 = u19("EventCurrencyModal")
		if u8.ActiveModal ~= v71 and u14 then
			u14:FireServer("open")
		end
		u8:ToggleModal(v71)
	end
}
local u73 = u15
local function v76(p74) -- name: setupButton
	-- upvalues: (copy) u72
	local v75 = p74:GetAttribute("Action")
	if v75 and u72[v75] then
		p74.MouseButton1Click:Connect(u72[v75])
	end
end
for _, v77 in ipairs(u1:GetTagged("UIActionBtn")) do
	local v78 = v77:GetAttribute("Action")
	if v78 and u72[v78] then
		v77.MouseButton1Click:Connect(u72[v78])
	end
end
u1:GetInstanceAddedSignal("UIActionBtn"):Connect(v76)
local u79 = false
local u80 = false
u9.CharacterAdded:Connect(function()
	-- upvalues: (ref) u79, (ref) u80, (ref) u73, (copy) u8
	u79 = false
	u80 = false
	u73 = {}
	u8:ForceResetModal()
end)
local function v87(u81) -- name: setupCheckpointPortal
	-- upvalues: (ref) u79, (copy) u9, (copy) u14, (copy) u8, (copy) u19
	if u81:IsA("BasePart") then
		u81.Touched:Connect(function(p82)
			-- upvalues: (ref) u79, (ref) u9, (ref) u14, (ref) u8, (ref) u19
			if not u79 then
				local v83 = u9.Character
				if v83 and p82:IsDescendantOf(v83) then
					u79 = true
					if u14 then
						u14:FireServer("open")
					end
					u8:ToggleModal((u19("CheckpointModal")))
				end
			end
		end)
		u81.TouchEnded:Connect(function(p84)
			-- upvalues: (ref) u9, (copy) u81, (ref) u79, (ref) u8, (ref) u19
			local u85 = u9.Character
			if u85 and p84:IsDescendantOf(u85) then
				task.delay(0.15, function()
					-- upvalues: (copy) u85, (ref) u81, (ref) u79, (ref) u8, (ref) u19
					local v86 = OverlapParams.new()
					v86.FilterDescendantsInstances = { u85 }
					v86.FilterType = Enum.RaycastFilterType.Include
					if #workspace:GetPartsInPart(u81, v86) == 0 then
						u79 = false
						if u8.ActiveModal == u19("CheckpointModal") then
							u8:CloseCurrentModal()
						end
					end
				end)
			end
		end)
	end
end
local u88 = u80
for _, v89 in ipairs(u1:GetTagged("OpenCheckpointModal")) do
	v87(v89)
end
u1:GetInstanceAddedSignal("OpenCheckpointModal"):Connect(v87)
local function u92() -- name: isAnyEventActive
	-- upvalues: (copy) u6
	local v90 = os.time()
	for _, v91 in ipairs(u6.Events) do
		if v91.Start <= v90 and v90 < v91.End then
			return true
		end
	end
	return false
end
local function v99(u93) -- name: setupEventShopPortal
	-- upvalues: (ref) u88, (copy) u92, (copy) u9, (copy) u14, (copy) u8, (copy) u19
	if u93:IsA("BasePart") then
		u93.Touched:Connect(function(p94)
			-- upvalues: (ref) u88, (ref) u92, (ref) u9, (ref) u14, (ref) u8, (ref) u19
			if u88 then
				return
			elseif u92() then
				local v95 = u9.Character
				if v95 and p94:IsDescendantOf(v95) then
					u88 = true
					if u14 then
						u14:FireServer("open")
					end
					u8:ToggleModal((u19("EventShopModal")))
				end
			end
		end)
		u93.TouchEnded:Connect(function(p96)
			-- upvalues: (ref) u9, (copy) u93, (ref) u88, (ref) u8, (ref) u19
			local u97 = u9.Character
			if u97 and p96:IsDescendantOf(u97) then
				task.delay(0.15, function()
					-- upvalues: (copy) u97, (ref) u93, (ref) u88, (ref) u8, (ref) u19
					local v98 = OverlapParams.new()
					v98.FilterDescendantsInstances = { u97 }
					v98.FilterType = Enum.RaycastFilterType.Include
					if #workspace:GetPartsInPart(u93, v98) == 0 then
						u88 = false
						if u8.ActiveModal == u19("EventShopModal") then
							u8:CloseCurrentModal()
						end
					end
				end)
			end
		end)
	end
end
for _, v100 in ipairs(u1:GetTagged("OpenEventShopModal")) do
	v99(v100)
end
u1:GetInstanceAddedSignal("OpenEventShopModal"):Connect(v99)
task.spawn(function()
	-- upvalues: (copy) u92, (copy) u19, (copy) u8, (ref) u88
	while true do
		repeat
			task.wait(5)
		until not u92()
		local v101 = u19("EventShopModal")
		if v101 and u8.ActiveModal == v101 then
			u88 = false
			u8:CloseCurrentModal()
		end
	end
end)
v13.OnClientEvent:Connect(function(p102)
	-- upvalues: (copy) u7
	u7:ShowWinNotification(p102)
end)
local v103 = u11:WaitForChild("BossHit", 10)
if v103 then
	v103.OnClientEvent:Connect(function() end)
end
task.wait(1)
u11.RequestInitialData:FireServer()
local u104 = {}
local function v116() -- name: connectSpeedLogic
	-- upvalues: (copy) u19, (copy) u104, (copy) u8, (copy) u7, (copy) u5, (copy) u11, (copy) u9, (copy) u51
	local u105 = u19("TextboxCustomSpeed")
	local v106 = u19("ButtonCustomSpeed")
	if u105 and v106 then
		if not u104[v106] then
			u104[v106] = v106.MouseButton1Click:Connect(function()
				-- upvalues: (ref) u8, (copy) u105, (ref) u7, (ref) u5, (ref) u11, (ref) u9, (ref) u51
				local v107 = u8:Get()
				local v108 = u105.Text
				local v109 = tonumber(v108)
				if v109 then
					local v110 = u5.CalculateMaxSpeed(v107.Level)
					local v111 = u5.DEFAULT_WALKSPEED
					local v112 = math.clamp(v109, v111, v110)
					u11.SetCustomSpeed:FireServer(v112)
					u8:Update({
						["CustomWalkSpeed"] = v112
					})
					local v113 = u9.Character
					if v113 and v113:FindFirstChild("Humanoid") then
						v113.Humanoid.WalkSpeed = v112
					end
					u51()
					local v114 = u105
					local v115 = math.floor(v112)
					v114.Text = tostring(v115)
					u7:ShowMessage("Speed updated!", Color3.fromRGB(200, 255, 200))
				else
					u7:ShowMessage("Enter a valid number!", Color3.fromRGB(255, 100, 100))
				end
			end)
		end
	else
		return
	end
end
u1:GetInstanceAddedSignal("TextboxCustomSpeed"):Connect(v116)
u1:GetInstanceAddedSignal("ButtonCustomSpeed"):Connect(v116)
task.spawn(v116)
u9.CharacterAdded:Connect(function(p117)
	-- upvalues: (copy) u8, (copy) u5
	local v118 = p117:WaitForChild("Humanoid")
	local v119 = u8:Get()
	task.wait(0.1)
	v118.WalkSpeed = v119.CustomWalkSpeed and v119.CustomWalkSpeed > 0 and v119.CustomWalkSpeed or u5.CalculateMaxSpeed(v119.Level)
end)