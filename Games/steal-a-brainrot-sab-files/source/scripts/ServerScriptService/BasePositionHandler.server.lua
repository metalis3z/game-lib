local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlotService = require(ServerScriptService.Services.PlotService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local BasePositionEvent = ReplicatedStorage:WaitForChild("BasePositionEvent")

BasePositionEvent.OnServerEvent:Connect(function(player, targetPosition)
	targetPosition = tonumber(targetPosition)
	if not targetPosition or targetPosition < 1 or targetPosition > 8 then
		BasePositionEvent:FireClient(player, "error", "Position invalide")
		return
	end

	local playerPlot = PlotService.getPlot(player)
	if not playerPlot then
		BasePositionEvent:FireClient(player, "error", "Vous n'avez pas de base")
		return
	end

	if playerPlot:GetAttribute("Order") == targetPosition then
		BasePositionEvent:FireClient(player, "error", "Vous êtes déjà à cette base !")
		return
	end

	local targetPlot
	for _, plot in ipairs(workspace.Plots:GetChildren()) do
		if plot:GetAttribute("Order") == targetPosition then
			targetPlot = plot
			break
		end
	end

	if not targetPlot then
		BasePositionEvent:FireClient(player, "error", "Base introuvable")
		return
	end

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= player and PlotService.getPlot(plr) == targetPlot then
			BasePositionEvent:FireClient(player, "error", "Il y a déjà un joueur !")
			return
		end
	end

	local cfA = playerPlot:GetPivot()
	local cfB = targetPlot:GetPivot()
	playerPlot:PivotTo(cfB)
	targetPlot:PivotTo(cfA)

	local orderA = playerPlot:GetAttribute("Order")
	local orderB = targetPlot:GetAttribute("Order")
	playerPlot:SetAttribute("Order", orderB)
	targetPlot:SetAttribute("Order", orderA)

	local channel = Synchronizer:Get(playerPlot.Name)
	if channel then
		channel:Set("AnimalList", channel:Get("AnimalList"))
		channel:Set("Owner", channel:Get("Owner"))
	end

	local spawn = playerPlot:FindFirstChild("Spawn")
	if spawn and player.Character then
		local hrp = player.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = spawn.CFrame
		end
	end

	BasePositionEvent:FireClient(player, "success", "Base changée !")
end)