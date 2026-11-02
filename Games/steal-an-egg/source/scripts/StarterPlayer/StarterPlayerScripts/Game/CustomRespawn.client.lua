-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedStorage.Library.Client.Network)
local LocalPlayer = Players.LocalPlayer

local function requestCharacterReset(p1) --[[ requestCharacterReset | Line: 17 | Upvalues: Network (copy) ]]
	Network.Fire(Network.NET_MAP.ClientCharacter.REQUEST_CHARACTER_RESET, p1)
end

local function bindCharacter(p1) --[[ bindCharacter | Line: 21 | Upvalues: Network (copy) ]]
	p1:WaitForChild("Humanoid").Died:Connect(function() --[[ Line: 24 | Upvalues: p1 (copy), Network (ref) ]]
		Network.Fire(Network.NET_MAP.ClientCharacter.REQUEST_CHARACTER_RESET, p1)
	end)
end

LocalPlayer.CharacterAdded:Connect(bindCharacter)

if not LocalPlayer.Character then
	return
end

local Character = LocalPlayer.Character

Character:WaitForChild("Humanoid").Died:Connect(function() --[[ Line: 24 | Upvalues: Character (copy), Network (copy) ]]
	Network.Fire(Network.NET_MAP.ClientCharacter.REQUEST_CHARACTER_RESET, Character)
end)