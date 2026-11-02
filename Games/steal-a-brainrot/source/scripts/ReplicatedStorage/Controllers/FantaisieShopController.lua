local FantaisieShopController = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

require(ReplicatedStorage.Packages.Serialization)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
require(ReplicatedStorage.Packages.CreateTween)
require(ReplicatedStorage.Packages.TopbarPlus)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Mutations = require(ReplicatedStorage.Shared.Mutations)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local Marketplace = require(ReplicatedStorage.Shared.Marketplace)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local PlotController = require(ReplicatedStorage.Controllers.PlotController)
local ShopController = require(ReplicatedStorage.Controllers.ShopController)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local VFX = require(ReplicatedStorage.Shared.VFX)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Updates = require(ReplicatedStorage.Shared.Updates)
local AnimalsShared = require(ReplicatedStorage.Shared.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local MutationsData = require(ReplicatedStorage.Datas.Mutations)
local FantaisieShopData = require(ReplicatedStorage.Datas.FantaisieShopData)

local LocalPlayer = Players.LocalPlayer
local FantaisieShopGui = LocalPlayer.PlayerGui:WaitForChild("FantaisieShop").FantaisieShop
local MainFrame = FantaisieShopGui.Frame
local List = MainFrame.List
local CloseBtn = MainFrame.Header.Close
local SetFocusedRE = Net:RemoteEvent("FantaisieShopService/SetFocused")
local AnimationRE = Net:RemoteEvent("FantaisieShopService/Animation")
local ShopPurchaseRE = Net:RemoteEvent("ShopService/Purchase")
local BuyRF = Net:RemoteFunction("FantaisieShopService/Buy")

local interfaceHandle = nil
local itemFrames = {}
local expandSignal = Signal.new()
local stockUpdateSignal = Signal.new()
local currentExpanded = nil

local function getRefreshPeriod(now)
	local wday = os.date("!*t", (now or workspace:GetServerTimeNow()) // 1).wday
	if wday == 1 or wday == 7 then
		return FFlags:GetInstant("WeekendMerchantRefreshTime", 1800)
	else
		return FFlags:GetInstant("WeekdayMerchantRefreshTime", 1800)
	end
end

local function setupBrainrotItem(frame, brainrotName)
	local animalData = AnimalsData[brainrotName]
	if animalData then
		local rarityData = Rarities[animalData.Rarity]
		frame.Title.Text = brainrotName
		if rarityData.GradientPreset then
			frame.UIStroke.Color = Color3.new(1, 1, 1)
			frame.Title.TextColor3 = Color3.new(1, 1, 1)
			Gradients.apply(frame.UIStroke, rarityData.GradientPreset)
			Gradients.apply(frame.Title, rarityData.GradientPreset)
		else
			frame.UIStroke.Color = rarityData.Color
			frame.Title.TextColor3 = rarityData.Color
		end
		frame.Visible = true
		AnimalsShared:AttachOnViewport(brainrotName, frame.ViewportFrame, true, nil, true)
	end
end

local function updateStockDisplay(itemFrame, entry, dropdownFrame)
	local now = workspace:GetServerTimeNow()
	local dt = DateTime.fromUnixTimestamp(now)
	local Y = dt:FormatUniversalTime("YYYY", "en-us")
	local M = dt:FormatUniversalTime("MM", "en-us")
	local D = dt:FormatUniversalTime("DD", "en-us")
	local H = dt:FormatUniversalTime("HH", "en-us")
	local mm = dt:FormatUniversalTime("mm", "en-us")
	local halfHr = (tonumber(mm) or 0) < 30 and "00" or "30"
	local key = string.format("%s-%s%s%s-%s%s", entry.StockKey, Y, M, D, H, halfHr)
	local attrName = "AstroStock_" .. (key:gsub("%s", "_"))
	local stock = ReplicatedStorage:GetAttribute(attrName) or 0

	itemFrame.Spacer.Left.Txt.Text = stock <= 0 and "SOLD OUT" or ("%s Left"):format(NumberUtils:Comma(stock))
	local leftBg = itemFrame.Spacer.Left
	leftBg.BackgroundColor3 = stock > 0 and Color3.fromRGB(33, 135, 40) or Color3.fromRGB(185, 52, 52)

	local cashBtn = dropdownFrame.Spacer.Cash
	cashBtn.BackgroundColor3 = stock > 0 and Color3.fromRGB(81, 158, 86) or Color3.fromRGB(127, 127, 127)
	cashBtn.Interactable = stock > 0
end

function FantaisieShopController.Start(_)
	FantaisieShopGui.Visible = false
	interfaceHandle = InterfaceController:Register("FantaisieShop", FantaisieShopGui, "TopQuint")
	interfaceHandle:AttachCloseButton(CloseBtn)
	interfaceHandle.OnOpen:Connect(function()
		SetFocusedRE:FireServer("astro-shop-focused", true)
	end)
	interfaceHandle.OnClose:Connect(function()
		SetFocusedRE:FireServer("astro-shop-focused", false)
	end)
	interfaceHandle:Close()

	for idx, entry in ipairs(FantaisieShopData.Brainrots) do
		local brainrotName = entry.Brainrot
		local animalData = AnimalsData[brainrotName]
		local template = entry.Template or "Normal"
		local itemFrame = List.UIListLayout[template]:Clone()
		itemFrames[idx] = itemFrame
		itemFrame.Visible = true
		itemFrame.LayoutOrder = (idx - 1) * 2

		local dropdownFrame = List.UIListLayout.DropdownCoins:Clone()
		dropdownFrame.LayoutOrder = itemFrame.LayoutOrder + 1
		dropdownFrame.Size = UDim2.fromScale(0.973, 0)
		dropdownFrame.Visible = false
		dropdownFrame.Parent = List

		setupBrainrotItem(itemFrame.Spacer.Brainrot, brainrotName)

		local function refreshStock()
			updateStockDisplay(itemFrame, entry, dropdownFrame)
		end
		refreshStock()
		stockUpdateSignal:Connect(refreshStock)

		ReplicatedStorage.AttributeChanged:Connect(function(attrName)
			if string.find(attrName, "AstroStock_", 1, true) then
				refreshStock()
			end
		end)

		itemFrame.Spacer.DropRate.Text = ("$%s/s"):format(NumberUtils:ToString(AnimalsShared:GetGeneration(brainrotName)))

		if animalData then
			dropdownFrame.Spacer.Cash.Txt.Text = ("$%s"):format(NumberUtils:ToString(animalData.Price or 0))
		else
			dropdownFrame.Spacer.Cash.Txt.Text = "$???"
		end

		itemFrame.Spacer.Txt.Text = brainrotName
		if animalData then
			local rarityData = Rarities[animalData.Rarity]
			if rarityData.GradientPreset then
				itemFrame.Spacer.Txt.TextColor3 = Color3.new(1, 1, 1)
				Gradients.apply(itemFrame.Spacer.Txt, rarityData.GradientPreset)
			else
				itemFrame.Spacer.Txt.TextColor3 = rarityData.Color
			end
		end

		itemFrame.Parent = List

		expandSignal:Connect(function(newExpanded, oldExpanded)
			if newExpanded == itemFrame then
				dropdownFrame.Visible = true
				Spr.target(dropdownFrame, 0.9, 6, {
					["Size"] = UDim2.fromScale(0.973, 0.192)
				})
				local scrollTarget = itemFrame.AbsolutePosition.Y - List.AbsolutePosition.Y + List.CanvasPosition.Y
				if oldExpanded and oldExpanded ~= newExpanded and table.find(itemFrames, oldExpanded) and table.find(itemFrames, oldExpanded) < idx then
					scrollTarget = scrollTarget - 0.192 * List.AbsoluteSize.Y
				end
				Spr.target(List, 1, 4, {
					["CanvasPosition"] = Vector2.new(0, scrollTarget)
				})
			else
				Spr.target(dropdownFrame, 1, 6, {
					["Size"] = UDim2.fromScale(0.973, 0)
				})
				Spr.completed(dropdownFrame, function()
					if dropdownFrame.Size.Y.Scale < 0.01 then
						dropdownFrame.Visible = false
					end
				end)
			end
		end)

		AnimatedButton.new(itemFrame.Spacer).OnActivated:Connect(function()
			SoundController:PlaySound("Sounds.Sfx.Activated")
			local oldExpanded = currentExpanded
			currentExpanded = currentExpanded == itemFrame and nil or itemFrame
			expandSignal:Fire(currentExpanded, oldExpanded)
		end)

		local buyBtn = AnimatedButton.new(dropdownFrame.Spacer.Cash)
		buyBtn:Animate()
		buyBtn.OnActivated:Connect(function()
			if BuyRF:InvokeServer("astro-shop-buy", idx) then
				SoundController:PlaySound("Sounds.Sfx.Success")
				InterfaceController:SetState("FantaisieShop", false)
			end
		end)
	end

	-- Mutation display
	local function updateMutation()
		local currentMutation = Mutations.get()
		MainFrame.Mutation.Visible = currentMutation ~= nil
		if currentMutation == nil then
			Spr.target(MainFrame.Mutation, 1, 4, {
				["Position"] = UDim2.fromScale(0.5, 0.9)
			})
			Spr.target(MainFrame, 1, 4, {
				["Position"] = UDim2.fromScale(0.5, 0.5)
			})
		else
			Spr.target(MainFrame.Mutation, 1, 4, {
				["Position"] = UDim2.fromScale(0.5, 1.01)
			})
			Spr.target(MainFrame, 1, 4, {
				["Position"] = UDim2.fromScale(0.5, 0.44)
			})
			local mutationInfo = MutationsData[currentMutation]
			if mutationInfo then
				MainFrame.Mutation.Frame.Icon.Image = mutationInfo.Icon
				MainFrame.Mutation.Frame.Txt.Text = ("10%% Chance of buying %s"):format(mutationInfo.DisplayText)
				if currentMutation == "YinYang" then
					MainFrame.Mutation.UIStroke.UIGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
						ColorSequenceKeypoint.new(0.49, Color3.new(0, 0, 0)),
						ColorSequenceKeypoint.new(0.51, Color3.new(1, 1, 1)),
						ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
					})
				else
					MainFrame.Mutation.UIStroke.UIGradient.Color = ColorSequence.new(mutationInfo.MainColor)
				end
			end
		end
	end
	Mutations.watch(updateMutation)
	updateMutation()

	-- No automatic restock timer - stock only via /restockfantaisie-shop command
	local lastRestockEpoch = ReplicatedStorage:GetAttribute("FantaisieShopNextRestockEpoch")
	Timer.Simple(1, function()
		local now = workspace:GetServerTimeNow()
		local nextRestockEpoch = ReplicatedStorage:GetAttribute("FantaisieShopNextRestockEpoch") or 0

		if lastRestockEpoch and nextRestockEpoch > lastRestockEpoch then
			lastRestockEpoch = nextRestockEpoch
			stockUpdateSignal:Fire()
			if Updates.Methods.IsEnabled("Update-11/08/2025") then
				NotificationController:Notify("The <font color='#9b59b6'>Fantaisie Shop</font> has Restocked!", 10, "Sounds.Sfx.Success")
			end
		end

		-- Check if any item has stock to decide what to display
		local hasAnyStock = false
		for _, entry in ipairs(FantaisieShopData.Brainrots) do
			local dt = DateTime.fromUnixTimestamp(now)
			local Y = dt:FormatUniversalTime("YYYY","en-us")
			local M = dt:FormatUniversalTime("MM","en-us")
			local D = dt:FormatUniversalTime("DD","en-us")
			local H = dt:FormatUniversalTime("HH","en-us")
			local mm = dt:FormatUniversalTime("mm","en-us")
			local halfHr = (tonumber(mm) or 0) < 30 and "00" or "30"
			local key = string.format("%s-%s%s%s-%s%s", entry.StockKey, Y, M, D, H, halfHr)
			local attrName = "AstroStock_" .. (key:gsub("%s", "_"))
			local stock = ReplicatedStorage:GetAttribute(attrName) or 0
			if stock > 0 then
				hasAnyStock = true
				break
			end
		end

		local timeString = hasAnyStock and "Stock Available!" or "No Stock - Use /restockfantaisie-shop"

		MainFrame.Header.Txt1.Text = timeString
		local fantaisieShop = workspace:FindFirstChild("FantaisieShop")
		if fantaisieShop then
			local billboard = fantaisieShop:FindFirstChild("Overhead") and fantaisieShop.Overhead:FindFirstChild("BillboardGui")
			if billboard and billboard:FindFirstChild("Countdown") then
				billboard.Countdown.Text = timeString
			end
		end
	end)

	-- Observer for FantaisieShop NPC prompt
	Observers.observeTag("FantaisieShopPrompt", function(promptInstance)
		local trove = Trove.new()
		local function updatePrompt()
			if Synchronizer:Wait(LocalPlayer) then
				promptInstance.ObjectText = "Fantaisie Shop"
				promptInstance.ActionText = "View"
			end
		end
		trove:Add(task.spawn(function()
			if Synchronizer:Wait(LocalPlayer) then
				trove:Add(Timer.Simple(1, updatePrompt))
				task.spawn(updatePrompt)
			end
		end))
		trove:Add(promptInstance.Triggered:Connect(function()
			InterfaceController:Toggle("FantaisieShop")
		end))
		return function()
			trove:Destroy()
		end
	end)

	-- Observer for FantaisieShop NPC animations
	Observers.observeTag("FantaisieShopNPC", function(npcModel)
		local trove = Trove.new()
		local animator = npcModel.Humanoid.Animator
		local idleAnim = animator:LoadAnimation(script.Idle)
		trove:Add(function()
			idleAnim:Stop(0)
			idleAnim:Destroy()
		end)
		idleAnim.Priority = Enum.AnimationPriority.Idle
		idleAnim.Looped = true
		idleAnim:Play()

		local idleToActionAnim = animator:LoadAnimation(script.IdleToAction)
		trove:Add(function()
			idleToActionAnim:Stop(0)
			idleToActionAnim:Destroy()
		end)
		idleToActionAnim.Priority = Enum.AnimationPriority.Action

		local actionIdleAnim = animator:LoadAnimation(script.ActionIdle)
		trove:Add(function()
			actionIdleAnim:Stop(0)
			actionIdleAnim:Destroy()
		end)
		actionIdleAnim.Priority = Enum.AnimationPriority.Movement
		actionIdleAnim.Looped = true

		local actionToIdleAnim = animator:LoadAnimation(script.ActionToIdle)
		trove:Add(function()
			actionToIdleAnim:Stop(0)
			actionToIdleAnim:Destroy()
		end)
		actionToIdleAnim.Priority = Enum.AnimationPriority.Action

		trove:Add(idleToActionAnim.Stopped:Connect(function()
			actionIdleAnim:Play()
		end))
		trove:Add(actionIdleAnim.Stopped:Connect(function()
			actionToIdleAnim:Play()
		end))

		trove:Add(AnimationRE.OnClientEvent:Connect(function(_, rarity)
			local effectModel = script.SpawnEffects:FindFirstChild(rarity) or script.SpawnEffects.Rare
			if effectModel then
				idleToActionAnim:Play()
				task.wait(0.5)
				local spawnPos = npcModel:GetPivot() * CFrame.new(0, 3.5, -3)
				task.spawn(function()
					local sound = ReplicatedStorage.Sounds.Sfx.Merchant:FindFirstChild(rarity)
					if sound then
						SoundController:PlaySound(sound, spawnPos.Position)
					end
				end)
				local effect = effectModel:Clone()
				effect:PivotTo(spawnPos)
				effect.Parent = workspace
				VFX.emit(effect)
				task.wait(2.5)
				actionIdleAnim:Stop()
			end
		end))

		return trove:WrapClean()
	end)

	return FantaisieShopController
end

return FantaisieShopController