local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Net = require(ReplicatedStorage.Packages.Net)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local SigningRemote = Net:RemoteEvent("SigningSystem")

-- State
local isWhitelisted = false
local initialized = false
local currentView = "players" -- "players" or "animals"
local selectedPlot = nil

-- ===== UI REFERENCES =====
local signGui
local signPanel
local content
local backButton
local infoLabel
local closeButton
local title

-- ===== UI HELPERS =====
local function clearContent()
	for _, child in ipairs(content:GetChildren()) do
		if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
			child:Destroy()
		end
	end
end

local function createEntryButton(text, subtitle, onClick)
	local button = Instance.new("TextButton")
	button.Name = "Entry"
	button.Size = UDim2.new(1, -10, 0, 60)
	button.Position = UDim2.new(0, 5, 0, 0)
	button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
	button.Text = ""
	button.BorderSizePixel = 0
	button.AutoButtonColor = true
	button.LayoutOrder = 0

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(60, 50, 80)
	stroke.Thickness = 1
	stroke.Parent = button

	local mainText = Instance.new("TextLabel")
	mainText.Name = "MainText"
	mainText.Size = UDim2.new(1, -20, 0, 35)
	mainText.Position = UDim2.new(0, 10, 0, 5)
	mainText.BackgroundTransparency = 1
	mainText.Text = text
	mainText.TextColor3 = Color3.fromRGB(255, 255, 255)
	mainText.Font = Enum.Font.GothamBold
	mainText.TextSize = 16
	mainText.TextXAlignment = Enum.TextXAlignment.Left
	mainText.Parent = button

	local subText = Instance.new("TextLabel")
	subText.Name = "SubText"
	subText.Size = UDim2.new(1, -20, 0, 20)
	subText.Position = UDim2.new(0, 10, 0, 35)
	subText.BackgroundTransparency = 1
	subText.Text = subtitle or ""
	subText.TextColor3 = Color3.fromRGB(170, 85, 255)
	subText.Font = Enum.Font.GothamMedium
	subText.TextSize = 12
	subText.TextXAlignment = Enum.TextXAlignment.Left
	subText.Parent = button

	button.MouseButton1Click:Connect(onClick)
	button.Parent = content
	return button
end

-- ===== VIEWS =====
local function showPlayerView(playerList)
	currentView = "players"
	title.Text = "Signing System - Select a Base"
	backButton.Visible = false
	infoLabel.Visible = false
	clearContent()

	if #playerList == 0 then
		local emptyLabel = Instance.new("TextLabel")
		emptyLabel.Size = UDim2.new(1, -10, 0, 40)
		emptyLabel.BackgroundTransparency = 1
		emptyLabel.Text = "No players with bases found"
		emptyLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
		emptyLabel.Font = Enum.Font.GothamMedium
		emptyLabel.TextSize = 14
		emptyLabel.Parent = content
		return
	end

	for _, entry in ipairs(playerList) do
		local subtitle = string.format("Plot #%d", entry.plotNumber)
		createEntryButton(entry.displayName .. " (" .. entry.username .. ")", subtitle, function()
			selectedPlot = entry
			SigningRemote:FireServer("GetPlotAnimals", { plotName = entry.plotName })
		end)
	end
end

local function showAnimalsView(animalData)
	currentView = "animals"
	title.Text = "Sign Brainrot - " .. (selectedPlot and selectedPlot.displayName or "Unknown")
	backButton.Visible = true
	infoLabel.Visible = true
	infoLabel.Text = "Click an animal to sign it"
	clearContent()

	local animals = animalData.animals or {}
	if #animals == 0 then
		local emptyLabel = Instance.new("TextLabel")
		emptyLabel.Size = UDim2.new(1, -10, 0, 40)
		emptyLabel.BackgroundTransparency = 1
		emptyLabel.Text = "No animals found on this base"
		emptyLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
		emptyLabel.Font = Enum.Font.GothamMedium
		emptyLabel.TextSize = 14
		emptyLabel.Parent = content
		return
	end

	for _, animal in ipairs(animals) do
		local subtitleParts = { animal.rarity }
		if animal.mutation then
			table.insert(subtitleParts, "Mutation: " .. animal.mutation)
		end
		if animal.traits and type(animal.traits) == "table" and #animal.traits > 0 then
			table.insert(subtitleParts, "Traits: " .. table.concat(animal.traits, ", "))
		end
		local subtitle = table.concat(subtitleParts, " | ")

		local isSigned = animal.signedBy ~= nil

		if isSigned then
			subtitle = subtitle .. " | Signed By " .. animal.signedBy
		else
			subtitle = subtitle .. " | Not Signed"
		end

		local button = createEntryButton(animal.displayName, subtitle, function()
			if isSigned then
				infoLabel.Text = "Already signed by " .. animal.signedBy
				return
			end
			SigningRemote:FireServer("SignAnimal", {
				plotName = selectedPlot.plotName,
				podiumIndex = animal.podiumIndex,
			})
			infoLabel.Text = "Signing " .. animal.displayName .. "..."
		end)

		-- Visually mark already-signed animals with a different color
		if isSigned then
			button.BackgroundColor3 = Color3.fromRGB(45, 30, 30)
			button.AutoButtonColor = false
			local stroke = button:FindFirstChildOfClass("UIStroke")
			if stroke then
				stroke.Color = Color3.fromRGB(100, 50, 50)
			end
		end
	end
