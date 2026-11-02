-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local UIGradient = script.Parent:WaitForChild("UIGradient")
local v1 = 0

RunService.RenderStepped:Connect(function(p1) --[[ Line: 5 | Upvalues: v1 (ref), UIGradient (copy) ]]
	v1 = v1 + p1 * 0.1

	local v3 = Color3.fromHSV(v1 % 1, 0.8, 1)
	local v4 = Color3.fromHSV((v1 + 0.05) % 1, 0.8, 1)

	UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v3), ColorSequenceKeypoint.new(1, v4) })
end)