-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1) --[[ Line: 11 | Upvalues: Asserts (copy), Players (copy) ]]
	Asserts.Tool(p1)

	local v1 = p1.Parent

	if not v1 then
		return nil
	end

	if v1:IsA("Player") then
		return v1
	end

	if v1:IsA("Model") then
		return Players:GetPlayerFromCharacter(v1)
	end

	return nil
end