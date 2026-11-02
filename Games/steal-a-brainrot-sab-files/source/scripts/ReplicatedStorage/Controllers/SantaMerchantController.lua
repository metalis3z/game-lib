-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ContentProvider")
game:GetService("ServerStorage")
game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
game:GetService("HttpService")
game:GetService("RunService")
game:GetService("StarterGui")
local Players = game:GetService("Players")
require(ReplicatedStorage.Packages.Serialization)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
require(ReplicatedStorage.Packages.CreateTween)
require(ReplicatedStorage.Packages.TopbarPlus)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Observers = require(ReplicatedStorage.Packages.Observers)
require(ReplicatedStorage.Shared.Mutations)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local Marketplace = require(ReplicatedStorage.Shared.Marketplace)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
require(ReplicatedStorage.Controllers.CharacterController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
require(ReplicatedStorage.Controllers.PlotController)
local ShopController = require(ReplicatedStorage.Controllers.ShopController)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
require(ReplicatedStorage.Utils.MathUtils)
local VFX = require(ReplicatedStorage.Shared.VFX)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
require(ReplicatedStorage.Shared.Updates)
require(ReplicatedStorage.Shared.Animals)
local Animals = require(ReplicatedStorage.Shared.Animals)
require(ReplicatedStorage.Shared.Index)
require(ReplicatedStorage.Datas.Mutations)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Animals_2 = require(ReplicatedStorage.Datas.Animals)
local SantaMerchantData = require(ReplicatedStorage.Datas.SantaMerchantData)
local LocalPlayer = Players.LocalPlayer
local SantaMerchant = LocalPlayer.PlayerGui:WaitForChild("SantaMerchant").SantaMerchant
local Brainrots = SantaMerchant.Brainrots
local Close = SantaMerchant.Header.Close
local GiftPlayerSelect = SantaMerchant.GiftPlayerSelect
local GiftButton = GiftPlayerSelect:WaitForChild("GiftButton")
local Txt = GiftButton:WaitForChild("Txt")
local PlayerSelected = GiftPlayerSelect:WaitForChild("PlayerSelected")
local Headshot = PlayerSelected:WaitForChild("PlayerImage"):WaitForChild("Headshot")
local PlayerName = PlayerSelected:WaitForChild("PlayerName")
local v1 = Net:RemoteEvent("SantaMerchantService/CollectGoldElf")
local v2 = Net:RemoteEvent("SantaMerchantService/SetFocused")
local v3 = Net:RemoteEvent("SantaMerchantService/Animation")
local v4 = Net:RemoteFunction("SantaMerchantService/Buy")
local v5 = Net:RemoteEvent("ShopService/Purchase")
local v6 = nil
local t = {}
local function formatStockAttribute(p1)
	return ("SantaMerchant_%*"):format((string.gsub(p1, "%s", "_")))
end
local function loadAnimation(p1, p2, p3)
	local v1 = p1:LoadAnimation(p2)
	p3:Add(function()
		v1:Stop(0)
		v1:Destroy()
	end)
	return v1
end
function t.Start(p1)
	SantaMerchant.Visible = false
	v6 = InterfaceController:Register("SantaMerchant", SantaMerchant, "TopQuint")
	v6:AttachCloseButton(Close)
	v6.OnOpen:Connect(function()
		v2:FireServer("1e7e8402-985d-4da9-b003-cea6344600af", true)
	end)
	v6.OnClose:Connect(function()
		v2:FireServer("1e7e8402-985d-4da9-b003-cea6344600af", false)
	end)
	v6:Close()
	local slotTroves = {}
	local function renderBrainrotAtFrame(p1, p2)
		local v1 = Animals_2[p2]
		if not v1 then
			return
		end
		local existingTrove = slotTroves[p1]
		if existingTrove then
			existingTrove:Destroy()
			slotTroves[p1] = nil
		end
		local frameTrove = Trove.new()
		slotTroves[p1] = frameTrove
		local v2 = Rarities[v1.Rarity]
		p1.Title.Text = p2
		if v2.GradientPreset then
			p1.Title.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			local gradientCleanup = Gradients.apply(p1.Title, v2.GradientPreset)
			if type(gradientCleanup) == "function" then
				frameTrove:Add(gradientCleanup)
			end
		else
			p1.Title.TextColor3 = v2.Color
		end
		p1.Visible = true
		local viewportTrove = Animals:AttachOnViewportWithOptimizations(p2, p1.ViewportFrame)
		if viewportTrove then
			frameTrove:Add(function()
				viewportTrove:Destroy()
			end)
		end
	end
	local v12 = table.create(#SantaMerchantData.Brainrots)
	local v22 = Signal.new()
	local overriddenSlots = {}
	for v32, v42 in SantaMerchantData.Brainrots do
		local Brainrot = v42.Brainrot
		local _ = Animals_2[Brainrot]
		local v52 = Brainrots:FindFirstChild((tostring(v32))) or Brainrots.UIGridLayout.Template:Clone()
		v12[v32] = v52
		v52.Visible = true
		v52.LayoutOrder = v32
		renderBrainrotAtFrame(v52, Brainrot)
		local function updateStock()
			if overriddenSlots[v32] then
				return
			end
			local v2 = ReplicatedStorage:GetAttribute((("SantaMerchant_%*"):format((string.gsub(Brainrot, "%s", "_"))))) or 0
			v52.Quantity.Text = if v2 > 0 then ("%* Left"):format((NumberUtils:Comma(v2))) else "SOLD OUT"
			v52.Quantity.TextColor3 = if v2 > 0 then Color3.fromRGB(255, 255, 255) else Color3.fromRGB(255, 72, 72)
		end
		updateStock()
		v22:Connect(updateStock)
		ReplicatedStorage:GetAttributeChangedSignal((("SantaMerchant_%*"):format((string.gsub(Brainrot, "%s", "_"))))):Connect(updateStock)
		v52.DropRate.Text = ("$%*/s"):format((NumberUtils:ToString(Animals:GetGeneration(Brainrot))))
		v52.BuyYellow.Price.Text = NumberUtils:ToString(v42.Price or 0)
		if v42.ProductId then
			v52.Buy.Price.Text = "\238\128\130???"
			task.spawn(function()
				local function formatPriceInRobux(p1)
					if p1 == 999999999 then
						return "???"
					else
						return NumberUtils:Comma(p1)
					end
				end
				local v3 = Marketplace:GetProductInfo(v42.ProductId, "Product").PriceInRobux or 999999999
				local v4 = if v3 == 999999999 then "???" else NumberUtils:Comma(v3)
				v52.Buy.Price.Text = ("\238\128\130%*"):format(v4)
			end)
		end
		v52.Parent = Brainrots
		local v62 = AnimatedButton.new(v52.BuyYellow)
		v62:Animate()
		v62.OnActivated:Connect(function()
			if not v4:InvokeServer("bea90936-51d8-4f9d-941a-9e759ec9345f", v32) then
				return
			end
			SoundController:PlaySound("Sounds.Sfx.Success")
			InterfaceController:SetState("SantaMerchant", false)
		end)
		if v42.ProductId then
			local v7 = AnimatedButton.new(v52.Buy)
			v7:Animate()
			v7.OnActivated:Connect(function()
				v5:FireServer(v42.ProductId, ShopController:GetGiftingTarget())
			end)
		end
	end
	local HttpService = game:GetService("HttpService")
	local OVERRIDE_ATTRIBUTE = "SantaMerchantOverrides"

	local frameIcon = SantaMerchant:FindFirstChild("Frame") and SantaMerchant.Frame:FindFirstChild("Icon")
	local headerElvesIcon
	do
		local header = SantaMerchant:FindFirstChild("Header")
		local elves = header and header:FindFirstChild("Elves")
		headerElvesIcon = elves and elves:FindFirstChild("ImageLabel")
	end
	local ELF_ICON = (frameIcon and frameIcon.Image) or "rbxassetid://118049763305999"

	local BROTINHO_ICON = "rbxassetid://84857908414689"

	local function isBrotinho(currency)
		return type(currency) == "string" and string.lower(currency) == "brotinho"
	end

	local function iconForCurrency(currency)
		if isBrotinho(currency) then
			return BROTINHO_ICON
		end
		return ELF_ICON
	end

	local function getBuyIcon(frame)
		local buyYellow = frame:FindFirstChild("BuyYellow")
		if not buyYellow then
			return nil
		end
		local iconHolder = buyYellow:FindFirstChild("Icon")
		if iconHolder then
			local nested = iconHolder:FindFirstChild("ImageLabel")
			if nested then
				return nested
			end
		end
		return buyYellow:FindFirstChild("ImageLabel")
	end

	local function renderDefaultSlot(slot)
		local frame = v12[slot]
		local entry = SantaMerchantData.Brainrots[slot]
		if not frame or not entry then
			return
		end
		renderBrainrotAtFrame(frame, entry.Brainrot)
		frame.DropRate.Text = "$" .. NumberUtils:ToString(Animals:GetGeneration(entry.Brainrot)) .. "/s"
		frame.BuyYellow.Price.Text = NumberUtils:ToString(entry.Price or 0)
		local buyIcon = getBuyIcon(frame)
		if buyIcon then
			buyIcon.Image = ELF_ICON
		end
		local robuxButton = frame:FindFirstChild("Buy")
		if robuxButton then
			robuxButton.Visible = entry.ProductId ~= nil
		end
		local stockAttr = ReplicatedStorage:GetAttribute(("SantaMerchant_%*"):format((string.gsub(entry.Brainrot, "%s", "_")))) or 0
		frame.Quantity.Text = if stockAttr > 0 then ("%* Left"):format((NumberUtils:Comma(stockAttr))) else "SOLD OUT"
		frame.Quantity.TextColor3 = if stockAttr > 0 then Color3.fromRGB(255, 255, 255) else Color3.fromRGB(255, 72, 72)
	end

	local function renderOverrideSlot(slot, record)
		local frame = v12[slot]
		if not frame then
			return
		end
		local animalName = record.Animal
		if type(animalName) == "string" and Animals_2[animalName] then
			renderBrainrotAtFrame(frame, animalName)
			frame.DropRate.Text = "$" .. NumberUtils:ToString(Animals:GetGeneration(animalName)) .. "/s"
		else
			local existingTrove = slotTroves[frame]
			if existingTrove then
				existingTrove:Destroy()
				slotTroves[frame] = nil
			end
			frame.Title.Text = tostring(animalName)
			frame.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			frame.Visible = true
			frame.DropRate.Text = ""
		end
		frame.BuyYellow.Price.Text = NumberUtils:ToString(tonumber(record.Cost) or 0)
		local buyIcon = getBuyIcon(frame)
		if buyIcon then
			buyIcon.Image = iconForCurrency(record.Currency)
		end
		local robuxButton = frame:FindFirstChild("Buy")
		if robuxButton then
			robuxButton.Visible = false
		end
		local stock = tonumber(record.Stock)
		if record.Stock == nil then
			frame.Quantity.Text = ""
			frame.Quantity.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			frame.Quantity.Text = if (stock or 0) > 0 then ("%* Left"):format((NumberUtils:Comma(stock))) else "SOLD OUT"
			frame.Quantity.TextColor3 = if (stock or 0) > 0 then Color3.fromRGB(255, 255, 255) else Color3.fromRGB(255, 72, 72)
		end
	end

	local currentHeaderCurrency = "elf"
	local refreshHeaderAmount = nil

	local appliedOverrides = {}
	local function refreshOverrides()
		local raw = ReplicatedStorage:GetAttribute(OVERRIDE_ATTRIBUTE)
		local decoded
		if type(raw) == "string" and raw ~= "" then
			local ok, result = pcall(function()
				return HttpService:JSONDecode(raw)
			end)
			if ok and type(result) == "table" then
				decoded = result
			end
		end

		local newApplied = {}
		local anyBrotinho = false
		if decoded then
			for slotKey, record in pairs(decoded) do
				local slot = tonumber(slotKey)
				if slot and type(record) == "table" and v12[slot] then
					overriddenSlots[slot] = true
					renderOverrideSlot(slot, record)
					newApplied[slot] = true
					if isBrotinho(record.Currency) then
						anyBrotinho = true
					end
				end
			end
		end

		for slot in pairs(appliedOverrides) do
			if not newApplied[slot] then
				overriddenSlots[slot] = nil
				renderDefaultSlot(slot)
			end
		end
		appliedOverrides = newApplied

		local sharedIcon = anyBrotinho and BROTINHO_ICON or ELF_ICON
		if headerElvesIcon then
			headerElvesIcon.Image = sharedIcon
		end
		if frameIcon then
			frameIcon.Image = sharedIcon
		end

		currentHeaderCurrency = anyBrotinho and "brotinho" or "elf"
		if refreshHeaderAmount then
			refreshHeaderAmount()
		end
	end

	refreshOverrides()
	ReplicatedStorage:GetAttributeChangedSignal(OVERRIDE_ATTRIBUTE):Connect(refreshOverrides)

	local function updateGiftInfo()
		local v1 = ShopController:GetGiftingTarget()
		if v1 then
			local v2 = Players:GetPlayerByUserId(v1)
			Txt.Text = "Back"
			PlayerSelected.Visible = true
			PlayerName.Text = if v2 then "@" .. v2.Name or v1 else v1
			Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v1)
			for v5, v6 in v12 do
				v6.BuyYellow.Visible = false
			end
		else
			PlayerSelected.Visible = false
			Txt.Text = "Gift Player"
			for v7, v8 in v12 do
				v8.BuyYellow.Visible = true
			end
		end
	end
	ShopController.ToggleGiftSignal:Connect(updateGiftInfo)
	task.spawn(updateGiftInfo)
	local v8 = AnimatedButton.new(GiftButton)
	v8:Animate()
	v8.OnActivated:Connect(function()
		if ShopController:GetGiftingTarget() then
			ShopController:RemoveGiftingTarget()
		else
			ShopController:OpenGiftingScreen()
		end
	end)
	v6.OnClose:Connect(function()
		if not ShopController:GetGiftingTarget() then
			return
		end
		ShopController:RemoveGiftingTarget()
	end)
	local v9 = ReplicatedStorage:GetAttribute("SantaMerchantStockId")
	Synchronizer:WaitAndCall(LocalPlayer, function(p1)
		local CURRENCY_BALANCE_PATHS = {
			elf = "ChristmasEvent.GoldElves",
			brotinho = "ChristmasEvent.BrotinhoCoins",
		}
		local function updateCurrency()
			local path = CURRENCY_BALANCE_PATHS[currentHeaderCurrency] or CURRENCY_BALANCE_PATHS.elf
			SantaMerchant.Header.Elves.Amount.Text = NumberUtils:Comma(p1:Get(path) or 0)
		end
		refreshHeaderAmount = updateCurrency
		p1:OnChanged("ChristmasEvent.GoldElves", updateCurrency)
		p1:OnChanged("ChristmasEvent.BrotinhoCoins", updateCurrency)
		task.spawn(updateCurrency)
	end)
	local function playCharacterAnimation(p1, p2, currency)
		local Character = p1.Character
		if not Character then
			return
		end
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		if HumanoidRootPart then
			local v1 = script.Reward:Clone()
			v1.Currency.Text = ("+%*"):format(p2)
			if isBrotinho(currency) then
				v1.ImageLabel.Image = BROTINHO_ICON
			end
			v1.Parent = HumanoidRootPart
			TweenService:Create(v1, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				StudsOffset = Vector3.new(0, 2.5, 2.2)
			}):Play()
			TweenService:Create(v1.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
				ImageTransparency = 1
			}):Play()
			TweenService:Create(v1.Currency, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
				TextTransparency = 1
			}):Play()
			TweenService:Create(v1.Currency.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
				Transparency = 1
			}):Play()
			task.delay(5, function()
				v1:Destroy()
			end)
		end
	end
	v1.OnClientEvent:Connect(function(p1, p2, p3)
		local v1 = script.Smoke:Clone()
		v1:PivotTo(p2)
		v1.Parent = workspace
		v1.smoke1:Emit(5)
		task.spawn(function()
			SoundController:PlaySound(ReplicatedStorage.Sounds.Sfx.Puff2, p2.Position, false)
		end)
		task.delay(3, function()
			v1:Destroy()
		end)
		playCharacterAnimation(p1, 1, p3 or currentHeaderCurrency)
	end)
	Observers.observeTag("SantaMerchantNPC", function(p1)
		local v1 = Trove.new()
		local v2 = p1.Humanoid.Animator:LoadAnimation(script.Idle)
		v1:Add(function()
			v2:Stop(0)
			v2:Destroy()
		end)
		v2.Priority = Enum.AnimationPriority.Idle
		v2.Looped = true
		v2:Play()
		return v1:WrapClean()
	end, { workspace })
	v3.OnClientEvent:Connect(function(vfxName)
		local merchant = workspace:FindFirstChild("Santa Merchant")
		if not merchant then return end

		local vfxFolder = merchant:FindFirstChild("VFX")
		if not vfxFolder then return end

		local vfx = vfxFolder:FindFirstChild(vfxName)
		if vfx then
			task.spawn(function()
				SoundController:PlaySound(ReplicatedStorage.Sounds.Sfx.SantaMerchantSFX, merchant.SpawnPart.Position, false)
			end)
			VFX.emit(vfx)
		end
	end)
	Observers.observeTag("SantaMerchantPrompt", function(p1)
		local v1 = Trove.new()
		local function updatePrompt()
			if Synchronizer:Wait(LocalPlayer) then
				p1.ObjectText = "Santa\'s Shop"
				p1.ActionText = "View"
			end
		end
		v1:Add(task.spawn(function()
			if Synchronizer:Wait(LocalPlayer) then
				v1:Add(Timer.Simple(1, updatePrompt))
				task.spawn(updatePrompt)
			end
		end))
		v1:Add(p1.Triggered:Connect(function()
			if Synchronizer:Get(LocalPlayer) then
				InterfaceController:Toggle("SantaMerchant")
			end
		end))
		return function()
			v1:Destroy()
		end
	end)
end
return t