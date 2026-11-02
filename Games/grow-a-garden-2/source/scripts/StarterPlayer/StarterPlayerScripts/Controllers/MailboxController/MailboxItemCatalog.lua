--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local SharedModules = ReplicatedStorage:WaitForChild("SharedModules")

local function tryRequire(p1) --[[ tryRequire | Line: 10 | Upvalues: SharedModules (copy) ]]
	local v1 = SharedModules:FindFirstChild(p1)

	if not (v1 and v1:IsA("ModuleScript")) then
		return nil
	end

	local ok, result = pcall(require, v1)

	if ok then
		return result
	end

	return nil
end

local SeedData = SharedModules:FindFirstChild("SeedData")
local v1

if SeedData and SeedData:IsA("ModuleScript") then
	local ok, result = pcall(require, SeedData)

	v1 = if ok then result else nil
else
	v1 = nil
end

local SprinklerData = SharedModules:FindFirstChild("SprinklerData")
local v2

if SprinklerData and SprinklerData:IsA("ModuleScript") then
	local ok, result = pcall(require, SprinklerData)

	v2 = if ok then result else nil
else
	v2 = nil
end

local WateringcanData = SharedModules:FindFirstChild("WateringcanData")
local v3

if WateringcanData and WateringcanData:IsA("ModuleScript") then
	local ok, result = pcall(require, WateringcanData)

	v3 = if ok then result else nil
else
	v3 = nil
end

local MushroomData = SharedModules:FindFirstChild("MushroomData")
local v4

if MushroomData and MushroomData:IsA("ModuleScript") then
	local ok, result = pcall(require, MushroomData)

	v4 = if ok then result else nil
else
	v4 = nil
end

local RaccoonData = SharedModules:FindFirstChild("RaccoonData")
local v5

if RaccoonData and RaccoonData:IsA("ModuleScript") then
	local ok, result = pcall(require, RaccoonData)

	v5 = if ok then result else nil
else
	v5 = nil
end

local GnomeData = SharedModules:FindFirstChild("GnomeData")
local v6

if GnomeData and GnomeData:IsA("ModuleScript") then
	local ok, result = pcall(require, GnomeData)

	v6 = if ok then result else nil
else
	v6 = nil
end

local PowerHoseData = SharedModules:FindFirstChild("PowerHoseData")
local v7

if PowerHoseData and PowerHoseData:IsA("ModuleScript") then
	local ok, result = pcall(require, PowerHoseData)

	v7 = if ok then result else nil
else
	v7 = nil
end

local CrateData = SharedModules:FindFirstChild("CrateData")
local v8

if CrateData and CrateData:IsA("ModuleScript") then
	local ok, result = pcall(require, CrateData)

	v8 = if ok then result else nil
else
	v8 = nil
end

local GuildCrateData = SharedModules:FindFirstChild("GuildCrateData")
local v9

if GuildCrateData and GuildCrateData:IsA("ModuleScript") then
	local ok, result = pcall(require, GuildCrateData)

	v9 = if ok then result else nil
else
	v9 = nil
end

local SeedPackData = SharedModules:FindFirstChild("SeedPackData")
local v10

if SeedPackData and SeedPackData:IsA("ModuleScript") then
	local ok, result = pcall(require, SeedPackData)

	v10 = if ok then result else nil
else
	v10 = nil
end

local EggData = SharedModules:FindFirstChild("EggData")
local v11

if EggData and EggData:IsA("ModuleScript") then
	local ok, result = pcall(require, EggData)

	v11 = if ok then result else nil
else
	v11 = nil
end

local TrowelData = SharedModules:FindFirstChild("TrowelData")
local v12

if TrowelData and TrowelData:IsA("ModuleScript") then
	local ok, result = pcall(require, TrowelData)

	v12 = if ok then result else nil
else
	v12 = nil
end

local PropData = SharedModules:FindFirstChild("PropData")
local v13

if PropData and PropData:IsA("ModuleScript") then
	local ok, result = pcall(require, PropData)

	v13 = if ok then result else nil
else
	v13 = nil
end

local GearShopData = SharedModules:FindFirstChild("GearShopData")
local v14

if GearShopData and GearShopData:IsA("ModuleScript") then
	local ok, result = pcall(require, GearShopData)

	v14 = if ok then result else nil
else
	v14 = nil
end

local SellValueData = SharedModules:FindFirstChild("SellValueData")
local v15

