local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local BadgeService = game:GetService("BadgeService")
local MarketplaceService = game:GetService("MarketplaceService")
local DataStore = DataStoreService:GetDataStore("FE2DataBase_1")
local Multiplayer = workspace:WaitForChild("Multiplayer")
local Lobby = workspace:WaitForChild("Lobby")
local BezierLib = require(script.Bezier)
local AdminModule = require(script.AdminModule)
local FE2Library = require(ReplicatedStorage:WaitForChild("SharedModules").FE2Library)
local rem = game.ReplicatedStorage:WaitForChild("Remote")
--local ChallengeLib = require(script.Parent.Misc.SV_DailyChallenges.ChallengeModule)
local CurrentMap = nil
local bindables = game:GetService("ServerStorage"):WaitForChild("Bindables")
local challengeBin = bindables:WaitForChild("Challenges")
local stop = false
local items = game.ReplicatedStorage.Items
local Players_Waiting = {}
local Players_Playing = {}
local Players_Voting = {}
local Players_Won = {}
local PlayerTouched = {}
local PlayersLoading = {}
local MapData = {}
local ForceMap = nil
local VotingMaxTime = 10
MapData[1] = {}
MapData[2] = {}
MapData[3] = {}
MapData[4] = {}
MapData[5] = {}
MapData[6] = {}
local Admins = {}
local Maps = {}
local ServerInit = time()
local PlayersWhoVoted = {}
local PlayerSelectedMaps = {}
local MonthNames = {"January","February","March","April","May","June","July","August","September","October","November","December"}
local GroupButtonCount = 1
local CurrentButtonCount = 0
local dateValue = os.date("!*t")
local CurrentMonth = MonthNames[dateValue["month"]]
local CurrentYear = dateValue["year"]
local CurrentDif = 1
local CurrentBoost = 5
local CurrentBoostValue = 0
local IsGameRunning = false
local voting = false
local MapGlobalID = 0
local voteStats = {
	mapData = {},
	pVotes = {}
}
local PlayerData = {}
local Map_PlayerData = {}
local MapsVoting
local cooldownData = {}
local VoteCostCounter = 0
local isExitOpen = false
local PassKey = math.random(1, 999999)
local EventCounter = 3
local EscapeeImportantParts = {
	"Humanoid",
	"Head",
	"Torso",
	"Left Arm",
	"Left Leg",
	"Right Arm",
	"Right Leg",
	"HumanoidRootPart",
	"RescueZone",
	"EscapeeSettings"
}
local vaildCodes = {
	{code = "ok", gems = 500, coins = 500, xp = 5000},
	{code = "aCodeThatContainsStuff", gems = 100, coins = 200, xp = 2500},
	{code = "LotsOfWater", gems = 60, coins = 120, xp = 2000},
	{code = "HalfADecade", gems = 40, coins = 80, xp = 1000},
	{code = "NoWay10K", gems = 100, coins = 100, xp = 0},
	{code = "JustForYou", gems = 100, coins = 0, xp = 0},
	{code = "LuckyNumber7", gems = 7, coins = 70, xp = 700},
	{code = "MadeYouLook", gems = 50, coins = 100, xp = 0},
	{code = "25KMembers", gems = 20, coins = 0, xp = 0},
	{code = "WannaSeeMeSpeedrun?", gems = 0, coins = 0, xp = 0, skinID = 164},
	{code = "4000onTwitter", gems = 10, coins = 60, xp = 0},
	{code = "2021goodwill", gems = 50, coins = 100, xp = 1000},
	{code = "happybirthdayfloodescape2", gems = 0, coins = 0, xp = 0, tankid = 161},
	{code = "finally", gems = 50, coins = 20, xp = 0},
	{code = "LotsOfItems", gems = 0, coins = 200, xp = 0},
	{code = "Happy400M", gems = 100, coins = 30, xp = 1000},
	{code = "iwannavote", gems = 10, coins = 60, xp = 0},
	{code = "6YearsOfFloodEscape2", gems = 60, coins = 600, xp = 2189},
	{code = "5thAnniversaryFE2", gems = 20, coins = 40, xp = 500},
	{code = "XSxriptX", gems = 10000000, coins = 10000000, xp = 10000000},
}
local ChinaPolicy = require(ReplicatedStorage.SharedModules.ChinaPolicyService)
local itemDataL = ChinaPolicy.fetchItemData()[1]

local function ReqRebirthFired(player : Player)
	if ((PlayerData[player.Name].level == 100 and PlayerData[player.Name].xp >= 10000) or (PlayerData[player.Name].level > 100)) and PlayerData[player.Name].rebirths < 30 then
		PlayerData[player.Name].xp = 0
		PlayerData[player.Name].level = 1
		PlayerData[player.Name].rebirths += 1
		rem.LvlUp:FireClient(player, 10)
		rem.UpdPlayerData:FireClient(player, PlayerData[player.Name])
	end
end

rem.ReqRebirth.OnServerEvent:Connect(ReqRebirthFired)

rem.StartedGame.OnServerEvent:Connect(function(player)
	wait()
	repeat task.wait() until PlayerData[player.Name] ~= nil
	if CheckGamepassOwnership(player).VIP then
		local rewards = ChinaPolicy.fetchProductAwards()[4223166]
		for _, item in ipairs(rewards) do
			if not table.find(PlayerData[player.Name].inventory, item) then
				table.insert(PlayerData[player.Name].inventory, item)
				local _item_ = nil
				for _, itemdata in next, itemDataL do
					if itemdata.ID == item then
						_item_ = itemdata
						break
					end
				end
				rem.Notify:FireClient(player, "You have been awarded with " .. _item_.name .. "!", "Item Awarded", nil, _item_.imgID)
			end
		end
		rem.UpdPlayerData:FireClient(player, PlayerData[player.Name])
	end
end)

rem.BoostIntensity.OnServerEvent:Connect(function(player : Player)
	print("Boosting")
	repeat task.wait() until PlayerData[player.Name] ~= nil
	local data = PlayerData[player.Name]
	local m_1 = data.gems - CurrentBoost
	print(m_1)
	if m_1 <= 0 then
		return
	end
	if m_1 > 0 then
		data.gems -= CurrentBoost
		--CurrentBoost = ((CurrentBoost == 5 or CurrentBoost == 9) and CurrentBoost + 0.5) or CurrentBoost
		local DoubleIntBoost = MarketplaceService:UserOwnsGamePassAsync(player.UserId, 14432092)
		CurrentBoostValue += (DoubleIntBoost and 1 or 0.5)
		rem.UpdPlayerData:FireClient(player, data)
		--print(CurrentDif)
		local AlertMessage = (player.Name .. " boosted" .. (DoubleIntBoost and " X2!" or "!") .. " Min. Intensity: %s - %s")
		local BoostColor = FE2Library.getDifInfo()[math.floor(math.clamp(CurrentBoostValue + CurrentDif, 1, 6.99))].Color
		local minInt = (CurrentBoostValue + CurrentDif) - (DoubleIntBoost and 1 or 0.5)
		CurrentBoost = ((CurrentBoost == 5 or CurrentBoost == 9) and CurrentBoost + 0.5) or CurrentBoost
		CurrentBoost = math.floor(CurrentBoost*(49/28))
		if minInt <= 0 then
			minInt = CurrentBoostValue
		end
		ServerStorage.Bindables.Challenges.BoostedIntensity:Fire(player, data)
		rem.UpdIngameStats:FireAllClients({
			boostingEnabled = minInt < 6.99,
			intBoostCurrentCost = CurrentBoost,
		})
		--print(minInt, CurrentBoostValue)
		rem.Alert:FireAllClients(AlertMessage:format(math.clamp(minInt, 1, 6.99), math.clamp((CurrentBoostValue + CurrentDif), 1, 6.99)), BoostColor, 2, minInt >= 6.99 and 'rainbow' or nil)
		if ReplicatedStorage.Flags.HasPlayedMap.Value == false then
			CurrentBoostValue = 0
			CurrentDif += (DoubleIntBoost and 1 or 0.5)
			CurrentDif = math.clamp(CurrentDif, 1, 6.99)
			--print(CurrentDif + CurrentBoostValue)
			rem.UpdateLobby:Fire(10, 10, "Ready!", "Waiting for Players", CurrentDif)
		end
	end
end)

type MapInfo = {
	Buttons : {Model},
	ExitRegions : {Model},
	Map : model,
	Creator : string,
	MapName : string,
	Difficulty : number,
	MapImage : number,
	BGM : string | number,
	MaxTime : number
}

local Events = {
	"Rescue",
	"All Group Buttons",
	"Random Group Buttons",
	"Exploding Buttons",
}

local function CreateMapInfo(Map : Model)
	local MapInfo : MapInfo = {}
	MapInfo.Buttons = {}
	MapInfo.ExitRegions = {}
	MapInfo.Map = Map:Clone()
	MapInfo.Creator = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("Creator")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("Creator") and Map:FindFirstChild("Settings"):FindFirstChild("Creator").Value) or "???"
	MapInfo.MapName = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("MapName")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("MapName") and Map:FindFirstChild("Settings"):FindFirstChild("MapName").Value) or "???"
	MapInfo.Difficulty = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("Difficulty")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("Difficulty") and Map:FindFirstChild("Settings"):FindFirstChild("Difficulty").Value) or 6.9
	MapInfo.MapImage = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("MapImage")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("MapImage") and Map:FindFirstChild("Settings"):FindFirstChild("MapImage").Value) 
	MapInfo.BGM = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("BGM")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("BGM") and Map:FindFirstChild("Settings"):FindFirstChild("BGM").Value) or 0
	MapInfo.MaxTime = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("MaxTime")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("MaxTime") and Map:FindFirstChild("Settings"):FindFirstChild("MaxTime").Value) or 90
	MapInfo.buttonCount = GetButtonCount(Map)
	for _, item in ipairs(MapInfo.Map:GetDescendants()) do
		if string.sub(item.Name, 1, 7) == "_Button" then
			table.insert(MapInfo.Buttons, item)
		end
		if item.Name == "ExitRegion" then
			table.insert(MapInfo.ExitRegions, item)
		end
	end
	--print(MapInfo)
	return MapInfo
end

local function getPlayerFromCharacter(character)
	for _, player in pairs(game:GetService("Players"):GetPlayers()) do
		if player.Character == character then
			return player
		end
	end
end

local function LoopThroughMapDescendants(descendantsN, Button)
	for index, descendantN in pairs(descendantsN) do
		local children = descendantN:GetChildren()
		for i, child in ipairs(children) do
			local waitValue = 0
			if child:FindFirstChild("_Delay") then
				waitValue = child._Delay.Value
			end
			if child.Name == "_Fall"..string.sub(Button.Name, 8) then
				if child.Parent.ClassName == "Model" or child.Parent.ClassName == "Folder" then
					local descendantsA = child.Parent:GetDescendants()
					for index, descendantA in pairs(descendantsA) do
						if descendantA:IsA("BasePart") then
							wait(waitValue)
							descendantA.Anchored = false
						end
					end
					game:GetService("Debris"):AddItem(child.Parent, 3)
				else
					wait(waitValue)
					child.Parent.Anchored = false
					game:GetService("Debris"):AddItem(child.Parent, 3)
				end
			elseif child.Name == "_Fade"..string.sub(Button.Name, 8) then
				if child.Parent.ClassName == "Model" or child.Parent.ClassName == "Folder" then
					local descendantsA = child.Parent:GetDescendants()
					for index, descendantA in pairs(descendantsA) do
						if descendantA:IsA("BasePart") then
							wait(waitValue)
							descendantA.CanCollide = false
							descendantA.Transparency = 1
						end
					end
				else
					wait(waitValue)
					child.Parent.CanCollide = false
					child.Parent.Transparency = 1
				end
			elseif child.Name == "_Appear"..string.sub(Button.Name, 8) then
				if child.Parent.ClassName == "Model" or child.Parent.ClassName == "Folder" then
					local descendantsA = child.Parent:GetDescendants()
					for index, descendantA in pairs(descendantsA) do
						if descendantA:IsA("BasePart") then
							wait(waitValue)
							descendantA.CanCollide = true
							descendantA.Transparency = 0
						end
					end
				else
					wait(waitValue)
					child.Parent.CanCollide = true
					child.Parent.Transparency = 0
				end
			elseif child.Name == "_Sound"..string.sub(Button.Name, 8) then
				wait(waitValue)
				child:Play()
			end
		end
	end
