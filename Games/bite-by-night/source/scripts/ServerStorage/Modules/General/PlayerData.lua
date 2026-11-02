--[[
    Written by: Nextix (ne_tix)
    Date: 3/29/2026
    
    Method:
    Any client scripts can use the module 'Warp' and do a request to the 'Side' remote to get the current player data.
    
    Example:
    local Warp = require(Warp)
    local DataRemote = Warp.Client('Side') | Warp.Server('Side')
    
    Warning:
    Breaking this script could result in a game failing to load.
    Do not try to edit this script if you do not know what you're doing.
]]

local PlayerDataModule = {}

-- <- Services -> --
local ServerStorage = game:GetService('ServerStorage');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local Players = game:GetService('Players');

-- <- Modules -> --
local DataTemplate = require('@self/Template');
local Warp = require('@game/ReplicatedStorage/Modules/Warp');
local ProfileStore = require('../ProfileStore');

-- <- Private Variables -> --
local StoredProfiles = {}

local PlayerStore = ProfileStore.New('OkHiKataLove16', DataTemplate);

local DataTransferThingy = Warp.Server('Side');

-- <- Private Functions -> --

-- // This function apply all the attributes to the player instance. (The attributes are the settings in this game)
local function ApplyAttributesToPlayer(Player: Player): ()
	local PlayerProfile = StoredProfiles[Player]
	if not PlayerProfile then -- // If this checks fails, consider having a look into your game file.
		return
	end
	
	for AttributeName, AttributeVal in PlayerProfile.Data.Settings do 
		if typeof(AttributeVal) == 'table' then
			continue
		end
		
		Player:SetAttribute(AttributeName, AttributeVal);
	end
end

-- // This function try to setup the player data profile. (If it fails, try turning on most of the securities in Game Settings > Securities)
local function InitPlayerData(Player: Player): ()
	local Profile = PlayerStore:StartSessionAsync(`{Player.UserId}`, {
		Cancel = function()
			return Player.Parent ~= Players
		end,
	})

	if Profile ~= nil then
		Profile:AddUserId(Player.UserId)
		Profile:Reconcile()
		Profile.OnSessionEnd:Connect(function()
			StoredProfiles[Player] = nil

			Player:Kick(`Profile session end - Please rejoin`);
		end)

		if Player.Parent == Players then
			StoredProfiles[Player] = Profile
			
			ApplyAttributesToPlayer(Player);
		else
			Profile:EndSession()
		end

	else
		Player:Kick(`Profile load fail - Please rejoin`)
	end
end

-- // The name explain the whole function... :sob:
local function Save(Player: Player): ()
	local Profile = StoredProfiles[Player]
	if Profile ~= nil then
		Profile:EndSession();
	end
end

-- <- Public Functions -> --

-- // This function.. bro its like the one above, the name explains it..
function PlayerDataModule.GetPlayerData(Player: Player)
	local Data = StoredProfiles[Player]
	if not Data then
		return {}
	end
	
	return Data
end

function PlayerDataModule.__PlayerAdded(Player: Player): ()			
	InitPlayerData(Player);
end

function PlayerDataModule.__PlayerLeft(Player: Player): ()		
	Save(Player);
end

-- // This function is a callback of the Event 'Side' with the first argument being 'Data'. (Basicly the client asking the server for the player data)
function PlayerDataModule.Event_Side_Data(Player: Player): ()
	return StoredProfiles[Player] and StoredProfiles[Player].Data or {}
end

-- <- Return -> --
return PlayerDataModule