if SellValueData and SellValueData:IsA("ModuleScript") then
	local ok, result = pcall(require, SellValueData)

	v15 = if ok then result else nil
else
	v15 = nil
end

local FruitValueCalc = SharedModules:FindFirstChild("FruitValueCalc")
local v16

if FruitValueCalc and FruitValueCalc:IsA("ModuleScript") then
	local ok, result = pcall(require, FruitValueCalc)

	v16 = if ok then result else nil
else
	v16 = nil
end

local v17 = nil
local SharedData = ReplicatedStorage:FindFirstChild("SharedData")
local v18 = SharedData and SharedData:FindFirstChild("PetData")

if v18 and v18:IsA("ModuleScript") then
	local ok, result = pcall(require, v18)

	if ok then
		v17 = result
	end
end

local GearImages = SharedModules:FindFirstChild("GearImages")
local PropImages = SharedModules:FindFirstChild("PropImages")

local function getStringValue(p1, p2) --[[ getStringValue | Line: 50 ]]
	if not p1 then
		return ""
	end

	local v1 = p1:FindFirstChild(p2)

	if v1 and v1:IsA("StringValue") then
		return v1.Value
	end

	if v1 and v1:IsA("ImageLabel") then
		return v1.Image
	end

	return ""
end

local function getGearImage(p1) --[[ getGearImage | Line: 61 | Upvalues: GearImages (copy) ]]
	local v1 = GearImages

	if not v1 then
		return ""
	end

	local v2 = v1:FindFirstChild(p1)

	if v2 and v2:IsA("StringValue") then
		return v2.Value
	end

	if v2 and v2:IsA("ImageLabel") then
		return v2.Image
	end

	return ""
end

local function getPropImage(p1) --[[ getPropImage | Line: 65 | Upvalues: PropImages (copy) ]]
	local v1 = PropImages

	if not v1 then
		return ""
	end

	local v2 = v1:FindFirstChild(p1)

	if v2 and v2:IsA("StringValue") then
		return v2.Value
	end

	if v2 and v2:IsA("ImageLabel") then
		return v2.Image
	end

	return ""
end

local function findEntry(p1, p2, p3) --[[ findEntry | Line: 69 ]]
	if typeof(p1) ~= "table" then
		return nil
	end

	for v1, v2 in p1 do
		for v3, v4 in p3 do
			if v2[v4] == p2 then
				return v2
			end
		end
	end

	return nil
end

local function getSeedAssetField(p1, p2) --[[ getSeedAssetField | Line: 81 | Upvalues: v1 (copy), findEntry (copy) ]]
	local v12 = v1

	if typeof(v12) ~= "table" then
		return nil
	end

	local v2 = findEntry(v12, p1, { "SeedName" })

	if not v2 then
		return nil
	end

	local v3 = v2[p2]

	if typeof(v3) == "Instance" then
		if v3:IsA("StringValue") then
			return v3.Value
		end

		if v3:IsA("ImageLabel") then
			return v3.Image
		end
	end

	return v3
end

local t = {
	Categories = {
		"Pets",
		"Sprinklers",
		"WateringCans",
		"Mushrooms",
		"Gnomes",
		"Raccoons",
		"Crates",
		"SeedPacks",
		"Trowels",
		"Props",
		"Seeds",
		"HarvestedFruits",
		"Flashbangs",
		"EmptyPots"
	}
}

function t.IsGiftable(p1) --[[ IsGiftable | Line: 115 | Upvalues: t (copy) ]]
	for v1, v2 in t.Categories do
		if v2 == p1 then
			return true
		end
	end

	return false
end

local function lookupSimple(p1, p2, p3, p4) --[[ lookupSimple | Line: 122 | Upvalues: findEntry (copy) ]]
	if typeof(p1) ~= "table" then
		return p2, ""
	end

	local v1 = findEntry(p1, p2, { p3 })

	if not v1 then
		return p2, ""
	end

	local v2 = v1[p4]

	if typeof(v2) ~= "string" then
		v2 = ""
	end

	return v1[p3] or p2, v2
end

local function lookupGearByName(p1, p2, p3, p4) --[[ lookupGearByName | Line: 131 | Upvalues: lookupSimple (copy) ]]
	if typeof(p1) == "table" and typeof(p1.Data) == "table" then
		p1 = p1.Data
	end

	return lookupSimple(p1, p2, p3, p4)
