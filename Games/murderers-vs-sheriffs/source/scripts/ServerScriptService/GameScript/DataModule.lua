local Module = {};
local GiveRewards = true;
local DataStoreService = game:GetService("DataStoreService")
local UtilityService = require(game.ReplicatedStorage.SharedServices.UtilityService)
local DataTable = {};
local Admins = {} -- Old admin list disabled; replacement admin panel will own access control.
local Config = require(game.ReplicatedStorage.Constants)
function Module.GetDataTable()
	return DataTable;
end
local function clearOutfitDisplays(character)
	if not character then return end
	local knifeDisplay = character:FindFirstChild("KnifeDisplay")
	if knifeDisplay then knifeDisplay:Destroy() end
	local gunDisplay = character:FindFirstChild("GunDisplay")
	if gunDisplay then gunDisplay:Destroy() end
end

local function getOutfitUserId(player, outfitName)
	local playerData = player and DataTable[player.Name]
	if not playerData or not playerData.Outfits then
		return nil, "missing outfit data"
	end

	local equippedOutfit = outfitName or (playerData.Outfits.Equipped and playerData.Outfits.Equipped[1])
	if not equippedOutfit or equippedOutfit == "" then
		return nil, "no outfit equipped"
	end

	if equippedOutfit == "Custom_Outfit" then
		local customUserId = tonumber(playerData.Outfits.OutfitId)
		if customUserId and customUserId > 0 then
			return math.floor(math.abs(customUserId))
		end
		return nil, "custom outfit user id missing"
	end

	local outfitsDB = require(game.ReplicatedStorage.Database.Sync.Outfits)
	local outfitData = outfitsDB[equippedOutfit]
	local outfitUserId = outfitData and tonumber(outfitData.UserId)
	if outfitUserId and outfitUserId > 0 then
		return math.floor(math.abs(outfitUserId))
	end

	return nil, "invalid outfit id: " .. tostring(equippedOutfit)
end

local function applyOutfitAppearance(player, outfitName)
	if _G.OutfitsDisabled == true then
		return false, "outfits disabled"
	end

	local userId, userIdError = getOutfitUserId(player, outfitName)
	if not userId then
		return false, userIdError
	end

	local character = player.Character or workspace:FindFirstChild(player.Name)
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return false, "humanoid missing"
	end

	local success, description = pcall(function()
		return game.Players:GetHumanoidDescriptionFromUserId(userId)
	end)
	if not success or not description then
		return false, description or "failed to load humanoid description"
	end

	clearOutfitDisplays(character)
	humanoid:ApplyDescription(description)

	if _G.WeldWeapons then _G.WeldWeapons(player) end
	if _G.WeldRadio then _G.WeldRadio(player) end

	return true, userId
end

function Module.ChangeOutfit(Player, Outfit)
	local applied, result = applyOutfitAppearance(Player, Outfit)
	if not applied and result ~= "outfits disabled" and result ~= "no outfit equipped" then
		warn(("[DataModule/ChangeOutfit]: Failed to apply outfit for %s (%s)"):format(Player and Player.Name or "unknown", tostring(result)))
	end
	return applied, result
end

local function GetSyncData(DataType)
	if DataType == "Weapons" then DataType = "Item" end
	return require(game.ReplicatedStorage.Database.Sync)[DataType]
end
local function PlayerIsElite(Player)
	return Player:GetAttribute("Elite") ~= nil
end
local function RewardElite(Player)
	local Rewards = GetSyncData("EliteRewards");
	local Rewarded = false;
	for DataName,RewardData in pairs(Rewards) do
		if (not DataTable[Player.Name][DataName]) then
			if RewardData.Type == "Weapon" or RewardData.Type == "Pets" then
				local Type = (RewardData.Type=="Pets" and "Pets") or nil;
				Module.GiveItem(Player,RewardData.Reward,1,Type);
				game.ReplicatedStorage.ItemGift:FireClient(Player,RewardData.Reward,Type);
			else
				Module.GiveOther(Player,RewardData.Reward,RewardData.Type);
			end;
			DataTable[Player.Name][DataName] = true;
			Rewarded = true;
		end
	end
	if Rewarded then
		task.spawn(function()
			Module.SaveData(Player);
		end)
	end
end

function CheckForItem(Player, ItemName, Type)
	local Owned = DataTable[Player.Name][Type].Owned
	for Index, Value in pairs(Owned) do
		if Index == ItemName then
			return true, Value
		end
		if Value == ItemName then
			return true, 1
		end
	end
	if Type == "Weapons" then
		local SyncWeapons = GetSyncData("Item")
		local WeaponData = SyncWeapons[ItemName]
		if WeaponData and WeaponData.EvoBaseID then
			local Base = WeaponData.EvoBaseID
			for _, unique in pairs(DataTable[Player.Name].Uniques or {}) do
				if unique.BaseItem == Base and (unique.XP or 0) > 0 then
					return true, 1
				end
			end
		end
	end

	return false
end



Module.CheckForItem = CheckForItem;

local function removeArrayValue(array, value)
	local removed = false
	for index = #array, 1, -1 do
		if array[index] == value then
			table.remove(array, index)
			removed = true
		end
	end
	return removed
end

local function removeOwnedValue(owned, itemID)
	local removed = false
	if owned[itemID] ~= nil then
		owned[itemID] = nil
		removed = true
	end
	return removeArrayValue(owned, itemID) or removed
end

local function playerRedeemedReward(playerData, itemType, itemID)
	local redeemedCodes = playerData.RedeemedCodes or {}
	local codeDatabase = GetSyncData("Codes")
	for code, redeemed in pairs(redeemedCodes) do
		if redeemed then
			local codeData = codeDatabase[code] or codeDatabase[string.upper(tostring(code))]
			if codeData and codeData.Rewards then
				for _, reward in ipairs(codeData.Rewards) do
					if reward.ItemType == itemType and reward.ItemID == itemID then
						return true
					end
				end
			end
		end
	end
	return false
end

local function playerOwnsItemPackReward(playerData, itemType, itemID)
	local itemPacks = playerData.ItemPacks or {}
	for passID, pack in pairs(GetSyncData("ItemPacks")) do
		if itemPacks[tostring(passID)] == true or itemPacks[passID] == true then
			for _, item in ipairs(pack) do
				if item.Type == itemType and item.ItemName == itemID then
					return true
				end
			end
		end
	end
	return false
end

local function cleanupUnredeemedCodeRewards(Player, skipAutoSave)
	local playerData = DataTable[Player.Name]
	if not playerData then
		return false
	end

	local changed = false
	for _, codeData in pairs(GetSyncData("Codes")) do
		for _, reward in ipairs(codeData.Rewards or {}) do
			local itemType = reward.ItemType
			local itemID = reward.ItemID
			local inventory = playerData[itemType]
			if inventory and inventory.Owned and not playerRedeemedReward(playerData, itemType, itemID) and not playerOwnsItemPackReward(playerData, itemType, itemID) then
				if removeOwnedValue(inventory.Owned, itemID) then
					changed = true
					if itemType == "Weapons" then
						if inventory.Equipped and inventory.Equipped.Knife == itemID then
							inventory.Equipped.Knife = "DefaultKnife"
						end
						if inventory.Equipped and inventory.Equipped.Gun == itemID then
							inventory.Equipped.Gun = "DefaultGun"
						end
						if playerData.Uniques then
							for index = #playerData.Uniques, 1, -1 do
								if playerData.Uniques[index].BaseItem == itemID then
									table.remove(playerData.Uniques, index)
								end
							end
						end
						if playerData.Trophies then
							for index = #playerData.Trophies, 1, -1 do
								if playerData.Trophies[index].ItemID == itemID then
									table.remove(playerData.Trophies, index)
								end
							end
						end
					elseif inventory.Equipped then
						removeArrayValue(inventory.Equipped, itemID)
					end
					game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, itemType, itemID, nil)
				end
			end
		end
	end

	if changed then
		game.ReplicatedStorage.UpdateData2:FireClient(Player, playerData, true)
		if not skipAutoSave then
			task.spawn(function()
				Module.SaveData(Player)
			end)
		end
	end
	return changed
end

local OutfitData = {
	["Owned"] = {};
	["Equipped"] = {};
	["Slots"] = 1;
	["Converted"] = true;
};

local DataDefaults = {
	["Coins"] 			= math.huge;
	["Gems"] 			= math.huge;
	["NewXP"] 				= 1237500;
	["XP"] 				= 82500;
	["Prestige"] 		= 10;
	["PetName"] = "";
	["GivedAllFree"] = false;
	["GroupRewards"] = false;
	["XboxKnife"] = false;
	["KnifePosition"] = "Belt";
	["RadioSongs"] = {};
	["ItemPacks"] = {};
	["RedeemedCodes"] = {};
	["Uniques"] = {};
	["Quests"] = {};
	["DeathEffect"] = true;
	["GunEffect"] = false;
	
	["Summer2026"] = {
		Quests = {
			DailyCoins = {
				Claimed = {},
				LastReset = 0,
				Progress = 0,
			},
			Rewards = {
				Claimed = {},
				Progress = 0,
			},
			WeeklyCoins = {
				Claimed = {},
				LastReset = 0,
				Progress = 0,
			},
		},
	},
	
	["Weapons"] = {
		["Owned"] = {
			["DefaultKnife"] = 1;
			["DefaultGun"] = 1;
		};
		["Equipped"] = {
			["Knife"] = "DefaultKnife";
			["Gun"] = "DefaultGun";
		};
		["Slots"] = 2;
		["Converted"] = false;
	};
	
	["Effects"] = {
		["Owned"] = {};
		["Equipped"] = {};
		["Slots"] = 1;
		["Converted"] = true;
	};
	
	["Perks"] = {
		["Owned"] = {"Footsteps"};
		["Equipped"] = {"Footsteps"};
		["Slots"] = 1;
		["Converted"] = true;
	};
	
	["Emotes"] = {
		["Owned"] = {};
		["Converted"] = true;
	};
	
	["Toys"] = {
		["Owned"] = {"zen","sit","ninja","dab","floss","zombie","headless",
			"Fireflies","ChocolateMilk","SprayPaint","FakeBomb","IceCream","Pizza","Teddy","PumpkinBucket","ZombieFriend",
			"CandyToy","SnowTokenToy","CandyToy2020","ScaryKey","GGSign",
			"BooSign","ReaverSign","SnowballToy2020","CandyToy2021","TeamSurvivors","TeamZombies","CandyToy2022",
			"EggToy2023","BeachBall2023","Pumpkin2023","Pie2023","Cookie2023","Bunny2024","CommonEgg2024",
			"RareEgg2024","Coconut2024","SandBucket2024","WaterBalloon2024","Gravestone2024",
			"MagicBook2024","Lantern2024","Candle2024","Santa2024","TreeToy2024","Snowman2024","Snowglobe2024",
			"CommonEgg2025","RareEgg2025","IceCream2025","Flamingo2025","VolleyBall2025","AlienPlushie","CandyBucket2025","Pumpkin2025", "Coffee2025", "Santa2025", "Candle2025", "Bell2025", "VelvetCake2025", "Heart2026"}; 
		["Equipped"] = {};
		["Slots"] = 1;
		["Converted"] = true;
		["Reset"] = true;
	};
	
	["Radios"] = {
		["Owned"] = {"Default"};
		["Equipped"] = {"Default"};
		["Slots"] = 1;
		["Converted"] = true;
	};
	
	["Pets"] = {
		["Owned"] = {};
		["Equipped"] = {};
		["Slots"] = 1;
		["Converted"] = true;
	};
	
	["Materials"] = {
		["Owned"] = {
			SummerKey2026 = math.huge;
			Coins = math.huge;
			Gems = math.huge;
		};
	};
	
	["FollowRewards"] = {
		["ItsPlayFede"] = false,
		["42devy"] = false
	},
	
	["OneTimePurchases"] = {},
	
	["Outfits"] = {
		["Owned"] = {};
		["Equipped"] = {};
		["Slots"] = 1;
		["OutfitId"] = 0,
		["Converted"] = true;
	};
	
	["Status"] = {
		["Innocents"] = 0;
		["Sheriffs"] = 0;
		["Murderer"] = 0;
	};
	
	["Gamepasses"] = {
		["DoubleEffect"] = false
	}
};

local LPA = {}
local LevelCap = 82500 --// Level 100
local ServerID = game.JobId;



Module.GetLevel = function(_)
	return 100;
end 














game.ReplicatedStorage.Remotes.Inventory.ToggleGunEffects.OnServerEvent:Connect(function(Player: Player, Value: boolean) 
	DataTable[Player.Name]["GunEffect"] = Value
	_G.WeldWeapons(Player)
end)

function game.ReplicatedStorage.Remotes.Extras.AmElite.OnServerInvoke(Player) 
	return PlayerIsElite(Player) 
end;
_G.CheckElite = PlayerIsElite;
_G.CheckRadio = function (Player)
	local HasRadio = (_G.RadioPlayers) and (_G.RadioPlayers[Player.Name] or _G.RadioPlayers[Player.UserId]);
	local CanUse = (not _G.ServerSettings.DisguisesMode);
	return HasRadio,CanUse
end
function game.ReplicatedStorage.Remotes.Extras.HasRadio.OnServerInvoke(Player)
	return _G.CheckRadio(Player);
end
local function PlayerHasRadio(Player)
	local HasRadio = (_G.RadioPlayers) and (_G.RadioPlayers[Player.Name] or _G.RadioPlayers[Player.UserId]);
	return HasRadio;
end











local Products = {
	Coins = {
		["50"] 		= 0;
		["100"] 	= 0;
		["200"] 	= 0;
		["500"] 	= 0;
		["1500"] 	= 0;
		["3500"] 	= 0; 
	};
	Gameplay = Config.Gamepasses.Gameplay;
	Gems = Config.Gamepasses.Gems
};
game.ReplicatedStorage.Remotes.Shop.GetElite.OnServerEvent:connect(function(Player)
	game:GetService("MarketplaceService"):PromptGamePassPurchase(Player,Config.Gamepasses.Elite)
end)
game.ReplicatedStorage.Remotes.Shop.GetPack.OnServerEvent:connect(function(Player,PackID)
	game:GetService("MarketplaceService"):PromptGamePassPurchase(Player,PackID)
end)
game.ReplicatedStorage.Remotes.Shop.GetRadio.OnServerEvent:connect(function(Player)
	game:GetService("MarketplaceService"):PromptGamePassPurchase(Player,Config.Gamepasses.Radio)
end)
game.ReplicatedStorage.Remotes.Shop.GetAdmin.OnServerEvent:connect(function(Player)
	game:GetService("MarketplaceService"):PromptGamePassPurchase(Player, Config.Gamepasses.AdminMenu or 1933372241)
end)
game.ReplicatedStorage.Remotes.Shop.GetDoubleEffect.OnServerEvent:connect(function(Player)
	game:GetService("MarketplaceService"):PromptGamePassPurchase(Player,Config.Gamepasses.DoubleEffect)
end)
game:GetService("MarketplaceService").PromptGamePassPurchaseFinished:connect(function(Player:Player, gamepassid, IsPurchased)
	if IsPurchased and gamepassid == Config.Gamepasses.Elite then
		Player:SetAttribute("Elite", true)
		RewardElite(Player);
	elseif IsPurchased and gamepassid == Config.Gamepasses.Radio then
		Player:SetAttribute("Radio", true)
		_G.WeldRadio(Player);
		game.ReplicatedStorage.Remotes.Shop.GetRadio:FireClient(Player);
	elseif IsPurchased and gamepassid == Config.Gamepasses.DoubleEffect then
		Player:SetAttribute("DoubleEffect", true)
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "DoubleEffect", true)
		DataTable[Player.Name].Gamepasses.DoubleEffect = true
		game.ReplicatedStorage.Remotes.Shop.GetDoubleEffect:FireClient(Player);
		task.spawn(function()
			Module.SaveData(Player);
		end)
	elseif IsPurchased and gamepassid == (Config.Gamepasses.AdminMenu or 1933372241) then
		Player:SetAttribute("AdminPanelAccess", true)
	elseif IsPurchased then
		for PassID,Pack in pairs(GetSyncData("ItemPacks")) do
			if tonumber(PassID) == gamepassid then
				DataTable[Player.Name].ItemPacks[PassID] = true;
				for _,Item in pairs(Pack) do
					if Item.Type == "Weapons" or Item.Type == "Pets" then
						Module.GiveItem(Player,Item.ItemName,1,Item.Type);
						game.ReplicatedStorage.ItemGift:FireClient(Player,Item.ItemName,Item.Type);
						game.ReplicatedStorage.Remotes.Extras.NewPurcahse:FireClient(Player)
					else
						Module.GiveOther(Player,Item.ItemName,Item.Type);
						game.ReplicatedStorage.Remotes.Extras.NewPurcahse:FireClient(Player)
					end;
				end;
				task.spawn(function()
					Module.SaveData(Player);
				end)
				break;
			end;
		end;
	end;