end
local function RemoveVariant(Map: Model)
	local function MutVariant(Variant_List)
		local a = {}
		for index, Variant in ipairs(Variant_List) do
			table.insert(a, Variant)
		end
		local rand = math.random(1,#a)
		local Variant = Variant_List[rand]
		local AvaiableVariants = Variant:GetChildren()
		local RandomVariant = AvaiableVariants[math.random(1,#AvaiableVariants)]
		for index, prt in pairs(Variant:GetChildren()) do
			if prt == RandomVariant then
			else
				prt:Destroy()
			end
			if Variant:GetChildren() == 1 then
				break
			end
		end
		for index, item in ipairs(a) do
			if Variant_List[index] == item then
				table.remove(Variant_List, index)
			end
		end
	end
	local Variant = {}
	for index, model in pairs(Map:GetDescendants()) do
		if model.Name == "_Variants" then
			table.insert(Variant, model)
		end
	end
	if Variant ~= nil then
		if #Variant == 1 then
			local VariantModel = nil
			for index, model in pairs(Map:GetDescendants()) do
				if model.Name == "_Variants" then
					VariantModel = model
				end
			end
			local AvaiableVariants = VariantModel:GetChildren()
			local RandomVariant = AvaiableVariants[math.random(1,#AvaiableVariants)]
			for index, prt in pairs(VariantModel:GetChildren()) do
				if prt == RandomVariant then
				else
					prt:Destroy()
				end
			end
		elseif #Variant > 1 then
			repeat task.wait() MutVariant(Variant) until #Variant == 1
		end
	end
end
local function GetMapLib()
	local Map = workspace.Multiplayer.Map
	local btnFuncs = {}
	local Button = game.ServerStorage.Bindables.BtnPress.Event
	local MapScript = require(script.Parent.MapScript)
	local Lib = {
		Map = Map,
		Script = MapScript,
		Button = Button,
		btnFuncs = btnFuncs,
	}
	return Lib
end

local function getRandomInPart(part)
	local random = Random.new()
	local randomCFrame = part.CFrame * CFrame.new(random:NextNumber(-part.Size.X/2,part.Size.X/2), random:NextNumber(-part.Size.Y/2,part.Size.Y/2), random:NextNumber(-part.Size.Z/2,part.Size.Z/2))
	return randomCFrame
end
function shuffleTable(t)
	local n = #t
	for i = n, 2, -1 do
		local j = math.random(1, i)
		t[i], t[j] = t[j], t[i]
	end
end
local function coolfunc(self)
	if cooldownData[self.Map] == nil then
		cooldownData[self.Map] = {}
	end
	cooldownData[self.Map].cooldown = self.cooldown
	cooldownData[self.Map].cooldowned = self.cooldowned
end
function GetButtonCount(map : Model)
	local i = 0
	for index, item in next, map:GetDescendants() do
		if item:IsA("Model") and string.sub(item.Name, 1, 7) == "_Button" then
			i += 1
		end
	end
	return i
end
local function createHighlightInfo(map)
	if not map:FindFirstChild("Settings") then
		return
	end
	local aaaa = {
		Name = map.Settings:GetAttribute("MapName") or (map.Settings:FindFirstChild("MapName") and map.Settings.MapName.Value) or '???',
		Image = map.Settings:GetAttribute("MapImage") or (map.Settings:FindFirstChild("MapImage") and map.Settings.MapImage.Value) or 0,
		Difficulty = map.Settings:GetAttribute("Difficulty") or (map.Settings:FindFirstChild("Difficulty") and map.Settings.Difficulty.Value) or 6,
		BadgeID = (map.Settings:GetAttribute("BadgeID") or (map.Settings:FindFirstChild("BadgeID") and map.Settings.BadgeID.Value)) or (map.Settings:GetAttribute("Badge") or (map.Settings:FindFirstChild("Badge") and map.Settings.Badge.Value)) or 0,
	}
	--print(aaaa)
	return aaaa
end
function findFromTable(tab,element)
	for _,v in pairs(tab) do
		if v == element then
			return true
		end
	end
	return false
end
local function createMapVoteInfo(map)
	if not map:FindFirstChild("Settings") then
		return
	end
	VoteCostCounter = VoteCostCounter + 1
	MapGlobalID = MapGlobalID + 1
	table.insert(Maps, map)
	local thisId = MapGlobalID
	local cooldownL = cooldownData[map] and cooldownData[map] or {cooldown = false, cooldowned = false}
	local mapdata = {
		name = map.Settings:GetAttribute("MapName") or (map.Settings:FindFirstChild("MapName") and map.Settings.MapName.Value) or '???',
		ID = thisId,
		imgID = map.Settings:GetAttribute("MapImage") or (map.Settings:FindFirstChild("MapImage") and map.Settings.MapImage.Value) or 0,
		difficulty = map.Settings:GetAttribute("Difficulty") or (map.Settings:FindFirstChild("Difficulty") and map.Settings.Difficulty.Value) or 6,
		displayMap = false,
		cooldown = cooldownL.cooldown,
		cooldowned = cooldownL.cooldowned,
		locked = false,
		unlockCost = 0,
		extraVoteCost = 10,
		Map = map,
		voteCount = 0,
		buttonCount = GetButtonCount(map),
		Creator = (map:FindFirstChild("Settings") and map:FindFirstChild("Settings"):GetAttribute("Creator")) or (map:FindFirstChild("Settings") and map:FindFirstChild("Settings"):FindFirstChild("Creator") and map:FindFirstChild("Settings"):FindFirstChild("Creator").Value) or "???",
		specialMapName = nil,
		specialMapColor = nil,
		specialMap = (map.Settings:FindFirstChild("Featured") and map.Settings.Featured.Value) 
			or map.Settings:GetAttribute("Featured")
			or (map.Settings:FindFirstChild("Seasonal") and map.Settings.Seasonal.Value)
			or map.Settings:GetAttribute("Seasonal")
			or (map.Settings:FindFirstChild("Halloween") and map.Settings.Halloween.Value)
			or map.Settings:GetAttribute("Halloween") or false,
		updateData = coolfunc,
	}
	local SpecialMapsVars = {
		"Featured",
		"Seasonal",
		"Halloween",
	}

	local SpecialMaps = {
		"Highlighted Map",
		"Seasonal Map",
		"Halloween Map", --TODO: make the summer special map well, in very huge future
	}

	local SpecialMapsColors = {
		Color3.fromRGB(230, 126, 34),
		Color3.fromRGB(166, 231, 255),
		Color3.fromRGB(118, 59, 0),
	}

	if mapdata.specialMap then
		for k, v in next, SpecialMapsVars do
			if (map.Settings:FindFirstChild(v) and map.Settings[v].Value) or map.Settings:GetAttribute(v) then
				mapdata.specialMapName = SpecialMaps[k]
				mapdata.specialMapColor = SpecialMapsColors[k]
			end
		end
	end
	return mapdata
end
function moveToLast(table1, item)
	local itemIndex = nil
	for i, v in ipairs(table1) do
		if v.ID == item.ID then
			itemIndex = i
			break
		end
	end
	if itemIndex then
		table.remove(table1, itemIndex)
		table.insert(table1, item)
	end
end
function EscapeeAppearance(Escapee)
	local Map = game.Workspace.Multiplayer:WaitForChild("Map")
	local s = Map:FindFirstChild("Settings")
	local r = s:FindFirstChild("Rescue")
	if #r:GetChildren() == 0 then
		local AppModel = script.DefaultEscapees:GetChildren()[math.random(1,#script.DefaultEscapees:GetChildren())]
		for _,v in pairs(Escapee:GetChildren()) do
			if not findFromTable(EscapeeImportantParts,v.Name) then
				v:Destroy()
			end
		end
		for i,v in pairs(AppModel:GetChildren()) do
			if v:IsA('SpecialMesh') or v:IsA('BlockMesh') or v:IsA('CylinderMesh') then
				v.Parent = Escapee.Head
			elseif v:IsA("Accessory") then
				v.Parent = Escapee
				if v.Handle:FindFirstChild("AccessoryWeld") then
					v.Handle.AccessoryWeld.Part1 = Escapee[tostring(v.Handle.AccessoryWeld.Part1)]	
				end
			elseif v:IsA('Decal') then
				if Escapee.Head:FindFirstChild("face") then
					Escapee.Head.face.Texture = v.Texture
				elseif Escapee.Head:FindFirstChild("Face") then
					Escapee.Head.Face.Texture = v.Texture
				end
			elseif v:IsA('BodyColors') or v:IsA('CharacterMesh') or v:IsA('Shirt') or v:IsA('Pants') or v:IsA('ShirtGraphic') then
				if Escapee:FindFirstChild('Body Colors') then
					Escapee['Body Colors']:Destroy()
				end
				v.Parent = Escapee
			elseif v:IsA('Hat') then
				v.Parent = Escapee
				local weld = Instance.new("Weld", Escapee.Head)
				weld.Name = "HatWeld"
				weld.Part0 = Escapee.Head
				weld.Part1 = v.Handle
				--v.Handle.CFrame = Escapee.Head.CFrame * CFrame.new(0, Escapee.Head.Size.Y / 2, 0) * v.AttachmentPoint:inverse()
			end
		end
		if AppModel.Head:FindFirstChild("face") then
			if Escapee.Head:FindFirstChild("face") then
				Escapee.Head.face.Texture =AppModel.Head.face.Texture
			elseif Escapee.Head:FindFirstChild("Face") then
				Escapee.Head.Face.Texture = AppModel.Head.face.Texture
			end
		elseif AppModel.Head:FindFirstChild("Face") then
			if Escapee.Head:FindFirstChild("face") then
				Escapee.Head.face.Texture = AppModel.Head.Face.Texture
			elseif Escapee.Head:FindFirstChild("Face") then
				Escapee.Head.Face.Texture = AppModel.Head.Face.Texture
			end
		end
		if not Escapee.Head:FindFirstChild('Mesh') then
			local m = Instance.new('SpecialMesh', Escapee.Head)
			m.MeshType = Enum.MeshType.Head
			m.Scale = Vector3.new(1.25, 1.25, 1.25)
		end
	else
		local AppModel = r
		for _,v in pairs(Escapee:GetChildren()) do
			if not findFromTable(EscapeeImportantParts,v.Name) then
				v:Destroy()
			end
		end
		for i,v in pairs(AppModel:GetChildren()) do
			if v:IsA('SpecialMesh') or v:IsA('BlockMesh') or v:IsA('CylinderMesh') then
				v.Parent = Escapee.Head
			elseif v:IsA("Accessory") then
				v.Parent = Escapee
				v.Handle.AccessoryWeld.Part1 = Escapee[tostring(v.Handle.AccessoryWeld.Part1)]
			elseif v:IsA('Decal') then
				Escapee.Head.face.Texture = v.Texture
			elseif v:IsA('BodyColors') or v:IsA('CharacterMesh') or v:IsA('Shirt') or v:IsA('Pants') or v:IsA('ShirtGraphic') then
				if Escapee:findFirstChild('Body Colors') then
					Escapee['Body Colors']:Destroy()
				end
				v.Parent = Escapee
			elseif v:IsA('Hat') then
				v.Parent = Escapee
				v.Handle.CFrame = Escapee.Head.CFrame * CFrame.new(0, Escapee.Head.Size.Y / 2, 0) * v.AttachmentPoint:inverse()
			end
		end
		if not Escapee.Head:FindFirstChild('Mesh') then
			local m = Instance.new('SpecialMesh', Escapee.Head)
			m.MeshType = Enum.MeshType.Head
			m.Scale = Vector3.new(1.25, 1.25, 1.25)
		end
	end
end
local function DoEvent()
	local Map = game.Workspace.Multiplayer:WaitForChild("Map")
	if EventCounter == 3 then
		EventCounter = 0
		local chosenEvent = math.random(1, #Events)
		if chosenEvent == 1 then
			local RescuePos = {}
			for _, RescueSpot in next, Map:GetDescendants() do
				if RescueSpot:IsA("BasePart") and RescueSpot.Name == "_Rescue" then
					table.insert(RescuePos, RescueSpot.Position)
					RescueSpot:Destroy()
				end
			end
			--print(RescuePos, #RescuePos)
			if #RescuePos == 0 then return end
			local cloned_Rescue = script._Rescue:Clone()
			EscapeeAppearance(cloned_Rescue.NPC)
			local ranSpot = RescuePos[math.random(1, #RescuePos)] -- + Vector3.new(0, 2, 0)
			cloned_Rescue.Parent = Map
			cloned_Rescue:MoveTo(ranSpot)
			task.spawn(function()
				cloned_Rescue.Contact.Touched:Connect(function(otherPart : BasePart)
					local plr = game.Players:GetPlayerFromCharacter(otherPart.Parent)
					if plr ~= nil then
						game.ReplicatedStorage.Remote:WaitForChild("RescueTrigger"):FireClient(plr, cloned_Rescue)
					end
				end)
			end)
		elseif chosenEvent == 2 then
			for _, v in next, Map:GetDescendants() do
				if v:IsA("Model") and string.sub(v.Name, 1, 7) == "_Button" then
					if v:FindFirstChild("Group") and v:FindFirstChild("Group"):IsA("ObjectValue") then
						continue
					else
						local g = Instance.new("ObjectValue")
						g.Value = v
						g.Name = "Group"
						g.Parent = v	
					end
				end
			end
		elseif chosenEvent == 3 then
			for _, v in next, Map:GetDescendants() do
				if v:IsA("Model") and string.sub(v.Name, 1, 7) == "_Button" then
					local ran = math.random(1, 4)
					if ran % 2 == 0 then
						if v:FindFirstChild("Group") and v:FindFirstChild("Group"):IsA("ObjectValue") then
							v.Group:Destroy()
						else
							local g = Instance.new("ObjectValue")
							g.Value = v
							g.Name = "Group"
							g.Parent = v
						end
					end
				end
			end
		elseif chosenEvent == 4 then
			for _, v in next, Map:GetDescendants() do
				if v:IsA("Model") and string.sub(v.Name, 1, 7) == "_Button" then
					if (v:FindFirstChild("Tick") and v:FindFirstChild("Tick"):IsA("ObjectValue")) or v:FindFirstChild("Fuse") and v:FindFirstChild("Fuse"):IsA("ObjectValue") then
						continue
					else
						local g = Instance.new("ObjectValue")
						g.Value = v
						g.Name = "Fuse"
						g.Parent = v	
					end
				end
			end
		end
		return chosenEvent
	else
		EventCounter += 1
		for _, RescueSpot in next, Map:GetDescendants() do
			if RescueSpot:IsA("BasePart") and RescueSpot.Name == "_Rescue" then
				--table.insert(RescuePos, RescueSpot.Position)
				RescueSpot:Destroy()
			end
		end
	end
end
local IsMapVoting = false
local function StartNewMapVote()
	if IsGameRunning then
		return
	end
	IsMapVoting = true
	rem.UpdIngameStats:FireAllClients({
		boostingEnabled = false,
		intBoostCurrentCost = CurrentBoost,
	})
	PlayerSelectedMaps = {}
	local MapSelected = nil
	MapsVoting = table.clone(MapData[math.floor(CurrentDif)])
	local Ran = 0
	if #MapData == 1 then
		Ran = 1
	elseif #MapData < 8 then
		Ran = math.round((#MapsVoting * 2/8) + 1)
	else
		Ran = 8
	end
	for index, testData in ipairs(MapsVoting) do
		testData.cooldown = false
		testData.locked = false
		testData.unlockCost = 0
	end
	local LastCost = 10
	for index, mapData in ipairs(MapsVoting) do
		if index == #MapsVoting and index ~= 1 and mapData.cooldown	== false then
			mapData.cooldown = true
		elseif index > Ran then
			mapData.locked = true
			mapData.unlockCost = LastCost
			LastCost += 10
		else
			mapData.cooldown = false
			mapData.locked = false
			mapData.unlockCost = 0
		end
	end
	--print("Current Players Waiting", Players_Waiting)
	for index, plr in ipairs(Players_Waiting) do
		table.insert(Players_Voting, plr)
		if table.find(Players_Won, plr) then
			rem.StartVotingWon:FireClient(plr)
		else
			rem.StartVoting:FireClient(plr)
		end
	end
	local CurrentTime = tick()
	local theres_no_one = false
	repeat
		task.wait()
		local ok = math.clamp((tick() - CurrentTime)/VotingMaxTime, 0, 1)
		game:GetService("TweenService"):Create(workspace.Lobby.GameInfo.SurfaceGui.Frame.TimeLeft.Percentage, TweenInfo.new(0.1), {Size = UDim2.new(1 - (ok), 0, 1, 0)}):Play()
		rem.UpdateLobby:Fire(nil, nil, "Ready!", "Waiting for Players",CurrentDif)
		rem.UpdateBar:FireAllClients(ok)
	until tick() - CurrentTime >= VotingMaxTime
	if #Players_Voting == 0 and #PlayersWhoVoted == 0 then
		IsMapVoting = false
		return
	end
	for index, item in next, PlayersWhoVoted do
		table.remove(PlayersWhoVoted, index)
	end
	local votes = {}
	local highestVoteCount = 0
	for index, mapData in ipairs(MapsVoting) do
		votes[index] = mapData.voteCount
	end
	for index, voteCount in next, votes do
		local number = tonumber(voteCount)
		if number > highestVoteCount then
			highestVoteCount = index
		end
	end
	MapSelected = MapsVoting[highestVoteCount]
	if MapSelected == nil then
		MapSelected = MapsVoting[1]
	end
	moveToLast(MapData[math.floor(CurrentDif)], MapSelected)
	--print(MapData[math.floor(CurrentDif)])
	for index, item in next, MapData do
		for i, v in next, item do
			v.voteCount = 0
		end
	end
	if ForceMap ~= nil then
		return ForceMap.Map
	else
		rem.SendOutput:FireAllClients("Map Selected: " .. MapSelected.name)
		print("Map Selected:",MapSelected.name)
		return MapSelected.Map
	end
end
rem.GetVotingData.OnServerInvoke = function()
	return MapsVoting
end
local plrStartingCount = 0
local function CalNewDif(NumberOfStartingPlayers, MapInfo : MapInfo)
	local Intensity_Data = {
		[1] = {balance = 0.4}, -- 0.4
		[2] = {balance = 0.5}, -- 0.5
		[3] = {balance = 0.6}, -- 0.6
		[4] = {balance = 0.65}, -- 0.65
		[5] = {balance = 0.5}, -- 1.5
		[6] = {balance = 0.2} -- 2
	}
	local MapBalance = Intensity_Data[math.floor(MapInfo.Difficulty)].balance
	local NewMath = (#Players_Won/NumberOfStartingPlayers) - MapBalance + CurrentBoostValue
	NewMath = math.clamp(NewMath, -2, 3.1)
	return NewMath
end
local Num = 0
local function NewRound(MapInfo : MapInfo)
	for i, v in ipairs(Players_Waiting) do
		table.insert(Players_Playing, v)
	end
	repeat task.wait() until #Players_Waiting == #Players_Playing
	for i, v in ipairs(Players_Waiting) do
		Players_Waiting[i] = nil
	end
	local OldMap = nil
	if Multiplayer:FindFirstChild("Map") then
		OldMap = Multiplayer.Map :: Model
		OldMap.Name = "OldMap"
	end
	if game.Lighting:FindFirstChildWhichIsA("Sky") then
		local a = game.Lighting:FindFirstChildWhichIsA("Sky")
		a:Destroy()
	end
	ForceMap = nil
	if #Players_Playing > 0 then
		local Map : Model = MapInfo.Map
		Map.Parent = Multiplayer
		Map.Name = "Map"
		workspace.Lobby.MapBG.SurfaceGui.Frame.MapImg.Image = "rbxassetid://" .. MapInfo.MapImage
		isExitOpen = false
		CurrentButtonCount = 0
		CurrentBoostValue = 0
		if ReplicatedStorage.Flags.HasPlayedMap.Value == false then
			ReplicatedStorage.Flags.HasPlayedMap.Value = true
		end
		for i, v in ipairs(Players_Playing) do
			table.insert(PlayersLoading, v)
			local Humanoid = v.Character.Humanoid :: Humanoid
			Humanoid.Health = 100
			Humanoid.WalkSpeed = 0
			Humanoid.MaxSlopeAngle = 89
			Humanoid.MaxHealth = 100
			Humanoid.JumpPower = 0
		end
		local Map_Spawn = nil
		for index, item in pairs(Map:GetDescendants()) do
			if item.Name == "Spawn" and item:IsA("BasePart") then
				Map_Spawn = item
			end
		end
		RemoveVariant(Map)
		Players_Won = {}
		for i, v in ipairs(PlayersLoading) do
			rem.StartLoading:FireClient(v, MapInfo, #PlayersLoading)
		end
		repeat task.wait() until #PlayersLoading == 0
		local Settings = Multiplayer:WaitForChild("Map"):WaitForChild("Settings")
		local mapImage = Settings:GetAttribute("MapImage") or Settings:FindFirstChild("MapImage") and Settings.MapImage.Value
		for i, v in ipairs(Players_Playing) do
			v.Character:PivotTo(getRandomInPart(Map_Spawn) + Vector3.new(0, 3, 0))
			local Humanoid = v.Character.Humanoid :: Humanoid
			--Reset Properties
			Humanoid.Health = 100
			--Humanoid.WalkSpeed = 20 (MEEE disabled to do that in cl main instead for better timing)
			Humanoid.MaxSlopeAngle = 89
			Humanoid.MaxHealth = 100
			--Humanoid.JumpPower = 50 (MEEE same here)
		end
		rem.UpdIngameStats:FireAllClients({
			boostingEnabled = true,
			intBoostCurrentCost = CurrentBoost,
		})
		rem.UpdIngameStatus:FireAllClients({
			plrCount = #Players_Playing,
			btnCount = 1,
		})
		rem.MapAdded:FireAllClients()
		for _, v in next, Map:WaitForChild("Settings"):WaitForChild("Lighting"):GetDescendants() do
			if v:IsA("Sky") then
				v:Clone().Parent = game.Lighting
			end
		end
		local c = 3
		repeat
			--Main_2.Info.LoadStatus.LoadInfo.Text = "Get Ready: " .. tostring(c)
			c -= 1
			wait(1)
		until c <= 0
		local e = DoEvent()
		plrStartingCount = #Players_Playing
		for i, v in ipairs(Players_Playing) do
			rem.GameStarted:FireClient(v)
			if e == 1 then
				local e_Name = Map:FindFirstChild("Settings"):FindFirstChild("Rescue"):GetAttribute("RescueName") or "Escappe"
				rem.Alert:FireClient(v, "⚠️ Rescue " .. e_Name .. "!", Color3.fromRGB(241, 219, 128), 4, "event")
			elseif e == 2 then
				rem.Alert:FireClient(v, "⚠️ All buttons are group buttons!", BrickColor.new("Bright blue").Color, 4, "event")
			elseif e == 3 then
				rem.Alert:FireClient(v, "⚠️ Random Group Buttons!", BrickColor.new("Bright blue").Color, 4, "event")
			elseif e == 4 then
				rem.Alert:FireClient(v, "⚠️ Exploding Buttons!", BrickColor.new("Bright red").Color, 4, "event")
			end
			PlayerData[v.Name].gameplayStats.mapsPlayed[math.floor(MapInfo.Difficulty)] += 1
			--Map_PlayerData[v.Name][#Map_PlayerData[v.Name].mapSums + 1].mapSums = {}
			if not Map_PlayerData[v.Name].mapSums then
				Map_PlayerData[v.Name].mapSums = {}
			end
			table.insert(Map_PlayerData[v.Name].mapSums, {
				MapInfo = {
					Image = mapImage,
					Difficulty = MapInfo.Difficulty,
					Name = MapInfo.MapName
				},
				Survived = {
					Position = 0,
					Time = 0,
				},
				Buttons = {
					Pressed = 0
				},
				XP = {
					Bonus = 0, --TODO
					Total = 0
				},
			})
		end
		rem.VotingReset:FireAllClients()
		if OldMap ~= nil then
			OldMap:Destroy()
			OldMap = nil
		end
		if Map:FindFirstChild("EventScript") and not Map:FindFirstChild("EventString") and not Map:FindFirstChild("Timelines") then
			local EventScript = Map.EventScript :: Script
			EventScript.Disabled = false
		elseif Map:FindFirstChild("Timelines") and not Map:FindFirstChild("EventString") and not Map:FindFirstChild("EventScript") then
			for index, item in ipairs(Map:GetDescendants()) do
				if item:IsA("Script") then
					item:Destroy() --bye script
				end
			end
			local t = script.SV_TimelineWrapper:Clone()
			t.Parent = Map
			t.Enabled = true
		elseif Map:FindFirstChild("EventString") and not Map:FindFirstChild("EventScript") and not Map:FindFirstChild("Timelines") then
			local EventStringValue = Map.EventString :: StringValue
			local forbiddenPhrases = { --thx crazyblox
				"serverscriptservice",
				"serverstorage",
				"players",
				"lighting",
				"replicatedfirst",
				"replicatedstorage",
				"startergui",
				"starterpack",
				"starterplayer",
				"soundservice",
				":clone()",
				"string",
				[[="]],
				"=[[",
				"name",
				"string",
				"value",
				"..",
				"='",
				"require"
			}
			local f, msg = loadstring(EventStringValue.Value, "EventString")
			if typeof(f) == "function" then
				return f()
			else
				warn("Map EventString load error: " .. msg)
			end
		end
		spawn(function()
			local ExplodingButtons = {}
			for index, descendant in pairs(MapInfo.Buttons) do
				if descendant:IsA("Model") then
					if descendant.Name == "_Button1" then
						local a = script.Marker:Clone()
						a.Parent = descendant
						if descendant:FindFirstChild("Group") then
							descendant.Light.BrickColor = BrickColor.new("Bright blue")
							descendant.Marker.ButtonIcon.ImageColor3 = BrickColor.new("Cyan").Color
							descendant.Marker.Border.ImageColor3 = BrickColor.new("Cyan").Color	
						else
							descendant:WaitForChild("Light").BrickColor = BrickColor.new("Bright green")
							descendant.Marker.ButtonIcon.ImageColor3 = Color3.fromRGB(0, 255, 0)
							descendant.Marker.Border.ImageColor3 = Color3.fromRGB(0, 255, 0)
						end
						if descendant:FindFirstChild("Tick") or descendant:FindFirstChild("Fuse") then
							table.insert(ExplodingButtons, descendant)
						end
						if not descendant.Marker.Border:FindFirstChild("RotateScript") then
							local s = script.Marker.Border.RotateScript:Clone()
							s.Parent = descendant.Marker.Border
						end
						if not descendant.Marker.ButtonIcon:FindFirstChild("SwitchIconScript") then
							local s = script.Marker.ButtonIcon.SwitchIconScript:Clone()
							s.Parent = descendant.Marker.ButtonIcon
						end 
						a.ButtonIcon.ImageTransparency = 0
						a.ButtonIcon.SwitchIconScript.Disabled = false
						a.Border.RotateScript.Disabled = false
						a.Background.Visible = true
						local NextButton = nil
						for _, v in next, Map:GetDescendants() do
							if v.Name == "_Button" .. tostring(tonumber(string.sub(descendant.Name, 8) + 1)) then
								NextButton = v
							end
						end
						--local NextButton2 = descendant.Parent:FindFirstChild("_Button" .. tostring(tonumber(string.sub(descendant.Name, 8) + 2))) or nil
						if NextButton ~= nil then
							NextButton = NextButton:FindFirstChild("Hitbox")
						end
						for _, plr in next, Players_Playing do
							rem.UpdGoalLocator:FireClient(plr, descendant:WaitForChild("Hitbox"), descendant:WaitForChild("Hitbox"), descendant.Marker, NextButton, nil) --newNextFl????
						end
					else
						local a = script.Marker:Clone()
						a.Parent = descendant
						if not descendant.Marker.Border:FindFirstChild("RotateScript") then
							local s = script.Marker.Border.RotateScript:Clone()
							s.Parent = descendant.Marker.Border
						end
						if not descendant.Marker.ButtonIcon:FindFirstChild("SwitchIconScript") then
							local s = script.Marker.ButtonIcon.SwitchIconScript:Clone()
							s.Parent = descendant.Marker.ButtonIcon
						end 
						a.Border.ImageColor3 = Color3.fromRGB(255, 255, 0)
					end
					descendant.Hitbox.Touched:Connect(function(hit)
						local plr = getPlayerFromCharacter(hit.Parent)
						if descendant.Light.BrickColor == BrickColor.new("Bright green") or descendant.Light.BrickColor == BrickColor.new("Bright blue") and plr ~= nil and table.find(PlayerTouched, getPlayerFromCharacter(hit.Parent)) == nil then
							local Hitbox:BasePart = descendant.Hitbox
							--plr = getPlayerFromCharacter(hit.Parent)
							if plr ~= nil then
								local ty_ = (descendant:FindFirstChild("Group") and "group") or "normal"
								local isExp = ((descendant:FindFirstChild("Tick") or descendant:FindFirstChild("Fuse")) and true) or false
								challengeBin.BtnPress:Fire(plr, PlayerData[plr.Name], ty_, isExp)
								table.insert(PlayerTouched, plr)
								PlayerData[plr.Name].gameplayStats.buttonsPressed += 1
								Map_PlayerData[plr.Name].mapSums[#Map_PlayerData[plr.Name].mapSums].Buttons.Pressed += 1	
								local isGroup = descendant:FindFirstChild("Group")
								if isGroup ~= nil then
									Map_PlayerData[plr.Name].mapSums[#Map_PlayerData[plr.Name].mapSums].XP.Total += 20
								else
									Map_PlayerData[plr.Name].mapSums[#Map_PlayerData[plr.Name].mapSums].XP.Total += 10
								end	
								local xpCount = (isGroup ~= nil and 20) or 10
								rem.Alert:FireClient(plr, "Pressed Button #" .. string.sub(descendant.Name, 8) .. ": " .. xpCount .. "XP", Color3.fromRGB(241, 196, 15))
							end
							if descendant.Light.BrickColor == BrickColor.new("Bright blue") then
								if #PlayerTouched == GroupButtonCount then
									CurrentButtonCount += 1
									rem.UpdIngameStatus:FireAllClients({
										plrCount = #Players_Playing,
										btnCount = CurrentButtonCount,
									})
									ServerStorage.Bindables.BtnPress:Fire(plr, CurrentButtonCount)
									for index, item in ipairs(ExplodingButtons) do
										table.remove(ExplodingButtons, index)
										local Exploding = script.Exploading:Clone()
										Exploding.Parent = descendant
										Exploding.Position = descendant.Hitbox.Position
										Exploding.ExploadHandler.Disabled = false
									end
									local descendantsN = Map:GetDescendants()
									spawn(function()
										LoopThroughMapDescendants(descendantsN, descendant)
									end)

									descendant.Light.BrickColor = BrickColor.new("Black")
									descendant.Light.Material = Enum.Material.SmoothPlastic
									if descendant:FindFirstChild("Marker") ~= nil then
										descendant.Marker:Destroy()
										PlayerTouched = {}
									end
									local Button = nil
									for _, v in next, Map:GetDescendants() do
										if v.Name == "_Button" .. tostring(tonumber(string.sub(descendant.Name, 8) + 1)) then
											Button = v
										end
									end
									if Button ~= nil then
										local a = Button.Marker
										if Button:FindFirstChild("Group") then
											Button.Light.BrickColor = BrickColor.new("Bright blue")
											Button.Marker.ButtonIcon.ImageColor3 = BrickColor.new("Cyan").Color
											Button.Marker.Border.ImageColor3 = BrickColor.new("Cyan").Color	
										else
											Button.Light.BrickColor = BrickColor.new("Bright green")
											Button.Marker.ButtonIcon.ImageColor3 = Color3.fromRGB(0, 255, 0)
											Button.Marker.Border.ImageColor3 = Color3.fromRGB(0, 255, 0)
										end
										if Button:FindFirstChild("Tick") or Button:FindFirstChild("Fuse") then
											table.insert(ExplodingButtons, Button)
										end
										Button.Marker.ButtonIcon.ImageTransparency = 0
										if not Button.Marker.Border:FindFirstChild("RotateScript") then
											local s = script.Marker.Border.RotateScript:Clone()
											s.Parent = Button.Marker.Border
										end
										if not Button.Marker.ButtonIcon:FindFirstChild("SwitchIconScript") then
											local s = script.Marker.ButtonIcon.SwitchIconScript:Clone()
											s.Parent = Button.Marker.ButtonIcon
										end 
										Button.Marker.ButtonIcon.SwitchIconScript.Disabled = false	
										Button.Marker.Border.RotateScript.Disabled = false	
										Button.Marker.Background.Visible = true	
										local NextButton = nil
										for _, v in next, Map:GetDescendants() do
											if v.Name == "_Button" .. tostring(tonumber(string.sub(descendant.Name, 8) + 1)) then
												NextButton = v
											end
										end
										local NextButton2 = nil
										for _, v in next, Map:GetDescendants() do
											if v.Name == "_Button" .. tostring(tonumber(string.sub(descendant.Name, 8) + 2)) then
												NextButton2 = v
											end
										end
										if NextButton2 ~= nil then
											NextButton2 = NextButton2:FindFirstChild("Hitbox")
										end
										for _, plr in next, Players_Playing do
											--print(NextButton, NextButton2)
											rem.UpdGoalLocator:FireClient(plr, NextButton:WaitForChild("Hitbox"), NextButton:WaitForChild("Hitbox"), NextButton.Marker, NextButton2, nil) --newNextFl????
										end
									end
								end
							elseif #PlayerTouched ~= GroupButtonCount and descendant.Light.BrickColor == BrickColor.new("Bright blue") then
								if descendant:FindFirstChild("Marker") ~= nil then
									descendant.Marker.Counter = tostring(#PlayerTouched) .. "/" .. tostring(GroupButtonCount)
								end
							else
								CurrentButtonCount += 1
								rem.UpdIngameStatus:FireAllClients({
									plrCount = #Players_Playing,
									btnCount = CurrentButtonCount,
								})
								ServerStorage.Bindables.BtnPress:Fire(plr, CurrentButtonCount)
								for index, item in ipairs(ExplodingButtons) do
									table.remove(ExplodingButtons, index)
									local Exploding = script.Exploading:Clone()
									Exploding.Parent = descendant
									Exploding.Position = descendant.Hitbox.Position
									Exploding.ExploadHandler.Disabled = false
								end
								local descendantsN = Map:GetDescendants()
								spawn(function()
									LoopThroughMapDescendants(descendantsN, descendant)
								end)

								descendant.Light.BrickColor = BrickColor.new("Black")
								descendant.Light.Material = Enum.Material.SmoothPlastic
								if descendant:FindFirstChild("Marker") ~= nil then
									descendant.Marker:Destroy()
									PlayerTouched = {}
								end
								local Button = nil
								for _, v in next, Map:GetDescendants() do
									if v.Name == "_Button" .. tostring(tonumber(string.sub(descendant.Name, 8) + 1)) then
										Button = v
									end
								end
								if Button ~= nil then
									if Button ~= nil then
										local a = Button.Marker
										if Button:FindFirstChild("Group") then
											Button.Light.BrickColor = BrickColor.new("Bright blue")
											Button.Marker.ButtonIcon.ImageColor3 = BrickColor.new("Cyan").Color
											Button.Marker.Border.ImageColor3 = BrickColor.new("Cyan").Color	
										else
											Button.Light.BrickColor = BrickColor.new("Bright green")
											Button.Marker.ButtonIcon.ImageColor3 = Color3.fromRGB(0, 255, 0)
											Button.Marker.Border.ImageColor3 = Color3.fromRGB(0, 255, 0)
										end
										if Button:FindFirstChild("Tick") or Button:FindFirstChild("Fuse") then
											table.insert(ExplodingButtons, Button)
										end
										if not Button.Marker.Border:FindFirstChild("RotateScript") then
											local s = script.Marker.Border.RotateScript:Clone()
											s.Parent = Button.Marker.Border
										end
										if not Button.Marker.ButtonIcon:FindFirstChild("SwitchIconScript") then
											local s = script.Marker.ButtonIcon.SwitchIconScript:Clone()
											s.Parent = Button.Marker.ButtonIcon
										end 
										a.ButtonIcon.ImageTransparency = 0
										a.ButtonIcon.SwitchIconScript.Disabled = false	
										a.Border.RotateScript.Disabled = false	
										a.Background.Visible = true
										local NextButton = nil
										for _, v in next, Map:GetDescendants() do
											if v.Name == "_Button" .. tostring(tonumber(string.sub(descendant.Name, 8) + 1)) then
												NextButton = v
											end
										end
										local NextButton2 = nil
										for _, v in next, Map:GetDescendants() do
											if v.Name == "_Button" .. tostring(tonumber(string.sub(descendant.Name, 8) + 2)) then
												NextButton2 = v
											end
										end
										if NextButton2 ~= nil then
											NextButton2 = NextButton2:FindFirstChild("Hitbox")
										end
										for _, plr in next, Players_Playing do
											rem.UpdGoalLocator:FireClient(plr, NextButton:WaitForChild("Hitbox"), NextButton:WaitForChild("Hitbox"), NextButton.Marker, NextButton2, nil) --newNextFl????
										end
									end
								end
							end
						end
					end)
				end
			end
		end)
		local Time = tick()
		local Num = 0
		--print(#Players_Playing)
		if #Players_Playing == 0 then
			Num = 1
		else
			Num = #Players_Playing
		end
		if mapImage ~= 0 then
			workspace.Lobby.GameInfo.SurfaceGui.Frame.Imgs.MapImg.Image = "rbxassetid://" ..tostring(mapImage)
		else
			workspace.Lobby.GameInfo.SurfaceGui.Frame.Imgs.MapImg.Image = "rbxassetid://" ..tostring(0)
		end
		workspace.Lobby.GameInfo.SurfaceGui.Frame.TimeLeft.Percentage.Size = UDim2.new(1, 0, 1, 0)
		spawn(function()
			while #Players_Playing > 0 do
				task.wait()
				if #Players_Playing >= 4 then
					GroupButtonCount = 2
					for _, v in next, Map:GetDescendants() do
						if v:IsA("BillboardGui") and v.Name == "Marker" then
							if v.Background.Visible == true then
								if v.ButtonIcon.ImageColor3 == BrickColor.new("Cyan").Color then
									local c = ((string.sub(v.Count.Text, 1, 2) ~= "") and string.sub(v.Count.Text, 1, 2)) or "0/"
									--print(c)
									v.Count.Text = c .. tostring(GroupButtonCount)
								end
							end
						end
					end
				else
					GroupButtonCount = 1
					for _, v in next, Map:GetDescendants() do
						if v:IsA("BillboardGui") and v.Name == "Marker" then
							if v.Background.Visible == true then
								if v.ButtonIcon.ImageColor3 == BrickColor.new("Cyan").Color then
									local c = ((string.sub(v.Count.Text, 1, 2) ~= "") and string.sub(v.Count.Text, 1, 2)) or "0/"
									--print(c)
									v.Count.Text = c .. tostring(GroupButtonCount)
								end
							end
						end
					end
				end	
			end
		end)
		task.spawn(function()
			while #Players_Playing > 0 do
				task.wait()
				if CurrentButtonCount >= #MapInfo.Buttons then
					rem.UpdIngameStatus:FireAllClients({
						plrCount = #Players_Playing,
						btnCount = "\240\159\143\129",
					})
					isExitOpen = true
					--local NextButton = descendant.Parent:FindFirstChild("_Button" .. tostring(tonumber(string.sub(descendant.Name, 8) + 1))) or nil
					for i, plr in ipairs(Players_Playing) do
						for	_, exitRegion in ipairs(MapInfo.ExitRegions) do
							for _, plr in next, Players_Playing do
								rem.UpdGoalLocator:FireClient(plr, exitRegion, exitRegion, nil, nil, nil) --newNextFl????
							end
							if plr.Character ~= nil then
								if FE2Library.inPart(plr.Character:WaitForChild("HumanoidRootPart").Position, exitRegion) then
									table.remove(Players_Playing, i)
									table.insert(Players_Waiting, plr)
									table.insert(Players_Won, plr)
									Map_PlayerData[plr.Name].mapSums[#Map_PlayerData[plr.Name].mapSums].Survived.Time = tick() - Time
									Map_PlayerData[plr.Name].mapSums[#Map_PlayerData[plr.Name].mapSums].Position = #Players_Won
									--print(Map_PlayerData[plr.Name].mapSums[#Map_PlayerData[plr.Name].mapSums])
									if PlayerData[plr.Name].gameplayStats.mapBestTimes[MapInfo.MapName] == nil then
										PlayerData[plr.Name].gameplayStats.mapBestTimes[MapInfo.MapName] = 0
									end
									PlayerData[plr.Name].gameplayStats.mapsSurvived[math.floor(MapInfo.Difficulty)] += 1
									if PlayerData[plr.Name].gameplayStats.mapBestTimes[MapInfo.MapName] == 0 or (tick()-Time) < PlayerData[plr.Name].gameplayStats.mapBestTimes[MapInfo.MapName] then
										PlayerData[plr.Name].gameplayStats.mapBestTimes[MapInfo.MapName] = (tick()-Time)
									end
									print(PlayerData[plr.Name])
									if e == 1 then
										if rem.ReqRescue:InvokeClient(plr) == false then
											return
										end
										challengeBin.Rescued:Fire(plr, PlayerData[plr.Name])
									elseif e == 2 then
										challengeBin.SurviveAllGroupBtns:Fire(plr, PlayerData[plr.Name])
									elseif e == 3 then
										challengeBin.SurviveAllGroupBtns:Fire(plr, PlayerData[plr.Name])
									elseif e == 4 then
										--print(e)
										challengeBin.SurviveExplodingBtns:Fire(plr, PlayerData[plr.Name])
									end
									if Num >= 6 and #Players_Won == 1 then
										challengeBin.Survived1Map:Fire(plr, PlayerData[plr.Name])
									end
									rem:WaitForChild("RescueTrigger"):FireClient(plr, nil, true)
									rem.ExitWon:FireClient(plr)	
									wait(0.1)
									challengeBin.WonMapGameMode:Fire(plr, PlayerData[plr.Name])
								end
							end
						end
					end
				else
					rem.UpdIngameStatus:FireAllClients({
						plrCount = #Players_Playing,
						btnCount = CurrentButtonCount,
					})	
				end
			end
		end)
		while #Players_Playing > 0 do
			task.wait()
			local ut = ((tick() - Time)/MapInfo.MaxTime)
			game:GetService("TweenService"):Create(workspace.Lobby.GameInfo.SurfaceGui.Frame.TimeLeft.Percentage, TweenInfo.new(0.1), {Size = UDim2.new(1 - ut, 0, 1, 0)}):Play()
			rem.UpdateLobby:Fire(nil, nil, MapInfo.MapName, `{tostring(#Players_Playing)}/{tostring(Num)} Players` ,CurrentDif)
			for i, v in ipairs(Players_Playing) do
				rem.UpdateBar:FireClient(v, ut)
			end
			if tick() - Time >= MapInfo.MaxTime then --what
				--rem.GameEnded:FireAllClients()
				for i, v in ipairs(Players_Playing) do
					if v:FindFirstChild("Humanoid") then
						v.Humanoid.Health = 0
						table.remove(Players_Playing, i)
					end
				end
			end
		end
		local function SetDecimals(Number)
			local Decimals = Number - math.floor(Number)
			if Decimals * 10 ~= math.floor(Decimals * 10) then
				return math.floor(Number * 10 + 0.5) / 10
			else
				return Number
			end
		end
		--print(Num)
		local c = CalNewDif(Num, MapInfo)
		CurrentDif += c
		CurrentDif = SetDecimals(CurrentDif)
		CurrentDif = math.clamp(CurrentDif, 1, 6.99)
		c = SetDecimals(c)
		local NewText = ""
		if c < 0 then
			NewText = `{tostring(#Players_Won)}/{tostring(Num)} Escaped: -🔻{tostring(c * -1)}: {tostring(CurrentDif)} Int.` --very evil hack
		else
			NewText = `{tostring(#Players_Won)}/{tostring(Num)} Escaped: +🔺{tostring(c)}: {tostring(CurrentDif)} Int.`
		end
		for _, plr in next, game.Players:GetPlayers() do
			if CurrentDif == nil then
				rem.Alert:FireClient(plr, NewText, FE2Library.Difficulties[1][2], 5)
			else
				--print(CurrentDif)
				rem.Alert:FireClient(plr, NewText, FE2Library.Difficulties[math.floor(CurrentDif)][2], 5)
			end
		end
		--print("New dif:",CurrentDif)
		rem.UpdateLobby:Fire(10, 10, "Ready!", "Waiting for Players", CurrentDif)
	end
end

local function isMidnightUTC()
	-- Get the current time in UTC
	local now = os.date("!*t")
	-- Check if the current time is 12 AM UTC
	if now.hour == 0 and now.min == 0 then
		return true
	else
		return false
	end
end

local function checkItemOwnership(tabl, ID)
	for _, check in pairs(tabl) do
		if ID == check then
			return true
		end
	end
end

Multiplayer.GetMapVals.OnInvoke = GetMapLib

local CachedTags = {}

function CheckGamepassOwnership(Local_Player)
	local ListOfPass = {}
	ListOfPass.CFC = false
	ListOfPass.VIP = false
	ListOfPass.Boost = false
	ListOfPass.TwoTimeVote = false
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 14784835) then
		ListOfPass.CFC = true
	end
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 4223166) then
		ListOfPass.VIP = true
	end
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 14432092) then
		ListOfPass.Boost = true
	end
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 141376407) then
		ListOfPass.TwoTimeVote = true
	end
	return ListOfPass
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAppearanceLoaded:Wait()
	player.Character.Animate.Enabled = true
	
	local Sound = Instance.new("Sound")
	Sound.Parent = player.Character:WaitForChild("Head")
	Sound.Name = "Boombox"
	Sound.SoundGroup = game.SoundService.Boomboxes
	--Sound.SoundId = "rbxassetid://0"
	rem.PlayerLoaded:FireClient(player)
	if table.find(Admins, player.UserId) then
		local c = script.MenuGui:Clone()
		c.Parent = player.PlayerGui
		local d = script.MapTest:Clone()
		d.Parent = c
	else
		script.MenuGui:Clone().Parent = player.PlayerGui
	end
	repeat task.wait() until player.PlayerGui:FindFirstChild("MenuGui") and player.PlayerGui:FindFirstChild("MenuGui"):FindFirstChild("Shop")
	if #Players_Voting > 0 then
		rem.UpdIngameStats:FireClient(player, {
			boostingEnabled = false,
			intBoostCurrentCost = CurrentBoost,
		})
	else
		rem.UpdIngameStats:FireClient(player, {
			boostingEnabled = true,
			intBoostCurrentCost = CurrentBoost,
		})
	end
	if not table.find(Map_PlayerData, player.Name) then
		Map_PlayerData[player.Name] = {
			mapSums = {},
			died = false,
			sumXP = 0,
			XPmulti = 0,
			awardedCoins = 0,
			awardedGems = 0,
		}
		--print(Map_PlayerData[player.Name])
	end
	if not table.find(PlayerData, player.Name) then
		local data = nil
		local success, err = pcall(function()
			data = DataStore:GetAsync(player.Name.."_data")
		end)
		if success then
			PlayerData[player.Name] = {
				xp = data and data.xp or 0;
				gems = data and data.gems or 20;
				level = data and data.level or 1;
				coins = data and data.coins or 50;
				rebirths = data and data.rebirths or 0;
				inventory = data and data.inventory or {};
				timeleft = data and data.timeleft or 604800;
				--dailyChallenges = data and data.dailyChallenges or ChallengeLib.createPlayerChallenges(false);
				consecutiveLogins = data and data.consecutiveLogins or 0;	
				daywhen_joined = os.date("!*t"),
				equipped = data and data.equipped or {
					Abilities = 0, 
					Auras = 0, 
					Tanks = 0, 
					Buddies = 0, 
					Emotes = 0, 
					Skins = 0	
				},
				gameplayStats = data and data.gameplayStats or {
					mapBestTimes = {},
					mapsPlayed = { 0, 0, 0, 0, 0, 0 },
					mapsSurvived = { 0, 0, 0, 0, 0, 0 },
					buttonsPressed = 0,
					diedIngame = 0,
					--dailyChallengesCompleted = 0,
					xpEarned = 0,
					mapHighestStreak = 0,
				}, --todo	
				redeemed = data and data.redeemed or {},
				dailylogins = data and data.dailylogins or 1,
				OptionsData = data and data.OptionsData or FE2Library.generateOptionsTab(),
				hasGivingCoins = data and data.hasGivingCoins or false,	
			}
			if PlayerData[player.Name].xp >= FE2Library.calcLevelXP(PlayerData[player.Name].level) then
				repeat
					task.wait()
					if PlayerData[player.Name].xp >= FE2Library.calcLevelXP(PlayerData[player.Name].level) then
						PlayerData[player.Name].level += 1
						PlayerData[player.Name].xp -= FE2Library.calcLevelXP(PlayerData[player.Name].level)
					end
				until PlayerData[player.Name].xp < FE2Library.calcLevelXP(PlayerData[player.Name].level)
				rem.LvlUp:FireClient(player, 10)
				PlayerData[player.Name].gems += 10	
			end
			for _, ItemID in next, PlayerData[player.Name].equipped do
				if ItemID == 0 then
					continue
				end
				local ItemFounded = nil
				for _, item in next, itemDataL do
					if item.ID == ItemID then
						ItemFounded = item
						break
					end
				end
				EquipItem(player, ItemFounded, ItemID, true)
			end
			--print(PlayerData[player.Name])
			if data and data.daywhen_joined ~= nil then
				if PlayerData[player.Name].daywhen_joined.day > data.daywhen_joined.day then
					PlayerData[player.Name].timeleft -= 86400
					--PlayerData[player.Name].dailyChallenges = ChallengeLib.createPlayerChallenges(false)
					local dif = PlayerData[player.Name].daywhen_joined.day - data.daywhen_joined.day
					if dif == 1 then
						PlayerData[player.Name].dailylogins += 1
					else
						PlayerData[player.Name].dailylogins = 1
					end
					PlayerData[player.Name].hasGivingCoins = false
					rem.UpdPlayerData:FireClient(player, PlayerData[player.Name], true)
				else
					rem.UpdPlayerData:FireClient(player, PlayerData[player.Name], false)
				end
			end
			if not PlayerData[player.Name].hasGivingCoins then
				PlayerData[player.Name].hasGivingCoins = true
				local t_1, t_2 = FE2Library.getLoginBonus(PlayerData[player.Name].dailylogins)
				if t_2 == 0 then
					t_2 = "coins"
				else
					t_2 = "gems"
				end
				--print(x_giveing, PlayerData[player.Name].coins)
				PlayerData[player.Name][t_2] += t_1
				--print(PlayerData[player.Name].coins)
			end
			rem.UpdPlayerData:FireClient(player, PlayerData[player.Name], false)
			--print(PlayerData[player.Name])
		else
			error(`Failed to get data! Reason: ${err}`)
		end
	end
	local listOfFriends = {}
	for _, plr : Player in next, game.Players:GetPlayers() do
		if plr:IsFriendsWith(player.UserId) then
			table.insert(listOfFriends, plr)
		end
	end
	if #listOfFriends > 0 then
		print(player.Name,"has a friend in this server")
		--game.ServerStorage.Bindables.Challenges.PlayWithFriend:Fire(player, PlayerData[player.Name])
	end
	local newTag = script.PlrInfo:Clone()
	newTag.PText.Text = (player.Name == player.DisplayName and "@" .. player.Name) or (player.DisplayName)
	newTag.PlayerInfo.PlayerHolder.BackgroundTransparency = 0
	newTag.PlayerInfo.LvlInfo.LvlText.Text = "Lvl" .. PlayerData[player.Name].level
	newTag.PlayerInfo.LvlInfo.RebirthNo.Visible = not (PlayerData[player.Name].rebirths == 0)
	newTag.PlayerInfo.LvlInfo.RebirthNo.Text = "Rebirth x" .. PlayerData[player.Name].rebirths .. " "
	if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 4223166) then
		newTag.PlayerInfo.PlayerHolder.VIP.Visible = true
	end
	newTag.Parent = player.Character
	newTag.Adornee = player.Character.HumanoidRootPart
	local c = task.spawn(function()
		while true do
			wait()
			if newTag ~= nil and PlayerData[player.Name] ~= nil then
				newTag.PText.Text = (player.Name == player.DisplayName and "@" .. player.Name) or (player.DisplayName)
				newTag.PlayerInfo.LvlInfo.LvlText.Text = "Lvl" .. PlayerData[player.Name].level
				newTag.PlayerInfo.LvlInfo.RebirthNo.Visible = not (PlayerData[player.Name].rebirths == 0)
				newTag.PlayerInfo.LvlInfo.RebirthNo.Text = "Rebirth x" .. PlayerData[player.Name].rebirths .. " "
				if newTag ~= nil and PlayerData[player.Name] ~= nil then
					local t = game:GetService("TweenService"):Create(newTag.PlayerInfo.LvlInfo.ProgressBar.NewPercentage, TweenInfo.new(0.25), {Size = UDim2.new(PlayerData[player.Name].xp/FE2Library.calcLevelXP(PlayerData[player.Name].level), 0, 1, 0)})
					t:Play()
					t.Completed:Connect(function()
						if newTag ~= nil and PlayerData[player.Name] ~= nil then
							local c = game:GetService("TweenService"):Create(newTag.PlayerInfo.LvlInfo.ProgressBar.Percentage, TweenInfo.new(0.25), {Size = UDim2.new(PlayerData[player.Name].xp/FE2Library.calcLevelXP(PlayerData[player.Name].level), 0, 1, 0)})
							c:Play()
						end
					end)
				end	
			end
		end
	end)
	if not BadgeService:UserHasBadgeAsync(player.UserId, 0) then
		BadgeService:AwardBadge(player.UserId, 0)
	end
	local lastBGM = ""
	player.Chatted:Connect(function(message)
		AdminModule.DoAdmin(player, message)
	end)
	player.CharacterAdded:Connect(function(char)
		task.defer(c)
		c = nil
		local newTag = script.PlrInfo:Clone()
		newTag.PText.Text = (player.Name == player.DisplayName and "@" .. player.Name) or (player.DisplayName)
		newTag.PlayerInfo.PlayerHolder.BackgroundTransparency = 0
		newTag.PlayerInfo.LvlInfo.LvlText.Text = "Lvl" .. PlayerData[player.Name].level
		newTag.PlayerInfo.LvlInfo.RebirthNo.Visible = not (PlayerData[player.Name].rebirths == 0)
		newTag.PlayerInfo.LvlInfo.RebirthNo.Text = "Rebirth x" .. PlayerData[player.Name].rebirths .. " "
		if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 4223166) then
			newTag.PlayerInfo.PlayerHolder.VIP.Visible = true
		end
		newTag.Parent = char
		newTag.Adornee = char.HumanoidRootPart
		Sound = Instance.new("Sound")
		Sound.Parent = char:WaitForChild("Head")
		Sound.Name = "Boombox"
		Sound.SoundId = lastBGM
		Sound.SoundGroup = game.SoundService.Boomboxes
		Sound:Play()
		c = task.spawn(function()
			while true do
				wait()
				if newTag ~= nil and PlayerData[player.Name] ~= nil then
					newTag.PText.Text = (player.Name == player.DisplayName and "@" .. player.Name) or (player.DisplayName)
					newTag.PlayerInfo.LvlInfo.LvlText.Text = "Lvl" .. PlayerData[player.Name].level
					newTag.PlayerInfo.LvlInfo.RebirthNo.Visible = not (PlayerData[player.Name].rebirths == 0)
					newTag.PlayerInfo.LvlInfo.RebirthNo.Text = "Rebirth x" .. PlayerData[player.Name].rebirths .. " "
					if newTag ~= nil and PlayerData[player.Name] ~= nil then
						local t = game:GetService("TweenService"):Create(newTag.PlayerInfo.LvlInfo.ProgressBar.NewPercentage, TweenInfo.new(0.25), {Size = UDim2.new(PlayerData[player.Name].xp/FE2Library.calcLevelXP(PlayerData[player.Name].level), 0, 1, 0)})
						t:Play()
						t.Completed:Connect(function()
							if newTag ~= nil and PlayerData[player.Name] ~= nil then
								local c = game:GetService("TweenService"):Create(newTag.PlayerInfo.LvlInfo.ProgressBar.Percentage, TweenInfo.new(0.25), {Size = UDim2.new(PlayerData[player.Name].xp/FE2Library.calcLevelXP(PlayerData[player.Name].level), 0, 1, 0)})
								c:Play()
							end
						end)
					end	
				end
			end
		end)
		player.CharacterAppearanceLoaded:Wait()
		for _, ItemID in next, PlayerData[player.Name].equipped do
			if ItemID == 0 then
				continue
			end
			local ItemFounded = nil
			for _, item in next, itemDataL do
				if item.ID == ItemID then
					ItemFounded = item
					break
				end
			end
			if ItemFounded.catagory == "Skins" then
				player:ClearCharacterAppearance()
			end
			EquipItem(player, ItemFounded, ItemID, true)
		end
	end)
	player.CharacterRemoving:Connect(function(character)
		if PlayerData[player.Name].xp >= FE2Library.calcLevelXP(PlayerData[player.Name].level) then
			repeat
				task.wait()
				if PlayerData[player.Name].xp >= FE2Library.calcLevelXP(PlayerData[player.Name].level) then
					PlayerData[player.Name].level += 1
					PlayerData[player.Name].xp -= FE2Library.calcLevelXP(PlayerData[player.Name].level)
				end
			until PlayerData[player.Name].xp < FE2Library.calcLevelXP(PlayerData[player.Name].level)
			rem.LvlUp:FireClient(player, 10)
			PlayerData[player.Name].gems += 10	
		end
		rem.VotingReset:FireClient(player)
		--rem.GameEnded:FireClient(player)
		lastBGM = string.sub(Sound.SoundId, 14, -1) or ""
		--Sound:Play()
		for i, v in ipairs(Players_Playing) do
			if v == player then
				table.remove(Players_Playing, i)
			end
		end
		for i, v in ipairs(Players_Waiting) do
			if v == player then
				table.remove(Players_Waiting, i)
			end
		end
		for i, v in ipairs(Players_Voting) do
			if v == player then
				table.remove(Players_Voting, i)
			end
		end
		for i, v in ipairs(PlayersLoading) do
			if v == player then
				table.remove(PlayersLoading, i)
			end
		end
		--print(Map_PlayerData[player.Name])
		if game.Players:FindFirstChild(player.Name) then
			if rem.ReqPlayerState:InvokeClient(player) == "Playing" then
				Map_PlayerData[player.Name].died = true
				PlayerData[player.Name].gameplayStats.diedIngame += 1
				for _, v in next, Map_PlayerData[player.Name].mapSums do
					Map_PlayerData[player.Name].sumXP += v.XP.Total
				end
				PlayerData[player.Name].gameplayStats.xpEarned += Map_PlayerData[player.Name].sumXP
				game.ReplicatedStorage.Remote.ShowSummary:FireClient(player, Map_PlayerData[player.Name].mapSums, Map_PlayerData[player.Name].died, Map_PlayerData[player.Name].sumXP, Map_PlayerData[player.Name].XPmulti, Map_PlayerData[player.Name].awardedCoins, Map_PlayerData[player.Name].awardedGems)
			end	
		end
		task.wait(0.5)
		Map_PlayerData[player.Name] = {
			mapSums = {},
			died = false,
			sumXP = 0,
			XPmulti = 0,
			awardedCoins = 0,
			awardedGems = 0,
		}
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	dateValue = os.date("!*t")
	CurrentMonth = MonthNames[dateValue["month"]]
	CurrentYear = dateValue["year"]
	local CurrentMonthLeaderStats
	local s, e = pcall(function()
		CurrentMonthLeaderStats = DataStoreService:GetOrderedDataStore("CMLeaderStore_ProjectEscape"..CurrentMonth..CurrentYear)
	end)
	local xp = PlayerData[player.Name].xp
	local DataToSave = PlayerData[player.Name]
	local success, erro = pcall(function()
		DataStore:SetAsync(player.Name.."_data", DataToSave)
	end)
	if not success then
		error(`Couldn't save data! Reason: {erro}`)
	end
	success, erro = pcall(function()
		CurrentMonthLeaderStats:SetAsync(player.Name, xp)
	end)
	if not success then
		error(`Couldn't update data! Reason: {erro}`)
	end
	for i, v in ipairs(Players_Playing) do
		if v == player then
			table.remove(Players_Playing, i)
		end
	end
	for i, v in ipairs(Players_Waiting) do
		if v == player then
			table.remove(Players_Waiting, i)
		end
	end
	PlayerData[player.Name] = nil
	Map_PlayerData[player.Name] = nil
end)

function generateRope(ropeModel)
	if ropeModel:IsA("Model") and ropeModel.Name == "_Rope" then
		BezierLib:renderRope(ropeModel)
	end
end

for i,v in pairs(game.Workspace:GetDescendants()) do
	if v:IsA("Model") and v.Name == "_Rope" then
		generateRope(v)
	end
end

local HighlightMaps = {}
for i, v in pairs(game.ServerStorage.Maps:GetChildren()) do
	if v:IsA("Model") then
		if v.Settings:GetAttribute("Featured") then
			local d = createHighlightInfo(v)
			table.insert(HighlightMaps, d)
		end
		local data = createMapVoteInfo(v)
		table.insert(MapData[math.floor(tonumber(data.difficulty))], data) --oh my god
	end
end

game.Workspace.ChildAdded:Connect(function(obj)
	if obj:IsA("Model") and obj.Name == "_Rope" then
		generateRope(obj)
	end
end)

game.Workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("Model") and obj.Name == "_Rope" then
		generateRope(obj)
	end
end)

game.ServerStorage.Maps.ChildAdded:Connect(function(obj)
	local found = false
	if obj:FindFirstChild("Featured") or obj:GetAttribute("Featured") then
		local d = createHighlightInfo(obj)
		table.insert(HighlightMaps, d)
	end
	local data = createMapVoteInfo(obj)
	table.insert(MapData[math.floor(tonumber(data.difficulty))], data) --oh my god
end)

rem.PlayerFinishedLoading.OnServerEvent:Connect(function(player : Player)
	rem.VotingReset:FireAllClients()
	local index = table.find(PlayersLoading, player)
	if index ~= nil then
		table.remove(PlayersLoading, index)
	end
	rem.UpdateLoadingCount:FireAllClients(#PlayersLoading)
end)
rem.UpdOptions.OnServerEvent:Connect(function(player : Player, arg1, arg2, arg3, arg4)
	rem.UpdOptions:FireClient(player, arg1, arg2, arg3, arg4)
end)
rem.DeleteMap.OnServerEvent:Connect(function(player, Map_Name)
	if table.find(Admins, player.UserId)  then
		local mapIndex, difIndex
		for difIdx, dif in ipairs(MapData) do
			for mapIdx, mapData in ipairs(dif) do
				if mapData.name == Map_Name then
					mapIndex = mapIdx
					difIndex = difIdx
					mapData.Map:Destroy()
					break
				end
			end
			if mapIndex then break end
		end

		if difIndex and mapIndex then
			table.remove(MapData[difIndex], mapIndex)
		else
			print("Map not found:", Map_Name)
		end
	end
end)
rem.ServerJoinedLift.Event:Connect(function(player : Player)
	if table.find(Players_Waiting, player) then
		return
	end
	table.insert(Players_Waiting, player)
	print(IsMapVoting)
	if IsMapVoting then
		table.insert(Players_Voting, player)
		rem.StartVoting:FireClient(player)
	end
end)
rem.ClientJoinedLift.OnServerEvent:Connect(function(player : Player)
	if table.find(Players_Waiting, player) then
		return
	end
	table.insert(Players_Waiting, player)
	player.Character:MoveTo(game.Workspace.Lobby.WaitingArea.WaitTeleport.Position + Vector3.new(0, 3, 0))
	print(IsMapVoting)
	if IsMapVoting then
		table.insert(Players_Voting, player)
		rem.StartVoting:FireClient(player)
	end	
end)
rem.UpdHighlightedMaps.OnServerEvent:Connect(function(player : Player)
	rem.UpdHighlightedMaps:FireClient(player, HighlightMaps)
end)
rem.ClientLeftLift.OnServerEvent:Connect(function(player : Player)
	local index = table.find(Players_Waiting, player)
	if index ~= nil then
		table.remove(Players_Waiting, index)
	end
	local inde2 = table.find(Players_Voting, player)
	if inde2 ~= nil then
		table.remove(Players_Voting, inde2)
	end
	player.Character:MoveTo(game.Workspace.Lobby.WaitingArea.ExitTeleport.Position + Vector3.new(0, 3, 0))
end)
rem.VoteUpdate.OnServerEvent:Connect(function(player, index, priceThing)
	--print(index, MapsVoting)
	local has2x = CheckGamepassOwnership(player).TwoTimeVote or table.find(Admins, player.UserId)
	local hasAll = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, 14112023) or table.find(Admins, player.UserId)
	local add_ = (has2x and 2) or 1
	if MapsVoting[index].locked == true and hasAll == false then
		local data = PlayerData[player.Name]
		if data == nil then
			return
		end
		--print(data.coins - MapsVoting[index].unlockCost)
		if data.coins - MapsVoting[index].unlockCost > 0 then
			data.coins -= MapsVoting[index].unlockCost
			MapsVoting[index].locked = false
			MapsVoting[index].voteCount += add_
		end
	elseif priceThing ~= nil then
		local data = PlayerData[player.Name]
		if data == nil then
			return
		end
		--print(data, data.coins - priceThing)
		if data.coins - priceThing > 0 then
			data.coins -= priceThing
			--MapsVoting[index].locked = false
			MapsVoting[index].voteCount += add_
		end
	else
		MapsVoting[index].locked = false
		MapsVoting[index].voteCount += add_
	end
	print(MapsVoting[index].voteCount, index)
	for i, v in next, game.Players:GetPlayers() do
		rem.VoteUpdate:FireClient(v, MapsVoting[index].name, tostring(MapsVoting[index].voteCount), index)
	end
	local index = table.find(Players_Voting, player)
	if index ~= nil then
		table.remove(Players_Voting, index)
	end
	if not table.find(PlayersWhoVoted, player) then
		table.insert(PlayersWhoVoted, player)
	end
end)
rem.UpdateCount.OnServerEvent:Connect(function(player : Player, newTimeLeft : number)
	if PlayerData[player.Name] ~= nil then
		PlayerData[player.Name].timeleft = newTimeLeft
	end
end)
rem.BoomboxPlay.OnServerEvent:Connect(function(player : Player, ID : number)
	if not player.Character:WaitForChild("Head"):FindFirstChild("Boombox") then
		local Sound = Instance.new("Sound")
		Sound.Parent = player.Character:WaitForChild("Head")
		Sound.Name = "Boombox"
		Sound.SoundId = "rbxassetid://" ..tostring(ID)
		Sound:Play()
	else
		local Sound = player.Character:WaitForChild("Head"):WaitForChild("Boombox")
		Sound.SoundId = "rbxassetid://" ..tostring(ID)
		Sound:Play()
	end
end)
rem.BoomboxStop.OnServerEvent:Connect(function(player : Player)
	if player.Character:WaitForChild("Head"):FindFirstChild("Boombox") then
		player.Character.Head.Boombox:Stop()
	end
end)
function EquipItem(player : Player, itemData, ItemID, isInit)
	local catagorytype = itemData.catagory
	local plr_data = PlayerData[player.Name]
	local item_data = items[catagorytype]:WaitForChild(tostring(ItemID))
	if isInit == nil then
		isInit = false
	end
	if isInit == false then
		if catagorytype == "Auras" then
			plr_data.equipped.Auras = 0
			local aboveRemove = false
			for _, aura_folder : Folder in ipairs(item_data:GetChildren()) do
				for _, aura : ParticleEmitter? in ipairs(aura_folder:GetChildren()) do
					local remove = false
					for _, item in ipairs(player.Character[aura_folder.Name]:GetDescendants()) do
						--print(item.Name, aura.Name)
						if item.Name == aura.Name then
							item:Destroy()
							remove = true
							aboveRemove = true
						end
					end
					if remove == false then
						if aura:IsA("ParticleEmitter") then
							local c = aura:Clone()
							c.Parent = player.Character[aura_folder.Name]
							c.Enabled = true
						end
					end
				end
			end
			plr_data.equipped.Auras = (aboveRemove == false and ItemID) or 0
			rem.UpdPlayerData:FireClient(player, plr_data)
		elseif catagorytype == "Emotes" then
			if plr_data.equipped.Emotes == ItemID then
				plr_data.equipped.Emotes = 0
				player.Character.Animate.UpdEmote:FireClient(player, 0)
			else
				plr_data.equipped.Emotes = ItemID
				player.Character.Animate.UpdEmote:FireClient(player, item_data.Value)
			end
			rem.UpdPlayerData:FireClient(player, plr_data)
		elseif catagorytype == "Skins" then
			if plr_data.equipped.Skins == ItemID then
				player:ClearCharacterAppearance()
				plr_data.equipped.Skins = 0
				rem.UpdPlayerData:FireClient(player, plr_data)
				local hum = player.Character.Humanoid :: Humanoid
				local temp_hum_desc = game.Players:GetHumanoidDescriptionFromUserId(1)
				local hum_desc = game.Players:GetHumanoidDescriptionFromUserId(player.UserId)
				if hum_desc and hum then
					hum:ApplyDescription(temp_hum_desc)
					hum:ApplyDescription(hum_desc)
				end
				local Done = false
				for item, value in pairs(game.Players:GetCharacterAppearanceInfoAsync(player.UserId).assets) do
					if value.assetType.name == "Face" then
						player.Character.Head.face.Texture = "rbxassetid://"..tostring(value.id)
						Done = true
						break
					end
				end
				if Done ~= true then
					player.Character.Head.face.Texture = "rbxasset://textures/face.png"
				end
				return
			else
				plr_data.equipped.Skins = ItemID
				player:ClearCharacterAppearance()
				local face = item_data:FindFirstChild("face") :: Decal
				if face then
					player.Character.Head.face.Texture = face.Texture
				else
					player.Character.Head.face.Texture = "rbxasset://textures/face.png"
				end
				local children = item_data:GetChildren()
				for i, child in ipairs(children) do
					if child.Name ~= "face" then
						player:LoadCharacterAppearance(child:Clone())
					end
				end
				rem.UpdPlayerData:FireClient(player, plr_data)
			end
		elseif catagorytype == "Tanks" then	
			if plr_data.equipped.Tanks == ItemID then
				if player.Character:FindFirstChild("Tank") then
					player.Character.Tank:Destroy()
				end
				plr_data.equipped.Tanks = 0
				rem.UpdPlayerData:FireClient(player, plr_data)
				return
			end
			if player.Character:FindFirstChild("Tank") then
				player.Character.Tank:Destroy()
			end
			plr_data.equipped.Tanks = ItemID
			local Tank = item_data:Clone() :: Model
			for _, v in ipairs(Tank:GetDescendants()) do
				if v:IsA("BasePart") and v.Name ~= "Center" then
					local a = Instance.new("ManualWeld")
					a.Part0 = Tank.Center
					a.Part1 = v
					a.C0 = Tank.Center.CFrame:inverse() * v.CFrame
					a.Parent = v
				end
			end
			local w = Instance.new("ManualWeld")
			w.Part0 = Tank.Center
			w.Part1 = player.Character.Torso
			w.Parent = player.Character.Torso
			w.C0 = CFrame.new(0,0,0,1,0,0,0,1,0,0,0,1)
			w.C1 = CFrame.new(0,0,0,1,0,0,0,1,0,0,0,1)
			Tank.Name = "Tank"
			Tank.PrimaryPart = Tank.Center
			local PrimaryCFrame = player.Character:GetPrimaryPartCFrame()
			Tank:SetPrimaryPartCFrame(PrimaryCFrame)
			Tank.Parent = player.Character
			for _, v in ipairs(Tank:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CollisionGroup = "Chars"
				end
			end
			rem.UpdPlayerData:FireClient(player, plr_data)
		elseif catagorytype == "Buddies" then
			if plr_data.equipped.Buddies == ItemID then
				if workspace.Buddies:FindFirstChild(player.Name .. "_Buddy") then
					local buddy = workspace.Buddies:FindFirstChild(player.Name .. "_Buddy")
					buddy:Destroy()
				end
				plr_data.equipped.Buddies = 0
				rem.UpdPlayerData:FireClient(player, plr_data)
				return
			end
			if workspace.Buddies:FindFirstChild(player.Name .. "_Buddy") then
				local buddy = workspace.Buddies:FindFirstChild(player.Name .. "_Buddy")
				buddy:Destroy()
			end
			local buddy = item_data:Clone() :: Model
			if buddy:FindFirstChild("Logo") then
				for _, v in ipairs(buddy:GetDescendants()) do
					if v:IsA("BasePart") then
						v.Anchored = false
					end
				end
			end
			if buddy:FindFirstChildWhichIsA("Humanoid") then
				local hum = buddy:FindFirstChildWhichIsA("Humanoid")
				hum.Name = "Humanoid"
				buddy.Follow:Destroy()
				local ff = script.Follow:Clone()
				ff.Parent = buddy
				ff.Enabled = true
			end
			if buddy:FindFirstChild("Animate") then
				local anim = buddy:FindFirstChild("Animate")
				anim:Destroy()
				local newAnim = script.Animate:Clone()
				newAnim.Parent = buddy
				newAnim.Enabled = true
			end
			for _, v in ipairs(buddy:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CollisionGroup = "Buddies"
				end
			end
			buddy.Pointer.Parent = buddy.Follow
			buddy.Follow.Pointer.Value = player.Character
			buddy.Name = player.Name .. "_Buddy"
			buddy.Parent = workspace.Buddies
			buddy:MoveTo(player.Character.HumanoidRootPart.Position)
			plr_data.equipped.Buddies = ItemID
			rem.UpdPlayerData:FireClient(player, plr_data)
		end
	elseif isInit == true then
		if catagorytype == "Auras" then
			plr_data.equipped.Auras = 0
			local aboveRemove = false
			for _, aura_folder : Folder in ipairs(item_data:GetChildren()) do
				for _, aura : ParticleEmitter? in ipairs(aura_folder:GetChildren()) do
					local remove = false
					for _, item in ipairs(player.Character[aura_folder.Name]:GetDescendants()) do
						--print(item.Name, aura.Name)
						if item.Name == aura.Name then
							item:Destroy()
							remove = true
							aboveRemove = true
						end
					end
					if remove == false then
						if aura:IsA("ParticleEmitter") then
							local c = aura:Clone()
							c.Parent = player.Character[aura_folder.Name]
							c.Enabled = true
						end
					end
				end
			end
			plr_data.equipped.Auras = (aboveRemove == false and ItemID) or 0
			rem.UpdPlayerData:FireClient(player, plr_data)
		elseif catagorytype == "Emotes" then
			plr_data.equipped.Emotes = ItemID
			player.Character.Animate.UpdEmote:FireClient(player, item_data.Value)
			rem.UpdPlayerData:FireClient(player, plr_data)
		elseif catagorytype == "Skins" then
			player:ClearCharacterAppearance()
			plr_data.equipped.Skins = ItemID
			player:ClearCharacterAppearance()
			local face = item_data:FindFirstChild("face") :: Decal
			player:ClearCharacterAppearance()
			if face then
				player.Character.Head.face.Texture = face.Texture
			else
				player.Character.Head.face.Texture = "rbxasset://textures/face.png"
			end
			local children = item_data:GetChildren()
			for i, child in ipairs(children) do
				if child.Name ~= "face" then
					player:LoadCharacterAppearance(child:Clone())
				end
			end
			rem.UpdPlayerData:FireClient(player, plr_data)
		elseif catagorytype == "Tanks" then	
			plr_data.equipped.Tanks = ItemID
			plr_data.equipped.Tanks = ItemID
			local Tank = item_data:Clone() :: Model
			for _, v in ipairs(Tank:GetDescendants()) do
				if v:IsA("BasePart") and v.Name ~= "Center" then
					local a = Instance.new("ManualWeld")
					a.Part0 = Tank.Center
					a.Part1 = v
					a.C0 = Tank.Center.CFrame:inverse() * v.CFrame
					a.Parent = v
				end
			end
			local w = Instance.new("ManualWeld")
			w.Part0 = Tank.Center
			w.Part1 = player.Character.Torso
			w.Parent = player.Character.Torso
			w.C0 = CFrame.new(0,0,0,1,0,0,0,1,0,0,0,1)
			w.C1 = CFrame.new(0,0,0,1,0,0,0,1,0,0,0,1)
			Tank.Name = "Tank"
			Tank.PrimaryPart = Tank.Center
			local PrimaryCFrame = player.Character:GetPrimaryPartCFrame()
			Tank:SetPrimaryPartCFrame(player.Character.Torso.CFrame)
			Tank.Parent = player.Character 
			for _, v in ipairs(Tank:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CollisionGroup = "Chars"
				end
			end
			rem.UpdPlayerData:FireClient(player, plr_data)
		elseif catagorytype == "Buddies" then
			if workspace.Buddies:FindFirstChild(player.Name .. "_Buddy") then
				local buddy = workspace.Buddies:FindFirstChild(player.Name .. "_Buddy")
				buddy:Destroy()
			end
			local buddy = item_data:Clone() :: Model
			if buddy:FindFirstChild("Logo") then
				for _, v in ipairs(buddy:GetDescendants()) do
					if v:IsA("BasePart") then
						v.Anchored = false
					end
				end
			end
			if buddy:FindFirstChildWhichIsA("Humanoid") then
				local hum = buddy:FindFirstChildWhichIsA("Humanoid")
				hum.Name = "Humanoid"
				buddy.Follow:Destroy()
				local ff = script.Follow:Clone()
				ff.Parent = buddy
				ff.Enabled = true
			end
			if buddy:FindFirstChild("Animate") then
				local anim = buddy:FindFirstChild("Animate")
				anim:Destroy()
				local newAnim = script.Animate:Clone()
				newAnim.Parent = buddy
				newAnim.Enabled = true
			end
			for _, v in ipairs(buddy:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CollisionGroup = "Buddies"
				end
			end
			buddy.Pointer.Parent = buddy.Follow
			buddy.Follow.Pointer.Value = player.Character
			buddy.Name = player.Name .. "_Buddy"
			buddy.Parent = workspace.Buddies
			buddy:MoveTo(player.Character.HumanoidRootPart.Position)
			plr_data.equipped.Buddies = ItemID
			rem.UpdPlayerData:FireClient(player, plr_data)
		end
	end
end
rem.ConfirmItem.OnServerEvent:Connect(function(player : Player, NegPassKey, ItemID)
	if NegPassKey == -PassKey then
		local ItemFounded = nil
		for _, item in next, itemDataL do
			if item.ID == ItemID then
				ItemFounded = item
				break
			end
		end
		
		local data = PlayerData[player.Name]
		--print(ItemFounded)
		if ItemFounded ~= nil and ItemFounded.notForSale ~= true and not table.find(PlayerData[player.Name].inventory, ItemID) then
			local CurrencyType = ItemFounded.currency
			if CurrencyType == 0 then
				local hasEnough = data.coins - ItemFounded.price
				if hasEnough > 0 then
					data.coins -= ItemFounded.price
					table.insert(data.inventory, ItemFounded.ID)
					print(data.inventory)
				end
			elseif CurrencyType == 1 then
				local hasEnough = data.gems - ItemFounded.price
				if hasEnough > 0 then
					data.gems -= ItemFounded.price
					table.insert(data.inventory, ItemFounded.ID)
					print(data.inventory)
				end
			else
				local cur = ItemFounded.curReward :: number | nil
				if cur ~= nil then
					local s, e = pcall(function()
						MarketplaceService:PromptProductPurchase(player, ItemFounded.ID)
					end)
					if not s then
						error(e)
					end
				else
					MarketplaceService:PromptGamePassPurchase(player, ItemFounded.ID)
				end
			end
		elseif ItemFounded ~= nil and table.find(data.inventory, ItemFounded.ID) then
			EquipItem(player, ItemFounded, ItemID)
		end
		rem.UpdPlayerData:FireClient(player, data)
	end
end)
rem.UpdateData.OnServerEvent:Connect(function(player, NewData)
	PlayerData[player.Name] = NewData
end)
rem.ReqCode.OnServerEvent:Connect(function(player : Player, NegPassKey, CodeInputted)
	if NegPassKey == -PassKey then
		for _, code_data in ipairs(vaildCodes) do
			if code_data.code == CodeInputted then
				local data = PlayerData[player.Name]
				if not table.find(data.redeemed, CodeInputted) then
					print("added code " .. CodeInputted .. " for " .. player.Name)
					table.insert(data.redeemed, CodeInputted)
					data.xp += code_data.xp
					data.coins += code_data.coins
					data.gems += code_data.gems
					rem.Alert:FireClient(player, `Awarded {code_data.xp or 0}XP`, Color3.fromRGB(241, 196, 15), 3)
					if code_data.skinID ~= nil then
						local Skin = items.Skins:FindFirstChild(tostring(code_data.skinID))
						if Skin ~= nil then
							local _item_ = nil
							for _, v in next, itemDataL do
								if code_data.skinID == v.ID then
									_item_ = v
									break
								end
							end
							rem.Notify:FireClient(player, "You have been awarded with " .. _item_.name .. "!", "Item Awarded", nil, _item_.imgID)
							table.insert(data.inventory, code_data.skinID)
							print("New inv for" .. player.Name, data.inventory)
						end
						--rem.UpdPlayerData:FireClient(player, data)
					elseif code_data.tankid ~= nil then
						local Skin = items.Tanks:FindFirstChild(tostring(code_data.tankid))
						if Skin ~= nil then
							if table.find(data.inventory, code_data.tankid) then
								print("already owned")
							else
								local _item_ = nil
								for _, v in next, itemDataL do
									if code_data.tankid == v.ID then
										_item_ = v
										break
									end
								end
								print(_item_)
								rem.Notify:FireClient(player, "You have been awarded with " .. _item_.name .. "!", "Item Awarded", nil, _item_.imgID)
								table.insert(data.inventory, code_data.tankid)
							end
						end
					end
					if PlayerData[player.Name].xp >= FE2Library.calcLevelXP(PlayerData[player.Name].level) then
						repeat
							task.wait()
							if PlayerData[player.Name].xp >= FE2Library.calcLevelXP(PlayerData[player.Name].level) then
								PlayerData[player.Name].level += 1
								PlayerData[player.Name].xp -= FE2Library.calcLevelXP(PlayerData[player.Name].level)
							end
						until PlayerData[player.Name].xp < FE2Library.calcLevelXP(PlayerData[player.Name].level)
						rem.LvlUp:FireClient(player, 10)
						PlayerData[player.Name].gems += 10	
					end
					rem.UpdPlayerData:FireClient(player, data)	
				end
			end
		end
	end
end)
rem.UpdSpectate.OnServerInvoke = function(player : Player)
	local ClonedPlayers = table.clone(Players_Playing)
	local index = table.find(ClonedPlayers, player)
	if index ~= nil then
		table.remove(ClonedPlayers,index)
	end
	return ClonedPlayers
end
rem.FetchPlayerPing.OnServerInvoke = function()
	return "received"
end
rem.GetCurrentBoost.OnServerInvoke = function(player : Player)
	return CurrentBoost
end
rem.CurrentDif.OnServerInvoke = function(player : Player)
	return CurrentDif
end
rem.GetPlayingPlayers.OnServerInvoke = function()
	return Players_Playing
end
rem.ReqMapData.OnServerInvoke = function()
	return MapData
end
rem.ReqItemData.OnServerInvoke = function(player : Player)
	repeat
		wait(0.1)
	until PlayerData[player.Name] ~= nil
	local plrData = PlayerData[player.Name]
	local itemData = itemDataL
	return plrData, itemData
end
rem.RequestAdminStatus.OnServerInvoke = function(player : Player)
	if table.find(Admins, player.UserId)  then
		return true
	else
		return false
	end
end
rem.CheckGamepassOwnership.OnServerInvoke = function(Local_Player : Player)
	local ListOfPass = {}
	ListOfPass.CFC = false
	ListOfPass.VIP = false
	ListOfPass.Boost = false
	ListOfPass.TwoTimeVote = false
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 14784835) then
		ListOfPass.CFC = true
	end
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 4223166) then
		ListOfPass.VIP = true
	end
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 14432092) then
		ListOfPass.Boost = true
	end
	if MarketplaceService:UserOwnsGamePassAsync(Local_Player.UserId, 141376407) then
		ListOfPass.TwoTimeVote = true
	end
	return ListOfPass
end
rem.ReqLostPages.OnServerInvoke = function(player : Player)
	return {} --todo lol
end
rem.ReqPassKey.OnServerInvoke = function(player : Player)
	return PassKey
end
rem.FetchStarterpackTimer.OnServerInvoke = function(player : Player)
	local timeleft = 0
	local awaitTick = tick()
	local found = false
	repeat task.wait() found = PlayerData[player.Name] ~= nil and PlayerData[player.Name].timeleft ~= nil until tick() - awaitTick >= 5 or found == true
	if found then
		timeleft = PlayerData[player.Name].timeleft
	end
	return timeleft
end
rem.ReqPlayerData.OnServerInvoke = function(player : Player)
	if PlayerData[player.Name] ~= nil then
		return PlayerData[player.Name]
	end
	return
end
rem.ReqMapPageData.OnServerInvoke = function(player : Player)
	local t = {}
	local Maps = game.ServerStorage.Maps
	for _, Map in next, Maps:GetChildren() do
		if Map:IsA("Model") then
			if Map.Settings:FindFirstChild("Featured") or Map.Settings:GetAttribute("Featured") then
				continue
			else
				local Tab = {}
				Tab.mapName = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("MapName")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("MapName") and Map:FindFirstChild("Settings"):FindFirstChild("MapName").Value) or "???"
				Tab.mapDif = math.floor((Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("Difficulty")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("Difficulty") and Map:FindFirstChild("Settings"):FindFirstChild("Difficulty").Value) or 6.9)
				Tab.mapImg = tostring((Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("MapImage")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("MapImage") and Map:FindFirstChild("Settings"):FindFirstChild("MapImage").Value))
				table.insert(t, Tab)
			end
		end
	end
	--print(t)
	return t
end
rem.ReqWaitingData.OnServerInvoke = function(player : Player)
	if #Players_Playing > 0 then
		repeat task.wait() until plrStartingCount > 0
		local Map = workspace.Multiplayer:WaitForChild("Map")
		local mapName = (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):GetAttribute("MapName")) or (Map:FindFirstChild("Settings") and Map:FindFirstChild("Settings"):FindFirstChild("MapName") and Map:FindFirstChild("Settings"):FindFirstChild("MapName").Value) or "???"
		return `{mapName} {#Players_Playing}/{plrStartingCount}`
	else
		return "Get Ready..."
	end
end	
game.ServerStorage.Bindables.GetMapData.OnInvoke = function(player : Player)
	return MapData
end
--game.ServerStorage.Bindables.Challenges.Data_UpdProgression.Event:Connect(function(player : Player, UpdatedData, IsCompleted : boolean)
--	PlayerData[player.Name] = UpdatedData
--	PlayerData[player.Name].gameplayStats.dailyChallengesCompleted += 1
--	rem.UpdPlayerData:FireClient(player, PlayerData[player.Name], true)	
--end)
game.ServerStorage.Bindables.GetPlaying.OnInvoke = function()
	return Players_Playing
end
game.ServerStorage.Bindables.ForceMap.Event:Connect(function(ForcedMap)
	ForceMap = ForcedMap
end)
game.ServerStorage.Bindables.UpdVotingTime.Event:Connect(function(NewTime : number)
	if NewTime == "me" then
		VotingMaxTime = 10
	else
		VotingMaxTime = tonumber(NewTime)
	end
end)
spawn(function()
	while wait(1) do
		if #Players_Waiting > 0 then
			if IsGameRunning == true then
				return
			end
			local MapVoted = StartNewMapVote()
			IsGameRunning = true
			IsMapVoting = false
			CurrentBoostValue = 0
			CurrentBoost = 5
			if MapVoted ~= nil then
				local MapInfo = CreateMapInfo(MapVoted)
				if MapInfo ~= nil then
					NewRound(MapInfo)
				end
			end
			IsGameRunning = false
		end
	end
end)

task.spawn(function()
	while task.wait(2 * 60) do
		dateValue = os.date("!*t")
		CurrentMonth = MonthNames[dateValue["month"]]
		CurrentYear = dateValue["year"]
		local CurrentMonthLeaderStats
		local s, e = pcall(function()
			CurrentMonthLeaderStats = DataStoreService:GetOrderedDataStore("CMLeaderStore_ProjectEscape"..CurrentMonth..CurrentYear)
		end)
		
		for name, plr in next, PlayerData do
			local DataToSave = plr
			local xp = plr.xp or 0
			local success, erro = pcall(function()
				DataStore:SetAsync(name.."_data", DataToSave)
			end)
			if not success then
				error(`Couldn't save data! Reason: {erro}`)
			else
				if game.Players:FindFirstChild(name) then
					local plr : PLayer = game.Players:FindFirstChild(name) :: Player
					rem.Alert:FireClient(plr, "💾 Data Saved!", Color3.new(0.964706, 0.580392, 1), 3)
				end
			end
			success, erro = pcall(function()
				CurrentMonthLeaderStats:SetAsync(name, xp)
			end)
			if not success then
				error(`Couldn't update data! Reason: {erro}`)
			end
		end
		local NewCurrentMonthLeaderStats = nil
		local s, e = pcall(function()
			NewCurrentMonthLeaderStats = DataStoreService:GetOrderedDataStore("CMLeaderStore_ProjectEscape"..CurrentMonth..CurrentYear)
		end)
		local s_pages, pages = pcall(function()
			return NewCurrentMonthLeaderStats:GetSortedAsync(false, 3)
		end)
		if s_pages and pages then
			local data = pages:GetCurrentPage()
			local function AddAwards(data_, index)
				local ids = {19, 39, 49}
				data_ = data_[index]
				local player = Players:FindFirstChild(data_.key) :: Player
				if not player then
					return
				end
				local plrData = PlayerData[player.Name]
				if not plrData then
					return
				end
				local id = ids[index]
				local _item_ = nil
				for _, v in next, itemDataL do
					if id == v.ID then
						_item_ = v
						break
					end
				end
				if not table.find(plrData.inventory, _item_.ID) then
					rem.Notify:FireClient(player, "You have been awarded with " .. _item_.name .. "!", "Item Awarded", nil, _item_.imgID)
					table.insert(plrData.inventory, _item_.ID)	
					rem.UpdPlayerData:FireClient(player, PlayerData[player.Name])
				end
			end
			for index, _ in next, data do
				AddAwards(data, index)
			end
		end
	end
end)

task.spawn(function()
	while task.wait() do
		if isMidnightUTC() then
			stop = true
			repeat task.wait() until stop == false
		end
	end
end)

task.spawn(function()
	while task.wait() do
		if stop == true then
			stop = false
			for name, plr in next, PlayerData do
				--plr.dailyChallenges = ChallengeLib.createPlayerChallenges(true)
				if game.Players:FindFirstChild(name) then
					rem.UpdPlayerData:FireClient(name, plr, true)	
				end
			end
		end
	end
end)

task.spawn(function()
	while task.wait() do
		ReplicatedStorage.Flags.ServerTime.Value = time() - ServerInit
	end
end)

game:BindToClose(function()
	dateValue = os.date("!*t")
	CurrentMonth = MonthNames[dateValue["month"]]
	CurrentYear = dateValue["year"]
	local CurrentMonthLeaderStats
	local s, e = pcall(function()
		CurrentMonthLeaderStats = DataStoreService:GetOrderedDataStore("CMLeaderStore_ProjectEscape"..CurrentMonth..CurrentYear)
	end)
	for name, plr in next, PlayerData do
		local DataToSave = plr
		local xp = plr.xp or 0
		local success, erro = pcall(function()
			DataStore:SetAsync(name.."_data", DataToSave)
		end)
		if not success then
			error(`Couldn't save data! Reason: {erro}`)
		else
			if game.Players:FindFirstChild(name) then
				local plr : PLayer = game.Players:FindFirstChild(name) :: Player
				rem.Alert:FireClient(plr, "💾 Data Saved!", Color3.new(0.964706, 0.580392, 1), 3)
			end
		end
		success, erro = pcall(function()
			CurrentMonthLeaderStats:SetAsync(name, xp)
		end)
		if not success then
			error(`Couldn't update data! Reason: {erro}`)
		end
	end
end)

local PassData = ChinaPolicy.fetchProductAwards()
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player : Player, gamePassId, isPurchased)
	if isPurchased then
		for id, data in next, PassData do
			if id == gamePassId then
				for _, v in ipairs(data) do
					if not table.find(PlayerData[player.Name].inventory, v) then
						local _item_ = nil
						for _, itemdata in next, itemDataL do
							if itemdata.ID == v then
								_item_ = itemdata
								break
							end
						end
						rem.Notify:FireClient(player, "You have been awarded with " .. _item_.name .. "!", "Item Awarded", nil, _item_.imgID)
						table.insert(PlayerData[player.Name].inventory, v)
					end	
				end
				rem.Alert:FireClient(player, `Awarded {0}XP`, Color3.fromRGB(241, 196, 15), 3)
				rem.UpdPlayerData:FireClient(player, PlayerData[player.Name])
				break
			end
		end
	end
end)
MarketplaceService.PromptProductPurchaseFinished:Connect(function(player, assetid, isPurchased)
	if isPurchased == true then
		for id, data in next, PassData do
			--print(id, assetid)
			if id == assetid then
				local plr = nil
				for _, v in next, game.Players:GetPlayers() do
					if v.UserId == player then
						plr = v
						break
					end
				end
				local local_player_data = PlayerData[plr.Name]
				local_player_data.coins += data.coins
				local_player_data.gems += data.gems
				local_player_data.xp += data.xp or 0
				if data.items then
					for _, v in ipairs(data.items) do
						if not table.find(PlayerData[plr.Name].inventory, v) then
							local _item_ = nil
							for _, itemdata in next, itemDataL do
								if itemdata.ID == v then
									_item_ = itemdata
									break
								end
							end
							rem.Notify:FireClient(player, "You have been awarded with " .. _item_.name .. "!", "Item Awarded", nil, _item_.imgID)
							table.insert(PlayerData[plr.Name].inventory, v)
						end	
					end
				end
				rem.Alert:FireClient(plr, `Awarded {data.xp or 0}XP`, Color3.fromRGB(241, 196, 15), 3)
				if data.otherMultiplier ~= nil then
					local coinAmount = data.coins * data.otherMultiplier
					local gemAmount = data.gems * data.otherMultiplier
					for _, v in next, game.Players:GetPlayers() do
						if v ~= plr then
							local l_data = PlayerData[v.Name]
							l_data.coins += coinAmount
							l_data.gems += gemAmount
						end
					end
					local type = (gemAmount ~= 0 and "Gems") or (coinAmount ~= 0 and "Coins")
					local much = (type == "Gems" and tostring(gemAmount)) or (type == "Coins" and tostring(coinAmount))
					local msg = `{plr.Name} has gifted everyone {much} {type}!`
					rem.Alert:FireAllClients(msg, Color3.new(1, 1, 1), 10, "rainbow")
				end
				rem.UpdPlayerData:FireClient(plr, PlayerData[plr.Name])
				break
			end
		end
	end
end)	

bindables.ReqPlayerData.OnInvoke = function(playerName)
	return PlayerData[playerName]
end
rem.ReqTele.OnServerEvent:Connect(function(player : Player, id, JoinData)
	local VistorId = nil
	if JoinData.UserId ~= nil then
		VistorId = JoinData.UserId
	end
	if VistorId ~= nil then
		local s, e = pcall(function() 
			game:GetService("TeleportService"):TeleportToPlaceInstance(id, VistorId, player)
		end)
		if not s then
			error("Couldn't teleport reason:",e)
		end	
	else
		local s, e = pcall(function() 
			game:GetService("TeleportService"):Teleport(id, player) 
		end)
		if not s then
			error("Couldn't teleport reason:",e)
		end
	end
end)
