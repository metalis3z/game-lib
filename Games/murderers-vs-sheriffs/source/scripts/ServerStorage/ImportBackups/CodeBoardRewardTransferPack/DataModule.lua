local Module = {};
local Admins = {"promisednothing"} -- put ur user to have access to admin panel
local d12 = script.Parent.DataModule
local GiveRewards = true;
local DataStoreService = game:GetService("DataStoreService")
local UtilityService= require(game.ReplicatedStorage.SharedServices.UtilityService)

local DataTable = {};
local Config = require(game.ReplicatedStorage.Constans)
local OUTFITS_GAMEPASS_ID = Config.Gamepasses.Outfits
local CUSTOM_OUTFIT_GAMEPASS_ID = Config.Gamepasses.CustomOutfits
function Module.GetDataTable()
	return DataTable;
end
function Module.ChangeOutfit(Player, Outfit)
	if not (DataTable[Player.Name] and DataTable[Player.Name].Gamepasses and DataTable[Player.Name].Gamepasses.Outfits) then
		return
	end
	local OutfitsDB = require(game.ReplicatedStorage.Database.Sync.Outfits)
	local EquippedDataOutfit = Outfit or DataTable[Player.Name].Outfits.Equipped[1]

	if EquippedDataOutfit == nil then return end 
	local OutfitData = OutfitsDB[EquippedDataOutfit]
	if not OutfitData or not OutfitData.UserId then return end 

	local PlayerHumanoid = game.Workspace:FindFirstChild(Player.Name) and game.Workspace[Player.Name]:FindFirstChild("Humanoid")
	if not PlayerHumanoid then return end

	local Appearance = game.Players:GetHumanoidDescriptionFromUserId(OutfitData.UserId)
	PlayerHumanoid:ApplyDescription(Appearance)
	_G.WeldWeapons(Player)
	_G.WeldRadio(Player)
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
	["FollowRewardsVxReapz"] = false;
	["FollowRewardsuh_myer"] = false;
	["XboxKnife"] = false;
	["RadioSongs"] = {};
	["ItemPacks"] = {};
	["RedeemedCodes"] = {};
	["Uniques"] = {};
	["Quests"] = {};
	["DeathEffect"] = true;
	["Halloween2025"] = {
		["CurrentTier"] = 1,
		["ClaimedRewards"] = {},
		["FinalRewardClaimAmount"] = 0,
		["LeaderboardPoints"] = 0,
		["LiveClaimed"] = false
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
			"CommonEgg2025","RareEgg2025","IceCream2025","Flamingo2025","VolleyBall2025","Pumpkin2025","CandyBucket2025","Bell2025",
			"AlienPlushie","Candle2025","Santa2025"}; -- some fixes
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
			BeachBalls2025 = math.huge,
			Candies2025 = math.huge
		};
	};
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
		["DoubleEffect"] = false,
		["Outfits"] = false,
		["CustomOutfits"] = false
	}
};

local LPA = {}
local LevelCap = 82500 -- level 100
local ServerID = game.JobId;



Module.GetLevel = function(XP)
	if XP ~= nil then
		return math.floor((25 + math.sqrt(625 + 300 * XP))/50);
	else
		return 1;
	end;
end 















function game.ReplicatedStorage.Remotes.Extras.AmElite.OnServerInvoke(Player) 
	return PlayerIsElite(Player) 
end;
_G.CheckElite = PlayerIsElite;
_G.CheckRadio = function (Player)
	local HasRadio = (_G.RadioPlayers) and (_G.RadioPlayers[Player.Name] or _G.RadioPlayers[Player.UserId]);
	local serverSettings = _G.ServerSettings or {}
	local CanUse = (not serverSettings.DisguisesMode);
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
	elseif IsPurchased and gamepassid == OUTFITS_GAMEPASS_ID then
		DataTable[Player.Name].Gamepasses.Outfits = true
		Player:SetAttribute("Outfits", true)
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Gamepasses", DataTable[Player.Name].Gamepasses)
		task.spawn(function()
			Module.SaveData(Player);
		end)
	elseif IsPurchased and gamepassid == CUSTOM_OUTFIT_GAMEPASS_ID then
		DataTable[Player.Name].Gamepasses.CustomOutfits = true
		Player:SetAttribute("CustomOutfits", true)
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Gamepasses", DataTable[Player.Name].Gamepasses)
		task.spawn(function()
			Module.SaveData(Player);
		end)
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
			return Enum.ProductPurchaseDecision.PurchaseGranted	
		end
		if ReceiptInfo.ProductId == Config.Gamepasses.Gameplay.Sheriff then
			Purchases[Key] = true;
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

		local Handle = EquippedWeapon.Handle:Clone();
		EquippedWeapon:Destroy();

		Handle.CanCollide = false;
		Handle.Massless = false
		Handle.CFrame = Player.Character.UpperTorso.CFrame;

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


		if not UseRadio  then 	
			DefaultPosition = (WeaponPosition and dOffset(WeaponPosition)) or DefaultPosition;
		elseif WeaponType == "Knife" then
			DefaultPosition = (RadioOffset and dOffset(RadioOffset)) or CFrame.new(-1.2,-1.3,0.25);
			DefaultRotation = CFrame.Angles(math.rad(-60),0,math.rad(180));
			DefaultRotation = 
				(RadioRotation and dAngles(RadioRotation)	) 
				or 	(WeaponRotation and DefaultRotation * dAngles(WeaponRotation)	) 	
				or 	DefaultRotation;
		end;
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
local OldProfiles = game:GetService("DataStoreService"):GetDataStore("Old");
local Profiles = game:GetService("DataStoreService"):GetDataStore("NewProfiles_E1");
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

