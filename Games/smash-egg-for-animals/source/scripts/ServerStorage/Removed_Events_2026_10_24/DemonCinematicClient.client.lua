-- DemonCinematicClient : joue la cinématique "Demon City" quand le serveur le demande (DemonCity.CinematicEvent "play"), puis
-- prévient le serveur qu'elle est finie ("done") : si le combat suit, il commence (DemonBossController).
-- Une seule cinématique à la fois (CutsceneLock) ; quoi qu'il arrive (erreur, film coupé), la caméra et les contrôles sont
-- rendus au joueur (FightFilm.Kit.finish dans le film, ici un pcall).
-- _G.DemonFilm.play({ffTo = secondes}) sert aux essais : avance rapide jusqu'à ce temps, puis pause (aucun combat).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local film = ReplicatedStorage:WaitForChild("FightFilm")
local remote = ReplicatedStorage:WaitForChild("DemonCity"):WaitForChild("CinematicEvent")
local CutsceneLock = require(ReplicatedStorage:WaitForChild("CutsceneLock"))
local player = Players.LocalPlayer
local playing = false

local function play(toArena, options)
	if playing then return end
	-- l'intro d'arrivée est passée ; une autre cinématique en cours a quelques secondes pour finir
	if player:GetAttribute("IntroState") == "playing" and _G.SkipIntro then pcall(_G.SkipIntro) end
	local waited = 0
	while not CutsceneLock.take("DemonCity", 170) do
		if waited >= 10 then
			warn("[DemonCity] another cutscene is still playing : film skipped")
			if toArena then remote:FireServer("done") end
			return
		end
		waited += task.wait(0.25)
	end
	playing = true
	options = options or {}
	options.toArena = toArena
	local ok, err = pcall(function() return require(film:WaitForChild("DemonFilm")).play(options) end)
	if not ok then warn("[DemonCity] " .. tostring(err)) end
	playing = false
	CutsceneLock.release("DemonCity")
	if not (options and options.ffTo) then remote:FireServer("done") end
end

_G.DemonFilm = {
	play = function(options) task.spawn(play, false, options) end,
	stop = function() require(film.DemonFilm).stop() end,
}
remote.OnClientEvent:Connect(function(action, toArena)
	if action == "play" then task.spawn(play, toArena == true) end
end)
