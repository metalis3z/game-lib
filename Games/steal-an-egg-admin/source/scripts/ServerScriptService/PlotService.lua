--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Homestead = Remotes.Homestead

local PlotService = {}

local plotsFolder = workspace:FindFirstChild("Plots")

local playerPlots: {[Player]: Model} = {}
local plotOwners: {[Model]: Player} = {}

local unclaimed_text = "Unclaimed"

local revision = 0

local function slotNumberOf(plot: Model): number?
	return tonumber(plot.Name)
end

local function broadcastShift(plot: Model, ownerId: number?)
	local slot = slotNumberOf(plot)
	if not slot then
		return
	end
	revision += 1
	Homestead.StateShifted:FireAllClients({
		Revision = revision,
		Slot = slot,
		UserId = ownerId,
	})
end

local function snapshot(): {Revision: number, OwnersBySlot: {[string]: number}}
	local ownersBySlot: {[string]: number} = {}
	if plotsFolder then
		for _, plot in plotsFolder:GetChildren() do
			if plot:IsA("Model") then
				local slot = slotNumberOf(plot)
				local owner = plotOwners[plot]
				if slot and owner then
					ownersBySlot[plot.Name] = owner.UserId
				end
			end
		end
	end
	return {
		Revision = revision,
		OwnersBySlot = ownersBySlot,
	}
end

local function findSignLabel(plot: Model): TextLabel?
	local plotSign = plot:FindFirstChild("PlotSign")
	if not plotSign then
		return nil
	end
	local attachment = plotSign:FindFirstChild("Attachment")
	if not attachment then
		return nil
	end
	local yourBase = attachment:FindFirstChild("YourBase")
	if not yourBase then
		return nil
	end
	for _, descendant in yourBase:GetDescendants() do
		if descendant:IsA("TextLabel") then
			return descendant
		end
	end
	return nil
end

local function ensureSignLabel(plot: Model): TextLabel?
	local plotSign = plot:FindFirstChild("PlotSign")
	if not plotSign then
		return nil
	end
	local attachment = plotSign:FindFirstChild("Attachment")
	if not attachment then
		attachment = Instance.new("Attachment")
		attachment.Name = "Attachment"
		attachment.Parent = plotSign
	end

	local existingTag = attachment:FindFirstChild("OwnerTag")
	if existingTag then
		local existingLabel = existingTag:FindFirstChild("OwnerLabel")
		if existingLabel and existingLabel:IsA("TextLabel") then
			return existingLabel
		end
	end

	local tag = Instance.new("BillboardGui")
	tag.Name = "OwnerTag"
	tag.AlwaysOnTop = true
	tag.Enabled = true
	tag.Size = UDim2.fromScale(20, 5)
	tag.StudsOffset = Vector3.new(0, 6, 0)
	tag.MaxDistance = 150
	tag.Parent = attachment

	local label = Instance.new("TextLabel")
	label.Name = "OwnerLabel"
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextStrokeTransparency = 0.4
	label.Text = unclaimed_text
	label.Parent = tag
	return label
end

local function setPlotOwnerPresentation(plot: Model, player: Player?)
	if player then
		plot:SetAttribute("OwnerUserId", player.UserId)
		plot:SetAttribute("OwnerName", player.Name)
		plot:SetAttribute("OwnerDisplayName", player.DisplayName)
	else
		plot:SetAttribute("OwnerUserId", nil)
		plot:SetAttribute("OwnerName", nil)
		plot:SetAttribute("OwnerDisplayName", nil)
	end

	local label = ensureSignLabel(plot)
	if label then
		label.Text = player and player.DisplayName or unclaimed_text
	end
end

local function moveToSpawnPoint(character: Model, plot: Model)
	local spawnPoint = plot:FindFirstChild("SpawnPoint")
	if not spawnPoint or not spawnPoint:IsA("BasePart") then
		return
	end
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root or not root:IsA("BasePart") then
		return
	end
	local offset = Vector3.new(0, 3, 0)
	character:PivotTo(spawnPoint.CFrame + offset)
end

local function onCharacterAdded(player: Player, character: Model)
	local plot = playerPlots[player]
	if plot then
		moveToSpawnPoint(character, plot)
	end
end



local function getFreePlot(): Model?
	if not plotsFolder then
		return nil
	end
	for _, plot in plotsFolder:GetChildren() do
		if plot:IsA("Model") and plotOwners[plot] == nil then
			return plot
		end
	end
	return nil
end

function PlotService.GetPlayerPlot(player: Player): Model?
	return playerPlots[player]
end

function PlotService.GetPlotOwner(plot: Model): Player?
	return plotOwners[plot]
end

function PlotService.GetPlotOwnerId(plot: Model): number?
	local owner = plotOwners[plot]
	return owner and owner.UserId or nil
end

function PlotService.AssignPlot(player: Player): Model?
	if playerPlots[player] then
		return playerPlots[player]
	end

	local plot = getFreePlot()
	if not plot then
		warn(`[PlotService] No free plots available for {player.Name}.`)
		return nil
	end

	playerPlots[player] = plot
	plotOwners[plot] = player
	setPlotOwnerPresentation(plot, player)
	broadcastShift(plot, player.UserId)

	local character = player.Character
	if character then
		moveToSpawnPoint(character, plot)
	end

	print(`[PlotService] Assigned plot '{plot.Name}' to {player.Name}.`)
	return plot
end

function PlotService.ReleasePlot(player: Player)
	local plot = playerPlots[player]
	if not plot then
		return
	end
	playerPlots[player] = nil
	plotOwners[plot] = nil
	setPlotOwnerPresentation(plot, nil)
	broadcastShift(plot, nil)
	print(`[PlotService] Released plot '{plot.Name}' from {player.Name}.`)
end

local function onPlayerAdded(player: Player)
	PlotService.AssignPlot(player)
	player.CharacterAdded:Connect(function(character)
		onCharacterAdded(player, character)
	end)
end

function PlotService.Init()
	Homestead.AskState.OnServerInvoke = function()
		return snapshot()
	end

	if not plotsFolder then
		warn("[PlotService] Workspace.Plots not found; plot assignment disabled.")
		return
	end

	for _, plot in plotsFolder:GetChildren() do
		if plot:IsA("Model") then
			setPlotOwnerPresentation(plot, nil)
		end
	end
end

function PlotService.Start()
	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(function(player)
		PlotService.ReleasePlot(player)
	end)

	for _, player in Players:GetPlayers() do
		onPlayerAdded(player)
	end
end

return PlotService