local ProfileStatusNames = {"Innocents", "Sheriffs", "Murderer"}
local ProfileStatusAliases = {
	Innocents = "Survivals",
	Sheriffs = "Victories",
	Murderer = "Eliminations",
}
local ProfileDataLoading = {}

local function ensureProfileStats(data)
	if not data then return end
	if type(data.Status) ~= "table" then
		data.Status = deepcopy(DataDefaults.Status)
	end
	for _, statName in ipairs(ProfileStatusNames) do
		data.Status[statName] = tonumber(data.Status[statName]) or 0
	end
	for statusName, aliasName in pairs(ProfileStatusAliases) do
		data[aliasName] = data.Status[statusName]
	end
end

local function syncProfileStats(Player)
	local data = Player and DataTable[Player.Name]
	if not data then return end
	ensureProfileStats(data)
	game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Status", data.Status)
	for _, aliasName in pairs(ProfileStatusAliases) do
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, aliasName, data[aliasName])
	end
end


local function getOrLoadProfileData(plr)
	if not plr then return nil end
	local data = DataTable[plr.Name]
	if data == nil and not ProfileDataLoading[plr] then
		ProfileDataLoading[plr] = true
		local ok, err = pcall(function()
			Module.SetData(plr)
		end)
		ProfileDataLoading[plr] = nil
		if not ok then
			warn("Failed to load profile data for " .. plr.Name .. ": " .. tostring(err))
		end
		data = DataTable[plr.Name]
	end
	ensureProfileStats(data)
	return data
end

game.ReplicatedStorage.Remotes.Inventory.GetProfileData.OnServerInvoke = function(plr)
	return getOrLoadProfileData(plr)
