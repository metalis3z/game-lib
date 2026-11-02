-- Reference copy for study. Game: drill-and-mine
-- Original: ServerScriptService/Source/Services/PlotService.lua
-- What it does: The smallest clean plot assigner in the set (~100 lines): sorts plots by number, gives the
--   first one with OwnerUserId == 0, teleports the player there on every spawn, and runs registered reset
--   callbacks when they leave.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local PlotService = {}

local PLOTS_FOLDER = Workspace:WaitForChild("Assets"):WaitForChild("Plots")

local assignedPlots = {}
local resetCallbacks = {}

local function teleportPlayerToPlot(player, plot)
	local character = player.Character
	if not character then return end

	local spawnPart = plot:FindFirstChild("SpawnLocation") or plot.PrimaryPart
	if not spawnPart then return end

	character:PivotTo(spawnPart.CFrame + Vector3.new(0, 3, 0))
end

function PlotService.RegisterResetCallback(fn)
	table.insert(resetCallbacks, fn)
end

function PlotService.GetPlot(player)
	return assignedPlots[player]
end

function PlotService.AssignPlot(player)
	if assignedPlots[player] then return assignedPlots[player] end

	local plots = PLOTS_FOLDER:GetChildren()
	table.sort(plots, function(a, b)
		local an = tonumber(a.Name:match("%d+")) or 0
		local bn = tonumber(b.Name:match("%d+")) or 0
		return an < bn
	end)

	for _, plot in ipairs(plots) do
		local currentOwner = plot:GetAttribute("OwnerUserId")
		if currentOwner == nil or currentOwner == 0 then
			assignedPlots[player] = plot
			plot:SetAttribute("OwnerUserId", player.UserId)

			if player.Character then
				task.wait(0.1)
				teleportPlayerToPlot(player, plot)
			end

			return plot
		end
	end

	-- this game ships no plots (Assets.Plots is empty -- vestigial system from
	-- the brainrot codebase), so an empty folder is normal; only warn when
	-- plots exist but every one is taken
	if #plots > 0 then
		warn(string.format("[PlotService] No available plots for %s", player.Name))
	end
end

function PlotService.UnassignPlot(player)
	local plot = assignedPlots[player]
	assignedPlots[player] = nil

	if plot then
		for _, cb in ipairs(resetCallbacks) do
			pcall(cb, plot)
		end
		plot:SetAttribute("OwnerUserId", 0)
	end
end

function PlotService.Init()
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		if plot:IsA("Model") then
			plot:SetAttribute("OwnerUserId", 0)
		end
	end

	Players.PlayerAdded:Connect(function(player)
		PlotService.AssignPlot(player)

		player.CharacterAdded:Connect(function()
			task.wait(0.2)
			local plot = assignedPlots[player]
			if plot then
				teleportPlayerToPlot(player, plot)
			end
		end)
	end)

	Players.PlayerRemoving:Connect(function(player)
		PlotService.UnassignPlot(player)
	end)
end

return PlotService