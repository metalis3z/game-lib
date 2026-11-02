-- Lance la cinématique "Alien Invasion" quand le serveur le demande (FightFilm.AlienPlay). withEvent = true : au moment où les
-- galaxies se percutent, on prévient le serveur (FightFilm.AlienCollide), qui lance le vrai Galaxy Event.
-- _G.AlienFilm.play({ffTo = secondes}) sert aux essais (avance rapide jusqu'à ce temps, puis pause ; aucun event).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local film = ReplicatedStorage:WaitForChild("FightFilm")
local CutsceneLock = require(ReplicatedStorage:WaitForChild("CutsceneLock")) -- une seule cinématique à la fois
local playing = false

local function play(withEvent, options)
	if playing then return end
	if not CutsceneLock.take("AlienInvasion", 170) then return end
	playing = true
	options = options or {}
	if withEvent then
		local sent = false
		options.onCollide = function()
			if sent then return end
			sent = true
			film:WaitForChild("AlienCollide"):FireServer()
		end
	end
	local ok, err = pcall(function() return require(film:WaitForChild("AlienFilm")).play(options) end)
	if not ok then warn("[AlienFilm] " .. tostring(err)) end
	playing = false
	CutsceneLock.release("AlienInvasion")
end

_G.AlienFilm = {
	play = function(options) task.spawn(play, false, options) end,
	stop = function() require(film.AlienFilm).stop() end,
}
film:WaitForChild("AlienPlay").OnClientEvent:Connect(function(withEvent) task.spawn(play, withEvent == true) end)
