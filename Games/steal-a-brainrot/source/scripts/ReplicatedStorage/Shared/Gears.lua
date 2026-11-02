
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Items = require(ReplicatedStorage.Datas.Items)
local t1 = {
	"Santa's Sleigh",
	"Cupid's Wings",
	"Witch's Broom",
	"Waverider",
	"Yin Yang Slap",
	"Cursed Slap",
	"Cyber Slap",
	"Divine Slap",
	"Bloodmoon Slap",
	"Radioactive Slap",
	"Rainbow Slap"
}
local t2 = {
	["Santa's Sleigh"] = "rbxassetid://106575011463424",
	["Cupid's Wings"] = "rbxassetid://125592127726740",
	["Witch's Broom"] = "rbxassetid://118466141203194",
	Waverider = "rbxassetid://125399512921257"
}
local t3 = {}

for _, v8 in t1 do
	t3[v8] = true
end

local t4 = {
	"Yin Yang Slap",
	"Cursed Slap",
	"Cyber Slap",
	"Phantom Slap",
	"Divine Slap",
	"Bloodmoon Slap",
	"Radioactive Slap",
	"Rainbow Slap"
}
local t5 = {}

for _, v12 in t4 do
	t5[v12] = true
end

local t6 = {
	TradableOrder = t1,
	ClaimOnceOrder = t4,
	IsTradable = function(s1: string)
		return t3[s1] == true
	end,
	IsClaimOnce = function(s2: string)
		return t5[s2] == true
	end,
	HasClaimed = function(p1, s3: string)
		return p1:Get(`ClaimedGears.{ s3 }`) == true
	end,
	MarkClaimed = function(p2, s4: string)
		if typeof(p2:Get("ClaimedGears")) ~= "table" then
			p2:Set("ClaimedGears", {})
		end

		if p2:Get(`ClaimedGears.{ s4 }`) ~= true then
			p2:InsertOnDictionary("ClaimedGears", s4, true)
		end
	end
}

function t6.AlreadyObtained(p3, s5: string)
	if p3:Get(`Items.{ s5 }`) == true then
		return true
	end

	return t6.IsClaimOnce(s5) and t6.HasClaimed(p3, s5)
end
function t6.OwnsInData(p4, s6: string)
	if typeof(p4.GearInventory) == "table" then
		for _, v28 in p4.GearInventory do
			if typeof(v28) == "table" and s6 == v28.GearName then
				return true
			end
		end
	end

	return typeof(p4.Items) == "table" and p4.Items[s6] == true
end
function t6.GetImage(s7: string)
	local v30 = t2[s7]

	if typeof(v30) == "string" and v30 ~= "" then
		return v30
	end

	local v31 = Items[s7]

	if v31 then
		local Icon = v31.Icon

		if typeof(Icon) == "string" and Icon ~= "" and Icon ~= "rbxassetid://0" then
			return Icon
		end
	end

	return nil
end
function t6.GetDisplayName(s8: string)
	return s8
end

local function getInventory(p5)
	local v35 = p5:Get("GearInventory")

	if typeof(v35) == "table" then
		return v35
	end

	return {}
end
local function ownsViaItemsFlag(p6, s9: string)
	return p6:Get(`Items.{ s9 }`) == true
end

function t6.GetOwnedEntries(p7, s10: string)
	local t7 = {}
	local v41 = p7:Get("GearInventory")
	local v42, v43

	if typeof(v41) == "table" then
		v42 = nil
		v43 = nil
	else
		v41 = {}
		v42 = nil
		v43 = nil
	end

	for v44, v45 in v41, v42, v43 do
		if typeof(v44) == "string" and typeof(v45) == "table" and s10 == v45.GearName then
			t7[v44] = v45
		end
	end

	return t7
end

local function getInventoryCount(p8, s11: string)
	local n1 = 0

	for _ in t6.GetOwnedEntries(p8, s11) do
		n1 += 1
	end

	return n1
end

function t6.GetOwnedCount(p9, s12: string)
	local n2 = 0

	for _ in t6.GetOwnedEntries(p9, s12) do
		n2 += 1
	end

	if n2 > 0 then
		return n2
	end

	if p9:Get(`Items.{ s12 }`) == true then
		return 1
	end

	return 0
end
function t6.GetTotalCount(p10)
	local n3 = 0
	local v56 = p10:Get("GearInventory")
	local v57, v58

	if typeof(v56) == "table" then
		v57 = nil
		v58 = nil
	else
		v56 = {}
		v57 = nil
		v58 = nil
	end

	for v59, v60 in v56, v57, v58 do
		if typeof(v59) == "string" and typeof(v60) == "table" then
			n3 += 1
		end
	end

	return n3
end
function t6.Owns(p11, s13: string)
	return t6.GetOwnedCount(p11, s13) > 0
