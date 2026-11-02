-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

require(script:FindFirstAncestor("Effects").Parent.Types)

local t = {}
local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

ColorCorrectionEffect.Brightness = 0
ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255)
ColorCorrectionEffect.Parent = Workspace.CurrentCamera

local v1 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
	Brightness = 0
})

function t.Activate() --[[ Activate | Line: 18 | Upvalues: ColorCorrectionEffect (copy), v1 (copy) ]]
	ColorCorrectionEffect.Brightness = 10
	v1:Cancel()
	v1:Play()
end

return t