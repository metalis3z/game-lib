--!strict
-- PlotManager (pattern module)
-- Clean, reusable plot / base assignment for tycoon and steal-a-X games.
--
-- Ideas taken from: drill-and-mine (PlotService: sort plots by number, OwnerUserId attribute,
-- reset callbacks), steal-an-egg (Core_Plots: plot slots, sign with name + headshot, teleport
-- on every spawn), brainrot-lab (PlotManager: first free plot, cleanup on leave) and
-- steal-a-brainrot (PlotService.getFreePlots / BaseManagerService: switch to another free base).
--
-- Expected world layout:
--   workspace.Plots
--     1 (Model)  -- name is the slot number; any Model works, they are sorted by number
--       Spawn (BasePart, optional)        -- where the owner is teleported
--       Sign  (BasePart, optional) > SurfaceGui > TextLabel "OwnerName"
--
-- Usage (a Script in ServerScriptService):
--   local PlotManager = require(path.to.PlotManager)
--   PlotManager.Init(workspace.Plots)
--   PlotManager.PlotAssigned:Connect(function(player, plot) --[[ load the player's base here ]] end)
--   PlotManager.PlotReleased:Connect(function(player, plot) --[[ clear buildings here ]] end)
--   local plot = PlotManager.GetPlot(player)
--   local owner = PlotManager.GetOwner(plot)
--   local ok, err = PlotManager.MovePlayer(player, otherFreePlot)
--
-- Clients can read ownership from attributes: plot:GetAttribute("OwnerUserId") (0 = free)
-- and player:GetAttribute("PlotName").

local Players = game:GetService("Players")

local PlotManager = {}

local assignedEvent = Instance.new("BindableEvent")
local releasedEvent = Instance.new("BindableEvent")
PlotManager.PlotAssigned = assignedEvent.Event -- (player: Player, plot: Model)
PlotManager.PlotReleased = releasedEvent.Event -- (player: Player, plot: Model)

local plotsFolder: Instance? = nil
local plotByPlayer: { [Player]: Model } = {}
local ownerByPlot: { [Model]: Player } = {}
local spawnConnections: { [Player]: RBXScriptConnection } = {}

local SPAWN_DELAY = 0.15 -- let the default spawn finish before moving the character

local function slotNumber(plot: Instance): number
	return tonumber(string.match(plot.Name, "%d+")) or math.huge
end

local function sortedPlots(): { Model }
	local list = {}
	if plotsFolder then
		for _, child in ipairs(plotsFolder:GetChildren()) do
			if child:IsA("Model") then
				table.insert(list, child)
			end
		end
	end
	table.sort(list, function(a, b)
		return slotNumber(a) < slotNumber(b)
	end)
	return list
end

local function setSign(plot: Model, player: Player?)
	local sign = plot:FindFirstChild("Sign")
	local gui = sign and sign:FindFirstChildWhichIsA("SurfaceGui")
	local label = gui and gui:FindFirstChild("OwnerName")
	if label and label:IsA("TextLabel") then
		label.Text = if player then player.DisplayName .. "'s Base" else "Empty Base"
	end
end

local function teleportToPlot(player: Player)
	local plot = plotByPlayer[player]
	local character = player.Character
	if not plot or not character then
		return
	end
	local spawnPart = plot:FindFirstChild("Spawn", true)
	local target: CFrame
	if spawnPart and spawnPart:IsA("BasePart") then
		target = spawnPart.CFrame
	else
		target = plot:GetPivot()
	end
	character:PivotTo(target + Vector3.new(0, 3, 0))
end

local function claim(player: Player, plot: Model)
	plotByPlayer[player] = plot
	ownerByPlot[plot] = player
	plot:SetAttribute("OwnerUserId", player.UserId)
	player:SetAttribute("PlotName", plot.Name)
	setSign(plot, player)
end

local function unclaim(player: Player, plot: Model)
	plotByPlayer[player] = nil
	ownerByPlot[plot] = nil
	plot:SetAttribute("OwnerUserId", 0)
	player:SetAttribute("PlotName", nil)
	setSign(plot, nil)
end

function PlotManager.GetPlot(player: Player): Model?
	return plotByPlayer[player]
end

function PlotManager.GetOwner(plot: Model): Player?
	return ownerByPlot[plot]
end

function PlotManager.GetFreePlots(): { Model }
	local free = {}
	for _, plot in ipairs(sortedPlots()) do
		if not ownerByPlot[plot] then
			table.insert(free, plot)
		end
	end
	return free
end

function PlotManager.Assign(player: Player): Model?
	if plotByPlayer[player] then
		return plotByPlayer[player]
	end
	local plot = PlotManager.GetFreePlots()[1]
	if not plot then
		player:SetAttribute("PlotUnavailable", true)
		warn(("[PlotManager] No free plot for %s"):format(player.Name))
		return nil
	end
	claim(player, plot)

	-- Teleport now and on every respawn.
	if spawnConnections[player] then
		spawnConnections[player]:Disconnect()
	end
	spawnConnections[player] = player.CharacterAdded:Connect(function()
		task.wait(SPAWN_DELAY)
		teleportToPlot(player)
	end)
	if player.Character then
		task.delay(SPAWN_DELAY, teleportToPlot, player)
	end

	assignedEvent:Fire(player, plot)
	return plot
end

function PlotManager.Release(player: Player)
	local plot = plotByPlayer[player]
	if spawnConnections[player] then
		spawnConnections[player]:Disconnect()
		spawnConnections[player] = nil
	end
	if not plot then
		return
	end
	unclaim(player, plot)
	releasedEvent:Fire(player, plot)
end

-- Move a player to another free plot (validated on the server, like steal-a-brainrot's
-- BaseManagerService). Listeners of PlotReleased / PlotAssigned rebuild the base.
function PlotManager.MovePlayer(player: Player, target: Model): (boolean, string?)
	local current = plotByPlayer[player]
	if not current then
		return false, "You don't have a base yet."
	end
	if target == current then
		return false, "You are already on this base."
	end
	if not target.Parent or target.Parent ~= plotsFolder then
		return false, "That base does not exist."
	end
	if ownerByPlot[target] then
		return false, "That base is taken."
	end
	unclaim(player, current)
	releasedEvent:Fire(player, current)
	claim(player, target)
	assignedEvent:Fire(player, target)
	teleportToPlot(player)
	return true, nil
end

function PlotManager.Init(folder: Instance)
	plotsFolder = folder
	for _, plot in ipairs(sortedPlots()) do
		plot:SetAttribute("OwnerUserId", 0)
		setSign(plot, nil)
	end
	Players.PlayerAdded:Connect(function(player)
		PlotManager.Assign(player)
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(PlotManager.Assign, player)
	end
	Players.PlayerRemoving:Connect(PlotManager.Release)
end

return PlotManager
