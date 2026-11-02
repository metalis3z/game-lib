--!strict
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Network = require(script.Parent.Core_Network)

local Plots = {}
local Data
local plotFolder = Workspace:WaitForChild("Plots")
local plots = {}
local ownerByPlayer: {[Player]: Model} = {}
local ownerBySlot: {[number]: Player} = {}
local revision = 0

local BASE_COSTS = {
	[1] = 1_000,
	[2] = 1_000_000,
	[3] = 75_000_000,
	[4] = 500_000_000,
	[5] = 1_000_000_000,
	[6] = 50_000_000_000,
	[7] = 500_000_000_000,
	[8] = 1_000_000_000_000,
	[9] = 25_000_000_000_000,
	[10] = 100_000_000_000_000,
	[11] = 500_000_000_000_000,
	[12] = 1_000_000_000_000_000,
}

local function slotOf(plot: Model): number
	return tonumber(plot.Name) or 0
end

local function collectPlots()
	table.clear(plots)
	for _, child in ipairs(plotFolder:GetChildren()) do
		if child:IsA("Model") and tonumber(child.Name) then
			table.insert(plots, child)
		end
	end
	table.sort(plots, function(a, b)
		return slotOf(a) < slotOf(b)
	end)
end

local function getSignObjects(plot: Model)
	local plotSign = plot:FindFirstChild("PlotSign")
	local playerSign = plotSign and plotSign:FindFirstChild("PlayerPlotSign")
	local frame = playerSign and playerSign:FindFirstChild("Frame")
	return frame and frame:FindFirstChild("PlayerName"), frame and frame:FindFirstChild("PlayerIcon")
end

