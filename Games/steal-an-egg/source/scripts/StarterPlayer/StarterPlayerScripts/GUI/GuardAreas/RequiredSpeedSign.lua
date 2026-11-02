-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local t = {}

t.__index = t
t.__class = "RequiredSpeedSign"

local v1 = Color3.fromRGB(0, 255, 0)
local v2 = Color3.fromRGB(153, 255, 0)
local v3 = Color3.fromRGB(255, 170, 0)
local v4 = Color3.fromRGB(255, 0, 0)

function t.new(p1) --[[ new | Line: 51 | Upvalues: Asserts (copy), t (copy), Constants (copy) ]]
	Asserts.Model(p1)

	local v2 = setmetatable({}, t)
	local RequiredSpeedSign = p1:WaitForChild("RequiredSpeedSign", Constants.STUDIO_YIELD_TIMEOUT)
	local v3 = if RequiredSpeedSign then RequiredSpeedSign:IsA("Model") else RequiredSpeedSign

	assert(v3, (("%*.RequiredSpeedSign must be a Model"):format((p1:GetFullName()))))

	local Main = RequiredSpeedSign:WaitForChild("Main", Constants.STUDIO_YIELD_TIMEOUT)
	local v5 = if Main then Main:IsA("BasePart") else Main

	assert(v5, (("%*.Main must be a BasePart"):format((RequiredSpeedSign:GetFullName()))))

	local SurfaceGui = Main:WaitForChild("SurfaceGui", Constants.STUDIO_YIELD_TIMEOUT)
	local v7 = if SurfaceGui then SurfaceGui:IsA("SurfaceGui") else SurfaceGui

	assert(v7, (("%*.SurfaceGui must be a SurfaceGui"):format((Main:GetFullName()))))

	local Info = SurfaceGui:WaitForChild("Info", Constants.STUDIO_YIELD_TIMEOUT)
	local v9 = if Info then Info:IsA("TextLabel") else Info

	assert(v9, (("%*.Info must be a TextLabel"):format((SurfaceGui:GetFullName()))))

	local Required = SurfaceGui:WaitForChild("Required", Constants.STUDIO_YIELD_TIMEOUT)
	local v11 = if Required then Required:IsA("GuiObject") else Required

	assert(v11, (("%*.Required must be a GuiObject"):format((SurfaceGui:GetFullName()))))

	local Speed = Required:WaitForChild("Speed", Constants.STUDIO_YIELD_TIMEOUT)
	local v13 = if Speed then Speed:IsA("TextLabel") else Speed

	assert(v13, (("%*.Speed must be a TextLabel"):format((Required:GetFullName()))))
	v2._infoLabel = Info
	v2._speedLabel = Speed
	v2:SetSlowdownTolerance(-1)

	return v2
end
function t.SetSlowdownTolerance(p1, p2) --[[ SetSlowdownTolerance | Line: 80 | Upvalues: Asserts (copy), v4 (copy), v3 (copy), v2 (copy), v1 (copy) ]]
	Asserts.number(p2)

	local v12 = if p2 < 0.03 then v4 elseif p2 < 0.1 then v3:Lerp(v2, (p2 - 0.03) / 0.07) elseif p2 < 0.4 then v2:Lerp(v1, (p2 - 0.1) / 0.30000000000000004) else v1

	p1._infoLabel.TextColor3 = v12
	p1._speedLabel.TextColor3 = v12
end
function t.SetSpeedPowerRequirement(p1, p2) --[[ SetSpeedPowerRequirement | Line: 104 | Upvalues: Asserts (copy), TreadmillUtil (copy) ]]
	Asserts.number(p2)
	p1._speedLabel.Text = TreadmillUtil.FormatSpeedPower(p2)
end
function t.Destroy(p1) --[[ Destroy | Line: 109 ]] end

return t