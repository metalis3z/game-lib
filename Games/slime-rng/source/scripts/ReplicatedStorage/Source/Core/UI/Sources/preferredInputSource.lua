-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: preferredInputSource, time of decompilation: Sun May  3 10:11:05 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local v3 = require(ReplicatedStorage.Packages.Vide).source(UserInputService.PreferredInput)

UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- line: 8
	-- upvalues: v3 (copy), UserInputService (copy)
	v3(UserInputService.PreferredInput)
end)

return v3