local function setSign(plot: Model, player: Player?)
	local nameLabel, icon = getSignObjects(plot)
	if nameLabel and nameLabel:IsA("TextLabel") then
		nameLabel.Text = if player then player.DisplayName .. "'s Farm" else "Unclaimed Farm"
	end
	if icon and icon:IsA("ImageLabel") then
		icon.Image = if player then ("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(player.UserId) else ""
	end
	plot:SetAttribute("OwnerUserId", if player then player.UserId else 0)
end

local function snapshot()
	local owners = {}
	for slot, player in pairs(ownerBySlot) do
		owners[tostring(slot)] = player.UserId
	end
	return {
		Revision = revision,
		OwnersBySlot = owners,
	}
end

local function teleportToPlot(player: Player, character: Model?)
	local plot = ownerByPlayer[player]
	character = character or player.Character
	if not plot or not character then
		return
	end
	local spawnPoint = plot:FindFirstChild("SpawnPoint", true)
	if spawnPoint and spawnPoint:IsA("BasePart") then
		character:PivotTo(spawnPoint.CFrame + Vector3.new(0, 3, 0))
	end
end

local function hideStarterGates(plot: Model)
	local toUpdate = plot:FindFirstChild("ToUpdate")
	local starterPen = toUpdate and toUpdate:FindFirstChild("StarterPen")
	local gates = starterPen and starterPen:FindFirstChild("Gate")
	if gates then
		for _, childGates in ipairs(gates:GetDescendants()) do
			if childGates:IsA("BasePart") then
				childGates.Transparency = 1
			end
		end
	end
end

local function assign(player: Player)
	if ownerByPlayer[player] then
		return
	end
	for _, plot in ipairs(plots) do
		local slot = slotOf(plot)
		if not ownerBySlot[slot] then
			ownerByPlayer[player] = plot
			ownerBySlot[slot] = player
			revision += 1
			player:SetAttribute("PlotSlot", slot)
			player:SetAttribute("PlotUnavailable", false)
			local profile = Data.Get(player)
			plot:SetAttribute("BaseUpgradeLevel", if profile then tonumber(profile.BaseUpgradeLevel) or 0 else 0)
			setSign(plot, player)
			Network.FireAll("Plots: StateUpdate", {
				Revision = revision,
				Slot = slot,
				UserId = player.UserId,
			})
			-- Handle future respawns (character dies and respawns)
			player.CharacterAdded:Connect(function(character)
				task.wait(0.15)
				teleportToPlot(player, character)
				hideStarterGates(plot)
			end)
			-- Handle the current character (may already exist from initial spawn)
			local currentChar = player.Character
			if currentChar then
				task.spawn(function()
					task.wait(0.15)
					teleportToPlot(player, currentChar)
					hideStarterGates(plot)
				end)
			end
			return
		end
	end
	player:SetAttribute("PlotUnavailable", true)
	warn(("[Plots] No free plot is available for %s"):format(player.Name))
end

local function release(player: Player)
	local plot = ownerByPlayer[player]
	if not plot then
		return
	end
	local toUpdate = plot:FindFirstChild("ToUpdate")
	local starterPen = toUpdate and toUpdate:FindFirstChild("StarterPen")
	local gates = starterPen and starterPen:FindFirstChild("Gate")
	if gates then
		for _, childGates in ipairs(gates:GetDescendants()) do
			if childGates:IsA("BasePart") then
				childGates.Transparency = 0
			end
		end
	end
	local slot = slotOf(plot)
	ownerByPlayer[player] = nil
	ownerBySlot[slot] = nil
	revision += 1
	player:SetAttribute("PlotSlot", nil)
	setSign(plot, nil)
	plot:SetAttribute("BaseUpgradeLevel", 0)
	Network.FireAll("Plots: StateUpdate", {
		Revision = revision,
		Slot = slot,
		UserId = nil,
	})
end

function Plots.GetPlot(player: Player): Model?
	return ownerByPlayer[player]
end

function Plots.GetSlot(player: Player): number?
	local plot = ownerByPlayer[player]
	return if plot then slotOf(plot) else nil
end

function Plots.GetCapacity(player: Player): number
	local profile = Data.Get(player)
	local level = if profile then tonumber(profile.BaseUpgradeLevel) or 0 else 0
	if level <= 1 then
		return 7
	end
	return math.min(18, level + 7)
end

function Plots.Init(dataService)
	Data = dataService
	collectPlots()
	for _, plot in ipairs(plots) do
		setSign(plot, nil)
	end

	Network.BindFunction("Plots: RequestState", function()
		return snapshot()
	end)

	local function buyUpgrade(player: Player)
		local profile = Data.Get(player)
		local plot = ownerByPlayer[player]
		if not profile or not plot then
			return
		end
		local current = tonumber(profile.BaseUpgradeLevel) or 0
		local nextLevel = current + 1
		local price = BASE_COSTS[nextLevel]
		if not price then
			Network.FireClient("Plots: OnBaseUpgraded", player, false, "Your base is fully upgraded.")
			return
		end
		local money = tonumber(profile.Money) or 0
		if money < price then
			Network.FireClient("Plots: OnBaseUpgraded", player, false, "You need more money.")
			return
		end
		Data.Update(player, {
			Money = money - price,
			BaseUpgradeLevel = nextLevel,
		})
		plot:SetAttribute("BaseUpgradeLevel", nextLevel)
		Network.FireClient("Plots: OnBaseUpgraded", player, true, nextLevel)
	end

	Network.BindEvent("Plots: RequestBaseUpgrade", buyUpgrade)
	Network.BindEvent("Plots: RequestProximityPurchase", buyUpgrade)
	Network.BindEvent("Plots: RequestLobbyTeleport", function(player)
		local spawns = Workspace:FindFirstChild("LobbySpawns", true)
		if not spawns or not player.Character then
			return
		end
		local choices = {}
		for _, child in ipairs(spawns:GetDescendants()) do
			if child:IsA("BasePart") then
				table.insert(choices, child)
			end
		end
		if #choices > 0 then
			player.Character:PivotTo(choices[math.random(1, #choices)].CFrame + Vector3.new(0, 3, 0))
		end
	end)

	Data.Loaded.Event:Connect(assign)
	Players.PlayerRemoving:Connect(release)
	for _, player in ipairs(Players:GetPlayers()) do
		if Data.Get(player) then
			assign(player)
		end
	end

	-- Fallback: periodically check for players who have data loaded but no plot.
	-- This catches cases where Data.Loaded fired before the connection was made
	-- or where assign() silently failed.
	task.spawn(function()
		while task.wait(2) do
			for _, player in ipairs(Players:GetPlayers()) do
				if not ownerByPlayer[player] and Data.Get(player) then
					assign(player)
				end
			end
		end
	end)
end

return Plots
