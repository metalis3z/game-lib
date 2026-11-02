-- Lance la cinématique "The Hollow Reaper" quand le serveur le demande (ReplicatedStorage.ReaperCutscene.Play).
-- Le film lui-même est dans ReplicatedStorage.FightFilm.ReaperFilm ; l'ancienne version est rangée dans ServerStorage.ReaperCutsceneClient_Old.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local film = ReplicatedStorage:WaitForChild("FightFilm")
local CutsceneLock = require(game:GetService("ReplicatedStorage"):WaitForChild("CutsceneLock")) -- une seule cinématique à la fois
local playing = false
local function play(options)
	if playing then return end
	if not CutsceneLock.take("Reaper", 200) then return end
	playing = true
	local ok, err = pcall(function() return require(film:WaitForChild("ReaperFilm")).play(options) end)
	if not ok then warn("[ReaperFilm] " .. tostring(err)) end
	playing = false
	CutsceneLock.release("Reaper")
end
_G.ReaperFilm = {play = function(options) task.spawn(play, options) end, stop = function() require(film.ReaperFilm).stop() end}
ReplicatedStorage:WaitForChild("ReaperCutscene"):WaitForChild("Play").OnClientEvent:Connect(function() play() end)
