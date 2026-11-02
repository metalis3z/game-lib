-- Configuration
MAX_ANTICHEAT_STRIKES = 2 -- amount of anticheat triggers it takes to kick someone
MINIMUM_PUZZLE_INTERVAL = 1 -- minimum time allowed between puzzles, until the anticheat is triggered
FAKE_REWARDS = { -- fake rewards that pop up when a player completes a puzzle
	"+ $5 & 20 EXP: Completed a generator puzzle",
	"+ $5 & 10 EXP: Completed a generator puzzle",
	"+ 5$ & 15 EXP: Completed a generator puzzle",
	"+ $5 and 15 EXP: Completed a generator puzzle",
	"+ $5 & 15 XP: Completed a generator puzzle",
	"+ $5 & 15 EXP: Completed a generator puzzle",
	"+ $5 & 15 EXP: Completed a generator puzzle!",
	"+ $5 & 15 EXP: Completed a puzzle",
	"+ $5 & 15 EXP: Completed a generator puzzle",
	"+ 5€ & 15 EXP: Completed a generator puzzle",
	"+ 5£ & 15 EXP: Completed a generator puzzle",
	"+ 5¢ & 15 EXP: Completed a generator puzzle",
	"+ 5¥ & 15 EXP: Completed a generator puzzle",
	"+ 5₭ & 15 EXP: Completed a generator puzzle",
	"+ $5 & 15 EXP: Completed a generator objective",
}

local Util = require(game.ReplicatedStorage.Modules.Util)
local Actors = require(game.ReplicatedStorage.Modules.Actors)
local Network = require(game.ReplicatedStorage.Modules.Network)

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
	if not Character then return end
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
	
	if workspace:GetAttribute("ServerType") ~= "VIP" then
		require(game.ReplicatedStorage.Modules.Network):FireClientConnection(Player, "SendNotif", "REMOTE_EVENT", FAKE_REWARDS[math.random(1, #FAKE_REWARDS)], "Objective")
	end
	
	Remotes.BE:Fire(Player, Progress.Value)
	
	if Progress.Value >= 100 then
		local prompt
		if Generator.Main:FindFirstChild("Prompt") then
			prompt = Generator.Main.Prompt
			prompt.Parent = game.ServerStorage.Assets.Miscellaneous.TemporaryData
		end
		for plr, plrInfo in pairs(CurrentPlayers) do
			if plrInfo.CurrentPosition then
				ExitGenerator(plr)
			end
		end
		task.wait(1)
		game.TweenService:Create(Progress, TweenInfo.new(1), {Value = 0}):Play()
		task.wait(1)
		if prompt then
			prompt.Parent = Generator.Main
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(Player)
	if CurrentPlayers[Player] then
		ExitGenerator(Player)
		CurrentPlayers[Player] = nil
	end
end)

Generator.Instances.Generator.ScaryEvil.SurfaceGui.ImageLabel.Position = UDim2.new(
	math.random(27, 73)/100,
	0,
	math.random(43, 62)/100,
	0
)