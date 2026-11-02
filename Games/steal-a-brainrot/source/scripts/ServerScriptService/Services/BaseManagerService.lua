local BaseManagerService = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PlotService = require(ServerScriptService.Services.PlotService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local GetFreeBases = Net:RemoteFunction("BaseManagerService/GetFreeBases")
local RequestChangeBase = Net:RemoteEvent("BaseManagerService/RequestChangeBase")
local ChangeBaseResult = Net:RemoteEvent("BaseManagerService/ChangeBaseResult")

local COOLDOWN_SECONDS = 3
local lastRequestTime: { [Player]: number } = {}

-- Renvoie au client la liste des bases actuellement libres, sous une forme simple
-- utilisable directement par la GUI (Id = nom du Plot, Label = numéro d'affichage).
GetFreeBases.OnServerInvoke = function(Player: Player)
	local FreePlots = PlotService.getFreePlots()

	local Result = {}
	for Index, Plot in ipairs(FreePlots) do
		table.insert(Result, {
			Id = Plot.Name,
			Label = string.format("Base #%d", Index),
		})
	end

	return Result
end

RequestChangeBase.OnServerEvent:Connect(function(Player: Player, TargetPlotId: string)
	if typeof(TargetPlotId) ~= "string" then
		return
	end

	local Now = os.clock()
	if lastRequestTime[Player] and Now - lastRequestTime[Player] < COOLDOWN_SECONDS then
		ChangeBaseResult:FireClient(Player, false, "Please wait a moment before switching base again.")
		return
	end
	lastRequestTime[Player] = Now

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		ChangeBaseResult:FireClient(Player, false, "Your data is still loading.")
		return
	end

	-- Retrouve le Plot cible parmi les bases actuellement libres (sécurité anti-triche côté serveur)
	local TargetPlot = nil
	for _, Plot in ipairs(PlotService.getFreePlots()) do
		if Plot.Name == TargetPlotId then
			TargetPlot = Plot
			break
		end
	end

	if not TargetPlot then
		ChangeBaseResult:FireClient(Player, false, "This base is no longer available.")
		return
	end

	local Success, Err = PlotService.movePlayerToFreePlot(Player, TargetPlot)

	if Success then
		NotificationService.Success(Player, "You moved to a new base! Your brainrots followed you.")
		ChangeBaseResult:FireClient(Player, true, nil)
	else
		NotificationService.Error(Player, Err or "Could not switch base.")
		ChangeBaseResult:FireClient(Player, false, Err)
	end
end)

Players.PlayerRemoving:Connect(function(Player: Player)
	lastRequestTime[Player] = nil
end)

return BaseManagerService
