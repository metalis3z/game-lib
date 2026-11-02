
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Index = require(ReplicatedStorage.Datas.Index)
local t1 = {
	Strawberry = true,
	Meowl = true,
	Skibidi = true,
	Headless = true,
	["John Pork"] = true,
	Spyder = true
}
local t2 = {
	Aquatic = "rbxassetid://100987404805977",
	["Bunny Basket"] = "rbxassetid://103854752453800",
	Candy = "rbxassetid://95295980395057",
	Christmas = "rbxassetid://82581266228221",
	Cursed = "rbxassetid://103442397385310",
	Cyber = "rbxassetid://70704569365791",
	Diamond = "rbxassetid://129081602059395",
	Divine = "rbxassetid://123619895457714",
	Easter = "rbxassetid://101004973484528",
	Galaxy = "rbxassetid://106862562813227",
	Gingerbread = "rbxassetid://85315107374050",
	Gold = "rbxassetid://80252148814852",
	Halloween = "rbxassetid://78069578479722",
	Headless = "rbxassetid://127794717088326",
	["John Pork"] = "rbxassetid://103526057900666",
	Lava = "rbxassetid://97577086368828",
	Lucky = "rbxassetid://99633507283702",
	Meowl = "rbxassetid://106055459107464",
	["Pot of Gold"] = "rbxassetid://104285709377050",
	Radioactive = "rbxassetid://102411245785930",
	Rainbow = "rbxassetid://131742943178952",
	Octo = "rbxassetid://117203223532989",
	Rose = "rbxassetid://87697470314885",
	Skibidi = "rbxassetid://115813831981880",
	Spyder = "rbxassetid://119443420474301",
	Strawberry = "rbxassetid://121254385285365",
	Summer = "rbxassetid://121389162032475",
	Taco = "rbxassetid://109613830616820",
	Valentines = "rbxassetid://72064872429166",
	YinYang = "rbxassetid://123280721293513"
}
local t3 = {
	Summer = true
}
local t4 = {
	EventBaseSkins = {
		"Summer",
		"Valentines",
		"Lucky",
		"Taco",
		"Easter"
	},
	PaidBaseSkins = {
		"Gingerbread",
		"Rose",
		"Pot of Gold",
		"Bunny Basket",
		"Octo"
	},
	OwnsInData = function(p1, s1: string)
		if typeof(p1.UnlockedBaseSkins) == "table" and p1.UnlockedBaseSkins[s1] == true then
			return true
		end

		if typeof(p1.BaseSkinInventory) == "table" then
			for _, v11 in p1.BaseSkinInventory do
				if typeof(v11) == "table" and s1 == v11.SkinName then
					return true
				end
			end
		end

		return false
	end,
	GetImage = function(s2: string)
		local v13 = t2[s2]

		if typeof(v13) == "string" and v13 ~= "" then
			return v13
		end

		return nil
	end,
	IsInventoryManaged = function(s3: string)
		if s3 == "Normal" or t1[s3] then
			return false
		end

		local v15 = Index[s3]

		if v15 and v15.IsMutation then
			return false
		end

		return true
	end
}

function t4.IsTradable(s4: string)
	return t4.IsInventoryManaged(s4) and not t3[s4]
end
function t4.GetOwnedEntries(p2, s5: string)
	local t5 = {}
	local v20 = p2:Get("BaseSkinInventory")

	if typeof(v20) ~= "table" then
		return t5
	end

	for v21, v22 in v20 do
		if typeof(v21) == "string" and typeof(v22) == "table" and s5 == v22.SkinName then
			t5[v21] = v22
		end
	end

	return t5
end
function t4.GetOwnedCount(p3, s6: string)
	local n1 = 0

	for _ in t4.GetOwnedEntries(p3, s6) do
		n1 += 1
	end

	if n1 > 0 then
		return n1
	end

	if not t4.IsInventoryManaged(s6) then
		if p3:Get(`UnlockedBaseSkins.{ s6 }`) then
			return 1
		end

		return 0
	end

	if not p3:Get("Migrations.BaseSkinInventory_v1") and p3:Get(`UnlockedBaseSkins.{ s6 }`) then
		return 1
	end

	return 0
end
function t4.Owns(p4, s7: string)
	if s7 == "Normal" then
		return true
	end

	return t4.GetOwnedCount(p4, s7) > 0
end
function t4.GetInventoryCount(p5)
	local n2 = 0
	local v31 = p5:Get("BaseSkinInventory")

	if typeof(v31) ~= "table" then
		return n2
	end

	for v32, v33 in v31 do
		if typeof(v32) == "string" and typeof(v33) == "table" then
			n2 += 1
		end
	end

	return n2
end
function t4.Grant(p6, s8: string, s9: string?)
	if not t4.IsInventoryManaged(s8) then
		return false, nil
	end

	if next(t4.GetOwnedEntries(p6, s8)) ~= nil then
		return false, nil
	end

	if typeof(p6:Get("BaseSkinInventory")) ~= "table" then
		p6:Set("BaseSkinInventory", {})
	end

	local guid = HttpService:GenerateGUID(false)

	while p6:Get(`BaseSkinInventory.{ guid }`) ~= nil do
		guid = HttpService:GenerateGUID(false)
	end

	p6:InsertOnDictionary("BaseSkinInventory", guid, {
		SkinName = s8,
		Source = s9,
		CreatedAt = DateTime.now().UnixTimestamp
	})

	return true, guid
end

return table.freeze(t4)
