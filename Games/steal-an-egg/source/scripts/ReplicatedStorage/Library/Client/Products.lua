-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Players = game:GetService("Players")
local Client = game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client")
local Save = require(Client.Save)

function t.Owns(p1, p2) --[[ Owns | Line: 9 | Upvalues: Players (copy), Save (copy) ]]
	local v2 = Save.Get(if p2 then p2 else Players.LocalPlayer)

	if v2 then
		return v2.Products[tostring(p1)]
	end

	return false
end
function t.GetAll(p1) --[[ GetAll | Line: 19 | Upvalues: Players (copy), Save (copy) ]]
	local v2 = Save.Get(if p1 then p1 else Players.LocalPlayer)

	return if v2 then v2.Products or {} else {}
end

return t