end
function t6.ListOwned(p12)
	local t8 = {}

	for _, v66 in t1 do
		local v67 = false

		for v68, v69 in (t6.GetOwnedEntries(p12, v66)) do
			v67 = true
			table.insert(t8, {
				GearName = v66,
				UUID = v68,
				Source = v69.Source,
				CreatedAt = v69.CreatedAt
			})
		end

		if not v67 and p12:Get(`Items.{ v66 }`) == true then
			table.insert(t8, {
				GearName = v66
			})
		end
	end

	return t8
end
function t6.ResolveOwnedRef(p13, p14)
	if typeof(p14) ~= "table" then
		return nil
	end

	local GearName = p14.GearName

	if typeof(GearName) ~= "string" or not t6.IsTradable(GearName) then
		return nil
	end

	local UUID = p14.UUID

	if typeof(UUID) == "string" then
		local v74 = p13:Get("GearInventory")
		local v75 = ((if typeof(v74) ~= "table" then {} else v74))[UUID]

		if typeof(v75) ~= "table" or GearName ~= v75.GearName then
			return nil
		end

		return {
			GearName = GearName,
			UUID = UUID
		}
	end

	local n4 = 0

	for _ in t6.GetOwnedEntries(p13, GearName) do
		n4 += 1
	end

	if n4 > 0 then
		return nil
	end

	if p13:Get(`Items.{ GearName }`) ~= true then
		return nil
	end

	return {
		GearName = GearName
	}
end
function t6.Escrow(p15, p16)
	if typeof(p16) ~= "table" or typeof(p16.GearName) ~= "string" then
		return nil
	end

	local GearName = p16.GearName
	local UUID = p16.UUID
	local t9

	if typeof(UUID) == "string" then
		local v82 = p15:Get("GearInventory")
		local v83 = ((if typeof(v82) ~= "table" then {} else v82))[UUID]

		if typeof(v83) ~= "table" or GearName ~= v83.GearName then
			return nil
		end

		p15:RemoveFromDictionary("GearInventory", UUID)
		t9 = {
			GearName = GearName,
			UUID = UUID,
			Source = v83.Source,
			CreatedAt = v83.CreatedAt
		}

		local n5 = 0

		for _ in t6.GetOwnedEntries(p15, GearName) do
			n5 += 1
		end

		if n5 == 0 then
			p15:RemoveFromDictionary("Items", GearName)

			return t9
		end
	else
		if p15:Get(`Items.{ GearName }`) ~= true then
			return nil
		end

		p15:RemoveFromDictionary("Items", GearName)
		t9 = {
			GearName = GearName
		}
	end

	return t9
end
function t6.Grant(p17, s14: string, s15: string?)
	if not t6.IsTradable(s14) then
		return false, nil
	end

	if typeof(p17:Get("GearInventory")) ~= "table" then
		p17:Set("GearInventory", {})
	end

	local guid = HttpService:GenerateGUID(false)

	while p17:Get(`GearInventory.{ guid }`) ~= nil do
		guid = HttpService:GenerateGUID(false)
	end

	p17:InsertOnDictionary("GearInventory", guid, {
		GearName = s14,
		Source = s15,
		CreatedAt = DateTime.now().UnixTimestamp
	})

	if p17:Get(`Items.{ s14 }`) ~= true then
		p17:InsertOnDictionary("Items", s14, true)
	end

	return true, guid
end
function t6.GrantToData(p18, s16: string, s17: string?)
	if not t6.IsTradable(s16) then
		return false, nil
	end

	if typeof(p18.GearInventory) ~= "table" then
		p18.GearInventory = {}
	end

	for _, v95 in p18.GearInventory do
		if typeof(v95) == "table" and s16 == v95.GearName then
			return false, nil
		end
	end

	local guid = HttpService:GenerateGUID(false)

	while p18.GearInventory[guid] ~= nil do
		guid = HttpService:GenerateGUID(false)
	end

	p18.GearInventory[guid] = {
		GearName = s16,
		Source = s17,
		CreatedAt = DateTime.now().UnixTimestamp
	}

	if typeof(p18.Items) ~= "table" then
		p18.Items = {}
	end

	p18.Items[s16] = true

	return true, guid
end
function t6.Restore(p19, p20)
	if typeof(p20) ~= "table" or typeof(p20.GearName) ~= "string" then
		return
	end

	local GearName = p20.GearName

	if typeof(p20.UUID) == "string" then
		if typeof(p19.GearInventory) ~= "table" then
			p19.GearInventory = {}
		end

		p19.GearInventory[p20.UUID] = {
			GearName = GearName,
			Source = p20.Source,
			CreatedAt = p20.CreatedAt
		}
	end

	if typeof(p19.Items) ~= "table" then
		p19.Items = {}
	end

	p19.Items[GearName] = true
end

return table.freeze(t6)
