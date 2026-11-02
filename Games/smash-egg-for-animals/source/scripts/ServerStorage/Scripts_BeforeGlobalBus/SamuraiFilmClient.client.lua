-- Lance la cinématique "Samouraï contre la horde" quand le serveur le demande (ReplicatedStorage.FightFilm.Play),
-- puis prévient le serveur qu'elle est finie (FightFilm.Done) : le combat dans l'arène commence.
-- _G.SamuraiFilm.play({ffTo = secondes}) sert aux essais : avance rapide jusqu'à ce temps, puis pause.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local film = ReplicatedStorage:WaitForChild("FightFilm")
local CutsceneLock = require(game:GetService("ReplicatedStorage"):WaitForChild("CutsceneLock")) -- une seule cinématique à la fois
local playing = false
local function play(options)
	if playing then return end
	if not CutsceneLock.take("Samurai", 150) then return end
	playing = true
	local ok, err = pcall(function() return require(film:WaitForChild("SamuraiFilm")).play(options) end)
	if not ok then warn("[SamuraiFilm] " .. tostring(err)) end
	playing = false
	CutsceneLock.release("Samurai")
	if not (options and options.ffTo) then film:WaitForChild("Done"):FireServer() end
end
_G.SamuraiFilm = {play = function(options) task.spawn(play, options) end, stop = function() require(film.SamuraiFilm).stop() end}
film:WaitForChild("Play").OnClientEvent:Connect(function() play() end)
