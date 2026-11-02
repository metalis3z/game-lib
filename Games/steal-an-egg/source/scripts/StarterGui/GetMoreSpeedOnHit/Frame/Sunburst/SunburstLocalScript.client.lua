-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local v1 = script.Parent
local v2 = 0

RunService.RenderStepped:Connect(function(p1) --[[ Line: 6 | Upvalues: v2 (ref), v1 (copy) ]]
	v2 = v2 + 20 * p1
	v1.Rotation = v2 % 360
end)