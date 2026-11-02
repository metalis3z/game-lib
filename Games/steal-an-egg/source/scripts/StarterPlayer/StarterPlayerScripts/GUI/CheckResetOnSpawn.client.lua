-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local StarterGui = game:GetService("StarterGui")

task.wait(3)

local t = { "GUIFX Holder", "ScreenGui", "ShiftLockButton" }

for v1, v2 in StarterGui:GetChildren() do
	if not table.find(t, v2.Name) and (v2:IsA("ScreenGui") and v2.ResetOnSpawn) then
		error("ScreenGui \'" .. v2.Name .. "\' has ResetOnSpawn enabled, which is not allowed.")
	end
end