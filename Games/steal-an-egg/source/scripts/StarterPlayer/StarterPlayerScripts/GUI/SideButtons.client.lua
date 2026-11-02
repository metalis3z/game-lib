-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ScreenResolution = require(ReplicatedStorage.Library.Client.ScreenResolution)
local DynamicScale = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Elements").Right.DynamicScale

local function ScaleRight() --[[ ScaleRight | Line: 28 | Upvalues: DynamicScale (copy), ScreenResolution (copy) ]]
	DynamicScale.Scale = ScreenResolution.GetScale() + 0.1
end

local function ScaleAll() --[[ ScaleAll | Line: 32 | Upvalues: DynamicScale (copy), ScreenResolution (copy) ]]
	DynamicScale.Scale = ScreenResolution.GetScale() + 0.1
end

local function UpdateMobile() --[[ UpdateMobile | Line: 36 | Upvalues: UserInputService (copy) ]]
	local _ = UserInputService.TouchEnabled
end

DynamicScale.Scale = ScreenResolution.GetScale() + 0.1

local TouchEnabled = UserInputService.TouchEnabled

ScreenResolution.Changed:Connect(ScaleAll)

return {}