end

function t.Resolve(p1, p2, p3) --[[ Resolve | Line: 142 | Upvalues: getSeedAssetField (copy), v17 (ref), lookupGearByName (copy), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), v7 (copy), v9 (copy), v8 (copy), v10 (copy), v11 (copy), PropImages (copy), v13 (copy), v12 (copy), GearImages (copy) ]]
	if p1 == "Seeds" then
		local v1 = getSeedAssetField(p2, "SeedImage") or ""
		local v22 = string.lower(p2)
		local v32 = if string.sub(v22, -5) == " seed" or v22 == "seed" then p2 else p2 .. " Seed"
		local v42, v52

		if typeof(v1) == "string" and v1 then
			v42 = v32
			v52 = v1
		else
			v42 = v32
			v52 = ""
		end

		return v42, v52
	end

	if p1 == "HarvestedFruits" then
		local v62, v72

		if typeof(p3) == "table" then
			v62 = p3.Mutation
			v72 = p3.FruitName or (p3.Name or p2)
		else
			v72 = p2
			v62 = nil
		end

		local v92 = getSeedAssetField(v72, "FruitImage") or ""
		local v102 = if v62 and v62 ~= "" then string.format("%s [%s]", v72, v62) else v72
		local v112, v122

		if typeof(v92) == "string" and v92 then
			v112 = v102
			v122 = v92
		else
			v112 = v102
			v122 = ""
		end

		return v112, v122
	end

	if p1 == "Pets" then
		local v132, v14, v15, v16

		if typeof(p3) == "table" then
			v132 = p3.Name or p2
			v14 = p3.Mutation
			v15 = p3.Size
			v16 = p3.Type
		else
			v132 = p2
			v16 = nil
			v15 = nil
			v14 = nil
		end

		local v172 = ""

		if typeof(v17) == "table" then
			if typeof(v17.GetImage) == "function" then
				local ok, result = pcall(v17.GetImage, v132, v15)

				if ok and typeof(result) == "string" and result ~= "" then
					v172 = result
				end
			end

			if v172 == "" then
				local v19 = v17[v132]

				if typeof(v19) == "table" and typeof(v19.Image) == "string" then
					v172 = v19.Image
				end
			end
		end

		local v21

		if typeof(v17) == "table" and typeof(v17.GetSpeciesDisplayName) == "function" then
			local ok, result = pcall(v17.GetSpeciesDisplayName, v132)

			v21 = if ok and typeof(result) == "string" then if result == "" then v132 else result else v132
		else
			v21 = v132
		end

		local t = {}

		if v16 ~= nil and v16 ~= "" then
			table.insert(t, v16)
		end

		if v15 ~= nil and v15 ~= "" then
			table.insert(t, v15)
		end

		table.insert(t, v21)

		local v22 = table.concat(t, " ")

		if v14 ~= nil and v14 ~= "" then
			v22 = string.format("%s [%s]", v22, v14)
		end

		return v22, v172
	end

	if p1 == "Sprinklers" then
		return lookupGearByName(v2, p2, "SprinklerName", "Image")
	end

	if p1 == "WateringCans" then
		return lookupGearByName(v3, p2, "Name", "Image")
	end

	if p1 == "Mushrooms" then
		return lookupGearByName(v4, p2, "Name", "IMG")
	end

	if p1 == "Raccoons" then
		return lookupGearByName(v5, p2, "Name", "IMG")
	end

	if p1 == "Gnomes" then
		return lookupGearByName(v6, p2, "Name", "IMG")
	end

	if p1 == "PowerHoses" then
		return lookupGearByName(v7, p2, "Name", "IMG")
	end

	if p1 == "Crates" then
		if v9 and v9.GetData then
			local v24 = v9.GetData(p2)

			if v24 then
				return v24.Name or p2, v24.IMG or ""
			end
		end

		if v8 and v8.GetData then
			local v25 = v8.GetData(p2)

			if v25 then
				return v25.Name or p2, v25.IMG or ""
			end
		end

		return p2, ""
	end

	if p1 == "SeedPacks" then
		return lookupGearByName(v10, p2, "PackName", "IMG")
	end

	if p1 == "Eggs" then
		if typeof(v11) == "table" and typeof(v11.GetData) == "function" then
			local v27 = v11.GetData(p2)

			if v27 then
				local IMG = v27.IMG
				local v28 = v27.EggName or p2

				if typeof(IMG) == "string" then
					return v28, IMG
				end

				return v28, ""
			end
		end

		return p2, ""
	end

	if p1 == "Props" then
		local v29 = PropImages
		local v30

		if v29 then
			local v31 = v29:FindFirstChild(p2)

			v30 = if v31 and v31:IsA("StringValue") then v31.Value elseif v31 and v31:IsA("ImageLabel") then v31.Image else ""
		else
			v30 = ""
		end

		if v30 == "" and (typeof(v13) == "table" and typeof(v13.Data) == "table") then
			for v33, v34 in v13.Data do
				if typeof(v34) == "table" and v34.PropName == p2 then
					if typeof(v34.IMG) == "string" then
						v30 = v34.IMG
					end

					break
				end
			end
		end

		return p2, v30
	end

	if p1 == "Trowels" then
		local v35 = ""

		if typeof(v12) == "table" then
			local Data = v12.Data

			if typeof(Data) == "table" and typeof(Data.IMG) == "string" then
				v35 = Data.IMG
			end
		end

		if v35 == "" then
			local v37 = GearImages

			if v37 then
				local v38 = v37:FindFirstChild(p2)

				v35 = if v38 and v38:IsA("StringValue") then v38.Value elseif v38 and v38:IsA("ImageLabel") then v38.Image else ""
			else
				v35 = ""
			end
		end

		return p2, v35
	end

	local v39 = GearImages

	if not v39 then
		return p2, ""
	end

	local v40 = v39:FindFirstChild(p2)

	if v40 and v40:IsA("StringValue") then
		return p2, v40.Value
	end

	if v40 and v40:IsA("ImageLabel") then
		return p2, v40.Image
	end

	return p2, ""
