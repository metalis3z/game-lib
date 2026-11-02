-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local v1 = Color3.fromRGB(238, 255, 0)
local v2 = Color3.fromRGB(255, 145, 0)
local t = {}
local v3 = false
local t2 = {}

local function getCombinedRestock() --[[ getCombinedRestock | Line: 27 | Upvalues: t (copy), v1 (copy), v2 (copy) ]]
	local ArmorsShop = t.ArmorsShop
	local SwordShop = t.SwordShop

	if not (ArmorsShop and SwordShop) then
		return
	end

	local t2 = {
		Message = string.format("Your <font color=\"#%s\">Pickaxe Shop</font> and <font color=\"#%s\">Sword Shop</font> have been restocked", v1:ToHex(), v2:ToHex())
	}

	t2.Time = math.max(ArmorsShop.Time or 5, SwordShop.Time or 5)
	t2.ShowShadow = ArmorsShop.ShowShadow or SwordShop.ShowShadow
	t2.Sound = ArmorsShop.Sound or SwordShop.Sound
	t2.DelayInRound = ArmorsShop.DelayInRound or SwordShop.DelayInRound

	return t2
end

local function flushRestocks() --[[ flushRestocks | Line: 48 | Upvalues: getCombinedRestock (copy), Message (copy), t (copy), v3 (ref) ]]
	local v1 = getCombinedRestock()

	if v1 then
		Message.Top(v1)
	else
		for v2, v32 in t do
			Message.Top(v32)
		end
	end

	table.clear(t)
	v3 = false
end

function t2.Push(p1, p2) --[[ Push | Line: 63 | Upvalues: t (copy), v3 (ref), flushRestocks (copy) ]]
	t[p1] = p2

	if not v3 then
		v3 = true
		task.delay(3, flushRestocks)
	end
end

return t2