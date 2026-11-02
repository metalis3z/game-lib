-- Configuration
MAX_ANTICHEAT_STRIKES = 2 -- amount of anticheat triggers it takes to kick someone
MINIMUM_PUZZLE_INTERVAL = 1 -- minimum time allowed between puzzles, until the anticheat is triggered

local Util = require(game.ReplicatedStorage.Modules.Util)
local Actors = require(game.ReplicatedStorage.Modules.Actors)

local Generator = script.Parent.Parent
local Remotes = Generator.Remotes
local Progress = Generator.Progress
local OccupiedPositions = {}
local CurrentPlayers = {}

function ExitGenerator(Player : Player)
	--local Character = Player.Character
	--if not Character then return end
	--if not Character.PrimaryPart then return end
	local PlayerInfo = CurrentPlayers[Player]
	if not PlayerInfo then return end
	
	if PlayerInfo.SpeedMultiplier then
		PlayerInfo.SpeedMultiplier:Destroy()
	end
	if PlayerInfo.CurrentPosition then
		OccupiedPositions[PlayerInfo.CurrentPosition] = nil
		PlayerInfo.CurrentPosition = nil
	end
	
	for _, connection : RBXScriptConnection in pairs(PlayerInfo.Connections) do
		if typeof(connection) == "RBXScriptConnection" then
			connection:Disconnect()
		end
	end
	PlayerInfo.Connections = {}
end

function EnterGenerator(Player : Player)
	if Progress.Value >= 100 then return "alreadyFixed" end
	if not Generator.Main:FindFirstChild("Prompt") then return "alreadyFixed" end
	
	local Character = Player.Character
	if (not Character) or (not Character.Parent) then return end
	if not Character.PrimaryPart then return end
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return end
	local PlayerInfo = CurrentPlayers[Player]
	
	if Character.Parent.Name == "Killers" then return "isKiller" end
	if Character.Parent.Name == "Spectating" then return "isUnknownTeam" end
	
	local Position : Part
	for _, pos : Part in pairs(Generator.Positions:GetChildren()) do
		if (pos.Position-Character.PrimaryPart.Position).Magnitude > Generator.Main.Prompt.MaxActivationDistance then continue end
		if (not Position) or (Position.Position-Character.PrimaryPart.Position).Magnitude > (pos.Position-Character.PrimaryPart.Position).Magnitude then
			Position = pos
		end
	end
	
	if not Position then return "tooFar" end
	if OccupiedPositions[Position] then return "positionOccupied" end
	
	OccupiedPositions[Position] = true
	PlayerInfo.CurrentPosition = Position
	PlayerInfo.SpeedMultiplier = Util:CreateSpeedMultiplier(Player, 0, "FixingGenerator")
	Character:PivotTo(Position.CFrame)
	
	local currentHealth = Humanoid.Health
	table.insert(PlayerInfo.Connections, Humanoid.HealthChanged:Connect(function(health)
		if not PlayerInfo.CurrentPosition then return end
		if health < currentHealth then
			ExitGenerator(Player)
		else
			currentHealth = health
		end
	end))
	
	return "fixing", Position, PlayerInfo.SpeedMultiplier
end

Remotes.RF.OnServerInvoke = function(Player : Player, ActionType)
	if ActionType ~= "leave" and ActionType ~= "enter" then return end
	if not CurrentPlayers[Player] then
		CurrentPlayers[Player] = {Strikes=MAX_ANTICHEAT_STRIKES, LastActionTime=tick(), Connections={}}
	end
	local playerinfo = CurrentPlayers[Player]
	if ActionType == "enter" and (not playerinfo.CurrentPosition) then
		return EnterGenerator(Player)
	elseif playerinfo.CurrentPosition then
		ExitGenerator(Player)
		return "notFixing"
	end
end

Remotes.RE.OnServerEvent:Connect(function(Player : Player)
	local playerInfo = CurrentPlayers[Player]
	if not playerInfo then return end
	if (tick() - playerInfo.LastActionTime) <= MINIMUM_PUZZLE_INTERVAL then
		playerInfo.Strikes -= 1
	end
	if playerInfo.Strikes <= 0 then
		Player:Kick("\n\nForsakenCheatKiller 000:\nGenerator Exploits\n")
		return
	end
	playerInfo.LastActionTime = tick()
	
	if not playerInfo.CurrentPosition then return end
	if Progress.Value >= 100 then return end
	
	local Character = Player.Character
	if not Character then return end
	if not Character.PrimaryPart then return end
	if (Character.PrimaryPart.Position-playerInfo.CurrentPosition.Position).Magnitude > 5 then
		ExitGenerator(Player)
		return
	end
	
	Progress.Value = math.clamp(Progress.Value + Generator:GetAttribute("PowerGain"), 0, 100)
	
	Actors:IncrementActorStats(Player, {
		Action = "Completed a generator puzzle",
		Money = 5,
		EXP = 15,
		KillerChance = 0.5
	})
	
	Remotes.BE:Fire(Player, Progress.Value)
	
	if Progress.Value >= 100 then
		if Generator.Main:FindFirstChild("Prompt") then
			Generator.Main.Prompt:Destroy()
		end
		for plr, plrInfo in pairs(CurrentPlayers) do
			if plrInfo.CurrentPosition then
				ExitGenerator(plr)
			end
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(Player)
	if CurrentPlayers[Player] then
		ExitGenerator(Player)
		CurrentPlayers[Player] = nil
	end
end)