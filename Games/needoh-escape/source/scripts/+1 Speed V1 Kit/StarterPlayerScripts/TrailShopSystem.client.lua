--!strict
-- LOCATION: StarterPlayerScripts/TrailShopSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local TrailConfigurations = require(ReplicatedStorage.Modules.TrailConfigurations)
local MonetizationSystem = require(ReplicatedStorage.Modules.MonetizationSystem)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("GUI")
local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local trailEvent = eventsFolder:WaitForChild("TrailAction") :: RemoteEvent

local frames = gui:WaitForChild("Frames")
local trailsFrame = frames:WaitForChild("Trails")
local scrolling = trailsFrame:WaitForChild("Scrolling")
local template = ReplicatedStorage:WaitForChild("Templates"):WaitForChild("TrailTemplate")

-- FIX: Close button in the Trails frame
local closeButton = trailsFrame:FindFirstChild("CloseButton") :: ImageButton
if closeButton then
	closeButton.MouseButton1Click:Connect(function()
		trailsFrame.Visible = false
	end)
end

local priceCache = {}

local function updateButtons(frame: Frame, info: any, isOwned: boolean, isEquipped: boolean)
	local buttons = frame:FindFirstChild("Buttons")
	if not buttons then return end

	local winBtn = buttons:FindFirstChild("Wins") :: ImageButton
	local robuxBtn = buttons:FindFirstChild("Robux") :: ImageButton
	local equipBtn = buttons:FindFirstChild("Equip") :: ImageButton

	if winBtn then winBtn.Visible = false end
	if robuxBtn then robuxBtn.Visible = false end
	if equipBtn then equipBtn.Visible = false end

	if isOwned then
		if equipBtn then
			equipBtn.Visible = true
			local btnText = equipBtn:FindFirstChild("Text") :: TextLabel

			if isEquipped then
				equipBtn.AutoButtonColor = false
				equipBtn.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
				if btnText then btnText.Text = "Unequip" end
			else
				equipBtn.AutoButtonColor = true
				equipBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
				if btnText then btnText.Text = "Equip" end
			end
		end
	else
		if winBtn then
			winBtn.Visible = true
			local t = winBtn:FindFirstChild("Text") :: TextLabel
			if t then t.Text = NumberFormatter.Format(info.WinCost) end
		end

		if robuxBtn then
			robuxBtn.Visible = true
			local t = robuxBtn:FindFirstChild("Text") :: TextLabel

			if t then
				if priceCache[info.ProductId] then
					t.Text = "" .. tostring(priceCache[info.ProductId])
				else
					t.Text = "..."

					task.spawn(function()
						local success, productInfo = pcall(function()
							return MarketplaceService:GetProductInfo(info.ProductId, Enum.InfoType.Product)
						end)

						if success and productInfo then
							priceCache[info.ProductId] = productInfo.PriceInRobux
							t.Text = "" .. tostring(productInfo.PriceInRobux)
						else
							t.Text = "Error"
						end
					end)
				end
			end
		end
	end
end

local function populateShop()
	for _, child in ipairs(scrolling:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end

	for _, info in ipairs(TrailConfigurations.Trails) do
		local clone = template:Clone()
		clone.Name = info.ID
		clone.Visible = true

		local nameLabel = clone:FindFirstChild("Name") :: TextLabel
		if nameLabel then nameLabel.Text = info.Name end

		local speedLabel = clone:FindFirstChild("SpeedBoost") :: TextLabel
		if speedLabel then speedLabel.Text = "x" .. tostring(info.SpeedBoost) .. " Points" end

		-- FIX: Populate the Range TextLabel in the template
		local rangeLabel = clone:FindFirstChild("Range") :: TextLabel
		if rangeLabel then
			if info.Range then
				rangeLabel.Text = "Range: " .. tostring(info.Range)
				rangeLabel.Visible = true
			else
				rangeLabel.Text = ""
				rangeLabel.Visible = false
			end
		end

		local imageLabel = clone:FindFirstChild("Image") :: ImageLabel
		if imageLabel and info.Image then
			imageLabel.Image = info.Image
		end

		clone.Parent = scrolling

		local btns = clone:FindFirstChild("Buttons")
		if btns then
			local winBtn = btns:FindFirstChild("Wins") :: ImageButton
			local robuxBtn = btns:FindFirstChild("Robux") :: ImageButton
			local equipBtn = btns:FindFirstChild("Equip") :: ImageButton

			if winBtn then
				winBtn.MouseButton1Click:Connect(function()
					trailEvent:FireServer("BuyWins", info.ID)
				end)
			end

			if robuxBtn then
				robuxBtn.MouseButton1Click:Connect(function()
					MonetizationSystem.PromptProduct(info.ProductId)
				end)
			end

			if equipBtn then
				equipBtn.MouseButton1Click:Connect(function()
					local trails = player:FindFirstChild("Trails")
					local equipped = trails and trails:FindFirstChild("Equipped") :: StringValue
					if equipped and equipped.Value == info.ID then
						trailEvent:FireServer("Unequip", info.ID)
					else
						trailEvent:FireServer("Equip", info.ID)
					end
				end)
			end
		end
	end
end

local function refreshShopStates()
	local trails = player:WaitForChild("Trails")
	local equippedVal = trails:WaitForChild("Equipped") :: StringValue

	local equippedId = equippedVal.Value
	local owned = {}
	for _, child in ipairs(trails:GetChildren()) do
		if child.Name ~= "Equipped" then
			owned[child.Name] = true
		end
	end

	for _, child in ipairs(scrolling:GetChildren()) do
		if child:IsA("Frame") then
			local info = TrailConfigurations.GetTrailById(child.Name)
			if info then
				local isOwned = owned[info.ID] == true
				local isEquipped = (equippedId == info.ID)
				updateButtons(child, info, isOwned, isEquipped)
			end
		end
	end
end

local function init()
	populateShop()

	local trails = player:WaitForChild("Trails")
	trails.ChildAdded:Connect(refreshShopStates)
	trails:WaitForChild("Equipped").Changed:Connect(refreshShopStates)

	refreshShopStates()
end

init()