end)
function Module.CheckGamepass(Player, GamepassID)
	if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId, GamepassID) then
		return true
	end
	return false
end
game.ReplicatedStorage.Remotes.Extras.CheckGamepass.OnServerInvoke = function(player, GamepassID)
	if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, GamepassID) then
		return true
	end
	return false
end
game.ReplicatedStorage.Remotes.Shop.PurchaseProduct.OnServerEvent:connect(function(Player,ButtonName,Type)
	game:GetService("MarketplaceService"):PromptProductPurchase(Player,Products[Type][ButtonName])
end)
local Purchases = {};
game:GetService("MarketplaceService").ProcessReceipt = function(ReceiptInfo)
	local Player = game.Players:GetPlayerByUserId(ReceiptInfo.PlayerId)
	local Key = ReceiptInfo.PlayerId .. ":" .. ReceiptInfo.PurchaseId
	if Purchases[Key] then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
	if Player then
		for Amount,ProductID in pairs(Products.Coins) do
			if ReceiptInfo.ProductId == ProductID then
				Purchases[Key] = true;
				Module.Give(Player,"Coins",tonumber(Amount));
				game.ReplicatedStorage.Remotes.Extras.NewPurcahse:FireClient()
				return Enum.ProductPurchaseDecision.PurchaseGranted	
			end
		end
		for Amount,ProductID in pairs(Products.Gems) do
			if ReceiptInfo.ProductId == ProductID then
				Purchases[Key] = true;
				Module.Give(Player,"Gems",tonumber(Amount));		
				game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Gems", DataTable[Player.Name].Gems)
				game.ReplicatedStorage.Remotes.Extras.NewPurcahse:FireClient(Player)
				return Enum.ProductPurchaseDecision.PurchaseGranted	
			end
		end
		if ReceiptInfo.ProductId == Config.Gamepasses.Gameplay.Murderer then
			Purchases[Key] = true;
			_G.CustomMurderer = Player.Name
			game.ReplicatedStorage.ChatMessage:FireClient(Player,{text = "Thanks for your purchase! " .. Player.Name .. " will be murderer next round."})
			return Enum.ProductPurchaseDecision.PurchaseGranted	
		end
		if ReceiptInfo.ProductId == Config.Gamepasses.Gameplay.Sheriff then
			Purchases[Key] = true;
			game.ReplicatedStorage.ChatMessage:FireClient(Player,{text = "Thanks for your purchase! " .. Player.Name .. " will be sheriff next round."})
			_G.CustomSheriff = Player.Name
			return Enum.ProductPurchaseDecision.PurchaseGranted	
		end
	end;
end


_G.WeldWeapons = function(Player: Player) -- Module.Equip
	local WeaponDisplays = workspace:FindFirstChild("WeaponDisplays")
	local ItemsDB = GetSyncData("Item") 
	local Equipped = DataTable[Player.Name]["Weapons"]["Equipped"];
	if Player.Character:FindFirstChild("KnifeDisplay") then
		Player.Character.KnifeDisplay:Destroy(); 
	end
	if Player.Character:FindFirstChild("GunDisplay") then
		Player.Character.GunDisplay:Destroy(); 
	end
	for i, WeaponType in pairs({"Knife", "Gun"}) do
		local WeaponName = Equipped[WeaponType];
		local WeaponRotation = ItemsDB[WeaponName]["Angles"] 
		local WeaponPosition = ItemsDB[WeaponName]["Offset"] 
		local RadioRotation = ItemsDB[WeaponName]["RadioAngles"]
		local RadioOffset = ItemsDB[WeaponName]["RadioOffset"];
		local EquippedWeapon = nil

		if game.ServerStorage.Database.Item:FindFirstChild(Equipped[WeaponType]) then
			EquippedWeapon = game.ServerStorage.Database.Item[Equipped[WeaponType]]:Clone()
		else
			local DefaultItem = "Default".. WeaponType
			EquippedWeapon = game.ServerStorage.Database.Item[DefaultItem]:Clone();
			warn("Couldn't Find Weapon:", WeaponName , "In The Database.")
		end
		EquippedWeapon.Handle.CanCollide = false
		EquippedWeapon.Handle.Massless = true
		require(script.Weld)(EquippedWeapon.Handle);		

		local Effects = GetSyncData("Effects");
		if WeaponType == "Knife" then
			local EquippedEffects = DataTable[Player.Name]["Effects"].Equipped;
			for _, EquippedEffect in pairs(EquippedEffects) do
				if Effects[EquippedEffect] ~= nil and EquippedEffect ~= "None" and EquippedEffect ~= "Dual" then
					local EffectModule = game.ServerStorage.Database.Effects:FindFirstChild(EquippedEffect)
					if EffectModule then
						require(EffectModule)(EquippedWeapon);
					else
						warn("Effect module not found:", EquippedEffect)
					end
				end
			end
		end
		if WeaponType == "Gun" and DataTable[Player.Name]["GunEffect"] == true then
			local Effects = GetSyncData("Effects")
			local EquippedEffects = DataTable[Player.Name]["Effects"].Equipped

			for _, EquippedEffect in pairs(EquippedEffects) do
				if Effects[EquippedEffect] ~= nil and EquippedEffect ~= "None" and EquippedEffect ~= "Dual" then
					local EffectModule = game.ServerStorage.Database.Effects:FindFirstChild(EquippedEffect)
					if EffectModule then
						require(EffectModule)(EquippedWeapon)
					else
						warn("Effect module not found:", EquippedEffect)
					end
				end
			end
		end


		local Handle = EquippedWeapon.Handle:Clone();
		EquippedWeapon:Destroy();

		Handle.CanCollide = false;
		Handle.Massless = false
		Handle.CFrame = Player.Character.UpperTorso.CFrame;
		Handle.CollisionGroup = "PlayerNoCollision";
		Player.Character.Destroying:Connect(function()
			Handle:Destroy()
		end)




		local HasRadio,CanUse = _G.CheckRadio(Player)
		local UseRadio = (HasRadio and CanUse);	

		local function dAngles(Data)
			return CFrame.Angles(Data.X,Data.Y,Data.Z)
		end

		local function dOffset(Data)
			return CFrame.new(Data.X,Data.Y,Data.Z)
		end


		local DefaultRotation = (WeaponRotation and dAngles(WeaponRotation)) or (WeaponType == "Knife" and CFrame.Angles(-math.pi/2,math.pi/4,math.pi/2)) or CFrame.Angles(math.rad(150),0,0)
		local DefaultPosition = (WeaponPosition and dOffset(WeaponPosition)) or (WeaponType == "Knife" and CFrame.new(-0.1,0,0.5)) or CFrame.new(1.26,-1.5,0.2)


		if WeaponType == "Knife" then
			if DataTable[Player.Name].KnifePosition == "Belt" then
				DefaultPosition = (RadioOffset and dOffset(RadioOffset)) or CFrame.new(-1.2,-1.3,0.25)
				DefaultRotation = CFrame.Angles(math.rad(-60),0,math.rad(180))
				DefaultRotation =
					(RadioRotation and dAngles(RadioRotation))
					or (WeaponRotation and DefaultRotation * dAngles(WeaponRotation))
					or DefaultRotation
			else
				DefaultPosition = (WeaponPosition and dOffset(WeaponPosition)) or DefaultPosition
			end
		else
			if not UseRadio then
				DefaultPosition = (WeaponPosition and dOffset(WeaponPosition)) or DefaultPosition
			end
		end
		--[[local WeaponWeld = Instance.new("Weld",Player.Character.UpperTorso);
		WeaponWeld.Part0 = Player.Character.UpperTorso;
		WeaponWeld.Part1 = Handle;
		WeaponWeld.C0 =  DefaultPosition * DefaultRotation;
		WeaponWeld.C1 = CFrame.new();]]

		local torsoAttachment = Instance.new("Attachment")
		torsoAttachment.Name = WeaponType .. "TorsoAttachment"
		torsoAttachment.CFrame = DefaultPosition * DefaultRotation
		torsoAttachment.Parent = Player.Character.UpperTorso
		local weaponAttachment = Instance.new("Attachment")
		weaponAttachment.Name = WeaponType .. "WeaponAttachment"
		weaponAttachment.Parent = Handle
		local constraint = Instance.new("RigidConstraint")
		constraint.Attachment0 = torsoAttachment
		constraint.Attachment1 = weaponAttachment
		constraint.Name = WeaponType .. "RigidConstraint"
		constraint.Parent = Handle

		Handle.Name = WeaponType.. "Display";
		Handle.Parent = WeaponDisplays;

		local DisplayRef = Player.Character:FindFirstChild("DisplayRef".. WeaponType) or Instance.new("ObjectValue")
		if DisplayRef.Value then
			DisplayRef.Value:Destroy()
		end
		DisplayRef.Value = Handle
		DisplayRef.Name = "DisplayRef".. WeaponType
		DisplayRef.Parent = Player.Character
		Player.Character.Destroying:Connect(function()
			Handle:Destroy()
		end)
	end
end
_G.WeldRadio = function(Player)
	--if DataTable[Player.Name].KnifePosition == "Back" then return end
	local Torso;
	local PlayerName;
	if Player:IsA("Player") then
		PlayerName = Player.Name;
		if Player.Character ~= nil then
			if Player.Character:FindFirstChild("UpperTorso") then
				Torso = Player.Character.UpperTorso;
			end
		end
	elseif Player:FindFirstChild("UpperTorso") then
		Torso = Player.UpperTorso;
		Player = game.Players:GetPlayerFromCharacter(Player)
		PlayerName = Player.Name;
	end;
	local Has,Use = _G.CheckRadio(Player)
	if Torso and Has and Use then
		if Torso.Parent:FindFirstChild("Radio") then Torso.Parent.Radio:Destroy(); end;
		local RadioID = DataTable[PlayerName].Radios.Equipped[1];
		local RadioData = GetSyncData("Radios")[RadioID];
		local EqquipedRadio;
		local Radio;
		if RadioID ~= nil then
			EqquipedRadio = game.ServerStorage.Database.Radios[RadioID]
			Radio = EqquipedRadio:Clone()
			Radio.Name = "Radio"
			local OS = RadioData.Offset;
			local RN = RadioData.Rotation;
			Radio.Anchored = false;
			Radio.CollisionGroup = "PlayerNoCollision"
			Radio.CanCollide = false;
			Radio.Massless = true;
			Radio.Name = "Radio";
			local Weld = Instance.new("Weld",Torso);
			Weld.Part0 = Torso;
			Weld.Part1 = Radio;
			Weld.C0 = CFrame.new(OS.X,OS.Y,OS.Z) * CFrame.Angles(RN.X,RN.Y,RN.Z);
			Radio.Parent = Player.Character;

			if Radio:FindFirstChild("Sound") then
				Radio.Sound:Destroy();
			end

			game.ServerStorage.Sounds.SoundForRadio:Clone().Parent = Radio;
		end
	end;
end
_G.WipeData = function(PlayerToRemove)
	DataTable[PlayerToRemove] = {}
	Module.SaveData(game:GetService("Players"):FindFirstChild(PlayerToRemove, true))
	game.Players[PlayerToRemove]:Kick('You\'ve removed your data, please rejoin for a fresh start.')
end
_G.GivePet = function(Player)
	if Player.Character:FindFirstChild("Pet") then Player.Character.Pet:Destroy(); end;
	if _G.ServerSettings.DisguisesMode then return end;
	local PetID = DataTable[Player.Name].Pets.Equipped[1];
	if not PetID then return; end;

	local PetData = GetSyncData("Pets")[PetID];

	if not game.ReplicatedStorage.Pets:FindFirstChild(PetID) then
		pcall(function()
			local PetTorso = game.ServerStorage.Database.Pets[PetID]
			PetTorso.Name = PetID;
			PetTorso.Parent = game.ReplicatedStorage.Pets;
		end);
	end;

	local NewPet = Instance.new("StringValue");
	NewPet.Name = "Pet";
	NewPet.Value = PetID;

	local FilteredPetName;
	-- for noobs
	--[[pcall(function()
		FilteredPetName = game:GetService("Chat"):FilterStringForBroadcast(DataTable[Player.Name].PetName,Player)
	end);]]
	-- tung tung tung sahur
	pcall(function()
		FilteredPetName = DataTable[Player.Name].PetName
	end);

	NewPet:SetAttribute("PetName", FilteredPetName)
	NewPet:SetAttribute("Walking", (PetData.Type == "Walking") or nil )



	NewPet.Parent = Player.Character;
	for _,Part in pairs(Player.Character:GetChildren()) do
		if Part.Name == "Pet" and Part ~= NewPet then
			Part:Destroy();
		end
	end
end




math.randomseed( os.time() )
math.random();
local OldProfiles = game:GetService("DataStoreService"):GetDataStore("OldData");
local Profiles = game:GetService("DataStoreService"):GetDataStore("NewData");
local MerchDataStore = game:GetService("DataStoreService"):GetDataStore("MerchCodes");
local RemoveMerchDataStore = game:GetService("DataStoreService"):GetDataStore("MerchRemoveCodes");
local DuperList = game:GetService("DataStoreService"):GetDataStore("DuperList");
game.ReplicatedStorage.Remotes.Inventory.GetProfileData.OnServerInvoke = function (plr)
	return DataTable[plr.Name]
end


local function deepcopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == 'table' then
			v = deepcopy(v)
		end
		copy[k] = v
	end
	return copy
end

local ProfileStatusAliases = {
	Innocents = "Survivals",
	Sheriffs = "Victories",
	Murderer = "Eliminations",
}
local RemovedPetIds = {
	NightOwl = true,
	Panda = true,
	Capybara = true,
	Alien = true,
}

local function cleanupRemovedPets(data)
	if type(data) ~= "table" or type(data.Pets) ~= "table" then
		return false
	end
	local changed = false
	local owned = data.Pets.Owned
	if type(owned) == "table" then
		for petId in pairs(RemovedPetIds) do
			if owned[petId] ~= nil then
				owned[petId] = nil
				changed = true
			end
		end
		for key, value in pairs(owned) do
			if RemovedPetIds[key] then
				owned[key] = nil
				changed = true
			elseif type(value) == "string" and RemovedPetIds[value] then
				owned[key] = nil
				changed = true
			end
		end
	end
	local equipped = data.Pets.Equipped
	if type(equipped) == "table" then
		for slot, petId in pairs(equipped) do
			if RemovedPetIds[petId] then
				equipped[slot] = nil
				changed = true
			end
		end
	end
	return changed
end

local function normalizeProfileStatValue(value)
	value = tonumber(value) or 0
	if value >= 999999999 then
		return 0
	end
	return math.max(0, math.floor(value))
end

local function ensureProfileStats(data)
	if not data then
		return false
	end
	local changed = false
	if type(data.Status) ~= "table" then
		data.Status = deepcopy(DataDefaults.Status)
		changed = true
	end
	for statusName, aliasName in pairs(ProfileStatusAliases) do
		local statusValue = data.Status[statusName]
		if statusValue == nil and data[aliasName] ~= nil then
			statusValue = data[aliasName]
		end
		local normalizedValue = normalizeProfileStatValue(statusValue)
		if data.Status[statusName] ~= normalizedValue then
			changed = true
		end
		if data[aliasName] ~= normalizedValue then
			changed = true
		end
		data.Status[statusName] = normalizedValue
		data[aliasName] = normalizedValue
	end
	return changed
end

local function syncProfileStats(player)
	local data = player and DataTable[player.Name]
	if not data then
		return false
	end
	local changed = ensureProfileStats(data)
	changed = cleanupRemovedPets(data) or changed
	game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(player, "Status", data.Status)
	for _, aliasName in pairs(ProfileStatusAliases) do
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(player, aliasName, data[aliasName])
	end
	return changed
end

local XboxReward = {};

game.ReplicatedStorage.Remotes.Extras.IsXbox.OnServerEvent:connect(function(Player)
	repeat wait(); until Player.Character ~= nil;
	repeat wait(); until DataTable[Player.Name];
	if not XboxReward[Player] and not DataTable[Player.Name].XboxKnife then
		Module.GiveItem(Player,"Xbox",1);
		game.ReplicatedStorage.ItemGift:FireClient(Player,"Xbox","Weapons");
		DataTable[Player.Name].XboxKnife = true;
	end
	XboxReward[Player] = true;
end)

Module.MaterialsOwnedAmount = function(PlayerName: string, MaterialType: string)
	if (PlayerName and DataTable[PlayerName] and DataTable[PlayerName].Materials) and DataTable[PlayerName].Materials.Owned[MaterialType] then
		return DataTable[PlayerName].Materials.Owned[MaterialType]
	end
	return 0
end

