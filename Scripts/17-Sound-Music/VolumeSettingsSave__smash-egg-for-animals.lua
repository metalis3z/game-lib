-- Reference copy for study. Game: Smash Egg For Animals (smash-egg-for-animals)
-- Original: ServerScriptService/SettingsServer.server.lua
-- What it does: Server half of the volume settings: loads Music/SFX volume from its own DataStore into player attributes, validates values sent by the client remote, and writes once on leave or BindToClose. Comments are in French.

-- Réglages du joueur (volume de la musique et des bruitages) : gardés d'une session à l'autre dans leur propre DataStore,
-- séparé de la sauvegarde du jeu. Le client (StarterGui.SettingsGui.SettingsHandler) lit les attributs MusicVolume / SfxVolume.
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local saveRemote = ReplicatedStorage:WaitForChild("SettingsRemotes"):WaitForChild("Save")
local okStore, store = pcall(function() return DataStoreService:GetDataStore("PlayerSettings_v1") end)
local pending = {} -- [player] = true : à écrire au départ (une seule écriture par session)

local function volume(v) return typeof(v) == "number" and v == v and math.clamp(v, 0, 1) or nil end

Players.PlayerAdded:Connect(function(player)
	if not okStore then return end
	local ok, data = pcall(function() return store:GetAsync("u" .. player.UserId) end)
	if ok and typeof(data) == "table" and player.Parent then
		player:SetAttribute("MusicVolume", volume(data.Music) or 1)
		player:SetAttribute("SfxVolume", volume(data.Sfx) or 1)
	end
end)

saveRemote.OnServerEvent:Connect(function(player, music, sfx)
	music, sfx = volume(music), volume(sfx)
	if not music or not sfx then return end
	player:SetAttribute("MusicVolume", music)
	player:SetAttribute("SfxVolume", sfx)
	pending[player] = true
end)

local function flush(player)
	if not pending[player] then return end
	pending[player] = nil
	if not okStore then return end
	local data = {Music = player:GetAttribute("MusicVolume") or 1, Sfx = player:GetAttribute("SfxVolume") or 1}
	pcall(function() store:SetAsync("u" .. player.UserId, data) end)
end
Players.PlayerRemoving:Connect(flush)
game:BindToClose(function()
	for _, player in Players:GetPlayers() do task.spawn(flush, player) end
	task.wait(1.5)
end)