end
local function fixOldFakeStats(Player)
	local data = DataTable[Player.Name]
	if not data then return end

	local changed = false
	if type(data.Status) ~= "table" then
		data.Status = deepcopy(DataDefaults.Status)
		changed = true
	end

	for _, statName in ipairs({"Innocents", "Sheriffs", "Murderer"}) do
		local value = tonumber(data.Status[statName]) or 0
		if value >= 999999999 then
			data.Status[statName] = 0
			changed = true
		elseif data.Status[statName] == nil then
			data.Status[statName] = 0
			changed = true
		end
	end

	if changed then
		game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, "Status", data.Status)
		task.spawn(function()
			Module.SaveData(Player)
		end)
	end
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
		DataTable[Player.Name]["Outfits"] = deepcopy(DataDefaults.Outfits)
	end
	if not DataTable[Player.Name].Gamepasses then
		DataTable[Player.Name].Gamepasses = deepcopy(DataDefaults.Gamepasses)
	end
	if DataTable[Player.Name].Gamepasses.Outfits == nil then
		DataTable[Player.Name].Gamepasses.Outfits = false
	end
	if DataTable[Player.Name].Gamepasses.CustomOutfits == nil then
		DataTable[Player.Name].Gamepasses.CustomOutfits = false
	end
	local ownsOutfitsPass = false
	local ownsOutfitsSuccess = pcall(function()
		ownsOutfitsPass = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId, OUTFITS_GAMEPASS_ID)
	end)
	if ownsOutfitsSuccess and ownsOutfitsPass then
		DataTable[Player.Name].Gamepasses.Outfits = true
	end
	local ownsCustomOutfitPass = false
	local ownsCustomOutfitSuccess = pcall(function()
		ownsCustomOutfitPass = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId, CUSTOM_OUTFIT_GAMEPASS_ID)
	end)
	if ownsCustomOutfitSuccess and ownsCustomOutfitPass then
		DataTable[Player.Name].Gamepasses.CustomOutfits = true
	end
	Player:SetAttribute("Outfits", DataTable[Player.Name].Gamepasses.Outfits == true)
	Player:SetAttribute("CustomOutfits", DataTable[Player.Name].Gamepasses.CustomOutfits == true)
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

	fixOldFakeStats(Player)
	syncProfileStats(Player) -- profile stat aliases
	
	
	
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
				DataTable[Player.Name]["Weapons"].Owned[ItemID] = math.random(9999)
			end
			if ItemID == "DefaultKnife" or ItemID == "DefaultGun" or ItemID == "Dartbringer" or ItemID == "SharkSeeker" then
				DataTable[Player.Name]["Weapons"].Owned[ItemID] = 1
			end
			if ItemID == "Reaver" or
				ItemID == "Reaver_Legendary" or
				ItemID == "Reaver_Godly" or
				ItemID == "Reaver_Ancient" or
				ItemID == "IceHammer" or
				ItemID == "IceHammer_Legendary" or
				ItemID == "IceHammer_Godly" or
				ItemID == "IceHammer_Ancient" or
				ItemID == "Synthwave" or
				ItemID == "Synthwave_Legendary" or
				ItemID == "Synthwave_Godly" or
				ItemID == "Synthwave_Ancient" or
				ItemID == "SynthwaveChroma" or
				ItemID == "Synthwave_LegendaryChroma" or
				ItemID == "Synthwave_GodlyChroma" or
				ItemID == "Synthwave_AncientChroma" or
				ItemID == "Partyblade" or
				ItemID == "Gingerscythe" or
				ItemID == "Gingerscythe_Legendary" or
				ItemID == "Gingerscythe_Godly" or
				ItemID == "Gingerscythe_Ancient" or
				ItemID == "Gingerscope_Purple" or
				ItemID == "Gingerscythe_Purple" or
				ItemID == "ZER0Scythe_K" or
				ItemID == "TravelerAxeBlue" or
				ItemID == "Umbrella_K_2025_F" or
				ItemID == "SlouseClown" or
				ItemID == "SorryChroma" or
				ItemID == "BanHammer" or
				ItemID == "AmethystGun_25" or
				ItemID == "TravelersSniper" or
				ItemID == "XenoKnife_Blue" or
				ItemID == "XenoKnife_Bronze" or
				ItemID == "XenoKnife_Silver" or
				ItemID == "XenoKnife_Gold" or
				ItemID == "uh_myerSCOPE" or
				ItemID == "Matrixscope" or
				ItemID == "FairyAxe" or
				ItemID == "BlackLuger" or
				ItemID == "FlowerwoodKnife_Pink" or
				ItemID == "FlowerwoodGun_Pink" or
				ItemID == "ChocoBunny" or
				ItemID == "Flamingo_K" or
				ItemID == "Archangel" or
				ItemID == "SlouseClownGun" then
				DataTable[Player.Name]["Weapons"].Owned[ItemID] = nil
			end
			if Data.Rarity == "Unique" and DataTable[Player.Name].Weapons.Owned[ItemID] then
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
			if Data.Evo and ItemID ~= "Sorry" and ItemID ~= "SynthwaveChroma" then
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
			if unique.BaseItem ~= "Dartbringer" and unique.BaseItem ~= "SharkSeeker" and unique.BaseItem ~= "Reaver" and unique.BaseItem ~= "Gingerscythe" and unique.BaseItem ~= "IceHammer" then
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
		repeat Player:LoadCharacter(); wait();
		until Player.Character ~= nil;
	end
	game.ReplicatedStorage.PlayerAdded:FireAllClients(Player)
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

	if DataTable[Player.Name]["GroupRewards"] == false then
		if Config.Group.Enabled then
			if Player:IsInGroup(Config.Group.GroupID) then
				Module.GiveItem(Player,"BlackGingerscythe_Godly",1,"Weapons")
				game.ReplicatedStorage.ItemGift:FireClient(Player,"CelestialChroma","Weapons");
			end
		else
			Config.Group.GroupID = 599488580;
			if game:GetService("RunService"):IsStudio() then
				Module.GiveItem(Player,"BlackGingerscythe_Godly",1,"Weapons")
				game.ReplicatedStorage.ItemGift:FireClient(Player,"CelestialChroma","Weapons");
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