end

-- ===== EVENT HANDLERS =====
SigningRemote.OnClientEvent:Connect(function(action, data)
	if action == "WhitelistResult" then
		isWhitelisted = data and data.whitelisted == true
		if isWhitelisted and not initialized then
			initialized = true
			-- Show the Sign button
			local leftCenter = PlayerGui:FindFirstChild("LeftCenter")
			if leftCenter then
				local buttons = leftCenter.LeftCenter:FindFirstChild("Buttons")
				if buttons then
					local signButton = buttons:FindFirstChild("Sign")
					if signButton then
						signButton.Visible = true
					end
				end
			end

			-- Register the Sign interface with InterfaceController
			signGui = PlayerGui:WaitForChild("Sign")
			signPanel = signGui:WaitForChild("SignPanel")
			content = signPanel:WaitForChild("Content")
			backButton = signPanel:WaitForChild("Back")
			infoLabel = signPanel:WaitForChild("Info")
			closeButton = signPanel:WaitForChild("Close")
			title = signPanel:WaitForChild("Title")

			-- Register interface so the Sign button toggle works
			local signInterface = InterfaceController:Register("Sign", signPanel, "Custom")

			-- Custom style doesn't auto-hide on Close, so handle it manually
			signInterface.OnClose:Connect(function()
				signPanel.Visible = false
			end)

			-- Properly close the interface to sync State with visibility
			-- (Interface defaults to State=true, but we want it closed initially)
			InterfaceController:Toggle("Sign", false)

			-- Close button handler
			closeButton.MouseButton1Click:Connect(function()
				InterfaceController:Toggle("Sign", false)
			end)

			-- Back button handler
			backButton.MouseButton1Click:Connect(function()
				if currentView == "animals" then
					SigningRemote:FireServer("GetPlayerPlots")
				end
			end)

			-- When the panel is opened, refresh the player list
			signInterface.OnOpen:Connect(function()
				SigningRemote:FireServer("GetPlayerPlots")
			end)

			-- Request initial player list
			SigningRemote:FireServer("GetPlayerPlots")
		end

	elseif action == "PlayerPlots" then
		if isWhitelisted and signPanel and signPanel.Visible then
			showPlayerView(data or {})
		end

	elseif action == "PlotAnimals" then
		if isWhitelisted and signPanel and signPanel.Visible then
			if data and data.error then
				infoLabel.Text = "Error: " .. data.error
			else
				showAnimalsView(data or {})
			end
		end

	elseif action == "SignResult" then
		if data and data.success then
			infoLabel.Text = "Successfully signed!"
			if NotificationController then
				NotificationController:Success("Successfully signed this brainrot!")
			end
		else
			infoLabel.Text = "Error: " .. (data and data.error or "Unknown error")
			if NotificationController then
				NotificationController:Error("Failed to sign: " .. (data and data.error or "Unknown error"))
			end
		end

		-- Refresh the animal list after signing
		if selectedPlot then
			task.wait(0.5)
			SigningRemote:FireServer("GetPlotAnimals", { plotName = selectedPlot.plotName })
		end
	end
end)

-- Initially hide the Sign button for all players
-- It will be shown when the server confirms whitelist status
task.spawn(function()
	local leftCenter = PlayerGui:WaitForChild("LeftCenter")
	local buttons = leftCenter.LeftCenter:WaitForChild("Buttons")
	local signButton = buttons:WaitForChild("Sign")
	signButton.Visible = false
end)

-- Request whitelist check on start
task.wait(2)
SigningRemote:FireServer("CheckWhitelist")
