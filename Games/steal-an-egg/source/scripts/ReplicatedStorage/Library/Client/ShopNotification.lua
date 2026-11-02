-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local t = {}
local t2 = {
	[Rarity.Rarities.Cosmic] = true,
	[Rarity.Rarities.Secret] = true,
	[Rarity.Rarities.Eternal] = true,
	[Rarity.Rarities.Divine] = true
}
local t3 = {}

function t.CheckStock(p1, p2, p3, p4) --[[ CheckStock | Line: 25 | Upvalues: t3 (copy), t2 (copy), Message (copy) ]]
	local v1 = t3[p1]

	if not v1 then
		v1 = {}
		t3[p1] = v1
	end

	local v2 = v1[p2]

	v1[p2] = p4

	if v2 == nil then
		return
	end

	if not (p4 > 0 and v2 <= 0) then
		return
	end

	local Rarity = p3.Rarity

	if not (Rarity and t2[Rarity]) then
		return
	end

	Message.Top({
		Time = 5,
		Message = string.format("%s is in the %s!", p3.DisplayName, p1),
		Color = Rarity.Color,
		Image = p3.Icon
	})
end

return t