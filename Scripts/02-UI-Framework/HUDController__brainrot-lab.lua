-- Reference copy for study. Game: Brainrot Lab (brainrot-lab)
-- Original: StarterPlayer/StarterPlayerScripts/HUDController.client.lua
-- What it does: HUD controller that keeps money/power labels in sync with leaderstats, cycles a random-item button, wires a dev-product purchase and a game-invite button, with hover/press button animations.

--!strict
-- LOCATION: StarterPlayerScripts/HUDController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local SocialService = game:GetService("SocialService") 

local NumberFormatter = require(ReplicatedStorage:WaitForChild("Modules", 10):WaitForChild("NumberFormatter", 10))
local ItemConfigurations = require(ReplicatedStorage:WaitForChild("Modules", 10):WaitForChild("ItemConfigurations", 10))
local ProductConfigurations = require(ReplicatedStorage:WaitForChild("Modules", 10):WaitForChild("ProductConfigurations", 10))
local NotificationManager = require(ReplicatedStorage:WaitForChild("Modules", 10):WaitForChild("NotificationManager", 10)) 

local player = Players.LocalPlayer

local HOVER_SCALE = 1.05
local CLICK_SCALE = 0.95
local TWEEN_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

print("[HUDController] Loaded (Anti-Yield Safeguards Active)")

local function setupButtonAnimation(button: GuiButton)
	local uiScale = button:FindFirstChildOfClass("UIScale")
	if not uiScale then
		uiScale = Instance.new("UIScale")
		uiScale.Name = "AnimationScale"
		uiScale.Parent = button
	end

	button.MouseEnter:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = HOVER_SCALE}):Play() end)
	button.MouseLeave:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = 1}):Play() end)
	button.MouseButton1Down:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = CLICK_SCALE}):Play() end)
	button.MouseButton1Up:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = HOVER_SCALE}):Play() end)
end

-- Safely finds the TextLabel whether the parent is the label itself, or a frame holding it
local function findTextLabel(obj: Instance?): TextLabel?
	if not obj then return nil end
	if obj:IsA("TextLabel") then return obj end

	local txt = obj:FindFirstChild("Text")
	if txt and txt:IsA("TextLabel") then return txt end

	return obj:FindFirstChildWhichIsA("TextLabel", true)
end

local function setupHUD()
	local playerGui = player:WaitForChild("PlayerGui", 10)
	local gui = playerGui and playerGui:WaitForChild("GUI", 10)
	if not gui then return end

	local hud = gui:WaitForChild("HUD", 10)
	if not hud then return end

	local labels = hud:WaitForChild("Labels", 10)
	if not labels then return end

	-- Use timeouts so it never infinitely yields
	local moneyObj = labels:WaitForChild("Money", 10)
	local powerObj = labels:WaitForChild("Power", 10)

	local moneyLabel = findTextLabel(moneyObj)
	local powerLabel = findTextLabel(powerObj)

	local leaderstats = player:WaitForChild("leaderstats", 10)
	if not leaderstats then return end

	-- Automatically map to whatever the PlayerController is using
	local moneyStat = leaderstats:WaitForChild("Money", 10) or leaderstats:WaitForChild("Cash", 10) :: NumberValue
	local powerStat = leaderstats:WaitForChild("Power", 10) :: NumberValue

	local function updateHUD()
		if moneyLabel and moneyStat then
			moneyLabel.Text = "Money: $" .. NumberFormatter.Format(moneyStat.Value)
		end
		if powerLabel and powerStat then
			powerLabel.Text = "Power: " .. NumberFormatter.Format(powerStat.Value)
		end
	end

	if moneyStat then moneyStat.Changed:Connect(updateHUD) end
	if powerStat then powerStat.Changed:Connect(updateHUD) end

	updateHUD()

	-- Right Panel Logic (Random Item Cycler)
	local rightPanel = hud:WaitForChild("Right", 5)
	if rightPanel then
		local randomBtn = rightPanel:WaitForChild("Random", 5) :: TextButton
		if randomBtn then
			local itemImage = randomBtn:WaitForChild("Image", 5) :: ImageLabel
			local randomPriceLabel = findTextLabel(randomBtn:WaitForChild("Price", 5))
			local randomTextLabel = findTextLabel(randomBtn)

			setupButtonAnimation(randomBtn)

			local validItems = {}
			for name, data in pairs(ItemConfigurations.Items) do
				if data.Rarity ~= "Common" and data.Rarity ~= "Uncommon" then
					table.insert(validItems, data)
				end
			end

			if #validItems > 0 then
				local totalValidItems = #validItems
				if not randomBtn:GetAttribute("CyclerRunning") then
					randomBtn:SetAttribute("CyclerRunning", true)
					task.spawn(function()
						while randomBtn.Parent do
							local selectedData = validItems[math.random(1, totalValidItems)]
							if itemImage then itemImage.Image = selectedData.ImageId end
							if randomTextLabel then
								local itemChance = (1 / totalValidItems) * 100
								randomTextLabel.Text = string.format("Random (%.1f%%)", itemChance)
							end
							task.wait(1.5)
						end
					end)
				end
			end

			local randomProductId = ProductConfigurations.Products["RandomItem"]
			if randomProductId then
				task.spawn(function()
					local success, info = pcall(function() return MarketplaceService:GetProductInfo(randomProductId, Enum.InfoType.Product) end)
					if success and info and randomPriceLabel then
						randomPriceLabel.Text = "" .. tostring(info.PriceInRobux)
					else
						if randomPriceLabel then randomPriceLabel.Text = "N/A" end
					end
				end)
				randomBtn.MouseButton1Click:Connect(function() MarketplaceService:PromptProductPurchase(player, randomProductId) end)
			end
		end
	end

	-- Left Panel Logic (Invite Button)
	local leftPanel = hud:WaitForChild("Left", 5)
	local leftButtons = leftPanel and leftPanel:WaitForChild("Buttons", 5)
	if leftButtons then
		local inviteBtn = leftButtons:FindFirstChild("Invite") :: TextButton
		if inviteBtn then
			setupButtonAnimation(inviteBtn)
			inviteBtn.MouseButton1Click:Connect(function()
				local success, canInvite = pcall(function() return SocialService:CanSendGameInviteAsync(player) end)
				if success and canInvite then SocialService:PromptGameInvite(player)
				else NotificationManager.show("You cannot send invites right now.", "Error") end
			end)
		end
	end
end

-- Initialize safely handling edge cases where the character respawns rapidly
player.CharacterAdded:Connect(function() task.wait(0.5); setupHUD() end)
if player.Character then task.spawn(setupHUD) end