Module.GiveStatus = function(Player, Status)
	if not Player or not DataTable[Player.Name] then return end
	ensureProfileStats(DataTable[Player.Name])
	DataTable[Player.Name].Status[Status] = (tonumber(DataTable[Player.Name].Status[Status]) or 0) + 1
	syncProfileStats(Player)
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
	if Type == "Outfits" then
		local gamepasses = DataTable[Player.Name].Gamepasses
		if not (gamepasses and gamepasses.Outfits) then
			return
		end
		if ItemName == "Custom_Outfit" and not gamepasses.CustomOutfits then
			return
		end
	end
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
			if Type == "Outfits" and not _G.Outfits[Player.UserId] then
				if _G.OutfitsDisabled then
					return
				end
				local OutfitsDB = require(game.ReplicatedStorage.Database.Sync.Outfits)
				local EquippedDataOutfit = DataTable[Player.Name].Outfits.Equipped[1]
				local EquippedOutfit = OutfitsDB[EquippedDataOutfit].UserId or 1
				local PlayerHumanoid = game.Workspace:WaitForChild(Player.Name):WaitForChild("Humanoid")
				local Appearance = game.Players:GetHumanoidDescriptionFromUserId(EquippedOutfit)
				PlayerHumanoid:ApplyDescription(Appearance)
				_G.WeldWeapons(Player)
				_G.WeldRadio(Player)
			end
			if Type == "Radios" and _G.CheckRadio(Player) then
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
			if ItemData.Rarity == Rarity then
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


Module.BuyItemNew = function (Player, ItemID, Currency)
	local NewShopData = GetSyncData("NewShop")
	local ShopItemData = NewShopData[ItemID]

	if not ShopItemData then
		warn("Item not found in Shop:", ItemID)
		return false
	end

	if not DataTable[Player.Name] then
		return false
	end

	local ItemType = ShopItemData.Type
	local Price = ShopItemData.Price[Currency]

	if not Price then
		warn("Currency not valid for this item:", Currency)
		return false
	end

	print(ItemID)

	if Currency == "Robux" then
		local MarketplaceService = game:GetService("MarketplaceService")

		if ShopItemData.GamePassId and ShopItemData.DevProductId then
			local success, hasPass = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(Player.UserId, ShopItemData.GamePassId)
			end)

			if success and hasPass then
				PendingPurchases[ShopItemData.DevProductId] = {
					ItemID = ItemID,
					ItemType = ItemType,
					RewardItems = ShopItemData.RewardItems
				}

				MarketplaceService:PromptProductPurchase(Player, ShopItemData.DevProductId)
				return "DevProduct"
			else
				PendingPurchases[ShopItemData.GamePassId] = {
					ItemID = ItemID,
					ItemType = ItemType,
					RewardItems = ShopItemData.RewardItems
				}

				MarketplaceService:PromptGamePassPurchase(Player, ShopItemData.GamePassId)
				return "GamePass"
			end

		elseif ShopItemData.GamePassId then
			local success, hasPass = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(Player.UserId, ShopItemData.GamePassId)
			end)

			if success and hasPass then
				warn("Player already owns this GamePass:", ItemID)
				return false
			end

			PendingPurchases[ShopItemData.GamePassId] = {
				ItemID = ItemID,
				ItemType = ItemType,
				RewardItems = ShopItemData.RewardItems
			}

			MarketplaceService:PromptGamePassPurchase(Player, ShopItemData.GamePassId)
			return "GamePass"

		elseif ShopItemData.DevProductId then
			PendingPurchases[ShopItemData.DevProductId] = {
				ItemID = ItemID,
				ItemType = ItemType,
				RewardItems = ShopItemData.RewardItems
			}

			MarketplaceService:PromptProductPurchase(Player, ShopItemData.DevProductId)
			return "DevProduct"
		else
			return false
		end
	end

	if (ItemID == "CandyExchange" or ItemID == "CoinExchange") and 
		DataTable[Player.Name].Materials.Owned[Currency] and 
		DataTable[Player.Name].Materials.Owned[Currency] >= 100 then
		DataTable[Player.Name].Materials.Owned.Coins = (DataTable[Player.Name].Materials.Owned.Coins or 0) + 100
		DataTable[Player.Name].Materials.Owned[Currency] -= 100
		game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, "Materials", "Coins", DataTable[Player.Name].Materials.Owned.Coins)
		game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, "Materials", Currency, DataTable[Player.Name].Materials.Owned[Currency])
		game.ReplicatedStorage.ItemGift:FireClient(Player, "CoinVisual", "Materials", 100)
		return true
	end

	if DataTable[Player.Name].Materials.Owned[Currency] and 
		DataTable[Player.Name].Materials.Owned[Currency] >= Price then
		DataTable[Player.Name].Materials.Owned[Currency] -= Price
		game.ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, "Materials", Currency, DataTable[Player.Name].Materials.Owned[Currency])
	else
		return false
	end

	local OwnedType = ItemType
	if OwnedType == "Weapons" or OwnedType == "Pets" or OwnedType == "Materials" then
		Module.GiveItem(Player, ItemID, 1, OwnedType)
	else
		Module.GiveOther(Player, ItemID, OwnedType)
	end

	game.ReplicatedStorage.ItemGift:FireClient(Player, ItemID, OwnedType)
	return true
