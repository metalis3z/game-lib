

local u1 = {}
local u2 = game:GetService("TweenService")
local v3 = game:GetService("Lighting")
require(game:GetService("ReplicatedStorage"):WaitForChild("Config"))
local u4 = workspace.CurrentCamera
u1.Data = {
	["Level"] = 0,
	["XP"] = 0,
	["XPRequired"] = 100,
	["TotalXP"] = 0,
	["Wins"] = 0,
	["Rebirths"] = 0,
	["Multiplier"] = 1,
	["StepBonus"] = 1,
	["onTreadmill"] = false,
	["GiftClaimed"] = false,
	["GoldTreadmillActive"] = false,
	["DiamondTreadmillActive"] = false,
	["CandyTreadmillActive"] = false,
	["KittyTreadmillActive"] = true,
	["FranceTreadmillActive"] = true,
	["AdminTreadmillActive"] = false,
	["SpeedBoostActive"] = false,
	["WinsBoostActive"] = false,
	["CurrentSpeedTier"] = 0,
	["SpeedBoostMultiplier"] = 1,
	["BonusXPMultiplier"] = 1,
	["BonusWinsMultiplier"] = 1,
	["EquippedTrail"] = "None",
	["OwnedTrails"] = {}
}
u1.ActiveModal = nil
u1.ActiveSystem = nil
u1.ModalListeners = {}
function u1.RegisterModalListener(p5, p6) 
	local v7 = p5.ModalListeners
	table.insert(v7, p6)
end
local u8 = v3:FindFirstChild("MenuBlur") or Instance.new("BlurEffect")
u8.Name = "MenuBlur"
u8.Size = 0
u8.Parent = v3
function u1.Get(p9) 
	return p9.Data
end
function u1.Update(p10, p11) 
	for v12, v13 in pairs(p11) do
		p10.Data[v12] = v13
	end
end
local u14 = UDim2.new(0.5, 0, 1.5, 0)
local u15 = UDim2.new(0.5, 0, 0.5, 0)
function u1.ToggleModal(p16, p17, p18) 

	if p16.ActiveModal == p17 then
		p16:CloseCurrentModal()
	else
		if p16.ActiveModal ~= nil then
			p16:CloseCurrentModal()
		end
		p16.ActiveModal = p17
		p16.ActiveSystem = p18
		p17.AnchorPoint = Vector2.new(0.5, 0.5)
		p17.Position = u14
		p17.Visible = true
		local v19 = {
			["Position"] = u15
		}
		u2:Create(p17, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v19):Play()
		u2:Create(u8, TweenInfo.new(0.4), {
			["Size"] = 20
		}):Play()
		u2:Create(u4, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
			["FieldOfView"] = 50
		}):Play()
		for _, v20 in ipairs(u1.ModalListeners) do
			v20(true)
		end
	end
end
function u1.CloseCurrentModal(p21) 

	local u22 = p21.ActiveModal
	if u22 then
		if p21.ActiveSystem and p21.ActiveSystem.OnClose then
			p21.ActiveSystem:OnClose()
		end
		p21.ActiveModal = nil
		p21.ActiveSystem = nil
		for _, v23 in ipairs(u1.ModalListeners) do
			v23(false)
		end
		local v24 = {
			["Position"] = u14
		}
		local v25 = u2:Create(u22, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), v24)
		v25:Play()
		u2:Create(u8, TweenInfo.new(0.3), {
			["Size"] = 0
		}):Play()
		u2:Create(u4, TweenInfo.new(0.3), {
			["FieldOfView"] = 70
		}):Play()
		v25.Completed:Connect(function(p26)

			if p26 == Enum.PlaybackState.Completed then
				u22.Visible = false
			end
		end)
	end
end
function u1.ForceResetModal(p27) 

	if p27.ActiveSystem and p27.ActiveSystem.OnClose then
		p27.ActiveSystem:OnClose()
	end
	if p27.ActiveModal then
		p27.ActiveModal.Visible = false
		p27.ActiveModal.Position = u14
	end
	p27.ActiveModal = nil
	p27.ActiveSystem = nil
	u8.Size = 0
	u4.FieldOfView = 70
	for _, v28 in ipairs(u1.ModalListeners) do
		v28(false)
	end
end
return u1