Module.SetData = function(Player: Player)

	local Profile;
	local DataCallSuccess = pcall(function()
		Profile = Profiles:UpdateAsync(Player.UserId, function(Data)
			if Data then Data.ServerID = ServerID; end;
			return Data;
		end)
	end)
	if not DataCallSuccess then
		repeat
			task.wait(5)
			DataCallSuccess = pcall(function()
				Profile = Profiles:UpdateAsync(Player.UserId, function(Data)
					if Data then Data.ServerID = ServerID; end;
					return Data;
				end)
			end)
		until DataCallSuccess;
	end;

	if Profile == nil then
		DataTable[Player.Name] = {};

		for DataName,Default in pairs(DataDefaults) do
			if DataTable[Player.Name][DataName] == nil then
				if type(Default) == "table" then
					DataTable[Player.Name][DataName] = deepcopy(Default);
				else
					DataTable[Player.Name][DataName] = Default;
				end
			end
		end
	else
		DataTable[Player.Name] = Profile;
		for DataName,Default in pairs(DataDefaults) do
			if DataTable[Player.Name][DataName] == nil then
				if type(Default) == "table" then
					DataTable[Player.Name][DataName] = deepcopy(Default);
				else
					DataTable[Player.Name][DataName] = Default;
				end
			end
		end
	end

	
	if not DataTable[Player.Name]["Outfits"] then
		DataTable[Player.Name]["Outfits"] = DataDefaults
	end
	for GamepassName, GamepassData in pairs(Config.Gamepasses) do
		local succ, hasIt = pcall(function()
			return game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId,GamepassData) 
		end)
		if not succ then
			--warn("Failed to fetch", GamepassName ,"for", Player.Name)
			-- gamepass not found!
		else
			
			Player:SetAttribute((GamepassData or GamepassName), hasIt)
		end
	end
	
	local adminSuccess, hasAdminPass = pcall(function()
		return false
	end)
	if adminSuccess and hasAdminPass then
		Player:SetAttribute("Admin", true)
	end

	if table.find(Admins, Player.Name) then
		Player:SetAttribute("Admin", true)
	end
	
	-- This should help fix the issue if a player is found to be using Valentines2026 or Summer2024 Profile Data.
	local function ReconcileTable(target, template)
		for key, value in pairs(template) do
			if typeof(value) == "table" then
				if typeof(target[key]) ~= "table" then
					target[key] = {}
				end
				ReconcileTable(target[key], value)
			elseif target[key] == nil then
				target[key] = value
			end
		end
	end
	
	local EventHandler = require(script.ActiveEventManager)
	local CurrentEvent = EventHandler:GetActiveEventInfo()
	
	if CurrentEvent then
		local EventData = CurrentEvent.EventStartInfo
		DataTable[Player.Name][CurrentEvent.Title] = DataTable[Player.Name][CurrentEvent.Title] or {}
		
		-- To actually call ReconcileTable instead of just defining it
		ReconcileTable(DataTable[Player.Name][CurrentEvent.Title], deepcopy(EventData.ProfileData))
		-- Fede if anything breaks, it is 70% likely that this is the issue.
		
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, CurrentEvent.Title, DataTable[Player.Name][CurrentEvent.Title])
		print(DataTable[Player.Name][CurrentEvent.Title])
	end

	if not DataTable[Player.Name][""] then
		DataTable[Player.Name] = {};
		for DataName,Default in pairs(DataDefaults) do
			if DataTable[Player.Name][DataName] == nil then
				if type(Default) == "table" then
					DataTable[Player.Name][DataName] = deepcopy(Default);
				else
					DataTable[Player.Name][DataName] = Default;
				end
			end
		end
		Profile = DataTable[Player.Name]
		DataTable[Player.Name][""] = true;
	end
	
	local cleanedRemovedPets = cleanupRemovedPets(DataTable[Player.Name])
	if syncProfileStats(Player) or cleanedRemovedPets then
		task.spawn(function()
			Module.SaveData(Player)
		end)
	end
	
	if not DataTable[Player.Name].TimeRewards then
		DataTable[Player.Name].TimeRewards = {}
		for rewardId, rewardData in pairs(require(game.ReplicatedStorage.Database.Sync).TimeRewards) do
			DataTable[Player.Name].TimeRewards[rewardId] = {
				Progress = 0,
				Claimed = false
			}
		end
	end
	
	if script.Parent["Event/Handlers"]:GetAttribute("isEvent") then
		require(script.Parent["Event/Handlers"][script.Parent["Event/Handlers"]:GetAttribute("EventName")]).intializeEventToDataTable(Player)
	end
	


	
	
	Module.CreatePlayerAttributes(Player)
	-- <<<ALL FREE>>>
	Player:SetAttribute("Elite", true)
	Player:SetAttribute("Radio", true)
	_G.RadioPlayers = _G.RadioPlayers or {}
	_G.RadioPlayers[Player.Name] = true
	_G.RadioPlayers[Player.UserId] = true
	RewardElite(Player)
	_G.WeldRadio(Player)
	if DataTable[Player.Name]["GivedAllFree"] == false then
		for ItemID, Data in pairs(GetSyncData('Item')) do
			if not DataTable[Player.Name]["Weapons"].Owned[ItemID] then
				DataTable[Player.Name]["Weapons"].Owned[ItemID] = math.random(12500)
			end
			if ItemID == "DefaultKnife" or ItemID == "DefaultGun" or ItemID == "Dartbringer" or ItemID == "SharkSeeker" then
				DataTable[Player.Name]["Weapons"].Owned[ItemID] = 1
			end
			if ItemID == "Reaver" or
				ItemID == "Reaver_Legendary" or
				ItemID == "Reaver_Godly" or
				ItemID == "Reaver_Ancient" or
				ItemID == "IceHammer" or
				ItemID == "IcepiercerBlue" or
				ItemID == "IceHammer_Legendary" or
				ItemID == "IceHammer_Godly" or
				ItemID == "IceHammer_Ancient" or
				ItemID == "Synthwave" or
				ItemID == "Synthwave_Legendary" or
				ItemID == "Synthwave_Godly" or
				ItemID == "Neon_K_2024" or
				ItemID == "Synthwave_Ancient" or
				ItemID == "SynthwaveChroma" or
				ItemID == "Synthwave_LegendaryChroma" or
				ItemID == "Synthwave_GodlyChroma" or
				ItemID == "Synthwave_AncientChroma" or
				ItemID == "GingerscytheChroma" or
				ItemID == "GingerscytheChroma_Legendary" or
				ItemID == "GingerscytheChroma_Godly" or
				ItemID == "GingerscytheChroma_Ancient" or
				ItemID == "Partyblade" or
				ItemID == "Gingerscythe" or
				ItemID == "GlacierKnife" or
				ItemID == "GlacierGun" or
				ItemID == "Gingerscythe_Legendary" or
				ItemID == "Gingerscythe_Godly" or
				ItemID == "Gingerscythe_Ancient" or
				ItemID == "Gingerscope_Purple" or
				ItemID == "Gingerscythe_Purple" or
				ItemID == "HarvesterPink" or
				ItemID == "ElderwoodPink" or
				ItemID == "IceHammerPink" or
				ItemID == "IcepiercerPink" or
				ItemID == "RandomUncommonWeapon" or
				ItemID == "RandomRareWeapon" or
				ItemID == "RandomLegendaryWeapon" or
				ItemID == "SlouseClown" or
				ItemID == "SorryChroma" or
				ItemID == "ChromaWinterEdge" or
				ItemID == "EvilIcecrusher" or
				ItemID == "TravelerAxePurple" or
				ItemID == "TravelerGunPurple" or
				ItemID == "BanHammer" or
				ItemID == "ChromaBatwing" or
				ItemID == "ChromaIcecrusher" or
				ItemID == "ChromaHeartblade" or
				ItemID == "ChromaSakura_K" or
				ItemID == "ChromaBlossom_G" or
				ItemID == "ChromaIcebreaker" or
				ItemID == "ChromaIceblaster" or
				ItemID == "SlouseClownGun" or
				ItemID == "RaygunRedE" or
				ItemID == "IceCrossbow" or
				ItemID == "RaygunBronzeE" or
				ItemID == "RaygunSilverE" or
				ItemID == "RaygunGoldE" or
				ItemID == "EggAxe" or
				ItemID == "EggGun" or
				ItemID == "SweetHarvester" or
				ItemID == "Jadequinox" or
				ItemID == "Candleflare" or
				ItemID == "Candleshot" or
				ItemID == "TravelerSniper" or
				ItemID == "IcepiercerPink" or
				ItemID == "ChocoBunny" or
				ItemID == "Flamingo" or
				ItemID == "Flamingo_K" or
				ItemID == "FlowerwoodGunPink" or
				ItemID == "FlowerwoodKnifePink" or
				ItemID == "FlowerwoodGun_Pink" or
				ItemID == "FlowerwoodKnife_Pink" or
				ItemID == "FairyAxe" or
				ItemID == "BlackGingerscythe_Godly" or
				ItemID == "BlackGingerscope" or
				ItemID == "Matrixscope" or
				ItemID == "PlayFedeSC" or
				ItemID == "PlayFedeScope" then
				if not playerRedeemedReward(DataTable[Player.Name], "Weapons", ItemID) and not playerOwnsItemPackReward(DataTable[Player.Name], "Weapons", ItemID) then
					DataTable[Player.Name]["Weapons"].Owned[ItemID] = nil
				end
                end  
			if Data.Rarity == "Unique" and DataTable[Player.Name].Weapons.Owned[ItemID] and not playerRedeemedReward(DataTable[Player.Name], "Weapons", ItemID) and not playerOwnsItemPackReward(DataTable[Player.Name], "Weapons", ItemID) and not (ItemID == "RaygunRedE" or ItemID == "RaygunBronzeE" or ItemID == "RaygunSilverE" or ItemID == "RaygunGoldE") then
				local rank = math.random(1, 100)
				if string.find(string.lower(Data.ItemName or ""), "bronze") then
					rank = 3
				elseif string.find(string.lower(Data.ItemName or ""), "silver") then
					rank = 2
				elseif string.find(string.lower(Data.ItemName or ""), "gold") then
					rank = 1
				end
				if ItemID ~= "Sorry" then
					table.insert(DataTable[Player.Name].Uniques, {
						BaseItem = ItemID,
						EvoEquipped = false,
						XP = nil,
						Signature = Player.Name,
						Rank = rank
					})
				end
				if DataTable[Player.Name].Trophies == nil then
					DataTable[Player.Name].Trophies = {}
				end
			end
			if Data.Evo and ItemID ~= "Sorry" and ItemID ~= "SynthwaveChroma" and ItemID ~= "GingerscytheChroma" then
				table.insert(DataTable[Player.Name].Uniques, {
					BaseItem = ItemID,
					XP = math.random(864000, 900000000),
					EvoEquipped = true,
					Signature = "",
					Rank = nil
				}) 
			end
			
			if ItemID == "Dartbringer" or ItemID == "SharkSeeker" then
				table.insert(DataTable[Player.Name].Uniques, {
					BaseItem = ItemID,
					XP = nil,
					EvoEquipped = false,
					Signature = Player.Name,
					Rank = nil
				})
			end
			game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, "Weapons", ItemID, DataTable[Player.Name]["Weapons"].Owned[ItemID])
		end
		
		local added = {}
		for _, unique in ipairs(DataTable[Player.Name].Uniques) do
			if unique.BaseItem ~= "Dartbringer" and unique.BaseItem ~= "SharkSeeker" and unique.BaseItem ~= "Reaver" and unique.BaseItem ~= "Gingerscythe" and unique.BaseItem ~= "IceHammer" and unique.BaseItem ~= "Synthwave" then
				if not added[unique.BaseItem] then
					table.insert(DataTable[Player.Name].Trophies, {
						ItemID = unique.BaseItem,
						Rank  = unique.Rank
					})
					added[unique.BaseItem] = true
				end
			end
		end
		for ItemID, _ in pairs(GetSyncData("Outfits")) do
			if ItemID ~= "Custom" then
				if not table.find(DataTable[Player.Name]["Outfits"].Owned, ItemID) then
					table.insert(DataTable[Player.Name]["Outfits"].Owned, ItemID)
				end				
			end
		end
		for ItemID, Data in pairs(GetSyncData('Pets')) do
			if not DataTable[Player.Name]["Pets"].Owned[ItemID] then
				DataTable[Player.Name]["Pets"].Owned[ItemID] = math.random(12500)
			end
			game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, "Pets", ItemID, DataTable[Player.Name]["Pets"].Owned[ItemID])
		end
		for ItemID, _ in pairs(GetSyncData("Effects")) do
			if ItemID ~= "Traveler2023Purple" and ItemID ~= "Balloons" then
				if not table.find(DataTable[Player.Name]["Effects"].Owned, ItemID) then
					table.insert(DataTable[Player.Name]["Effects"].Owned, ItemID)
				end
			end
		end
		for ItemID, _ in pairs(GetSyncData("Perks")) do
			if ItemID ~= "VampireBat" then
				if not table.find(DataTable[Player.Name]["Perks"].Owned, ItemID) then
					table.insert(DataTable[Player.Name]["Perks"].Owned, ItemID)
				end
			end
		end
 		--[[for ItemID, _ in pairs(GetSyncData("Toys")) do
			if not table.find(DataTable[Player.Name]["Toys"].Owned, ItemID) then
				table.insert(DataTable[Player.Name]["Toys"].Owned, ItemID)
			end
		end]]
		for ItemID, _ in pairs(GetSyncData("Radios")) do
			if not table.find(DataTable[Player.Name]["Radios"].Owned, ItemID) then
				table.insert(DataTable[Player.Name]["Radios"].Owned, ItemID)
			end
		end
		cleanupUnredeemedCodeRewards(Player, true)
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Coins" ,DataTable[Player.Name]["Coins"])
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Gems" ,DataTable[Player.Name]["Gems"])
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Radios" ,DataTable[Player.Name]["Radios"])
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Perks" ,DataTable[Player.Name]["Perks"])
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Effects" ,DataTable[Player.Name]["Effects"])
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Uniques" ,DataTable[Player.Name]["Uniques"])
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Outfits" ,DataTable[Player.Name]["Outfits"])
		DataTable[Player.Name]["GivedAllFree"] = true
	end
	-- <<<ALL FREE>>>
	

	


	task.wait(3);
	if Player:IsDescendantOf(game:GetService("Players")) then
		repeat Player:LoadCharacterAsync(); wait();
		until Player.Character ~= nil;
	end
	game.ReplicatedStorage.PlayerAdded:FireAllClients(Player)
	local EventData = DataTable[Player.Name] and DataTable[Player.Name]["Summer2026"]
	if not EventData then return end