end

local v19 = nil

local function buildGearCostIndex() --[[ buildGearCostIndex | Line: 293 | Upvalues: v19 (ref), v14 (copy) ]]
	if v19 ~= nil then
		return
	end

	local t = {}

	if typeof(v14) == "table" and typeof(v14.Data) == "table" then
		for v2, v3 in v14.Data do
			if typeof(v3) == "table" and (typeof(v3.ItemName) == "string" and typeof(v3.Cost) == "number") then
				t[v3.ItemName] = v3.Cost
			end
		end
	end

	v19 = t
end

function t.GetValue(p1, p2, p3, p4) --[[ GetValue | Line: 313 | Upvalues: v16 (copy), v15 (copy), buildGearCostIndex (copy), v19 (ref) ]]
	if p1 == "HarvestedFruits" then
		if typeof(p3) ~= "table" then
			return 0
		end

		if typeof(v16) ~= "function" then
			return 0
		end

		local ok, result = pcall(v16, p3.FruitName or (p3.Name or p2), p3.SizeMultiplier or 1, p3.Mutation, p4)

		if ok and typeof(result) == "number" then
			return result
		end

		return 0
	end

	if p1 == "Seeds" then
		if typeof(v15) ~= "table" then
			return 0
		end

		local v5 = v15[p2]

		if typeof(v5) == "number" then
			return v5
		end

		return 0
	end

	buildGearCostIndex()

	local v6 = v19

	if not v6 then
		return 0
	end

	if typeof(v6[p2]) == "number" then
		return v6[p2]
	end

	return 0
