-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local LocalPlayer = game:GetService("Players").LocalPlayer

return function() --[[ Line: 8 | Upvalues: LocalPlayer (copy) ]]
	return LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GUIFX Holder")
end