end

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


game.ReplicatedStorage.Remotes.Shop.BuyItem.OnServerInvoke = function (Player, ItemID, ItemType, Currency)
	Module.BuyItem(Player, ItemID, ItemType, Currency)
end



Module.OpenCrate = function(Player, CrateName, BoxType: "MysteryBox" | "Egg", Currency)
	local BoxData = GetSyncData(BoxType)[CrateName]
	local ShopBoxData = GetSyncData("Shop")[BoxData.BoxType][CrateName]
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
	for _, RarityChances in pairs(BoxRarityChancess) do
		TotalRarityChancess = TotalRarityChancess + RarityChances
	end
	local randomRarityChances = math.random() * TotalRarityChancess
	local selectedRarity
	for RarityID, RarityChances in pairs(BoxRarityChancess) do
		combWeight = combWeight + RarityChances
		if randomRarityChances <= combWeight then
			selectedRarity = RarityID
			break
		end
	end
	local SelectedItem = SortedRarityContent[selectedRarity][math.random(1, #SortedRarityContent[selectedRarity])]

	task.delay(6.1 - Player:GetNetworkPing(), function()
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
		DoubleEffect = data.Gamepasses.DoubleEffect
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












Module.GiveToys = function(Player,RequiredToy)
	if not Player:FindFirstChild("Backpack") then return; end;
	if Player.Backpack:FindFirstChild(RequiredToy) then return end
	local FakeTool = Instance.new("Tool",Player.Backpack);
	FakeTool.Name = "Loading Toys...";
	for _,ToyName in pairs(DataTable[Player.Name].Toys.Owned) do
		if tostring(ToyName) == tostring(RequiredToy) then
			local NewToy = Instance.new("Tool");
			pcall(function() NewToy = game.ServerStorage.Database.Toys:FindFirstChild(ToyName):Clone() end);
			NewToy.CanBeDropped = false;
			NewToy.Parent = Player.Backpack;
			wait()
			NewToy.Parent = Player.Character
		end
	end
	FakeTool:Destroy();
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
		local Level = Module.GetLevel(XP)
		local Prestige = PlayerData.Prestige or 0
		local Elite = PlayerIsElite(game:GetService("Players"):FindFirstChild(targetPlayerName))
		return Level, Prestige, Elite, XP
	end
end



game.ReplicatedStorage.Remotes.Inventory.Equip.OnServerEvent:connect(function(Player,ItemName,Type)
	Module.Equip(Player,ItemName,Type);
end)
game.ReplicatedStorage.Remotes.Inventory.Unequip.OnServerEvent:connect(function(Player,ItemName,Type)
	Module.Unequip(Player,ItemName,Type);
end)
game.ReplicatedStorage.Remotes.Inventory.ChangeCustomOutfitId.OnServerInvoke = function(Player, Username)
	local gamepasses = DataTable[Player.Name].Gamepasses
	if not (gamepasses and gamepasses.Outfits) then
		return "Outfits gamepass required"
	end
	if not gamepasses.CustomOutfits then
		return "Custom outfit gamepass required"
	end
	local success, result = pcall(function()
		DataTable[Player.Name]["Outfits"]["Equipped"] = { Username }

		local ItemsDB = GetSyncData("Item")
		local OutfitsDB = GetSyncData("Outfits")

		local char = Player.Character
		if char then
			if char:FindFirstChild("KnifeDisplay") then char.KnifeDisplay:Destroy() end
			if char:FindFirstChild("GunDisplay") then char.GunDisplay:Destroy() end
		end

		local PlayerHumanoid = workspace:WaitForChild(Player.Name):WaitForChild("Humanoid")
		local Appearance

		if Username ~= 1 then
			local userId = game.Players:GetUserIdFromNameAsync(Username)
			DataTable[Player.Name]["Outfits"]["OutfitId"] = userId
			Appearance = game.Players:GetHumanoidDescriptionFromUserId(userId)
		else
			DataTable[Player.Name]["Outfits"]["OutfitId"] = 0
			local EquippedOutfit = DataTable[Player.Name]["Outfits"]["Equipped"]
			if EquippedOutfit and EquippedOutfit ~= "" and OutfitsDB[EquippedOutfit[1]] then
				Appearance = game.Players:GetHumanoidDescriptionFromUserId(OutfitsDB[EquippedOutfit[1]]["UserId"])
			else
				Appearance = game.Players:GetHumanoidDescriptionFromUserId(Player.UserId)
			end
		end

		if Appearance then
			PlayerHumanoid:ApplyDescription(Appearance)
		end

		Module.SaveData(Player)

		return DataTable[Player.Name]["Outfits"]["OutfitId"]
	end)

	_G.WeldWeapons(Player)

	if success then
		return result
	else
		warn("Error in ChangeCustomOutfitId:", result)
		return "Invalid username"
	end
end

function game.ReplicatedStorage.Remotes.Shop.OpenCrate.OnServerInvoke(Player,Box,BoxType,Currency)
	return Module.OpenCrate(Player,Box,BoxType,Currency);
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

game.ReplicatedStorage.Remotes.Misc.GetPlayerProfile.OnServerInvoke = function (Player, PlayerName)
	local plrReq:Player = game:GetService("Players"):FindFirstChild(PlayerName);
	if not plrReq then return end
	local Data = getOrLoadProfileData(plrReq) or {}
	pcall(function()
		Data.Elite = (plrReq:GetAttribute("Elite") ~= nil)
		Data.Level = Module.GetLevel(Data.XP);
		Data.Eliminations = Data.Eliminations or 0
		Data.Victories = Data.Victories or 0
		Data.Survivals = Data.Survivals or 0
	end)
	return Data
end
game.ReplicatedStorage.Remotes.Inventory.RenamePet.OnServerEvent:connect(function(Player,PetName)
	if string.len(PetName)<=20 then
		DataTable[Player.Name].PetName = PetName;
		_G.GivePet(Player)
	end;
end)


-- uh_myer
game.ReplicatedStorage.Remotes.Extras.FollowRewardsTwo.OnServerEvent:Connect(function(Player)

	if DataTable[Player.Name]["FollowRewardsuh_myer"] == true then
		return
	end

	local HttpService = game:GetService("HttpService")
	local Follower = Player.UserId
	local Followed = 4880953662
	local Table = "https://friends.roproxy.com/v1/users/"..Follower.."/followings?limit=100&sortOrder=Desc"

	local response = HttpService:RequestAsync({
		Url = Table,
		Method = "GET"
	});

	if response.Success then
		local TableBody = HttpService:JSONDecode(response.Body)
		for index, v in pairs(TableBody.data) do
			if v.id == Followed then
				Module.GiveItem(Player,"ZER0Scythe_K",1,"Weapons")
				DataTable[Player.Name]["FollowRewardsuh_myer"] = true
				game.ReplicatedStorage.ItemGift:FireClient(Player, "ZER0Scythe_K", "Weapons");
			end
		end
	end
end)

-- VxReapz
game.ReplicatedStorage.Remotes.Extras.FollowRewardsThree.OnServerEvent:Connect(function(Player)

	if DataTable[Player.Name]["FollowRewardsVxReapz"] == true then
		return
	end

	local HttpService = game:GetService("HttpService")
	local Follower = Player.UserId
	local Followed = 20428960
	local Table = "https://friends.roproxy.com/v1/users/"..Follower.."/followings?limit=100&sortOrder=Desc"

	local response = HttpService:RequestAsync({
		Url = Table,
		Method = "GET"
	});

	if response.Success then
		local TableBody = HttpService:JSONDecode(response.Body)
		for index, v in pairs(TableBody.data) do
			if v.id == Followed then
				Module.GiveItem(Player,"TravelerAxeBlue",1,"Weapons")
				Module.GiveItem(Player,"Matrixscope",1,"Weapons")
				DataTable[Player.Name]["FollowRewardsVxReapz"] = true
				game.ReplicatedStorage.ItemGift:FireClient(Player, "Matrixscope", "Weapons");
				game.ReplicatedStorage.ItemGift:FireClient(Player, "TravelerAxeBlue", "Weapons");
			end
		end
	end
end)

function game.ReplicatedStorage.GetDataServer.OnInvoke(Player,DataName)
	return Module.Get(Player,DataName);
end

local function CheckForAdminGamepass(Player)
	local success, hasPass = pcall(function()
		return game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId, Config.Gamepasses.AdminMenu)
	end)
	return success and hasPass == true
end

game.ReplicatedStorage.Remotes.Admin.AdminRequest.OnServerInvoke = function(Player)
	_G.BoughtAdmin = CheckForAdminGamepass(Player)
	return _G.BoughtAdmin
end

game.ReplicatedStorage.Remotes.Extras.CheckAdmin.OnServerInvoke = function(player)
	return CheckForAdminGamepass(player)
end
local function CheckForAdmin(Player)
	return CheckForAdminGamepass(Player)
end
game.ReplicatedStorage.Remotes.AdminSettings.GiveCurrency.OnServerInvoke = function(Player, PlayerToGive, Value, TypeCurrency)
	if not CheckForAdmin(Player) then
		return {message = "ADMIN GAMEPASS REQUIRED!",exp = true}
	end
	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return {message = "PLAYER HAVE BEEN NOT FOUND!", exp = false}
	end
	local amount = tonumber(Value)
	if not amount or amount < 1 then
		return {message = "INVALID AMOUNT!", exp = false}
	end
	local currencyValue = DataTable[PlayerToGive.Name] and DataTable[PlayerToGive.Name][TypeCurrency]
	if currencyValue == nil then
		return {message = "CURRENCY TYPE IS NOT FOUND FOR PLAYER!", exp = false}
	end
	if amount < 0 then
		return {message = "YOU CANNOT PUT ( - ) IN VALUE!", exp = false}
	end
	Module.Give(PlayerToGive, TypeCurrency, amount)
	game.ReplicatedStorage.ItemGift:FireClient(PlayerToGive, TypeCurrency, "Materials", amount)
	game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(PlayerToGive, TypeCurrency, DataTable[PlayerToGive.Name][TypeCurrency])
	return {message = ("Successfully gave %s (x%d)."):format(TypeCurrency, amount), exp = false}
end
game.ReplicatedStorage.Remotes.AdminSettings.BecomeARole.OnServerInvoke = function(player, PlayerToGive, RoleName)
	if not CheckForAdmin(player) then
		return {message = "ADMIN GAMEPASS REQUIRED!", exp = true}
	end
	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return {message = "PLAYER HAVE BEEN NOT FOUND!", exp = false}
	end
	if _G.CustomMurderer == PlayerToGive.Name and RoleName ~= "Murderer" then
		return {message = PlayerToGive.Name .. " IS ALEREADY MURDERER, CANNOT GIVE DIFFRENT ROLE!", exp = false}
	end
	if _G.CustomSheriff == PlayerToGive.Name and RoleName ~= "Sheriff" then
		return {message = PlayerToGive.Name .. " IS ALEREADY SHERIFF, CANNOT GIVE DIFFRENT ROLE!", exp = false}
	end
	if RoleName == "Murderer" then
		if _G.CustomMurderer and _G.CustomMurderer ~= PlayerToGive.Name then
			return {message = "MURDERER ROLE IS ALEREADY TAKEN BY " .. _G.CustomMurderer, exp = false}
		end
		if _G.CustomSheriff == PlayerToGive.Name then
			_G.CustomSheriff = nil
		end
		_G.CustomMurderer = PlayerToGive.Name
		return {message = "SUCCESS GIVING MURDERER TO " .. PlayerToGive.Name, exp = false}

	elseif RoleName == "Sheriff" then
		if _G.CustomSheriff and _G.CustomSheriff ~= PlayerToGive.Name then
			return {message = "SHERIFF ROLE HAVE BEEN TAKEN BY " .. _G.CustomSheriff, exp = false}
		end
		if _G.CustomMurderer == PlayerToGive.Name then
			_G.CustomMurderer = nil
		end
		_G.CustomSheriff = PlayerToGive.Name
		return {message = "SUCCESS GIVING SHERIFF TO " .. PlayerToGive.Name, exp = false}
	else
		return {message = "THE ROLE HAVE BEEN NOT FOUND!", exp = false}
	end
end
game.ReplicatedStorage.Remotes.AdminSettings.SetMap.OnServerInvoke = function(player, MapID)
	if not CheckForAdmin(player) then
		return {message = "ADMIN GAMEPASS REQUIRED!", exp = true}
	end
	if not GetSyncData("Maps")[MapID] then
		return {message = "UNKOWN MAP", exp = false}
	end
	_G.Map = MapID
	return {message = MapID, exp = false}
end
game.ReplicatedStorage.Remotes.AdminSettings.GiveWeapon.OnServerInvoke = function(player, PlayerToGive, TypeWeapon)
	if not CheckForAdmin(player) then
		return {message = "ADMIN GAMEPASS REQUIRED!", exp = true}
	end
	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return { message = "PLAYER HAVE BEEN NOT FOUND!", exp = false }
	end
	if TypeWeapon == "Knife" then
		
		
		
		
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
		NewItem.Name = "Gun"
		NewItem.CanBeDropped = false;
		NewItem.Parent = PlayerToGive.Backpack;
		NewItem:AddTag("Weapon_Knife")
		
		
		
		
		return {message = "SUCCESSFULLY GIVED KNIFE!", exp = false}
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
		NewItem:AddTag("Weapon_Gun")
		
		
		
		
		
		return {message = "SUCCESSFULLY GIVED GUN!", exp = false}
	else
		return {message = "UNKOWN WEAPON!", exp = true}
	end
end
game.ReplicatedStorage.Remotes.AdminSettings.GiveItem.OnServerInvoke = function(player, PlayerToGive, itemNameSent, Amount)
	if not CheckForAdmin(player) then
		return {message = "ADMIN GAMEPASS REQUIRED!", exp = true }
	end
	if not PlayerToGive or not PlayerToGive:IsA("Player") then
		return {message = "PLAYER HAVE BEEN NOT FOUND!", exp = false }
	end
	if not itemNameSent or itemNameSent == "" then
		return {message = "PLEASE TYPE THE ITEM NAME CORRECTLY!", exp = false }
	end
	local amount = tonumber(Amount)
	if not amount or amount < 1 then
		return {message = "INVALID AMOUNT!", exp = false }
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
		return {message = "ITEM HAVE BEEN NOT FOUND :" .. tostring(itemNameSent), exp = false }
	end
	local ItemData = ItemsData[keyToUse]
	if not ItemData.ItemName or ItemData.ItemName == "" then
		return {message = "PLEASE TYPE THE NAME CORRECTLY!", exp = false }
	end
	if ItemData.Rarity == "Unique" then
		return { message = "UNIQUE ITEMS CANNOT BE GIVEN!", exp = false }
	end
	if ItemData.EvoBaseID then
		return {message = "EVO ITEMS CANNOT BE GIVEN ( NEVER BE NOOO!!! )", exp = false }
	end
	Module.GiveItem(PlayerToGive, keyToUse, amount, "Weapons")
	game.ReplicatedStorage.ItemGift:FireClient(PlayerToGive, keyToUse, "Weapons", amount)
	return {message = ("SUCCESSFULLY GIVED %s (x%d)."):format(ItemData.ItemName, amount), exp = false}
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


local FakeGunData = {}

local function FakeGun(Player, Activate)
	if FakeGunData[Player.Name] == nil then 
		FakeGunData[Player.Name] = {}
	end

	FakeGunData[Player.Name].Active = Activate

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

	if Knife then
		if Activate then
			local ItemsDB = GetSyncData("Item")
			local GunName = DataTable[Player.Name].Weapons.Equipped.Gun
			local Gun = game.ServerStorage.Database.Item[GunName]

			local FakeGunTool = Gun:Clone()
			FakeGunTool.Name = ItemsDB[GunName].ItemName
			FakeGunTool.TextureId = ItemsDB[GunName].Image

			local hasValue = false
			for _, obj in pairs(Gun.Handle:GetChildren()) do
				if obj:IsA("BoolValue") then
					local newValue = Instance.new("BoolValue")
					newValue.Value = obj.Value
					newValue.Name = obj.Name
					newValue.Parent = FakeGunTool
					hasValue = true
				end
			end

			if hasValue then
				local anim = game.ReplicatedStorage.Resources.Perks.FakeGun.FakeGunAnimation:Clone()
				anim.Parent = FakeGunTool
			end

			local function ScanEffects(ScanPart)
				for _, Obj in pairs(ScanPart:GetChildren()) do 
					local Effect = pcall(function() return Obj["Enabled"] end)
					if Effect then Obj.Enabled = false end
					ScanEffects(Obj)
				end
			end

			ScanEffects(FakeGunTool.Handle)
			FakeGunTool.Parent = Player.Character
			Knife.Parent = Player.Backpack
			FakeGunData[Player.Name].FakeTool = FakeGunTool

		elseif FakeGunData[Player.Name].FakeTool then
			if FakeGunData[Player.Name].FakeTool.Parent == Player.Character then
				FakeGunData[Player.Name].FakeTool.Parent = Player.Backpack
			end

			FakeGunData[Player.Name].FakeTool:Destroy()
			if Knife then
				Knife.Parent = Player.Character
			end
			FakeGunData[Player.Name].FakeTool = nil
		end
	end
end

Remotes.Gameplay.FakeGun.OnServerEvent:connect(function(Player,Activate)
	if Module.CheckForItem(Player,"FakeGun","Perks") then
		FakeGun(Player,Activate);
	end
end)

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
	[0] = true
}

Module.PlayerIsCreator = function(Player)
	local success, hasPass = pcall(function()
		return game.MarketplaceService:UserOwnsGamePassAsync(Player.UserId, 1907726269)
	end)
	if success and hasPass then
		Module.Creators[Player.UserId] = true
	end
end

game.ReplicatedStorage.Remotes.Extras.GetCreatorStatus.OnServerInvoke = function(Player)
	local IsCreator
	if Module.Creators[Player.UserId] then
		IsCreator = true
	else
		IsCreator = false
	end
	local CreatorStatus = {};

	if IsCreator then
		CreatorStatus = {
			["MapCommand"] = true,
			["MurdererCommand"] = true,
			["SheriffCommand"] = true,
		};
	end

	return IsCreator, CreatorStatus;
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



Module.Ready = true;
return Module;