--[[	if EventData.GiftInventory > 0 then
		if not Player.Backpack:FindFirstChild("GiftTool")
			and not (Player.Character and Player.Character:FindFirstChild("GiftTool")) then
			local GiftTool = game.ServerStorage.GiftTool:Clone()
			GiftTool.GiftScript.Enabled = true
			GiftTool.Parent = Player.Backpack
		end
	end]]
	
	wait();
	
	local MarketplaceService = game:GetService("MarketplaceService")
	for PassID, Pack in pairs(GetSyncData("ItemPacks")) do
		local stringPassID = tostring(PassID)
		local numericPassID = tonumber(PassID)

		if not numericPassID then
			warn("ItemPack ID is not a number:", PassID)
			continue
		end

		if typeof(Pack) ~= "table" then
			warn("Invalid ItemPack for PassID:", numericPassID)
			continue
		end

		local PackClaimed = DataTable[Player.Name].ItemPacks[stringPassID]
		if PackClaimed then
			continue
		end

		local HasPass = false
		local success, result = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(Player.UserId, numericPassID)
		end)

		if not success then
			warn("Error checking GamePass ownership for", Player.Name, numericPassID, result)
		end

		if (success and result) or Player.Name == "Player1" then
			DataTable[Player.Name].ItemPacks[stringPassID] = true

			for _, Item in pairs(Pack) do
				if typeof(Item) ~= "table" or not Item.ItemName or not Item.Type then
					warn("Invalid item structure in pack", numericPassID, "->", Item)
					continue
				end

				if Item.Type == "Weapons" or Item.Type == "Pets" then
					local ok, err = pcall(function()
						Module.GiveItem(Player, Item.ItemName, 1, Item.Type)
					end)
					if not ok then
						warn("Failed to GiveItem:", Item.ItemName, err)
					end

					game.ReplicatedStorage.ItemGift:FireClient(Player, Item.ItemName, Item.Type)
				else
					local ok, err = pcall(function()
						Module.GiveOther(Player, Item.ItemName, Item.Type)
					end)
					if not ok then
						warn("Failed to GiveOther:", Item.ItemName, err)
					end
					game.ReplicatedStorage.ItemGift:FireClient(Player, Item.ItemName, Item.Type)
				end
				
			end

			task.spawn(function()
				local ok, err = pcall(function()
					Module.SaveData(Player)
				end)
				if not ok then
					warn("Error saving data for", Player.Name, err)
				end
			end)

			game.ReplicatedStorage.UpdateData2:FireClient(Player, DataTable[Player.Name], true)
		end
	end

	cleanupUnredeemedCodeRewards(Player)

	local BanHammerPassID = Config.Gamepasses.ItemPacks and Config.Gamepasses.ItemPacks.BanHammer
	if BanHammerPassID then
		local OwnsBanHammer = false
		local BanHammerOwnershipOk, BanHammerOwnershipErr = pcall(function()
			OwnsBanHammer = MarketplaceService:UserOwnsGamePassAsync(Player.UserId, BanHammerPassID)
		end)

		if BanHammerOwnershipOk and OwnsBanHammer then
			DataTable[Player.Name].ItemPacks[tostring(BanHammerPassID)] = true

			local WeaponsData = DataTable[Player.Name].Weapons
			if WeaponsData and WeaponsData.Owned and not WeaponsData.Owned.BanHammer then
				Module.GiveItem(Player, "BanHammer", 1, "Weapons")
				game.ReplicatedStorage.ItemGift:FireClient(Player, "BanHammer", "Weapons")
				game.ReplicatedStorage.UpdateData2:FireClient(Player, DataTable[Player.Name], true)

				task.spawn(function()
					local SaveOk, SaveErr = pcall(function()
						Module.SaveData(Player)
					end)
					if not SaveOk then
						warn("Error saving BanHammer repair for", Player.Name, SaveErr)
					end
				end)
			end
		elseif not BanHammerOwnershipOk then
			warn("Error checking BanHammer ownership for", Player.Name, BanHammerOwnershipErr)
		end
	end

	if DataTable[Player.Name]["GroupRewards"] == false then
		if Config.Group.Enabled then
			if Player:IsInGroupAsync(Config.Group.GroupID) then
				Module.GiveItem(Player,"BlackGingerscythe_Godly",1,"Weapons")
				game.ReplicatedStorage.ItemGift:FireClient(Player,"BlackGingerscythe_Godly","Weapons");

				Module.GiveItem(Player,"BlackGingerscope",1,"Weapons")
				game.ReplicatedStorage.ItemGift:FireClient(Player,"BlackGingerscope","Weapons");
			end
		else
			Config.Group.GroupID = 378754827;
			if game:GetService("RunService"):IsStudio() then
				Module.GiveItem(Player,"BlackGingerscythe_Godly",1,"Weapons")
				game.ReplicatedStorage.ItemGift:FireClient(Player,"BlackGingerscythe_Godly","Weapons");

				Module.GiveItem(Player,"BlackGingerscope",1,"Weapons")
				game.ReplicatedStorage.ItemGift:FireClient(Player,"BlackGingerscope","Weapons");
			end
		end
		DataTable[Player.Name]["GroupRewards"] = true
	end
	if PlayerIsElite(Player) then
		RewardElite(Player);
	end
	game.ReplicatedStorage.Remotes.Misc.UpdateLeaderboard:FireAllClients();
end

Module.Give = function(Player,DataName,Amount)
	if DataName == "NewXP" then
		DataTable[Player.Name]["NewXP"] = LevelCap;
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, DataName, DataTable[Player.Name][DataName]);
		return;
	end
	if DataName == "NewXP" then
		if string.sub(Player.Name,1,6)~="Guest " then--and Player.userId > 0 then
			local _,Error = pcall(function()
				local Badges = GetSyncData("Badge");
				local CurrentXP = Module.Get(Player,"NewXP");
				local CurrentLevel = Module.GetLevel(CurrentXP);
				local NextLevel = Module.GetLevel(CurrentXP + ((PlayerIsElite(Player) and Amount*1.5) or Amount) );
				if NextLevel > CurrentLevel and NextLevel%10 == 0 then
					--game.ReplicatedStorage.Chatted:FireAllClients("Server",Player.Name .. " has just reached level " .. NextLevel);
					local OldImage = require(game.ReplicatedStorage.RankIcons)[CurrentLevel];
					local NewImage = require(game.ReplicatedStorage.RankIcons)[NextLevel];
				end

				for BadgeName,BadgeID in pairs(Badges) do
					local Level = tonumber(string.sub(BadgeName,6));
					if (NextLevel >= Level) or Module.Get(Player,"Prestige") >= 1 then
						game.BadgeService:AwardBadge(Player.userId,BadgeID);
					end
				end
			end)
			if Error then
				game:GetService("TestService"):Error("Error giving badge: " .. Error,script);
			end
		end;

		if Module.Get(Player,DataName) + Amount > LevelCap then
			DataTable[Player.Name]["NewXP"] = LevelCap;
		else
			if PlayerIsElite(Player) then
				Amount = Amount*1.5;
			end
			DataTable[Player.Name]["NewXP"] = DataTable[Player.Name]["NewXP"] + Amount;
		end

		game.ReplicatedStorage.Remotes.Inventory.GiveXP:FireClient(Player,Amount)
	else
		DataTable[Player.Name][DataName] = DataTable[Player.Name][DataName] + Amount;
	end
	game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, DataName, DataTable[Player.Name][DataName])
	task.spawn(function()
		Module.SaveData(Player);	
	end)
end

Module.GiveStatus = function(Player,Status,Amount)
	local data = DataTable[Player.Name]
	if not data then
		return
	end
	Amount = tonumber(Amount) or 1
	if Amount <= 0 then
		return
	end
	ensureProfileStats(data)
	data["Status"][Status] = normalizeProfileStatValue(data["Status"][Status]) + math.floor(Amount)
	local aliasName = ProfileStatusAliases[Status]
	if aliasName then
		data[aliasName] = data["Status"][Status]
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, aliasName, data[aliasName])
	end
	game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Status", data.Status)
	task.spawn(function()
		if _G.LiveBoardPublishPlayer then
			_G.LiveBoardPublishPlayer(Player, true)
		end
	end)
	task.spawn(function()
		Module.SaveData(Player);	
	end)
end

Module.GiveOther = function(Player,ID,Type,NoSave)
	if DataTable[Player.Name] == nil then return end;
	if DataTable[Player.Name][Type] == nil then return end;
	table.insert(DataTable[Player.Name][Type].Owned,ID);
	game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, Type, ID, table.find(DataTable[Player.Name][Type].Owned, ID))
	task.spawn(function()
		Module.SaveData(Player);	
	end)
end


Module.GiveItem = function(Player,ItemName,Amount,Type, ItemGift)
	if not Type then Type = "Weapons" end;
	local PlayerName = GetPlayerName(Player);
	if DataTable[PlayerName][Type].Owned[ItemName] == nil then
		DataTable[PlayerName][Type].Owned[ItemName] = Amount;
	else
		DataTable[PlayerName][Type].Owned[ItemName] = DataTable[PlayerName][Type].Owned[ItemName] + Amount;
	end;
	game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, Type, ItemName, DataTable[PlayerName][Type].Owned[ItemName])
	if ItemGift then
		game.ReplicatedStorage.ItemGift:FireClient(Player, ItemName, Type, Amount)
	end
	task.spawn(function()
		Module.SaveData(Player);	
	end)
end

Module.RemoveItem = function(Player,ItemName,Amount,Type)
	if not Type then Type = "Weapons" end;
	local PlayerName = GetPlayerName(Player);
	if PlayerName ~= nil then
		if DataTable[PlayerName] ~= nil then
			if DataTable[PlayerName][Type] ~= nil then

				if DataTable[PlayerName][Type].Owned[ItemName] == nil then
					warn("[DataModule/RemoveItem]: Player doesn't have the item");
				elseif DataTable[PlayerName][Type].Owned[ItemName] - Amount > 0 then
					DataTable[PlayerName][Type].Owned[ItemName] = DataTable[PlayerName][Type].Owned[ItemName] - Amount;
				else
					DataTable[PlayerName][Type].Owned[ItemName] = nil;
					if DataTable[PlayerName].Weapons.Equipped.Knife == ItemName then
						DataTable[PlayerName].Weapons.Equipped.Knife = "DefaultKnife";
					elseif DataTable[PlayerName].Weapons.Equipped.Gun == ItemName then
						DataTable[PlayerName].Weapons.Equipped.Gun = "DefaultGun";
					elseif DataTable[PlayerName].Pets.Equipped[1] == ItemName then
						Module.Unequip(Player,1,"Pets");
					end;
					warn("[DataModule/RemoveItem]: Player has less than 0");
				end

				game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, Type, ItemName, DataTable[PlayerName][Type].Owned[ItemName])
				task.spawn(function()
					Module.SaveData(Player);
				end)

			else
				warn("[DataModule/RemoveItem]: DataTable[PlayerName][DataName] == nil");
			end
		else
			warn("[DataModule/RemoveItem]: DataTable[PlayerName] == nil)");
		end;
	else
		warn("[DataModule/RemoveItem]: PlayerName == nil");
	end;
end




local SavingData = {};
Module.SaveData = function(Player)
	if DataTable[Player.Name] ~= nil then	
		if not SavingData[Player.Name] then
			SavingData[Player.Name] = true;
			local DataCallSuccess = pcall(function()
				Profiles:UpdateAsync(Player.userId, function()
					return DataTable[Player.Name]
				end)
			end)
			if not DataCallSuccess then
				repeat
					wait(5)
					DataCallSuccess = pcall(function()
						Profiles:UpdateAsync(Player.userId, function()
							return DataTable[Player.Name]
						end)
					end)
				until DataCallSuccess;
			else
			end;
			SavingData[Player.Name] = false;
		end;
	end
end

Module.Get = function(Player,DataName)
	local Output = game:GetService("TestService");
	if Player == nil then return end;
	local PlayerName = Player.Name;
	if PlayerName == nil then return nil end --Output:Error("PlayerName is nil (Get)"); return nil end;
	if DataTable[PlayerName] == nil then return nil end -- Output:Error("DataTable[" .. PlayerName .. "] is nil. (Get)"); return nil end;
	if DataTable[PlayerName][DataName] == nil then return nil end -- Output:Error("DataTable[" .. PlayerName .. "]["..DataName.."] is nil. (Get)"); return nil end;
	if DataTable[Player.Name] ~= nil then
		return DataTable[Player.Name][DataName];
	else
		return nil;
	end;
end

game.Players.PlayerRemoving:connect(function(Player)
	task.spawn(function()
		Module.SaveData(Player);
	end)
	game.ReplicatedStorage.Remotes.Misc.UpdateLeaderboard:FireAllClients();
end)

Module.CheckForItem = CheckForItem;
Module.Equip = function(Player,ItemName,Type)

	if Type == "Outfits" and _G.OutfitsDisabled == true then return end
	if Module.CheckForItem(Player,ItemName,Type) then
		if Type == "Weapons" then
			local ItemsDB = GetSyncData("Item") 
			local ItemType = ItemsDB[ItemName]["ItemType"]
			DataTable[Player.Name]["Weapons"]["Equipped"][ItemType] = ItemName;
		elseif Type == "Effects" then
			for _,Item in pairs(DataTable[Player.Name][Type].Equipped) do if Item == ItemName then return end; end;
			table.insert(DataTable[Player.Name][Type].Equipped,1,ItemName);

			local hasDoubleEffectPass = DataTable[Player.Name].Gamepasses.DoubleEffect

			local maxEffectSlots = hasDoubleEffectPass and 2 or 1
			local Equipped = #DataTable[Player.Name][Type].Equipped;

			while Equipped > maxEffectSlots do
				table.remove(DataTable[Player.Name][Type].Equipped);
				Equipped = #DataTable[Player.Name][Type].Equipped;
			end
		else
			for _,Item in pairs(DataTable[Player.Name][Type].Equipped) do if Item == ItemName then return end; end;
			table.insert(DataTable[Player.Name][Type].Equipped,1,ItemName);
			local Equipped = #DataTable[Player.Name][Type].Equipped;
			if Equipped > DataTable[Player.Name][Type].Slots then
				table.remove(DataTable[Player.Name][Type].Equipped);
			end
			if Type == "Outfits" then
				local applied, applyResult = applyOutfitAppearance(Player, ItemName)
				if not applied then
					warn(("[DataModule/Equip]: Failed to apply outfit %s for %s (%s)"):format(tostring(ItemName), Player.Name, tostring(applyResult)))
				end
			end
			if Type == "Radios" and _G.CheckRadio(Player) then
				if DataTable[Player.Name].KnifePosition == "Back" then
					return
				end
				_G.WeldRadio(Player); 
			elseif Type == "Pets" then
				_G.GivePet(Player);
			end
		end;
		_G.WeldWeapons(Player)	
		task.spawn(function()
			Module.CreatePlayerAttributes(Player);
		end)
		task.spawn(function()
			Module.SaveData(Player);	
		end)
	end
end
Module.Unequip = function(Player, Index, Type)
	local SlotInfo = GetSyncData("SlotInfo")
	if SlotInfo[Type].Unequip then
		if type(DataTable[Player.Name][Type].Equipped) == "table" then
			table.remove(DataTable[Player.Name][Type].Equipped, Index)
		else
			DataTable[Player.Name][Type].Equipped = {}
		end
	end

	if Type == "Radios" then
		_G.WeldRadio(Player)
	end
	if Type == "Outfits" or Type == "Custom_Outfit" then
		DataTable[Player.Name].Outfits.Equipped = {}

		local Character = Player.Character
		if Character and Character:FindFirstChild("Humanoid") then
			local Humanoid = Character.Humanoid
			local DefaultAppearance = game.Players:GetHumanoidDescriptionFromUserId(Player.UserId)
			Humanoid:ApplyDescription(DefaultAppearance)
			if _G.WeldWeapons then _G.WeldWeapons(Player) end
			if _G.WeldRadio then _G.WeldRadio(Player) end
		end
	end


	_G.GivePet(Player);
	_G.WeldWeapons(Player)
	task.spawn(function()
		Module.CreatePlayerAttributes(Player);
	end)
	task.spawn(function()
		Module.SaveData(Player);	
	end)
end
function GetPlayerName(Player)
	local PlayerName;
	if type(Player) == "string" then
		PlayerName = Player;
	elseif type(Player) == "userdata" then
		PlayerName = Player.Name;
	end
	return PlayerName;
end

-- Salvage

