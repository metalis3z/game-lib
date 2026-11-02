local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")

local PlotService = require(ServerScriptService.Source.Services.PlotService)
local LostBrainrotService = require(ServerScriptService.Source.Services.LostBrainrotService)

local IslandRespawnService = {}

-- DropCarriedLuckyOnFall BindableFunction lives on IslandBrainrotSpawner (a
-- top-level Script) and pops every carried lucky-block entry. We resolve it
-- lazily so we don't race the spawner script's startup at server boot.
local IslandBrainrotSpawnerScript = ServerScriptService:WaitForChild("IslandBrainrotSpawner", 30)
local DropCarriedLuckyOnFallBindable = IslandBrainrotSpawnerScript
	and IslandBrainrotSpawnerScript:WaitForChild("DropCarriedLuckyOnFall", 30)

local Assets = Workspace:WaitForChild("Assets")
local Map = Assets:WaitForChild("Map")
local Islands = Assets:WaitForChild("Islands")
local MainIsland = Map:WaitForChild("MainIsland")
local TPBack = Map:WaitForChild("TPBack")

local TELEPORT_COOLDOWN = 0.5
local lastIsland = {}
local lastTeleport = {}

local function getPlayerFromHit(hit)
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character then
		return nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return nil
	end

	return Players:GetPlayerFromCharacter(character)
end

local function setLastIsland(player, islandPart)
	lastIsland[player] = islandPart
end

local function teleportPlayerToPart(player, part)
	local character = player.Character
	if not character then
		return
	end

	local offsetY = part.Size.Y / 2 + 3
	character:PivotTo(part.CFrame + Vector3.new(0, offsetY, 0))
end

local function teleportPlayerHome(player)
	local plot = PlotService.GetPlot(player)
	if not plot then
		return
	end

	local spawnPart = plot:FindFirstChild("SpawnLocation")
	if not spawnPart then
		return
	end

	teleportPlayerToPart(player, spawnPart)
end

local function handleTPBackTouch(hit)
	local player = getPlayerFromHit(hit)
	if not player then
		return
	end

	-- ignore touches around the dig-entry hole: the player is falling
	-- through TPBack into Zone1, not falling off the islands
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		local pos = hrp.Position
		if pos.X > 24.85 and pos.X < 68.85 and pos.Z > 284.34 and pos.Z < 338.34 then
			return
		end
	end

	local now = os.clock()
	if lastTeleport[player] and (now - lastTeleport[player]) < TELEPORT_COOLDOWN then
		return
	end
	lastTeleport[player] = now

	-- Lucky-block carry loss: dropping the carry has to happen *before* the
	-- teleport (the player still owns the entry until we pop it). The bindable
	-- returns an array of luckyBlockIds it removed; an empty array means the
	-- player wasn't carrying any so we keep the normal back-to-last-island flow.
	local lostBlocks = {}
	if DropCarriedLuckyOnFallBindable then
		local ok, result = pcall(function()
			return DropCarriedLuckyOnFallBindable:Invoke(player)
		end)
		if ok and type(result) == "table" then
			lostBlocks = result
		end
	end

	if #lostBlocks > 0 then
		-- Falling while holding a lucky block forfeits the carry and sends the
		-- player to their plot spawn (not back to the last island they touched)
		-- so the recovery prompt is the only path back to the block.
		teleportPlayerHome(player)
		LostBrainrotService.RegisterLoss(player, lostBlocks)
		return
	end

	local target = lastIsland[player]
	if target and target ~= MainIsland then
		teleportPlayerToPart(player, target)
	else
		teleportPlayerHome(player)
	end
end

function IslandRespawnService.Init()
	for _, island in ipairs(Islands:GetChildren()) do
		if island:IsA("BasePart") then
			island.Touched:Connect(function(hit)
				local player = getPlayerFromHit(hit)
				if not player then
					return
				end

				setLastIsland(player, island)
			end)
		end
	end

	MainIsland.Touched:Connect(function(hit)
		local player = getPlayerFromHit(hit)
		if not player then
			return
		end

		setLastIsland(player, MainIsland)
	end)

	-- TPBack is split into several pieces around the dig-entry hole
	for _, piece in ipairs(Map:GetChildren()) do
		if piece.Name == "TPBack" and piece:IsA("BasePart") then
			piece.Touched:Connect(handleTPBackTouch)
		end
	end

	Players.PlayerRemoving:Connect(function(player)
		lastIsland[player] = nil
		lastTeleport[player] = nil
	end)
end

return IslandRespawnService
