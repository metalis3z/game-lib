local InventoryManager = {}

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
local InventoryEvent = Warps.Server('Side');

-- <- Private Functions -> --
local function EquipCharacter(Player: Player, Type: string, CharacterToEquip: string): ()
	local SubbedName = string.gsub(CharacterToEquip, 'Survivor%-', '');
	local Data = PlayerData.GetPlayerData(Player);
	if not Data then
		return
	end

	-- // Check if the player owns the character.
	if not table.find(Data.Data.OwnedChars, CharacterToEquip) then
		warn('Player doesnt own the character.');

		return
	end

	-- // Check if the type actual exist in the PlayerData. (Imagine it doesn't.. Dumbass)
	if not Data.Data.Character[Type] then
		warn('Type doesnt exist in the playerdata.');

		return
	end

	-- // Incase the player tries to equip, idk Springtrap as Survivor lol.. (Love the exploiters <3)
	if Type == 'Killer' then
		if not Characters:FindFirstChild(CharacterToEquip) then
			warn('Couldnt find the killer folder.');

			return
		end
	else
		if not Characters.Survivor:FindFirstChild(SubbedName) then
			warn(`Couldnt find the survivor folder. ({CharacterToEquip} / {SubbedName})`);

			return
		end
	end

	Data.Data.Character[Type] = CharacterToEquip
end

local function EquipEmote(Player: Player, CharacterToEquipOn: string, Slot: number, Emote: string): ()
	local Data = PlayerData.GetPlayerData(Player);
	if not Data then
		return
	end
	
	-- // Check if the player does own the emote.
	if not table.find(Data.Data.OwnedEmotes, Emote) then
		return
	end
	
	-- // Check if the character the player is trying to equip the emote on exists.
	if not Data.Data.Emotes[CharacterToEquipOn] then
		return
	end
	
	-- // Check if the emote itself exists.
	local EmoteModule = Emotes:FindFirstChild(Emote);
	if not EmoteModule then
		return
	end
	
	-- // Check if the emote can be equipped on the asked character.
	local EmoteInformation = EmoteModule:GetAttributes();
	if EmoteInformation.Character ~= CharacterToEquipOn then
		return
	end
	
	-- // Check if the slot is valid.
	if not Data.Data.Emotes[CharacterToEquipOn][Slot] then
		return
	end
	
	-- // Check if the slot already has the asked emote on it.
	if Data.Data.Emotes[CharacterToEquipOn][Slot] == Emote then
		return
	end
	
	Data.Data.Emotes[CharacterToEquipOn][Slot] = Emote
end

local function EquipSkin(Player: Player, CharacterToEquipOn: string, Skin: string): ()
	local Data = PlayerData.GetPlayerData(Player);
	if not Data then
		return
	end
	
	if not Data.Data.OwnedSkins[CharacterToEquipOn] then
		return
	end
	
	if not table.find(Data.Data.OwnedSkins[CharacterToEquipOn], Skin) and not table.find(Data.Data.OwnedSkins.SurvivorAll, Skin) then
		return
	end
	
	-- // Fun fact, this line was Data.Data.OwnedSkins[CharacterToEquipOn] = Skin which broke the game. (Lol)
	Data.Data.EquippedSkins[CharacterToEquipOn] = Skin
end

-- <- Public Functions -> --
function InventoryManager.Event_Side_Equip(Player: Player, InformationTable: {}): ()	
	-- // First arg of the table is always the type and second what thing to equip <3
	EquipCharacter(Player, table.unpack(InformationTable));
end

function InventoryManager.Event_Side_EquipEmote(Player: Player, InformationTable: {}): ()
	EquipEmote(Player, table.unpack(InformationTable));
end

function InventoryManager.Event_Side_EquipSkin(Player: Player, InformationTable: {}): ()
	EquipSkin(Player, table.unpack(InformationTable));
end

-- <- Return -> --
return InventoryManager