Module.SalvageItem = function(Player,Item)
	if CheckForItem(Player,Item,"Weapons") then
		local ItemRarity = GetSyncData("Item")[Item].Rarity;
		local SalvageRewards = GetSyncData("SalvageRewards");
		local SalvageTable = SalvageRewards[Item] or SalvageRewards[ItemRarity];
		local Rewards = {};
		local ItemCount = 0;
		for i = 1,3 do
			if math.random(1,100)<=SalvageTable.CountChance[i] then
				ItemCount = ItemCount+1;
			else
				break;
			end;
		end		
		Module.RemoveItem(Player,Item,1);
		for i = 1,ItemCount do
			local RewardsTable = {};
			for RewardID,RewardData in pairs(SalvageTable.Rewards) do
				if RewardData.Rarity[i] then
					for i = 1,RewardData.Rarity[i] do
						table.insert(RewardsTable,RewardID);
					end;
				end;
			end
			if #RewardsTable >= 1 then
				local Reward = RewardsTable[math.random(1,#RewardsTable)];
				local Amount = math.random(SalvageTable.Rewards[Reward].Amount[1],SalvageTable.Rewards[Reward].Amount[2]);
				Rewards[i] = {
					ID = Reward;
					Amount = Amount;
				};
				Module.GiveItem(Player,Reward,Amount,"Materials");
				game.ReplicatedStorage.UpdateData2:FireClient(Player,DataTable[Player.Name],true);
			end;
		end
		local ConvertedRewards = {};
		for i,v in pairs(Rewards) do
			ConvertedRewards[v.ID] = v.Amount;
		end
		task.spawn(function()
			Module.SaveData(Player);	
		end)
		return Rewards;
	end
end
function game.ReplicatedStorage.Remotes.Inventory.Salvage.OnServerInvoke(Player,Item)
	return Module.SalvageItem(Player,Item);
end
Module.CraftItem = function(Player, RecipeName)
	local function GiveRandomItem(Player, Rarity)
		local ItemsDB = GetSyncData("Item")
		local possibleItems = {}
		for ItemID, ItemData in pairs(ItemsDB) do
			if ItemData.Rarity == Rarity
				and not ItemData.Event
				and not ItemData.Season then

				table.insert(possibleItems, ItemID)
			end
		end
		if #possibleItems > 0 then
			local selected = possibleItems[math.random(1, #possibleItems)]
			Module.GiveItem(Player, selected, 1, "Weapons")
			return selected, 1, "Weapons"
		end
	end
	local function RemovePlayerMaterial(Player, materialName, amount)
		local materials = DataTable[Player.Name] and DataTable[Player.Name].Materials
		if materials and materials.Owned[materialName] then
			materials.Owned[materialName] = materials.Owned[materialName] - amount
			game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, "Materials", materialName, materials.Owned[materialName])
		end
	end
	local function GetPlayerMaterialAmount(Player, materialName)
		local materials = DataTable[Player.Name] and DataTable[Player.Name].Materials
		if materials and materials.Owned[materialName] then
			return materials.Owned[materialName]
		end
		return 0
	end
	local function GivePaintedSeer(Player)
		local paintedSeers = {
			"BlueSeer",
			"RedSeer",
			"PurpleSeer",
			"YellowSeer",
			"BlueSeer",
			"OrangeSeer"
		}
		local selected = paintedSeers[math.random(1, #paintedSeers)]
		Module.GiveItem(Player, selected, 1, "Weapons")
		return selected, 1, "Weapons"
	end
	local Recipes = GetSyncData("Recipes")
	if typeof(RecipeName) ~= "string" then
		warn("Invalid recipe type from player: " .. Player.Name)
		return
	end
	local CraftingTable = Recipes[RecipeName]
	if not CraftingTable then
		warn("Unknown crafting recipe: " .. RecipeName .. " from player: " .. Player.Name)
		return
	end
	for materialName, amountRequired in pairs(CraftingTable.Materials or {}) do
		local playerAmount = GetPlayerMaterialAmount(Player, materialName)
		if playerAmount < amountRequired then
			warn("Not enough materials for " .. RecipeName .. " by " .. Player.Name)
			return
		end
	end
	for materialName, amountRequired in pairs(CraftingTable.Materials or {}) do
		RemovePlayerMaterial(Player, materialName, amountRequired)
	end
	local itemID, itemAmount, itemType
	if CraftingTable.Function == "RandomCraft" then
		itemID, itemAmount, itemType = GiveRandomItem(Player, CraftingTable.Rarity)
	elseif CraftingTable.Function == "PaintedSeer" then
		itemID, itemAmount, itemType = GivePaintedSeer(Player)
	elseif CraftingTable.RewardItem then
		itemID = CraftingTable.RewardItem
		itemAmount = CraftingTable.RewardAmount or 1
		itemType = CraftingTable.RewardType
		Module.GiveItem(Player, itemID, itemAmount, itemType)
	end
	game.ReplicatedStorage.UpdateData2:FireClient(Player, DataTable[Player.Name], true)
	return itemID, itemAmount, itemType
end
function game.ReplicatedStorage.Remotes.Inventory.Craft.OnServerInvoke(Player,CraftingTable)
	return Module.CraftItem(Player,CraftingTable);
end


Module.Redeem = function(Player: Player, Code)
	local CodeDatabase = GetSyncData("Codes")
	if Player:IsDescendantOf(game.Players) and DataTable[Player.Name] and CodeDatabase then
		local CodeData = CodeDatabase[Code]
		if CodeData and CodeData.ValidUntil > os.time() then
			if not DataTable[Player.Name].RedeemedCodes[Code] then
				DataTable[Player.Name].RedeemedCodes[Code] = true
				local rewardList = {}
				for _, d in pairs(CodeData.Rewards) do
					if d.ItemType == "Weapons" or d.ItemType == "Pets" or d.ItemType == "Materials" then
						Module.GiveItem(Player, d.ItemID, d.Amount, d.ItemType)
					elseif d.ItemType == "Currency" then
						Module.Give(Player, d.ItemID, d.Amount)
						game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Coins", DataTable[Player.Name].Coins)
					else
						Module.GiveOther(Player, d.ItemID, d.ItemType)
					end
					table.insert(rewardList, {
						ID = d.ItemID,
						Type = d.ItemType,
						Amount = d.Amount,
					})
				end
				return "Redeemed!", rewardList
			else
				return "Already Redeemed.", nil
			end
		else
			return "Expired.", nil
		end
	end
end

game.ReplicatedStorage.Remotes.Extras.RedeemCode.OnServerInvoke = function (Player, Code:{"Code that is being redeem'd"})
	return Module.Redeem(Player,Code);
end



local ShirtCodes = game:GetService("DataStoreService"):GetDataStore("StoreCodes2");




Module.BuyItem = function (Player, ItemID, ItemType, Currency)
	local ShopItemData = GetSyncData("Shop")[ItemType][ItemID]
	if DataTable[Player.Name] then
		if Currency == "MysteryKey" then

		elseif (ItemID == "CoinExchange" and DataTable[Player.Name].Materials.Owned[Currency]) and DataTable[Player.Name].Materials.Owned[Currency] >= 100 then
			DataTable[Player.Name].Coins += 100
			DataTable[Player.Name].Materials.Owned[Currency] -= 100
			game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Coins", DataTable[Player.Name]["Coins"])
			game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, "Materials", Currency , DataTable[Player.Name].Materials.Owned[Currency])
			game.ReplicatedStorage.ItemGift:FireClient(Player, "CoinVisual", "Materials", 100)
			return true
		elseif (DataTable[Player.Name][Currency]) and DataTable[Player.Name][Currency] >= ShopItemData.Price[Currency] then
			DataTable[Player.Name][Currency] -= ShopItemData.Price[Currency]
			game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, Currency, DataTable[Player.Name][Currency])
		elseif (DataTable[Player.Name].Materials.Owned[Currency]) and DataTable[Player.Name].Materials.Owned[Currency] >= ShopItemData.Price[Currency] then
			DataTable[Player.Name].Materials.Owned[Currency] -= ShopItemData.Price[Currency]
			game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, Currency, DataTable[Player.Name].Materials[Currency])
		else
			return false
		end
	else
		return false
	end
	ItemType = ShopItemData.OwnedType or ShopItemData.DataType or ItemType
	if ItemType == "Weapons" or ItemType == "Pets" or ItemType == "Materials" then
		Module.GiveItem(Player, ItemID, 1, ItemType)
	else
		Module.GiveOther(Player, ItemID, ItemType)
	end
	game.ReplicatedStorage.ItemGift:FireClient(Player, ItemID, ItemType)
	return true
end

local Remotes = game.ReplicatedStorage.Remotes

game.ReplicatedStorage.Remotes.Shop.BuyItem.OnServerInvoke = function (Player, ItemID, ItemType, Currency)
	Module.BuyItem(Player, ItemID, ItemType, Currency)
end
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
Remotes.Shop.BuyItemNew.OnServerInvoke = function(Player, ItemID, Currency)
	local ShopData = GetSyncData("NewShop")[ItemID]
	if not ShopData then
		warn("Shop item not found:", ItemID)
		return false
	end

	local l_Inventory_0 = game.ReplicatedStorage.Remotes.Inventory
	--[[if ShopData.Free or (Currency and ShopData.Price and ShopData.Price[Currency] ~= nil) then
		for _, Reward in ipairs(ShopData.RewardItems) do
			if Reward.ItemType == "Weapons"
				or Reward.ItemType == "Pets"
				or Reward.ItemType == "Materials" then
				Module.GiveItem(Player, Reward.ItemID, Reward.Amount or 1, Reward.ItemType)
			else
				Module.GiveOther(Player, Reward.ItemID, Reward.ItemType)
			end

			game.ReplicatedStorage.ItemGift:FireClient(
				Player,
				Reward.ItemID,
				Reward.ItemType,
				Reward.Amount or 1
			)
		end
		return true
	end]]
	if ShopData.GamepassId or ShopData.DevProductId then
		local hasPass = false

		if ShopData.GamepassId then
			local success, err = pcall(function()
				hasPass = MarketplaceService:UserOwnsGamePassAsync(Player.UserId, ShopData.GamepassId)
			end)

			if not success then
				warn("Error while checking for gamepass:", err)
				return false
			end
		end

		if hasPass and ShopData.DevProductId then
			MarketplaceService:PromptProductPurchase(Player, ShopData.DevProductId)
			return false
		end

		if ShopData.GamepassId and not hasPass then
			MarketplaceService:PromptGamePassPurchase(Player, ShopData.GamepassId)
			return false
		end

		if ShopData.DevProductId then
			MarketplaceService:PromptProductPurchase(Player, ShopData.DevProductId)
			return false
		end

		return false
	end
	if Currency and ShopData.Price and ShopData.Price[Currency] then
		if not DataTable[Player.Name] then return false end
		local playerCurrency = DataTable[Player.Name][Currency] or 0
		local playerMaterials = DataTable[Player.Name].Materials.Owned[Currency] or 0
		local price = ShopData.Price[Currency]
		if ItemID == "CandyExchange" or ItemID == "CoinExchange" then
			if playerMaterials >= 100 then
				DataTable[Player.Name].Coins += 100
				DataTable[Player.Name].Materials.Owned[Currency] -= 100

				l_Inventory_0.ChangeProfileData:FireClient(Player, "Coins", DataTable[Player.Name].Coins)
				l_Inventory_0.ChangeInventoryItem:FireClient(Player, "Materials", Currency, DataTable[Player.Name].Materials.Owned[Currency])
				game.ReplicatedStorage.ItemGift:FireClient(Player, "CoinVisual", "Materials", 100)
				return true
			else
				return false
			end
		end
		if DataTable[Player.Name][Currency] and DataTable[Player.Name][Currency] >= ShopData.Price[Currency] then
			DataTable[Player.Name][Currency] -= ShopData.Price[Currency]
			l_Inventory_0.ChangeProfileData:FireClient(Player, Currency, DataTable[Player.Name][Currency])

		elseif DataTable[Player.Name].Materials.Owned[Currency]
			and DataTable[Player.Name].Materials.Owned[Currency] >= ShopData.Price[Currency]
		then
			DataTable[Player.Name].Materials.Owned[Currency] -= ShopData.Price[Currency]
			l_Inventory_0.ChangeProfileData:FireClient(Player, Currency, DataTable[Player.Name].Materials.Owned[Currency])

		else
			return false
		end

		local ItemType = ShopData.OwnedType or ShopData.DataType
		local l_Sync_0 = require(ReplicatedStorage.Database.Sync)
		if not ItemType then
			if l_Sync_0.Weapons[ItemID] then
				ItemType = "Weapons"
			elseif l_Sync_0.Pets[ItemID] then
				ItemType = "Pets"
			elseif l_Sync_0.Effects[ItemID] then
				ItemType = "Effects"
			elseif l_Sync_0.Perks[ItemID] then
				ItemType = "Perks"
			elseif l_Sync_0.Emotes[ItemID] then
				ItemType = "Emotes"
			elseif l_Sync_0.Toys[ItemID] then
				ItemType = "Toys"	
			elseif l_Sync_0.Materials[ItemID] then
				ItemType = "Materials"
			else
				ItemType = "Misc"
			end
		end

		if ItemType == "Weapons" or ItemType == "Pets" or ItemType == "Materials" then
			Module.GiveItem(Player, ItemID, 1, ItemType)
		else
			Module.GiveOther(Player, ItemID, ItemType)
		end

		game.ReplicatedStorage.ItemGift:FireClient(Player, ItemID, ItemType)
		return true
	end

	warn("Missing requirements for:", ItemID)
	return false
end


Module.OpenCrate = function(Player, CrateName, BoxType: "MysteryBox" | "Egg", Currency)
	local BoxData = GetSyncData(BoxType)[CrateName]
	local ShopBoxData = GetSyncData("NewShop")[CrateName]
	local BoxRarityChancess = BoxData.RarityChances
	local SortedRarityContent = {}
	if DataTable[Player.Name] then
		if (DataTable[Player.Name][Currency]) and DataTable[Player.Name][Currency] >= ShopBoxData.Price[Currency] then
			DataTable[Player.Name][Currency] -= ShopBoxData.Price[Currency]
			game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, Currency, DataTable[Player.Name][Currency])
		elseif (DataTable[Player.Name].Materials.Owned[Currency]) and DataTable[Player.Name].Materials.Owned[Currency] >= ShopBoxData.Price[Currency] then
			DataTable[Player.Name].Materials.Owned[Currency] -= ShopBoxData.Price[Currency]
			game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Materials", DataTable[Player.Name].Materials)
		elseif DataTable[Player.Name].Weapons.Owned[Currency] then
			DataTable[Player.Name].Weapons.Owned[Currency] -= ShopBoxData.Price[Currency]
			game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, "Weapons", Currency, DataTable[Player.Name].Weapons.Owned[Currency])
		else 
			return
		end
	else
		return
	end
	for _, ItemID in pairs(BoxData.Contents) do
		local ItemData = GetSyncData((BoxData.BoxType == "Weapons") and "Item" or BoxData.BoxType)[ItemID]
		local ItemRarity = ItemData.Rarity or "Common"
		SortedRarityContent[ItemRarity] = SortedRarityContent[ItemRarity] or {}
		table.insert(SortedRarityContent[ItemRarity], ItemID)
	end
	local TotalRarityChancess, combWeight = 0, 0
	for _, RarityData in pairs(BoxRarityChancess) do
		TotalRarityChancess += RarityData.Chance
	end
	local randomRarityChances = math.random() * TotalRarityChancess
	local selectedRarity
	for _, RarityData in pairs(BoxRarityChancess) do
		combWeight += RarityData.Chance
		if randomRarityChances <= combWeight then
			selectedRarity = RarityData.Rarity
			break
		end
	end
	local SelectedItem = SortedRarityContent[selectedRarity][math.random(1, #SortedRarityContent[selectedRarity])]


	task.delay(4 - Player:GetNetworkPing(), function()
		if BoxData.BoxType == "Weapons" or BoxData.BoxType == "Pets" or BoxData.BoxType == "Materials" then
			Module.GiveItem(Player, SelectedItem, 1, BoxData.BoxType)
		else
			Module.GiveOther(Player, SelectedItem, BoxData.BoxType)
		end

		local MsgConnection;
		MsgConnection = game.ReplicatedStorage.Remotes.Shop.CrateComplete.OnServerEvent:Connect(function(ePlayer)
			wait()
			MsgConnection:Disconnect()
			game.ReplicatedStorage.ChatMessage:FireAllClients({text = Player.Name .. " has just unboxed:", item = SelectedItem})
		end)
	end)
	return SelectedItem or nil
end

Module.Prestige = function(Player)
	local Level = Module.GetLevel(Module.Get(Player,"NewXP"));
	if Level >= 100 and Module.Get(Player,"Prestige") < 10 then
		DataTable[Player.Name]["NewXP"] = 0;
		DataTable[Player.Name]["Prestige"] = DataTable[Player.Name]["Prestige"] + 1;
		game.ReplicatedStorage.Remotes.Misc.UpdateLeaderboard:FireAllClients();
	end
end
game.ReplicatedStorage.Remotes.Inventory.Prestige.OnServerEvent:connect(Module.Prestige);

game.ReplicatedStorage.Remotes.Inventory.ToggleDeathEffects.OnServerEvent:Connect(function(Player: Player, Value: boolean) 
	DataTable[Player.Name]["DeathEffect"] = Value
end)

Module.CreatePlayerAttributes = function(Player)
	local data = DataTable[Player.Name]
	local attributes = {
		Elite = PlayerIsElite(Player),
		Radio = PlayerHasRadio(Player),
		Prestige = data.Prestige,
		XP = Module.Get(Player,"NewXP");
		Level = Module.GetLevel(Module.Get(Player, "XP")),
		PerformingTrade = false,
		EquippedKnife = data.Weapons.Equipped.Knife,
		EquippedGun = data.Weapons.Equipped.Gun,
		EquippedEffect = data.Effects.Equipped[1],
		EquippedPerk = data.Perks.Equipped[1],
		EquippedRadio = data.Radios.Equipped[1],
		DoubleEffect = data.Gamepasses.DoubleEffect,
		KnifePosition = data.KnifePosition
	}
	for name, value in pairs(attributes) do
		Player:SetAttribute(name, value)
	end
end




local MAX_TRADING_OFFERS = 4
local NON_TRADEABLE_ITEMS = {"DefaultKnife", "DefaultGun"}
local TRADEABLE_DATATYPES = {"Weapons", "Pets"}
local MINIMUM_LEVEL_TO_TRADE = 10
type AllTradeRequestTypes = "SendingRequest" | "ReceivingRequest"
type TradeRequestTableType = { [string]: string }
type OfferItemData = {
	ItemID: string,
	Amount: number,
	ItemType: string,
}
type TradeDataForEachPlayersType = {
	Player: Player,
	Accepted: boolean,
	Offer: { OfferItemData },
}
type TradeDataTableType = {
	Player1: TradeDataForEachPlayersType,
	Player2: TradeDataForEachPlayersType,
	TradeLocked: boolean,
}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TradingRemotes = ReplicatedStorage.Trade
local TradingTable = {
	Requests = {} :: TradeRequestTableType,
	TradeData = {} :: { TradeDataTableType },
}
local function playerIsInTrade(playerName: string): boolean
	for _, tradeData in pairs(TradingTable.TradeData) do
		for _, playerTradeData in pairs(tradeData) do
			if playerTradeData.Player and playerTradeData.Player.Name == playerName then
				return true
			end
		end
	end
	return false
end
local function playerBeingRequestedBy(playerName: string): string?
	for sender, receiver in pairs(TradingTable.Requests) do
		if receiver == playerName then
			return sender
		end
	end
	return nil
end
local function createTrading(...: Player)
	local self = {} :: TradeDataTableType
	for i, player in ipairs({...}) do
		self[`Player{i}`] = {
			Player = player,
			Offer = {} :: { OfferItemData },
			Accepted = false,
		}
		if TradingTable.Requests[player.Name] then
			TradingTable.Requests[player.Name] = nil
		end
	end
	table.insert(TradingTable.TradeData, self)
	if self.Player1 and self.Player2 then
		TradingRemotes.StartTrade:FireClient(self.Player2.Player, self, self.Player1.Player.Name)
		TradingRemotes.StartTrade:FireClient(self.Player1.Player, self, self.Player2.Player.Name)
	end
end
local function getTradeData(player: Player): (TradeDataTableType?, number?)
	for tradeID, tradeData in pairs(TradingTable.TradeData) do
		for _, playerTradeData in pairs(tradeData) do
			if playerTradeData.Player == player then
				return tradeData, tradeID
			end
		end
	end
	return nil
end
local function findItemOrderInOffers(offerTable: { OfferItemData }, itemID: string, itemType: string): number?
	for orderID, offerData in pairs(offerTable) do
		if offerData.ItemID == itemID and offerData.ItemType == itemType then
			return orderID
		end
	end
	return nil
end
local function amountItemInOffers(offerTable: { OfferItemData }, itemID: string, itemType: string): number
	local orderID = findItemOrderInOffers(offerTable, itemID, itemType)
	return orderID and offerTable[orderID].Amount or 0
end
local function offerItem(player: Player, itemID: string, itemType: string)
	if table.find(NON_TRADEABLE_ITEMS, itemID) then
		return
	end
	if not table.find(TRADEABLE_DATATYPES, itemType) then
		return
	end
	local tradingData = getTradeData(player)
	if not playerIsInTrade(player.Name) then
		return
	end
	if not tradingData then
		return
	end
	local playerTradingName = (tradingData.Player1.Player == player) and "Player1" or "Player2"
	local playerTradingData = tradingData[playerTradingName]

	if #playerTradingData.Offer >= MAX_TRADING_OFFERS then
		return
	end
	if not Module.Get(player, itemType) or not Module.Get(player, itemType).Owned or not Module.Get(player, itemType).Owned[itemID] then
		return
	end
	local offerItemOrder = findItemOrderInOffers(playerTradingData.Offer, itemID, itemType)
	if offerItemOrder then
		local offerItemData = playerTradingData.Offer[offerItemOrder]
		if (offerItemData.Amount + 1) > Module.Get(player, itemType).Owned[itemID] then
			return
		end
		offerItemData.Amount += 1
	else
		table.insert(playerTradingData.Offer, {
			ItemID = itemID,
			ItemType = itemType,
			Amount = 1,
		})
	end
	for _, playerTradeData in pairs(tradingData) do
		if playerTradeData.Player and playerTradeData.Player:IsDescendantOf(game.Players) then
			TradingRemotes.UpdateTrade:FireClient(playerTradeData.Player, getTradeData(playerTradeData.Player))
		end
	end
end

--[[local function offerItem(player: Player, itemID: string, itemType: string)
	local tradeData = getTradeData(player)
	if not playerIsInTrade(player.Name) or not tradeData then return end
	local playerTradingName   = (tradeData.Player1.Player == player) and "Player1" or "Player2"
	local playerTradingData   = tradeData[playerTradingName]
	local offerItemOrder      = findItemOrderInOffers(playerTradingData.Offer, itemID, itemType)
	if not offerItemOrder and #playerTradingData.Offer >= MAX_TRADING_OFFERS then
		return
	end
	local owned = Module.Get(player, itemType)
	if not owned or not owned.Owned or not owned.Owned[itemID] then
		warn(`couldn't find Item {itemID} in player {itemType} inventory`)
		return
	end
	if offerItemOrder then
		local offerItemData = playerTradingData.Offer[offerItemOrder]
		if (offerItemData.Amount + 1) > owned.Owned[itemID] then
			warn(`{player.Name} has not enough {itemID} to add, current amount added {offerItemData.Amount}`)
			return
		end
		offerItemData.Amount += 1
	else
		table.insert(playerTradingData.Offer, {
			ItemID   = itemID,
			ItemType = itemType,
			Amount   = 1,
		})
	end
	for _, pData in pairs(tradeData) do
		if pData.Player and pData.Player:IsDescendantOf(game.Players) then
			TradingRemotes.UpdateTrade:FireClient(pData.Player, getTradeData(pData.Player))
		end
	end
end]]



local function removeOffer(player: Player, itemID: string, itemType: string)
	local tradingData = getTradeData(player)
	if not playerIsInTrade(player.Name) then
		warn(`player is not in trade`)
		return
	end
	if not tradingData then
		return
	end
	local playerTradingName = (tradingData.Player1.Player == player) and "Player1" or "Player2"
	local playerTradingData = tradingData[playerTradingName]
	local offerItemOrder = findItemOrderInOffers(playerTradingData.Offer, itemID, itemType)
	if offerItemOrder then
		local offerItemData = playerTradingData.Offer[offerItemOrder]
		if offerItemData.Amount == 1 then
			table.remove(playerTradingData.Offer, offerItemOrder)
		elseif offerItemData.Amount > 1 then
			offerItemData.Amount -= 1
		end
	end
	for _, playerTradeData in pairs(tradingData) do
		if playerTradeData.Player and playerTradeData.Player:IsDescendantOf(game.Players) then
			TradingRemotes.UpdateTrade:FireClient(playerTradeData.Player, getTradeData(playerTradeData.Player))
		end
	end
end
function cancelTrade(playerDeclining: Player)
	local tradeData, tradeID = getTradeData(playerDeclining)
	if not tradeID or not tradeData then
		warn(`failed to decline trade of {playerDeclining.Name}`)
		return
	end

	for _, playerTradeData in pairs(tradeData) do
		if playerTradeData.Player and playerTradeData.Player:IsDescendantOf(game.Players) then
			TradingRemotes.DeclineTrade:FireClient(playerTradeData.Player)
		end
	end
	table.remove(TradingTable.TradeData, tradeID)
end
local function acceptTrade(playerAccepting: Player)
	local tradeData, tradeID = getTradeData(playerAccepting)
	if not tradeID or not tradeData then
		warn(`failed to accept trade of {playerAccepting.Name}`)
		return
	end
	if tradeData.TradeLocked then
		return
	end
	local tradeDone = true
	for _, playerTradeData in pairs(tradeData) do
		if playerTradeData.Player == playerAccepting then
			playerTradeData.Accepted = true
		elseif not playerTradeData.Accepted then
			tradeDone = false
		end
	end
	if not tradeDone then
		for _, playerTradeData in pairs(tradeData) do
			if playerTradeData.Player and playerAccepting ~= playerTradeData.Player then
				TradingRemotes.AcceptTrade:FireClient(playerTradeData.Player, tradeDone)
			end
		end
	else
		tradeData.TradeLocked = true
		for _, playerTradeData in pairs(tradeData) do
			if (typeof(playerTradeData)=="table") and playerTradeData.Player and playerTradeData.Player:IsDescendantOf(game.Players) then
				playerTradeData.Player:SetAttribute("PerformingTrade", true)
			end
		end

		math.randomseed(os.time())
		task.wait(math.random(0.1, 1.25))
		for playerTradeName, playerTradeData in pairs(tradeData) do
			if  (typeof(playerTradeData)=="table") and playerTradeData.Player and playerTradeData.Player:IsDescendantOf(game.Players) then
				playerTradeData.Player:SetAttribute("PerformingTrade", false)
				local otherPlayerTradeName = (playerTradeName == "Player1") and "Player2" or "Player1"
				for _, offerItemData in pairs(playerTradeData.Offer) do
					Module.RemoveItem(playerTradeData.Player, offerItemData.ItemID, offerItemData.Amount, offerItemData.ItemType)
				end
				for _, offerItemData in pairs(tradeData[otherPlayerTradeName].Offer) do
					Module.GiveItem(playerTradeData.Player, offerItemData.ItemID, offerItemData.Amount, offerItemData.ItemType, true)
				end
				TradingRemotes.AcceptTrade:FireClient(playerTradeData.Player, true, tradeData[otherPlayerTradeName].Offer)
			end
		end
		table.remove(TradingTable.TradeData, tradeID)
	end
end
local function getTradeStatus(player: Player): (AllTradeRequestTypes?, { Receiver: string?, Sender: Player? }?)
	if TradingTable.Requests[player.Name] then
		return "SendingRequest", {
			Receiver = TradingTable.Requests[player.Name],
		}
	elseif playerBeingRequestedBy(player.Name) then
		return "ReceivingRequest", {
			Sender = game.Players:FindFirstChild(playerBeingRequestedBy(player.Name))
		}
	end
	return
end
local function sendRequest(player: Player, otherPlayer: Player): boolean
	if not player or not otherPlayer then
		return true
	end
	if not player:IsDescendantOf(game.Players) or not otherPlayer:IsDescendantOf(game.Players) then
		return true
	end
	if player == otherPlayer then
		return true
	end
	if playerIsInTrade(player.Name) or playerIsInTrade(otherPlayer.Name) then
		return true
	end
	if otherPlayer:GetAttribute("Level") and otherPlayer:GetAttribute("Level") < MINIMUM_LEVEL_TO_TRADE then
		return true
	end
	if TradingTable.Requests[otherPlayer.Name] or playerBeingRequestedBy(player.Name) then
		return true
	end
	if otherPlayer:GetAttribute("RequestsEnabled") == false then
		return true
	end
	TradingTable.Requests[player.Name] = otherPlayer.Name
	TradingRemotes.RequestSent:FireClient(otherPlayer, player)
	return false
end

local function acceptRequest(receiver: Player)
	if playerIsInTrade(receiver.Name) then
		return
	end
	if not playerBeingRequestedBy(receiver.Name) then
		return
	end

	local sender = game.Players:FindFirstChild(playerBeingRequestedBy(receiver.Name))
	if not sender then
		return
	end

	createTrading(receiver, sender)
end

local function declineRequest(receiver: Player)
	if playerIsInTrade(receiver.Name) then
		return
	end
	if not playerBeingRequestedBy(receiver.Name) then
		return
	end

	local sender = game.Players:FindFirstChild(playerBeingRequestedBy(receiver.Name))
	if not sender then
		return
	end

	TradingRemotes.DeclineRequest:FireClient(sender)
	TradingTable.Requests[sender.Name] = nil
end
local function cancelRequest(sender: Player)
	local receiver = game.Players:FindFirstChild(TradingTable.Requests[sender.Name])
	if receiver then
		TradingTable.Requests[sender.Name] = nil
		TradingRemotes.CancelRequest:FireClient(receiver)
	end
end
local function setRequestsEnabled(player: Player, activation: boolean)
	if player and activation and player:IsDescendantOf(game.Players) then
		player:SetAttribute("RequestsEnabled", activation)
	end
end
local function clearPlayerTradeConnections(player: Player)
	local receiver = (TradingTable.Requests[player.Name]) and game.Players:FindFirstChild(TradingTable.Requests[player.Name])
	if receiver then
		TradingRemotes.CancelRequest:FireClient(receiver)
		TradingTable.Requests[player.Name] = nil
	end
	if playerIsInTrade(player.Name) then
		cancelTrade(player)
	end
end
TradingRemotes.GetTradeStatus.OnServerInvoke = getTradeStatus
TradingRemotes.SendRequest.OnServerInvoke = sendRequest
TradingRemotes.AcceptRequest.OnServerEvent:Connect(acceptRequest)
TradingRemotes.DeclineRequest.OnServerEvent:Connect(declineRequest)
TradingRemotes.CancelRequest.OnServerEvent:Connect(cancelRequest)
TradingRemotes.OfferItem.OnServerEvent:Connect(offerItem)
TradingRemotes.RemoveOffer.OnServerEvent:Connect(removeOffer)
TradingRemotes.DeclineTrade.OnServerEvent:Connect(cancelTrade)
TradingRemotes.AcceptTrade.OnServerEvent:Connect(acceptTrade)
TradingRemotes.SetRequestsEnabled.OnServerEvent:Connect(setRequestsEnabled)
game:GetService("Players").PlayerRemoving:Connect(clearPlayerTradeConnections)









Module.GetKeys = function(Player)
	if DataTable[Player.Name].Weapons.Owned["MysteryKey"] then
		return true
	end
end
Module.GetNumberKeys = function(Player)
	if DataTable[Player.Name].Weapons.Owned["MysteryKey"] then
		return DataTable[Player.Name].Weapons.Owned["MysteryKey"]
	end
end












Module.GiveToys = function(Player, RequiredToy)
	if not Player:FindFirstChild("Backpack") then return end
	if Player.Backpack:FindFirstChild(RequiredToy)
		or (Player.Character and Player.Character:FindFirstChild(RequiredToy)) then
		return
	end

	local playerData = DataTable[Player.Name]
	if not playerData or not playerData.Toys or not playerData.Toys.Owned then return end
	for _, ToyName in pairs(playerData.Toys.Owned) do
		if tostring(ToyName) == tostring(RequiredToy) then
			local ToyTemplate = game.ServerStorage.Database.Toys:FindFirstChild(ToyName)
			if ToyTemplate then
				local NewToy = ToyTemplate:Clone()
				NewToy.CanBeDropped = false
				NewToy.Parent = Player.Backpack
			end
			break 
		end
	end
end
function game.ReplicatedStorage.Remotes.Extras.ReplicateToy.OnServerInvoke(Player,WantedToy)
	Module.GiveToys(Player,WantedToy)
end


game.ReplicatedStorage.Remotes.Inventory.BuySlot.OnServerEvent:connect(function(Player,Type)
	local SlotInfo = GetSyncData("SlotInfo");
	local NextSlot = DataTable[Player.Name][Type].Slots + 1;
	if NextSlot <= SlotInfo[Type].Max then
		DataTable[Player.Name][Type].Slots = DataTable[Player.Name][Type].Slots + 1;
		DataTable[Player.Name]["Coins"] = DataTable[Player.Name]["Coins"] - SlotInfo[Type].Prices[NextSlot];
	end
end);

game.ReplicatedStorage.Remotes.Extras.GetPlayerLevel.OnServerInvoke = function(player, targetPlayerName)
	local PlayerData = DataTable[targetPlayerName]
	if PlayerData then
		local XP = PlayerData.XP
		local Elite = PlayerIsElite(game:GetService("Players"):FindFirstChild(targetPlayerName))
		return 100, 10, Elite, XP
	end
end



game.ReplicatedStorage.Remotes.Inventory.Equip.OnServerEvent:connect(function(Player,ItemName,Type)
	Module.Equip(Player,ItemName,Type);
end)
game.ReplicatedStorage.Remotes.Inventory.Unequip.OnServerEvent:connect(function(Player,ItemName,Type)
	Module.Unequip(Player,ItemName,Type);
end)
game.ReplicatedStorage.Remotes.Inventory.ChangeCustomOutfitId.OnServerInvoke = function(Player, Username)
	local playerData = DataTable[Player.Name]
	if not playerData or not playerData.Outfits then
		return "Invalid username"
	end
	if _G.OutfitsDisabled == true then
		return "Outfits disabled"
	end

	local success, result = pcall(function()
		if Username == 1 or Username == "1" then
			playerData.Outfits.Equipped = {}
			playerData.Outfits.OutfitId = 0

			local character = Player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local defaultAppearance = game.Players:GetHumanoidDescriptionFromUserId(Player.UserId)
				humanoid:ApplyDescription(defaultAppearance)
			end
			if _G.WeldWeapons then _G.WeldWeapons(Player) end
			if _G.WeldRadio then _G.WeldRadio(Player) end

			Module.SaveData(Player)
			return 0
		end

		local usernameText = tostring(Username or ""):match("^%s*(.-)%s*$")
		if usernameText == "" then
			return "Invalid username"
		end

		local userId = tonumber(usernameText)
		if not userId then
			userId = game.Players:GetUserIdFromNameAsync(usernameText)
		end
		userId = math.floor(math.abs(tonumber(userId) or 0))
		if userId <= 0 then
			return "Invalid username"
		end

		playerData.Outfits.Equipped = { "Custom_Outfit" }
		playerData.Outfits.OutfitId = userId

		local applied, applyResult = applyOutfitAppearance(Player, "Custom_Outfit")
		if not applied then
			error(applyResult)
		end

		Module.SaveData(Player)
		return userId
	end)

	if success then
		return result
	else
		warn("Error in ChangeCustomOutfitId:", result)
		return "Invalid username"
	end
end

function game.ReplicatedStorage.Remotes.Shop.OpenCrate.OnServerInvoke(Player, Box, BoxType, Currency)
	local success = Module.OpenCrate(Player, Box, BoxType, Currency)
	if success and Box == "Summer2026Box" then
		game.ReplicatedStorage.Insight.BoxOpen:Fire(Player)
	end
	return success
end


function game.ReplicatedStorage.Remotes.Extras.GetData2.OnServerInvoke(Player)
	return DataTable[Player.Name];
end

game.ReplicatedStorage.Remotes.Extras.ChangeLastDevice.OnServerEvent:connect(function(Player,NewDevice)
	DataTable[Player.Name]["LastDevice"] = NewDevice;
	task.spawn(function()
		Module.SaveData(Player);
	end)
end);

--// Follow Rewards By @PlayFede

--// ItsPlayFede
game.ReplicatedStorage.Remotes.FollowRewards.ItsPlayFede.OnServerEvent:Connect(function(Player)
	if DataTable[Player.Name]["FollowRewards"]["ItsPlayFede"] then
		return
	end
	
	local HttpService = game:GetService("HttpService")
	local Follower = Player.UserId
	local Followed = 4614856075
	local Table = "https://friends.roproxy.com/v1/users/"..Follower.."/followings?limit=100&sortOrder=Desc"
	local response = HttpService:RequestAsync({
		Url = Table,
		Method = "GET"
	});
	
	if response.Success then
		local TableBody = HttpService:JSONDecode(response.Body)
		for index, v in pairs(TableBody.data) do
			if v.id == Followed then
				Module.GiveItem(Player, "IceHammerPink" , 1, "Weapons")
				Module.GiveItem(Player, "IcepiercerPink" , 1, "Weapons")
				DataTable[Player.Name]["FollowRewards"]["ItsPlayFede"] = false
				game.ReplicatedStorage.ItemGift:FireClient(Player, "IceHammerPink", "Weapons");
				game.ReplicatedStorage.ItemGift:FireClient(Player, "IcepiercerPink", "Weapons");
			end
		end
	end
end)

--// 42devy
game.ReplicatedStorage.Remotes.FollowRewards:WaitForChild("42devy").OnServerEvent:Connect(function(Player)
	if DataTable[Player.Name]["FollowRewards"]["42devy"] then
		return
	end
	
	local HttpService = game:GetService("HttpService")
	local Follower = Player.UserId
	local Followed = 3223673484
	local Table = "https://friends.roproxy.com/v1/users/"..Follower.."/followings?limit=100&sortOrder=Desc"
	local response = HttpService:RequestAsync({
		Url = Table,
		Method = "GET"
	});
	
	if response.Success then
		local TableBody = HttpService:JSONDecode(response.Body)
		for index, v in pairs(TableBody.data) do
			if v.id == Followed then
				Module.GiveItem(Player, "Gingerscythe_Purple" , 1, "Weapons")
				Module.GiveItem(Player, "Gingerscope_Purple" , 1, "Weapons")
				DataTable[Player.Name]["FollowRewards"]["42devy"] = false
				game.ReplicatedStorage.ItemGift:FireClient(Player, "Gingerscythe_Purple", "Weapons");
				game.ReplicatedStorage.ItemGift:FireClient(Player, "Gingerscope_Purple", "Weapons");
			end
		end
	end
end)

game.ReplicatedStorage.Remotes.Inventory.SaveSong.OnServerEvent:connect(function(Player,SoundID,SongName)
	table.insert(DataTable[Player.Name]["RadioSongs"],1,{ID=SoundID,Name=SongName});
	if #DataTable[Player.Name]["RadioSongs"] >= 30 then
		table.remove(DataTable[Player.Name]["RadioSongs"],30);
	end
end)
game.ReplicatedStorage.Remotes.Inventory.RemoveSong.OnServerEvent:connect(function(Player,Index)
	table.remove(DataTable[Player.Name]["RadioSongs"],Index);
end)


function game.ReplicatedStorage.Remotes.Extras.GetData.OnServerInvoke(Player,DataName,Target)
	if Target ~= nil then
		return Module.Get(Target,DataName);
	else
		return Module.Get(Player,DataName);
	end;
end






function game.ReplicatedStorage.Remotes.Extras.GetFullInventory.OnServerInvoke(Player,TargetPlayer)
	return DataTable[TargetPlayer];
end

-- If playfede can have a created thing then lukas deserve too >:(

--// Made with Love by 4devy \\--
game.ReplicatedStorage.Remotes.Misc.GetPlayerProfile.OnServerInvoke = function (Player, PlayerName)
	local Target : Player? = game.Players:FindFirstChild(PlayerName)	
	local plrReq:Player = game:GetService("Players"):FindFirstChild(PlayerName);
	if not plrReq then return end
	local Data = DataTable[PlayerName] or {}

	local NameTags = GetSyncData("NameTags")
	local TagData = NameTags[tostring(Target.UserId)] or {}
	local ProfileTags = TagData.ProfileTags or {}
	
	pcall(function()
		local statsChanged = ensureProfileStats(Data)
		local petsChanged = cleanupRemovedPets(Data)
		Data.Elite = (plrReq:GetAttribute("Elite") ~= nil)
		Data.Admin = (plrReq:GetAttribute("Admin") ~= nil)
		Data.Level = Module.GetLevel(Data.XP);
		Data.Eliminations = Data.Status.Murderer
		Data.Victories = Data.Status.Sheriffs
		Data.Survivals = Data.Status.Innocents
		if (statsChanged or petsChanged) and Target then
			task.spawn(function()
				Module.SaveData(Target)
			end)
		end

		Data.Nikilis = ProfileTags.MM2Creator == true
		Data.MapBuilder = ProfileTags.Builder == true
		Data.BetaTester = ProfileTags.BetaTester == true
		Data.WeaponDesigner = ProfileTags.WeaponDesigner == true
	end)
	return Data
end
game.ReplicatedStorage.Remotes.Inventory.RenamePet.OnServerEvent:connect(function(Player,PetName)
	if string.len(PetName)<=20 then
		DataTable[Player.Name].PetName = PetName;
		_G.GivePet(Player)
	end;
end)

function game.ReplicatedStorage.GetDataServer.OnInvoke(Player,DataName)
	return Module.Get(Player,DataName);
end



local ADMIN_OWNER_IDS = {
	[24029404] = true,
}

local function CheckForAdminGamepass(Player)
	if not Player then
		return false
	end
	if ADMIN_OWNER_IDS[Player.UserId] or Player:GetAttribute("AdminPanelAccess") == true then
		return true
	end
	local gamepassId = Config.Gamepasses.AdminMenu or 1933372241
	local success, hasPass = pcall(function()
		return game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId, gamepassId)
	end)
	if not success then
		warn("[Admin] Could not verify admin gamepass for", Player.Name, hasPass)
		return false
	end
	return hasPass == true
end

game.ReplicatedStorage.Remotes.Admin.AdminRequest.OnServerInvoke = function(Player)
	local hasAdmin = CheckForAdminGamepass(Player)
	_G.BoughtAdmin = hasAdmin
	return hasAdmin
end

game.ReplicatedStorage.Remotes.Extras.CheckAdmin.OnServerInvoke = function(player)
	return CheckForAdminGamepass(player)
end
local function CheckForAdmin(Player)
	return CheckForAdminGamepass(Player)
end
game.ReplicatedStorage.Remotes.AdminSettings.GiveCurrency.OnServerInvoke = function(Player, PlayerToGive, Value, TypeCurrency)
	if not CheckForAdmin(Player) then
		return {message = "You’re trying, and that’s cute. But no.",exp = true}
	end
	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return {message = "Target player not found.", exp = false}
	end
	local amount = tonumber(Value)
	if not amount or amount < 1 then
		return {message = "Invalid amount specified.", exp = false}
	end
	local currencyValue = DataTable[PlayerToGive.Name] and DataTable[PlayerToGive.Name][TypeCurrency]
	if currencyValue == nil then
		return {message = "Currency type not found for target player.", exp = false}
	end
	if amount < 0 then
		return {message = "Negative currency transfer is not allowed.", exp = false}
	end
	Module.Give(PlayerToGive, TypeCurrency, amount)
	game.ReplicatedStorage.ItemGift:FireClient(PlayerToGive, TypeCurrency, "Materials", amount)
	game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(PlayerToGive, TypeCurrency, DataTable[PlayerToGive.Name][TypeCurrency])
	return {message = ("Successfully gave %s (x%d)."):format(TypeCurrency, amount), exp = false}
end
game.ReplicatedStorage.Remotes.AdminSettings.BecomeARole.OnServerInvoke = function(player, PlayerToGive, RoleName)
	if not CheckForAdmin(player) then
		return {message = "You’re trying, and that’s cute. But no.", exp = true}
	end
	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return {message = "Target player not found.", exp = false}
	end
	if _G.CustomMurderer == PlayerToGive.Name and RoleName ~= "Murderer" then
		return {message = PlayerToGive.Name .. " is already Murderer, cannot assign different role.", exp = false}
	end
	if _G.CustomSheriff == PlayerToGive.Name and RoleName ~= "Sheriff" then
		return {message = PlayerToGive.Name .. " is already Sheriff, cannot assign different role.", exp = false}
	end
	if RoleName == "Murderer" then
		if _G.CustomMurderer and _G.CustomMurderer ~= PlayerToGive.Name then
			return {message = "Murderer role is already taken by " .. _G.CustomMurderer, exp = false}
		end
		if _G.CustomSheriff == PlayerToGive.Name then
			_G.CustomSheriff = nil
		end
		_G.CustomMurderer = PlayerToGive.Name
		return {message = "Successfully assigned Murderer to " .. PlayerToGive.Name, exp = false}

	elseif RoleName == "Sheriff" then
		if _G.CustomSheriff and _G.CustomSheriff ~= PlayerToGive.Name then
			return {message = "Sheriff role is already taken by " .. _G.CustomSheriff, exp = false}
		end
		if _G.CustomMurderer == PlayerToGive.Name then
			_G.CustomMurderer = nil
		end
		_G.CustomSheriff = PlayerToGive.Name
		return {message = "Successfully assigned Sheriff to " .. PlayerToGive.Name, exp = false}
	else
		return {message = "Wrong Role Name!", exp = false}
	end
end
game.ReplicatedStorage.Remotes.AdminSettings.SetMap.OnServerInvoke = function(player, MapID)
	if not CheckForAdmin(player) then
		return {message = "You’re trying, and that’s cute. But no.", exp = true}
	end
	if not GetSyncData("Maps")[MapID] then
		return {message = "Unknown map", exp = false}
	end
	_G.Map = MapID
	return {message = MapID, exp = false}
end
game.ReplicatedStorage.Remotes.Admin.SetMap.OnServerInvoke = function(player, MapID)
	if not CheckForAdminGamepass(player) then
		return {message = "You’re trying, and that’s cute. But no.", exp = true}
	end

	local Maps = GetSyncData("Maps")
	MapID = tostring(MapID):gsub("%s+", "")

	if not Maps[MapID] then
		return {message = "Unknown map", exp = false}
	end

	_G.Map = MapID
	return {message = "Map set to: " .. MapID, exp = false}
end

game.ReplicatedStorage.Remotes.Admin.BecomeRole.OnServerInvoke = function(player, PlayerToGive, RoleName)
	if not CheckForAdminGamepass(player) then
		return {message = "You’re trying, and that’s cute. But no.", exp = true}
	end
	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return {message = "Target player not found.", exp = false}
	end
	if _G.CustomMurderer == PlayerToGive.Name and RoleName ~= "Murderer" then
		return {message = PlayerToGive.Name .. " is already Murderer, cannot assign different role.", exp = false}
	end
	if _G.CustomSheriff == PlayerToGive.Name and RoleName ~= "Sheriff" then
		return {message = PlayerToGive.Name .. " is already Sheriff, cannot assign different role.", exp = false}
	end
	if RoleName == "Murderer" then
		if _G.CustomMurderer and _G.CustomMurderer ~= PlayerToGive.Name then
			return {message = "Murderer role is already taken by " .. _G.CustomMurderer, exp = false}
		end
		if _G.CustomSheriff == PlayerToGive.Name then
			_G.CustomSheriff = nil
		end
		_G.CustomMurderer = PlayerToGive.Name
		return {message = "Successfully assigned Murderer to " .. PlayerToGive.Name, exp = false}

	elseif RoleName == "Sheriff" then
		if _G.CustomSheriff and _G.CustomSheriff ~= PlayerToGive.Name then
			return {message = "Sheriff role is already taken by " .. _G.CustomSheriff, exp = false}
		end
		if _G.CustomMurderer == PlayerToGive.Name then
			_G.CustomMurderer = nil
		end
		_G.CustomSheriff = PlayerToGive.Name
		return {message = "Successfully assigned Sheriff to " .. PlayerToGive.Name, exp = false}
	else
		return {message = "Wrong Role Name!", exp = false}
	end
end
game.ReplicatedStorage.Remotes.AdminSettings.GiveWeapon.OnServerInvoke = function(player, PlayerToGive, TypeWeapon)
	if not CheckForAdmin(player) then
		return {message = "You’re trying, and that’s cute. But no.", exp = true}
	end
	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return { message = "Target player not found.", exp = false }
	end
	if TypeWeapon == "Knife" then
		
		
		
		local PerkManager = require(game.ServerScriptService.GameScript.Modules.PerksController)
		local ItemsDB = GetSyncData("Item")
		local NewItem;
		NewItem = game.ServerStorage.Database.Default.Knife:Clone(); 
		if game.ServerStorage.Database.Item[Module.Get(PlayerToGive,"Weapons").Equipped.Knife] then
			NewItem = game.ServerStorage.Database.Item[Module.Get(PlayerToGive,"Weapons").Equipped.Knife]:Clone(); 
		end
		NewItem.Handle.CanCollide = false
		NewItem.Handle.Massless = true
		NewItem.TextureId = ItemsDB[Module.Get(PlayerToGive,"Weapons").Equipped.Knife].Image;
		for i,Script in pairs(game.ServerStorage.Gameplay.KnifeScripts:GetChildren()) do
			local NewScript = Script:Clone()
			if NewScript:IsA("LocalScript") or NewScript:IsA("Script") then
				NewScript.Disabled = false
			end;
			NewScript.Parent = NewItem;
		end
		PerkManager.new(player, Module.Get(player,"Perks").Equipped[1])
		NewItem.Name = "Knife"
		NewItem.CanBeDropped = false;
		NewItem.Parent = PlayerToGive.Backpack;
		
		
		
		
		return {message = "Successfully gave knife!", exp = false}
	elseif TypeWeapon == "Gun" then
		
		
		
		
		local ItemsDB = GetSyncData("Item")
		local NewItem;
		NewItem = game.ServerStorage.Database.Default.Gun:Clone(); 
		if game.ServerStorage.Database.Item[Module.Get(PlayerToGive,"Weapons").Equipped.Gun] then
			NewItem = game.ServerStorage.Database.Item[Module.Get(PlayerToGive,"Weapons").Equipped.Gun]:Clone(); 
		end
		NewItem.Handle.CanCollide = false
		NewItem.Handle.Massless = true
		NewItem.TextureId = ItemsDB[Module.Get(PlayerToGive,"Weapons").Equipped.Gun].Image;
		for i,Script in pairs(game.ServerStorage.Gameplay.GunScripts:GetChildren()) do
			local NewScript = Script:Clone()
			if NewScript:IsA("LocalScript") or NewScript:IsA("Script") then
				NewScript.Disabled = false
			end;
			NewScript.Parent = NewItem;
		end
		NewItem.Name = "Gun"
		NewItem.CanBeDropped = false;
		NewItem.Parent = PlayerToGive.Backpack;
		local Folder = game.ServerStorage.Gameplay.GunScripts
		if Folder:FindFirstChildWhichIsA("Attachment") then
			for _, Attachments in ipairs(Folder:GetChildren()) do
				if Attachments:IsA("Attachment") then
					Attachments:Clone().Parent = PlayerToGive.Character.HumanoidRootPart
				end
			end
		end
		
		
		
		
		return {message = "Successfully gave gun!", exp = false}
	else
		return {message = "Unknown weapon type!", exp = true}
	end
end

game.ReplicatedStorage.Remotes.AdminSettings.GiveItem.OnServerInvoke = function(player, PlayerToGive, itemNameSent, Amount)
	if not CheckForAdmin(player) then
		return {message = "You’re trying, and that’s cute. But no.", exp = true }
	end
	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return {message = "Target player not found.", exp = false }
	end
	if not itemNameSent or itemNameSent == "" then
		return {message = "Please provide a valid ItemName value.", exp = false }
	end
	local amount = tonumber(Amount)
	if not amount or amount < 1 then
		return {message = "Invalid amount specified.", exp = false }
	end
	local ItemsData  = GetSyncData("Item")
	local queryLower = string.lower(tostring(itemNameSent))
	local keyToUse   = nil
	for key, itemData in pairs(ItemsData) do
		if string.lower(key) == queryLower
			or (itemData.ItemName and string.lower(itemData.ItemName) == queryLower)
		then
			keyToUse = key
			break
		end
	end
	if not keyToUse then
		return {message = "Item not found:" .. tostring(itemNameSent), exp = false }
	end
	local ItemData = ItemsData[keyToUse]
	if not ItemData.ItemName or ItemData.ItemName == "" then
		return {message = "Please provide a valid ItemName value.", exp = false }
	end
	if ItemData.Rarity == "Unique" then
		return { message = "Unique items cannot be given.", exp = false }
	end
	if ItemData.EvoBaseID then
		return {message = "Evo items cannot be given(soon..)", exp = false }
	end
	Module.GiveItem(PlayerToGive, keyToUse, amount, "Weapons")
	game.ReplicatedStorage.ItemGift:FireClient(PlayerToGive, keyToUse, "Weapons", amount)
	return {message = ("Successfully gave %s (x%d)."):format(ItemData.ItemName, amount), exp = false}
end
game.ReplicatedStorage.Remotes.AdminSettings.GiveToy.OnServerInvoke = function(player, PlayerToGive, itemNameSent, Amount)
	if not CheckForAdmin(player) then
		return {message = "You’re trying, and that’s cute. But no.", exp = true }
	end

	if typeof(PlayerToGive) == "string" then
		PlayerToGive = game.Players:FindFirstChild(PlayerToGive)
	end

	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return {message = "Target player not found.", exp = false }
	end

	if not itemNameSent or itemNameSent == "" then
		return {message = "Please provide a valid ItemName value.", exp = false }
	end

	local amount = tonumber(Amount)
	if not amount or amount < 1 then
		return {message = "Invalid amount specified.", exp = false }
	end

	local ItemsData  = GetSyncData("Toys")
	if not ItemsData then
		return {message = "Item data not found (Toys Sync is nil).", exp = false }
	end

	local queryLower = string.lower(tostring(itemNameSent))
	local keyToUse   = nil
	for key, itemData in pairs(ItemsData) do
		if string.lower(key) == queryLower
			or (itemData.ItemName and string.lower(itemData.ItemName) == queryLower)
		then
			keyToUse = key
			break
		end
	end

	if not keyToUse then
		return {message = "Item not found: " .. tostring(itemNameSent), exp = false }
	end

	local ItemData = ItemsData[keyToUse]
	local displayName = ItemData.ItemName or ItemData.Name
	if not displayName or displayName == "" then
		return {message = "Please provide a valid ItemName value.", exp = false }
	end


	Module.GiveOther(PlayerToGive, keyToUse, "Toys")
	game.ReplicatedStorage.ItemGift:FireClient(PlayerToGive, keyToUse, "Toys")

	local displayName = ItemData.ItemName or ItemData.Name or tostring(keyToUse)
	return {message = ("Successfully gave %s (x%d)."):format(displayName, amount), exp = false}
end


-------------- PERK SYSTEM ----------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local StealthTable = {}

local function Fade(Player, In)
	local Frames = 10
	local Step = 1 / Frames
	local Character = Player.Character
	if not Character then return end
	local DisplayKnifeRef = Character:FindFirstChild("DisplayRefKnife")
	local DisplayGunRef = Character:FindFirstChild("DisplayRefGun")
	local DisplayKnife = DisplayKnifeRef and DisplayKnifeRef.Value
	local DisplayGun = DisplayGunRef and DisplayGunRef.Value
	local function GetFadableParts(model)
		local parts = {}
		if model:IsA("BasePart") or model:IsA("MeshPart") or model:IsA("Decal") or model:IsA("Texture") then
			table.insert(parts, model)
		end
		for _, part in ipairs(model:GetDescendants()) do
			if (part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("Decal") or part:IsA("Texture")) and part.Name ~= "HumanoidRootPart" then
				table.insert(parts, part)
			end
		end
		return parts
	end
	local function ToggleEffects(model, enabled)
		for _, v in ipairs(model:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Beam") then
				v.Enabled = enabled
			end
		end
	end
	local AllParts = {}
	for _, part in ipairs(GetFadableParts(Character)) do table.insert(AllParts, part) end
	if DisplayKnife and DisplayKnife:IsDescendantOf(workspace) then
		for _, part in ipairs(GetFadableParts(DisplayKnife)) do table.insert(AllParts, part) end
	end
	if DisplayGun and DisplayGun:IsDescendantOf(workspace) then
		for _, part in ipairs(GetFadableParts(DisplayGun)) do table.insert(AllParts, part) end
	end
	ToggleEffects(Character, not In)
	if DisplayKnife then ToggleEffects(DisplayKnife, not In) end
	if DisplayGun then ToggleEffects(DisplayGun, not In) end
	for i = 1, Frames do
		if (StealthTable[Player.Name] == true and In == true) or In == false then
			for _, part in ipairs(AllParts) do
				local newTransparency = part.Transparency
				if In then
					newTransparency = math.clamp(part.Transparency + Step, 0, 1)
				else
					newTransparency = math.clamp(part.Transparency - Step, 0, 1)
				end
				part.Transparency = newTransparency
			end
			RunService.Heartbeat:Wait()
		else
			break
		end
	end
end

Remotes.Gameplay.Stealth.OnServerEvent:Connect(function(Player, Activate)
	StealthTable[Player.Name] = Activate;
	Fade(Player,Activate);
end)
local RollTable = {}
local Chances = {
	Common = 100,
	Uncommon = 70,
	Rare = 30,
	Legendary = 20
}

local PossibleRewards = {
	Common = {"Shaded", "Lovely", "Leaf"},
	Uncommon = {"HighTech", "Graffiti"},
	Rare = {"DeepSea"},
	Legendary = {"Midnight", "Splash_G",}
}

local function GetRandomReward()
	if #RollTable == 0 then
		for ObjectName, Chance in pairs(Chances) do
			for i = 1, Chance do
				table.insert(RollTable, ObjectName)
			end
		end
	end

	local ItemType = RollTable[math.random(1, #RollTable)]
	local RandomItem = PossibleRewards[ItemType][math.random(1, #PossibleRewards[ItemType])]

	return RandomItem
end

local FakeGunData = {}

local function FakeGun(Player)
	FakeGunData[Player.Name] = FakeGunData[Player.Name] or {}

	local Knife
	for _, Obj in pairs(Player.Backpack:GetChildren()) do
		if Obj:FindFirstChild("KnifeServer") then
			Knife = Obj
			break
		end
	end

	if not Knife then
		for _, Obj in pairs(Player.Character:GetChildren()) do
			if Obj:FindFirstChild("KnifeServer") then
				Knife = Obj
				break
			end
		end
	end

	if not Knife then return end

	local ItemsDB = GetSyncData("Item")
	local GunName = DataTable[Player.Name].Weapons.Equipped.Gun
	local Gun = game.ServerStorage.Database.Item:FindFirstChild(GunName)
	if not Gun then return end

	local FakeGunTool = Gun:Clone()
	FakeGunTool.Name = ItemsDB[GunName].ItemName
	FakeGunTool.TextureId = ItemsDB[GunName].Image

	local hasValue = false
	for _, obj in pairs(Gun.Handle:GetChildren()) do
		if obj:IsA("BoolValue") then
			obj:Clone().Parent = FakeGunTool
			hasValue = true
		end
	end

	if hasValue then
		local anim = game.ReplicatedStorage.Resources.Perks.FakeGun.FakeGunAnimation:Clone()
		anim.Parent = FakeGunTool
	end

	local function ScanEffects(part)
		for _, obj in pairs(part:GetChildren()) do
			if pcall(function() return obj.Enabled end) then
				obj.Enabled = false
			end
			ScanEffects(obj)
		end
	end
	ScanEffects(FakeGunTool.Handle)
	FakeGunTool.Parent = Player.Character
	Knife.Parent = Player.Backpack

	table.insert(FakeGunData[Player.Name], FakeGunTool)
end


Remotes.Gameplay.FakeGun.OnServerEvent:Connect(function(Player)
	if Module.CheckForItem(Player, "FakeGun", "Perks") then
		FakeGun(Player)
	end
end)


--task.spawn(function()
--	while true do
--		for _, player in pairs(game:GetService("Players"):GetPlayers()) do
--			local data = DataTable[player.Name]
--			if data and data.TimeRewards then
--				for rewardId, rewardState in pairs(data.TimeRewards) do
--					local rewardInfo = require(ReplicatedStorage.Database.Sync).TimeRewards[rewardId]
--					if not rewardState.Claimed then
--						rewardState.Progress += 1
--						if rewardState.Progress > rewardInfo.RequiredTime then
--							rewardState.Progress = rewardInfo.RequiredTime
--						end
--					end
--				end
--				game.ReplicatedStorage.Remotes.Gameplay.TimeRewardsUpdate:FireClient(player, data.TimeRewards)
--				Module.SaveData(player)
--			end
--		end
--		task.wait(1)
--	end
--end)

















local ReplicatedStorage = game:GetService("ReplicatedStorage")
local QuestRemote = ReplicatedStorage.Remotes.Gameplay:WaitForChild("QuestRemote")
local UpdateQuestProgress = ReplicatedStorage.Remotes.Gameplay:WaitForChild("UpdateQuestProgress")

local QuestGoals = {
	Coins = {min = 20, max = 50},
	Gems = {min = 5, max = 15},
	Time = {min = 600, max = 1800},
	Murderer = {min = 1, max = 5},
	Sheriff = {min = 1, max = 5},
	Hero = {min = 1, max = 5},
	Innocent = {min = 2, max = 6},
}

local function getRandomGoal(type)
	local conf = QuestGoals[type]
	if not conf then return 1 end
	return math.random(conf.min, conf.max)
end

local function generateQuest(type)
	local isSpecial = type == "Murderer" or type == "Sheriff" or type == "Hero"
	local time = isSpecial and math.random(1800, 3600) or math.random(600, 1800)
	local value = getRandomGoal(type)

	local questTextTemplates = {
		Coins = function(v) return "Collect " .. v .. " coins" end,
		Gems = function(v) return "Collect " .. v .. " gems" end,
		Time = function(v) return "Play for " .. math.floor(v / 60) .. " minutes" end,
		Murderer = function(v) return "Eliminate " .. v .. " players as Murderer" end,
		Sheriff = function(v) return "Eliminate " .. v .. " Murderers as Sheriff" end,
		Hero = function(v) return "Save the day " .. v .. " times as Hero" end,
		Innocent = function(v) return "Survive " .. v .. " rounds as Innocent" end,
	}

	local questText = (questTextTemplates[type] and questTextTemplates[type](value)) or ("Complete task: " .. type)

	return {
		Type = type,
		QuestText = questText,
		Value = value,
		Current = 0,
		Reward = tostring(value * 5) .. " XP",
		Time = time,
		StartTime = os.time()
	}
end

local function refreshQuests(player)
	local plrData = DataTable[player.Name]
	if not plrData then return end
	plrData.Quests = plrData.Quests or {}

	local questTypes = {"Coins", "Gems", "Time", "Murderer", "Sheriff", "Hero", "Innocent"}
	for _, questType in ipairs(questTypes) do
		if not plrData.Quests[questType] then
			plrData.Quests[questType] = generateQuest(questType)
		end
	end
	Module.SaveData(player)
end

local function cleanupExpiredQuests(player)
	local plrData = DataTable[player.Name]
	if not plrData or not plrData.Quests then return end
	local now = os.time()
	for questType, data in pairs(plrData.Quests) do
		if now - (data.StartTime or now) >= data.Time then
			plrData.Quests[questType] = nil
		end
	end
end

QuestRemote.OnServerInvoke = function(player)
	cleanupExpiredQuests(player)
	refreshQuests(player)

	local plrData = DataTable[player.Name]
	if not plrData then return {} end

	local result = {}
	for _, quest in pairs(plrData.Quests) do
		table.insert(result, {
			Type = quest.Type,
			QuestText = quest.QuestText,
			Value = quest.Value,
			Reward = quest.Reward,
			Time = quest.Time - (os.time() - quest.StartTime),
			Current = quest.Current
		})
	end
	return result
end

UpdateQuestProgress.OnServerEvent:Connect(function(player, questType, amount)
	local playerData = DataTable[player.Name]
	if not playerData or not playerData.Quests then return end
	local quest = playerData.Quests[questType]
	if not quest then return end

	quest.Current = math.clamp(amount, 0, quest.Value)

	if quest.Current >= quest.Value then
		local rewardType, rewardValue = string.match(quest.Reward, "(%w+)%s*(.+)")
		rewardValue = tonumber(rewardValue) or rewardValue

		-- Награды
		if rewardType == "XP" then
			-- Rewards.GiveXP(player, rewardValue)
		elseif rewardType == "Coins" then
			-- Rewards.GiveCoins(player, rewardValue)
		elseif rewardType == "Weapon" then
			-- Rewards.GiveWeapon(player, rewardValue)
		elseif rewardType == "Item" then
			-- Rewards.GiveItem(player, rewardValue)
		end

		playerData.Quests[questType] = nil
		Module.SaveData(player)
	end
end)

-------------- EXTRA ----------------
Module.Creators= {
	[9823279791] = true,
	[4614856075] = true,
	[3223673484] = true,
	[5628042924] = true
}

Module.PlayerIsCreator = function(Player)
	local success, hasPass = pcall(function()
		return false
	end)
	if success and hasPass then
		Module.Creators[Player.UserId] = true
	end
end

game.ReplicatedStorage.Remotes.Extras.GetCreatorStatus.OnServerInvoke = function(Player)
	return false, {}
end

-------------------------------------

local function MaterialsOwnedAmount(PlayerName: string, MaterialType: string)
	if (PlayerName and DataTable[PlayerName] and DataTable[PlayerName].Materials) and DataTable[PlayerName].Materials.Owned[MaterialType] then
		return DataTable[PlayerName].Materials.Owned[MaterialType]
	end
	return 0
end

local function GiveTierReward(Player: Player, TierData: table)
	if (Player.Name) and DataTable[Player.Name] then
		if TierData.ItemType == "Weapons" or TierData.ItemType == "Materials" or TierData.ItemType == "Pets" then
			Module.GiveItem(Player, TierData.ItemID, 1, TierData.ItemType)
		else
			Module.GiveOther(Player, TierData.ItemID, TierData.ItemType)
		end
	end
end
--[[local EventInfoService1 = require(ReplicatedStorage.SharedServices.EventInfoService1)
local EventRemotes = EventInfoService1:GetEventRemotes()
local CurrentEvent = EventInfoService1:GetEventTitle()
if EventInfoService1:IsEventActive() then
	EventInfoService1:GetCurrentEvent().Remotes.ClaimTrackReward.OnServerEvent:Connect(function(Player: Player, TierData: table)
		if DataTable[Player.Name][CurrentEvent].Claimed[TierData.Index] == true then return end
		local OwnedHearts = DataTable[Player.Name]["Materials"].Owned.Hearts2023
		local reward = EventInfoService1:GetCurrentEvent().RewardTracks.BattlePass.Rewards[TierData.Index]
		if not reward then return end

		if OwnedHearts < reward.Cost then
			return
		end
		
		DataTable[Player.Name][CurrentEvent] = DataTable[Player.Name][CurrentEvent] or {}
		DataTable[Player.Name][CurrentEvent].Claimed = DataTable[Player.Name][CurrentEvent].Claimed or {}
		if TierData.ItemType == "Weapons" or TierData.ItemType == "Materials" or TierData.ItemType == "Pets" then
			Module.GiveItem(Player, TierData.ItemID, 1, TierData.ItemType)
			ReplicatedStorage.ItemGift:FireClient(Player, TierData.ItemID, TierData.ItemType)
		else
			Module.GiveOther(Player, TierData.ItemID, TierData.ItemType)
			ReplicatedStorage.ItemGift:FireClient(Player, TierData.ItemID, TierData.ItemType)
		end

		DataTable[Player.Name][CurrentEvent].Claimed[TierData.Index] = true

		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, CurrentEvent, DataTable[Player.Name][CurrentEvent])
	end)
end

local ActiveEventManager= require(script.ActiveEventManager)
local EventHandlers = script.EventHandlers

require(script.Parent.Sync)
for i,v in EventHandlers:GetChildren() do
	if v:IsA("Folder") and v:GetAttribute("Enabled") then
		if v:FindFirstChild("MainHandler") then
			task.spawn(function()
				require(v.MainHandler)(Module)
			end)
		end
	end
end]]--

Module.Ready = true;
return Module;