end
function t.GetHeadshot(p1) --[[ GetHeadshot | Line: 341 | Upvalues: Players (copy) ]]
	local ok, result = pcall(function() --[[ Line: 342 | Upvalues: Players (ref), p1 (copy) ]]
		return Players:GetUserThumbnailAsync(p1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)

	if ok and typeof(result) == "string" then
		return result
	end

	return ""
end

local function setLabelChain(p1, p2) --[[ setLabelChain | Line: 386 ]]
	if p1:IsA("TextLabel") or p1:IsA("TextButton") then
		p1.Text = p2
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("TextLabel") or v2:IsA("TextButton") then
			v2.Text = p2
		end
	end
end

local t2 = {
	Common = "#bfbfbf",
	Uncommon = "#44d200",
	Rare = "#2f8bff",
	Epic = "#a64bff",
	Legendary = "#ffd11a",
	Mythic = "#ff3b3b",
	Super = "#ffffff"
}

local function pickGuildRewardTemplate(p1, p2) --[[ pickGuildRewardTemplate | Line: 442 ]]
	local function child(p12) --[[ child | Line: 446 | Upvalues: p1 (copy) ]]
		local v1 = p1:FindFirstChild(p12)

		if v1 and v1:IsA("Frame") then
			return v1
		end

		return nil
	end

	if p2 == "Owner" then
		local GuildRewardTemplate_Owner = p1:FindFirstChild("GuildRewardTemplate_Owner")
		local v1 = if GuildRewardTemplate_Owner and GuildRewardTemplate_Owner:IsA("Frame") then GuildRewardTemplate_Owner else nil

		if v1 then
			return v1, "Owner"
		end
	end

	if p2 == "Elder" then
		local GuildRewardTemplate_Elder = p1:FindFirstChild("GuildRewardTemplate_Elder")
		local v2 = if GuildRewardTemplate_Elder and GuildRewardTemplate_Elder:IsA("Frame") then GuildRewardTemplate_Elder else nil

		if v2 then
			return v2, "Elder"
		end
	end

	local GuildRewardTemplate = p1:FindFirstChild("GuildRewardTemplate")

	return if GuildRewardTemplate and GuildRewardTemplate:IsA("Frame") then GuildRewardTemplate else nil, "Member"
end

local function findPrizeDisplayTemplate(p1) --[[ findPrizeDisplayTemplate | Line: 468 ]]
	local Frame = p1:FindFirstChild("Frame")

	if Frame then
		local PrizeDisplayTemplate = Frame:FindFirstChild("PrizeDisplayTemplate")

		if PrizeDisplayTemplate and PrizeDisplayTemplate:IsA("Frame") then
			return PrizeDisplayTemplate, Frame
		end
	end

	local PrizeDisplayTemplate = p1:FindFirstChild("PrizeDisplayTemplate")

	if PrizeDisplayTemplate and PrizeDisplayTemplate:IsA("Frame") then
		return PrizeDisplayTemplate, p1
	end

	return nil, nil
end

local SeedpackReward = game.SoundService.SFX.SeedpackSFX.SeedpackReward

function t.BuildGuildRewardVisual(p1, p2, p3, p4) --[[ BuildGuildRewardVisual | Line: 505 | Upvalues: pickGuildRewardTemplate (copy), t2 (copy), findPrizeDisplayTemplate (copy), t (copy), SeedpackReward (copy) ]]
	if not p1 then
		return nil
	end

	local v2 = pickGuildRewardTemplate(p1, if typeof(p3.RoleAtFlip) == "string" then p3.RoleAtFlip else "Member")

	if not v2 then
		return nil
	end

	local v3 = v2:Clone()

	v3.Name = "Gift_" .. p2
	v3.Visible = true

	local Interior = v3:FindFirstChild("Interior")

	if not Interior then
		v3:Destroy()

		return nil
	end

	local v5 = string.format("<font color=\"%s\">Guild Reward</font>", if typeof(p3.Tier) == "string" then t2[p3.Tier] or "#ffffff" else "#ffd11a")
	local TopFrame = Interior:FindFirstChild("TopFrame")

	if TopFrame then
		local SubjectLine1 = TopFrame:FindFirstChild("SubjectLine1")

		if SubjectLine1 and (SubjectLine1:IsA("TextLabel") or SubjectLine1:IsA("TextButton")) then
			SubjectLine1.RichText = true
			SubjectLine1.Text = v5

			local SubjectLine2 = SubjectLine1:FindFirstChild("SubjectLine2")

			if SubjectLine2 and (SubjectLine2:IsA("TextLabel") or SubjectLine2:IsA("TextButton")) then
				SubjectLine2.RichText = true
				SubjectLine2.Text = v5
			end
		end
	end

	local v6 = tonumber(p3.Placement) or 0
	local NoteTextlabel = Interior:FindFirstChild("NoteTextlabel")

	if NoteTextlabel and (NoteTextlabel:IsA("TextLabel") or NoteTextlabel:IsA("TextButton")) then
		NoteTextlabel.RichText = false
		NoteTextlabel.Text = if v6 > 0 then string.format("Your guild placed #%d", v6) else "Your guild placed in the contest!"
	end

	local v8, v9 = findPrizeDisplayTemplate(Interior)

	if v8 and v9 then
		v8.Visible = false

		local v10 = if typeof(p3.Items) == "table" then p3.Items else {}

		if #v10 == 0 and (typeof(p3.CrateName) == "string" and p3.CrateName ~= "") then
			local t3 = {}
			local t4 = {
				Category = "Crates",
				ItemName = p3.CrateName
			}

			t4.Count = tonumber(p3.BaseAmount) or 1
			t3[1] = t4
			v10 = t3
		end

		for v11, v12 in v10 do
			if typeof(v12) == "table" then
				local v13 = if typeof(v12.ItemName) == "string" then v12.ItemName else ""
				local v14 = if typeof(v12.Category) == "string" then v12.Category else "Crates"
				local v15 = tonumber(v12.Count) or 1
				local _, v16 = t.Resolve(v14, v13, v12)
				local v17 = v8:Clone()

				v17.Name = string.format("PrizeDisplay_%d", v11)
				v17.Visible = true
				v17.LayoutOrder = v11
				v17.Parent = v9

				local PrizeImage = v17.Frame:FindFirstChild("PrizeImage")

				if PrizeImage and PrizeImage:IsA("ImageLabel") then
					PrizeImage.Image = v16
				end

				for v18, v19 in { "Count", "Amount", "CountLabel" } do
					local v20 = v17.Frame:FindFirstChild(v19)

					if v20 and (v20:IsA("TextLabel") or v20:IsA("TextButton")) then
						v20.Text = "x" .. tostring(v15)
					end
				end
			end
		end
	end

	local Claim = Interior:FindFirstChild("Claim")

	if not (Claim and Claim:IsA("GuiButton")) then
		v3.Parent = p1

		return v3
	end

	Claim.MouseButton1Click:Connect(function() --[[ Line: 614 | Upvalues: SeedpackReward (ref), p4 (copy) ]]
		SeedpackReward.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		SeedpackReward.Playing = true
		SeedpackReward.TimePosition = 0
		p4()
	end)
	v3.Parent = p1

	return v3
end
function t.BuildInviteVisual(p1, p2, p3, p4, p5, p6) --[[ BuildInviteVisual | Line: 626 | Upvalues: setLabelChain (copy), t (copy) ]]
	if not (p1 and p1:IsA("Frame")) then
		return nil
	end

	local v1 = p1:Clone()

	v1.Name = "Invite_" .. p3
	v1.Visible = true

	local Interior = v1:FindFirstChild("Interior")

	if not Interior then
		v1:Destroy()

		return nil
	end

	local v3 = tostring(p4.GuildName or "Unknown Guild")
	local v5 = tostring(p4.GuildTag or "?")
	local v7 = tostring(p4.FromName or "?")
	local TopFrame = Interior:FindFirstChild("TopFrame")

	if TopFrame then
		local SubjectLine1 = TopFrame:FindFirstChild("SubjectLine1")

		if SubjectLine1 then
			setLabelChain(SubjectLine1, string.format("Guild Invite from @%s", v7))
		end

		local SentPlayerImageLabel = TopFrame:FindFirstChild("SentPlayerImageLabel")

		if SentPlayerImageLabel and SentPlayerImageLabel:IsA("ImageLabel") then
			task.spawn(function() --[[ Line: 666 | Upvalues: t (ref), p4 (copy), v1 (copy), SentPlayerImageLabel (copy) ]]
				local v12 = t.GetHeadshot(p4.FromUserId or 0)

				if v12 == "" or not v1.Parent then
					return
				end

				SentPlayerImageLabel.Image = v12
			end)
		end
	end

	local NoteTextlabel = Interior:FindFirstChild("NoteTextlabel")

	if NoteTextlabel then
		setLabelChain(NoteTextlabel, string.format("%s [%s] | %s", v3, v5, if p4.MemberCount and p4.MaxSlots then string.format("%d/%d Members", p4.MemberCount, p4.MaxSlots) else "?/? Members"))
	end

	local JoinButton = Interior:FindFirstChild("JoinButton")

	if JoinButton and JoinButton:IsA("GuiButton") then
		JoinButton.MouseButton1Click:Connect(function() --[[ Line: 691 | Upvalues: p5 (copy) ]]
			p5()
		end)
	end

	local ExitButton = Interior:FindFirstChild("ExitButton")

	if not (ExitButton and ExitButton:IsA("GuiButton")) then
		v1.Parent = p2

		return v1
	end

	ExitButton.MouseButton1Click:Connect(function() --[[ Line: 699 | Upvalues: p6 (copy) ]]
		p6()
	end)
	v1.Parent = p2

	return v1
end

return t