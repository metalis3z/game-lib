--[[
    Written by: Nextix (ne_tix)
    Date: 3/30/2026
    
    Method:
    New function for ShopManager.Name() = a new functions which can be called by the client.
    In StarterGui > UI > Main > Server is a remote event which gets called by the client.
    The Backend of the remote will have a look onto this exact module seeing if a Function has the name the client is providing it.
    
    Warning:
    Please, don't do dumb stuff with the functions. Have securities for them.
]]

local ShopManager = {}

-- <- Types -> --
type FolderAttributes = {
	COST: number,
	Default: string,
	Type: string
}

type SkinFolderAttributes = {
	Cost: number,
	Type: string
}

type EmoteFolderAttributes = {
	ADMIN: boolean,
	Character: string,
	Price: number
}

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local Players = game:GetService('Players');

-- <- Modules -> --
local Warps = require('@game/ReplicatedStorage/Modules/Warp');
local PlayerData = require('@game/ServerStorage/Modules/General/PlayerData');

-- <- Public Variables -> --
local Characters = ReplicatedStorage.Characters
local Emotes = ReplicatedStorage.Modules.Emotes

-- <- Private Variables -> --
local BannedTypes = {
	'admin'
}

-- <- Public Functions -> --

-- // Handle the buying of a Survivor.
function ShopManager.SurvivorBuy(Player: Player, Survivor: string): ()
	local PeurcoolIsACoolPerson = `Survivor-{Survivor}` -- // He might be gay btw
	local Data = PlayerData.GetPlayerData(Player);
	if not Data then
		return
	end
	
	-- // Check if the player already own the survivor.
	if table.find(Data.Data.OwnedChars, PeurcoolIsACoolPerson) then
		return
	end
	
	-- // Check if the survivor itself exists.
	local SurvivorFolder = Characters.Survivor:FindFirstChild(Survivor);
	if not SurvivorFolder then		
		return
	end
	
	-- // Get the survivor shop information.
	local Information: FolderAttributes = SurvivorFolder:GetAttributes();
	
	-- // Check if the price exists.
	if not Information.COST then
		return
	end
	
	-- // Check if the type exists.
	if not Information.Type then
		return
	end
	
	-- // Check if the survivor type is a banned type.
	if table.find(BannedTypes, string.lower(Information.Type)) and Player:GetAttribute("Rank") < 35 then
		return
	end
	
	-- // Check for the player money.
	local PlayerMoney = Data.Data.Stats.FazCoins
	if not PlayerMoney then
		return
	end
	
	-- // Check if the player has enough money.
	if PlayerMoney - Information.COST < 0 then
		return
	end

	Data.Data.Stats.FazCoins -= Information.COST
	Data.Data.EquippedSkins[PeurcoolIsACoolPerson] = 'Normal'
	Data.Data.OwnedEmotes[PeurcoolIsACoolPerson] = {}

	table.insert(Data.Data.OwnedChars, PeurcoolIsACoolPerson);
end

-- // Handle the buying of an Killer / Animatronic. (Like they say)
function ShopManager.AnimatronicBuy(Player: Player, Animatronic: string): ()
	local Data = PlayerData.GetPlayerData(Player);
	if not Data then
		return
	end
	
	-- // Check if the player already owns the animatronic.
	if table.find(Data.Data.OwnedChars, Animatronic) then
		return
	end
	
	-- // Check if the animatronic itself exists.
	local AnimatronicFolder = Characters:FindFirstChild(Animatronic);
	if not AnimatronicFolder then
		return
	end
	
	-- // Get the animatronic shop information.
	local Information: FolderAttributes = AnimatronicFolder:GetAttributes();
	
	-- // Check if the price exists.
	if not Information.COST then
		return
	end
	
	-- // Check if the type exists.
	if not Information.Type then
		return
	end
	
	-- // Check check if the animatronic type is a banned type.
	if table.find(BannedTypes, string.lower(Information.Type)) and Player:GetAttribute("Rank") < 35 then
		return
	end
	
	-- // Check the player money.
	local PlayerMoney = Data.Data.Stats.FazCoins
	if not PlayerMoney then
		return
	end
	
	-- // Check if the player has enough money
	if PlayerMoney - Information.COST < 0 then
		return
	end
	
	Data.Data.Stats.FazCoins -= Information.COST
	Data.Data.EquippedSkins[Animatronic] = 'Normal'
	Data.Data.OwnedEmotes[Animatronic] = {}
	
	table.insert(Data.Data.OwnedChars, Animatronic);
end

-- // Detailed comments stops there cause Im low-key lazy to continue doing them on this script.
-- // They're all the same so please lock-in.

-- // Handle the buying of a emote.
function ShopManager.EmoteBuy(Player: Player, Emote: string): ()
	local Data = PlayerData.GetPlayerData(Player);
	if not Data then
		return
	end
	
	if table.find(Data.Data.OwnedEmotes, Emote) then
		return
	end
	
	local EmoteFolder = Emotes:FindFirstChild(Emote);
	if not EmoteFolder then
		return
	end
	
	local EmoteInformation: EmoteFolderAttributes = EmoteFolder:GetAttributes();
	if not EmoteInformation.Price then
		return
	end
	
	if EmoteInformation.ADMIN and Player:GetAttribute("Rank") < 35 then
		return
	end
	
	if Data.Data.Stats.FazCoins - EmoteInformation.Price < 0 then
		return
	end
	
	Data.Data.Stats.FazCoins -= EmoteInformation.Price
	
	table.insert(Data.Data.OwnedEmotes, Emote);
end

-- // Handle the buying of a skin.
function ShopManager.SkinBuy(Player: Player, Skin: string, BaseCharacter: string, IsSurvivor: boolean): ()
	local Data = PlayerData.GetPlayerData(Player);
	if not Data then
		return
	end
	
	if not Data.Data.OwnedSkins[IsSurvivor and `Survivor-{BaseCharacter}` or BaseCharacter] then
		return
	end
	
	local BaseFolder = IsSurvivor and Characters.Survivor:FindFirstChild(BaseCharacter) or Characters:FindFirstChild(BaseCharacter);
	if not BaseFolder then
		return
	end
	
	local SkinFolder = BaseFolder:FindFirstChild(Skin);
	if not SkinFolder then
		return
	end

	local BaseInformation: FolderAttributes = BaseFolder:GetAttributes();
	local SkinInformation: SkinFolderAttributes = SkinFolder:GetAttributes();
	if not SkinInformation.Cost then
		return
	end
	
	if not SkinInformation.Type then
		return
	end
	
	if table.find(BannedTypes, string.lower(SkinInformation.Type)) and Player:GetAttribute("Rank") < 35 then
		return
	end
	
	if Data.Data.Stats.FazCoins - SkinInformation.Cost < 0 then
		return
	end
	
	Data.Data.Stats.FazCoins -= SkinInformation.Cost
	
	table.insert(Data.Data.OwnedSkins[IsSurvivor and `Survivor-{BaseCharacter}` or BaseCharacter], Skin);
end

-- <- Return -> --
return ShopManager