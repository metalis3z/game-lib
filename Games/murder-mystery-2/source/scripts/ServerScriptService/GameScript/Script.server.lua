local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Knit)

local PlayerStatus = require(ReplicatedStorage.Modules.PlayerStatus)
local Gun = require(ReplicatedStorage.Modules.Gun)

local MurderMystery = Knit.CreateService {
	Name = "MurderMystery";
	Client = {};
}

function MurderMystery:StartRound()
	local alivePlayers = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if PlayerStatus:GetStatus(player) ~= "Dead" then
			table.insert(alivePlayers, player)
		end
	end

	if #alivePlayers ~= #Players:GetPlayers() then
		return
	end

	for _, player in ipairs(alivePlayers) do
		if PlayerStatus:GetStatus(player) == "Lobby" then
			player:LoadCharacter()
		end
	end

	local murderer = alivePlayers[math.random(1, #alivePlayers)]
	local sheriff = alivePlayers[math.random(1, #alivePlayers)]
	while sheriff == murderer do
		sheriff = alivePlayers[math.random(1, #alivePlayers)]
	end

	Knit.Controllers.Gun:GiveGun(murderer, "Murderer")
	Knit.Controllers.Gun:GiveGun(sheriff, "Sheriff")

	for _, player in ipairs(alivePlayers) do
		if player ~= murderer and player ~= sheriff then
			Knit.Controllers.Gun:GiveGun(player, "Innocent")
		end
	end
end

function MurderMystery:KillPlayer(player)
	local killer = Gun:GetKiller(player)
	if killer == player then
		return
	end

	PlayerStatus:SetStatus(player, "Dead")
	player:LoadCharacter()
	Gun:RemoveGun(player)

	local alivePlayers = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if PlayerStatus:GetStatus(player) ~= "Dead" then
			table.insert(alivePlayers, player)
		end
	end

	if #alivePlayers == 1 then
		Knit.Controllers.GameOver:EndGame(alivePlayers[1])
	end
end

function MurderMystery:KnitStart()
	Knit.Controllers.PlayerStatus = PlayerStatus
	Knit.Controllers.Gun = Gun	

	Players.PlayerAdded:Connect(function(player)
		PlayerStatus:SetStatus(player, "Lobby")
		player.CharacterAdded:Connect(function(character)
			if PlayerStatus:Get() then
				return -- Add this function so it returns nothing!
			end
		end)
	end)
end;