-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local GearTools = ReplicatedStorage.GearTools

return function(p1) --[[ Line: 13 | Upvalues: Asserts (copy), GearTools (copy) ]]
	Asserts.string(p1)

	local v1 = GearTools:FindFirstChild(p1, true)

	if v1 and v1:IsA("Tool") then
		return v1
	end

	for i, v in ipairs(GearTools:GetDescendants()) do
		if v.Name == p1 and v:IsA("Tool") then
			return v
		end
	end
end