-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local u1 = game:GetService("CollectionService")
local v2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local u4 = require(v3:WaitForChild("Config"))
local u5 = require(v3:WaitForChild("NotificationSystem"))
local u6 = require(v3:WaitForChild("ClientState"))
local u7 = require(v3:WaitForChild("GiftUISystem"))
local u8 = v2.LocalPlayer
local u9 = v3:WaitForChild("Remotes"):WaitForChild("EquipStepAward")
local u10 = false
local u11 = {}
local u12 = nil
local u13 = false
local function v24(p14) -- name: connectStepAward
	-- upvalues: (copy) u4, (copy) u11, (copy) u8, (ref) u10, (copy) u6, (copy) u9, (copy) u5
	local u15 = p14:GetAttribute("AwardID")
	local u16 = u4.STEP_AWARDS[u15]
	if u16 then
		u11[p14] = u16
		task.defer(function()
			if _G.RefreshAwardVisuals then
				_G.RefreshAwardVisuals()
			end
		end)
		p14.Touched:Connect(function(p17)
			-- upvalues: (ref) u8, (ref) u10, (ref) u6, (copy) u16, (ref) u9, (copy) u15, (ref) u5
			local v18 = u8.Character
			if v18 and (p17:IsDescendantOf(v18) and not u10) then
				u10 = true
				local v19 = u6:Get()
				local v20 = v19.Wins or 0
				local v21 = v19.StepBonus or 1
				local v22 = u16.ReqWins
				local v23 = tonumber(v22) or 0
				if v23 <= v20 then
					if v21 ~= u16.Bonus then
						u9:FireServer(u15)
						u5:ShowMessage("EQUIPPED! +" .. u16.Bonus .. "/step", Color3.fromRGB(0, 255, 100))
						u6:Update({
							["StepBonus"] = u16.Bonus
						})
						_G.RefreshAwardVisuals()
					end
				else
					u5:ShowMessage("Need " .. v23 .. " Wins!", Color3.fromRGB(255, 100, 100))
				end
				task.delay(0.5, function()
					-- upvalues: (ref) u10
					u10 = false
				end)
			end
		end)
	end
end
local function u27() -- name: getGiftModal
	-- upvalues: (ref) u12, (copy) u1, (copy) u8
	if u12 then
		return u12
	end
	local v25 = u1:GetTagged("GiftModal")
	for _, v26 in ipairs(v25) do
		if v26:IsDescendantOf(u8:WaitForChild("PlayerGui")) then
			u12 = v26
			return v26
		end
	end
	return nil
end
local function v31(p28) -- name: connectGiftChest
	-- upvalues: (ref) u13, (copy) u27, (copy) u7, (copy) u6
	local v29 = p28:IsA("ProximityPrompt") and p28 and p28 or p28:FindFirstChildOfClass("ProximityPrompt")
	if v29 then
		v29.Triggered:Connect(function()
			-- upvalues: (ref) u13, (ref) u27, (ref) u7, (ref) u6
			if not u13 then
				u13 = true
				local v30 = u27()
				if not v30 then
					task.wait(0.2)
					v30 = u27()
				end
				if v30 then
					u7:InitLogic()
					u6:ToggleModal(v30, u7)
				else
					warn("\226\154\160\239\184\143 Probl\195\168me : GiftModal introuvable dans PlayerGui")
				end
				task.delay(0.5, function()
					-- upvalues: (ref) u13
					u13 = false
				end)
			end
		end)
	end
end
for _, v32 in ipairs(u1:GetTagged("GiftChest")) do
	v31(v32)
end
u1:GetInstanceAddedSignal("GiftChest"):Connect(v31)
for _, v33 in ipairs(u1:GetTagged("StepAward")) do
	v24(v33)
end
u1:GetInstanceAddedSignal("StepAward"):Connect(v24)
function _G.RefreshAwardVisuals()
	-- upvalues: (copy) u6, (copy) u1, (copy) u4
	local v34 = u6:Get()
	local v35 = v34.StepBonus or 1
	local v36 = v34.Wins or 0
	local v37 = u1:GetTagged("StepAward")
	for _, v38 in ipairs(v37) do
		local v39 = v38:GetAttribute("AwardID")
		local v40 = u4.STEP_AWARDS[v39]
		if v40 then
			local v41 = v40.ReqWins
			local v42 = tonumber(v41) or 0
			if v40.Bonus == v35 then
				v38.BrickColor = u4.COLORS.AWARD_EQUIPPED
			elseif v36 < v42 then
				v38.BrickColor = u4.COLORS.AWARD_LOCKED
			else
				v38.BrickColor = u4.COLORS.AWARD_DEFAULT
			end
		end
	end
end
task.delay(1.5, function()
	if _G.RefreshAwardVisuals then
		_G.RefreshAwardVisuals()
	end
end)