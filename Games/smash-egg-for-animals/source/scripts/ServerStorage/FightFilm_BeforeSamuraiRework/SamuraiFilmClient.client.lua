-- Lance la cinématique "Samouraï contre la horde" quand le serveur le demande (ReplicatedStorage.FightFilm.Play).
-- _G.SamuraiFilm.play({ffTo = secondes}) sert aux essais : avance rapide jusqu'à ce temps, puis pause.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local film = ReplicatedStorage:WaitForChild("FightFilm")
local playing = false
local function play(options)
	if playing then return end
	playing = true
	local ok, err = pcall(function() return require(film:WaitForChild("SamuraiFilm")).play(options) end)
	if not ok then warn("[SamuraiFilm] " .. tostring(err)) end
	playing = false
end
_G.SamuraiFilm = {play = function(options) task.spawn(play, options) end, stop = function() require(film.SamuraiFilm).stop() end}
film:WaitForChild("Play").OnClientEvent:Connect(function() play() end)
