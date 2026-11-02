-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent:FindFirstChild("ModdedRainbow") or script.Parent:FindFirstChildOfClass("UIGradient")

if v1 then
	local RunService = game:GetService("RunService")
	local Rotation = v1.Rotation

	RunService.RenderStepped:Connect(function(p1) --[[ Line: 5 | Upvalues: Rotation (ref), v1 (copy) ]]
		Rotation = (Rotation + p1 * 55) % 360
		v1.Rotation = Rotation
	end)
end