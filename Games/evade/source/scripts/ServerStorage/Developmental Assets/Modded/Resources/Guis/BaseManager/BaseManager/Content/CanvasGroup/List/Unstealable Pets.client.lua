local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)

local BuyUnstealablePets = Net:RemoteFunction("RobuxShopService/BuyUnstealablePets")

local playerPlot
repeat
	for _, plot in pairs(workspace.Plots:GetChildren()) do
		if plot.PlotSign.SurfaceGui.Frame.TextLabel.Text == string.format("%*'s Base", game.Players.LocalPlayer.DisplayName) then
			playerPlot = plot
		end
	end
	task.wait(1)
until playerPlot

if not playerPlot then return end

local AnimalPodiums = playerPlot:FindFirstChild("AnimalPodiums")
if not AnimalPodiums then return end

local selectedPodium = nil
local selectionEnabled = false

local HOVER_COLOR = Color3.fromRGB(200, 200, 200)
local SELECTED_COLOR = Color3.fromRGB(75, 255, 75)

local mainFrame = script.Parent.Unstealable.Frame

local function setClickDetectorsEnabled(enabled)
	for _, podium in ipairs(AnimalPodiums:GetChildren()) do
		local clickDetector = podium.Claim.Hitbox:FindFirstChild("ClickDetector")
		if clickDetector then
			clickDetector.MaxActivationDistance = enabled and 32 or 0
		end
	end
end

local function setupPodiumInteraction(podium)
	local interactionPart = podium.Claim.Hitbox

	local highlight = podium:FindFirstChild("Highlight")
	if not highlight then
		highlight = Instance.new("Highlight")
		highlight.FillColor = HOVER_COLOR
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 0.5
		highlight.Enabled = false
		highlight.Parent = podium
	end

	local clickDetector = interactionPart:FindFirstChild("ClickDetector")
	if not clickDetector then
		clickDetector = Instance.new("ClickDetector")
		clickDetector.Parent = interactionPart
	end
	
	clickDetector.MaxActivationDistance = selectionEnabled and 32 or 0

	clickDetector.MouseHoverEnter:Connect(function()
		if podium ~= selectedPodium and selectionEnabled then
			highlight.FillColor = HOVER_COLOR
			highlight.Enabled = true
		end
	end)

	clickDetector.MouseHoverLeave:Connect(function()
		if podium ~= selectedPodium then
			highlight.Enabled = false
		end
	end)

	clickDetector.MouseClick:Connect(function()
		if not selectionEnabled then return end

		if selectedPodium and selectedPodium:FindFirstChild("Highlight") then
			selectedPodium.Highlight.Enabled = false
		end

		selectedPodium = podium
		highlight.FillColor = SELECTED_COLOR
		highlight.Enabled = true

		mainFrame.Select.ImageColor3 = Color3.fromRGB(255, 255, 255)
		mainFrame.Select.Price.Text = "SELECT"
		selectionEnabled = false

		setClickDetectorsEnabled(false)

		for _, podium in ipairs(AnimalPodiums:GetChildren()) do
			local highlight = podium:FindFirstChild("Highlight")
			if highlight and podium ~= selectedPodium then
				highlight.Enabled = false
			end
		end

		InterfaceController:Toggle("BaseManager", true)
	end)
end

local function updateAllInteractions()
	for _, podium in ipairs(AnimalPodiums:GetChildren()) do
		setupPodiumInteraction(podium)
	end
end

local Toggle = AnimatedButton.new(mainFrame.Select)
Toggle:Animate()
Toggle.OnActivated:Connect(function()
	if mainFrame.Select.ImageColor3 == Color3.fromRGB(255, 0, 0) then
		mainFrame.Select.ImageColor3 = Color3.fromRGB(255, 255, 255)
		mainFrame.Select.Price.Text = "SELECT"
		selectionEnabled = false

		setClickDetectorsEnabled(false)

		for _, podium in ipairs(AnimalPodiums:GetChildren()) do
			local highlight = podium:FindFirstChild("Highlight")
			if highlight and podium ~= selectedPodium then
				highlight.Enabled = false
			end
		end
	else
		mainFrame.Select.ImageColor3 = Color3.fromRGB(255, 0, 0)
		mainFrame.Select.Price.Text = "UNSELECT"
		selectionEnabled = true

		InterfaceController:Toggle("BaseManager", false)

		updateAllInteractions()
		setClickDetectorsEnabled(true)
	end
end)

local Toggle = AnimatedButton.new(mainFrame.Buy)
Toggle:Animate()
Toggle.OnActivated:Connect(function()
	if selectedPodium then
		local success, msg = BuyUnstealablePets:InvokeServer(selectedPodium)
		if success then
			if selectedPodium:FindFirstChild("Highlight") then
				selectedPodium.Highlight.Enabled = false
			end
			selectedPodium = nil
		else
			NotificationController:Error(msg)
		end
	else
		NotificationController:Error("Please select a brainrot.")
	end
end)