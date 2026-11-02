-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Workspace = game:GetService("Workspace")

return function(p1, p2, p3) --[[ Line: 3 | Upvalues: Workspace (copy) ]]
	return Workspace:Raycast(p1, CFrame.lookAt(p1, p2).LookVector * (p1 - p2).Magnitude, p3)
end