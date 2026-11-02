-- Walking into and out of the Shooting Range.
--
--   Misc.ShootingRangeEnter()   touching the hub's ShootingRangeEntrance part, or the side task
--   Misc.ShootingRangeLeave()   touching a ShootingRangeExit part, or the "Leave" button
--
-- Entering moves the character to one of Lobby.ShootingRange.Important's Spawn parts and sets
-- the fighter's IsInShootingRange, which is what the client keys everything off (the lobby HUD
-- hides, the range HUD and lighting come on). Leaving puts the player back in the hub.
-- It also counts for the "Go to Shooting Range" beginner task.
--
-- Inside, the fighter lives in the range's environment (hits only land on the range's dummies
-- and targets) and may pick any weapon (CanPickWeapons opens the PickWeapons page); leaving
-- or respawning takes the weapons away again.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FighterService = require(script.Parent.FighterService)
local ItemService = require(script.Parent.ItemService)
local PlayerService = require(script.Parent.PlayerService)
local TaskService = require(script.Parent.TaskService)

local Misc = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Misc")

local COOLDOWN = 1
-- The range's EnvironmentID: its RaycastWhitelist tag and its entities use it.
local ENVIRONMENT_ID = utf8.char(2047)

local ShootingRangeService = {}

local lastMove: { [Player]: number } = {}

local function spawnParts(): { BasePart }
	local parts = {}
	local important = workspace.Lobby.ShootingRange:FindFirstChild("Important")
	for _, child in important and important:GetChildren() or {} do
		if child.Name == "Spawn" and child:IsA("BasePart") then
			table.insert(parts, child)
		end
	end
	return parts
end

local function moveTo(player: Player, part: BasePart)
	local character = player.Character
	if not character then
		return
	end
	local offset = Vector3.new(math.random(-4, 4), part.Size.Y / 2 + 4, math.random(-4, 4))
	character:PivotTo(CFrame.new(part.Position + offset) * part.CFrame.Rotation)
end

local function ready(player: Player): boolean
	local now = os.clock()
	if now - (lastMove[player] or 0) < COOLDOWN then
		return false
	end
	lastMove[player] = now
	return true
end

function ShootingRangeService.IsInside(player: Player): boolean
	local fighter = FighterService.Get(player)
	return fighter ~= nil and fighter:Get("IsInShootingRange") == true
end

function ShootingRangeService.Enter(player: Player)
	local fighter = FighterService.Get(player)
	if not fighter or fighter:Get("IsInDuel") or fighter:Get("IsInShootingRange") or not ready(player) then
		return
	end

	local spawns = spawnParts()
	if #spawns == 0 then
		warn("[ShootingRange] no Spawn parts in Lobby.ShootingRange.Important")
		return
	end

	moveTo(player, spawns[math.random(#spawns)])
	FighterService.SetEnvironment(player, ENVIRONMENT_ID)
	fighter:SetReplicate("IsInShootingRange", true)
	ItemService.AllowPicking(fighter, true)
	TaskService.Record(player, "ShootingRange", 1)
end

function ShootingRangeService.Leave(player: Player)
	local fighter = FighterService.Get(player)
	if not fighter or not fighter:Get("IsInShootingRange") or not ready(player) then
		return
	end

	ItemService.AllowPicking(fighter, false)
	FighterService.SetEnvironment(player, nil)
	fighter:SetReplicate("IsInShootingRange", false)
	PlayerService.Spawn(player)
end

function ShootingRangeService.Start()
	Misc.ShootingRangeEnter.OnServerEvent:Connect(ShootingRangeService.Enter)
	Misc.ShootingRangeLeave.OnServerEvent:Connect(ShootingRangeService.Leave)

	-- Any new character spawns in the hub, so it is out of the range.
	local function watch(player: Player)
		player.CharacterAdded:Connect(function()
			local fighter = FighterService.Get(player)
			if fighter and fighter:Get("IsInShootingRange") then
				ItemService.AllowPicking(fighter, false)
				FighterService.SetEnvironment(player, nil)
				fighter:SetReplicate("IsInShootingRange", false)
			end
		end)
	end
	Players.PlayerAdded:Connect(watch)
	for _, player in Players:GetPlayers() do
		watch(player)
	end

	Players.PlayerRemoving:Connect(function(player: Player)
		lastMove[player] = nil
	end)
end

ShootingRangeService.Remotes = { Misc.ShootingRangeEnter, Misc.ShootingRangeLeave }

return ShootingRangeService
