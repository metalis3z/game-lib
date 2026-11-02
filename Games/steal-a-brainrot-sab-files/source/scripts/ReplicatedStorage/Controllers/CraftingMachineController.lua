-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService       = game:GetService("HttpService")
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local Synchronizer   = require(ReplicatedStorage.Packages.Synchronizer)
local Gradients      = require(ReplicatedStorage.Packages.Gradients)
local Observers      = require(ReplicatedStorage.Packages.Observers)
local Signal         = require(ReplicatedStorage.Packages.Signal)
local Timer          = require(ReplicatedStorage.Packages.Timer)
local Trove          = require(ReplicatedStorage.Packages.Trove)
local Spr            = require(ReplicatedStorage.Packages.Spr)
local Net            = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController     = require(ReplicatedStorage.Controllers.SoundController)
local NumberUtils         = require(ReplicatedStorage.Utils.NumberUtils)
local TimeUtils           = require(ReplicatedStorage.Utils.TimeUtils)
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local VFX     = require(ReplicatedStorage.Shared.VFX)
local Animals = require(ReplicatedStorage.Shared.Animals)
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local MutationsData = require(ReplicatedStorage.Datas.Mutations)
local RaritiesData  = require(ReplicatedStorage.Datas.Rarities)
local AnimalsDB     = require(ReplicatedStorage.Datas.Animals)
local TraitsData    = require(ReplicatedStorage.Datas.Traits)
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
workspace:WaitForChild("RenderedMovingAnimals")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local CraftNowEvent = Net:RemoteEvent("CraftingMachineService/CraftNow")
local UpdateEvent   = Net:RemoteEvent("CraftingMachineService/Update")
local ReturnEvent   = Net:RemoteEvent("CraftingMachineService/Return")
local ClaimEvent    = Net:RemoteEvent("CraftingMachineService/Claim")
local DeliveryFunc  = Net:RemoteFunction("CraftingMachineService/Delivery")
local StartFunc     = Net:RemoteFunction("CraftingMachineService/Start")
local FetchFunc     = Net:RemoteFunction("CraftingMachineService/Fetch")
Net:RemoteEvent("ShopService/Purchase")

local LocalPlayer = Players.LocalPlayer

local function resolveCraftModel(craftType)
	if craftType == "OG" then
		local direct = workspace:FindFirstChild("OG CraftingMachine")
		if direct then return direct end
		local folder = workspace:FindFirstChild("Og craft machine")
		return folder and folder:FindFirstChild("OG CraftingMachine")
	end
	return workspace:FindFirstChild("CraftingMachine")
end

local function getActiveCrafttype()
	local cyber = workspace:FindFirstChild("CraftingMachine")
	if cyber and cyber:GetAttribute("Crafttype") then
		return cyber:GetAttribute("Crafttype")
	end
	local og = resolveCraftModel("OG")
	if og and og:GetAttribute("Crafttype") then
		return og:GetAttribute("Crafttype")
	end
	return "Cyber"
end

local function getActiveModel()
	return resolveCraftModel(getActiveCrafttype())
end

local CRAFT_LABELS = { Cyber = "Cyber Craft", OG = "OG Craft" }

local function buildPanel(rootGui, interfaceKey, supportsStock, supportsLists)
	if not rootGui then return nil end
	local content = rootGui:FindFirstChild("Content")
	if not content then return nil end
	local lists  = rootGui:FindFirstChild("Lists")
	local header = rootGui:FindFirstChild("Header")
	return {
		interfaceKey  = interfaceKey,
		root          = rootGui,
		List          = rootGui:FindFirstChild("List"),
		Content       = content,
		Time          = content:FindFirstChild("Time"),
		Buy           = content:FindFirstChild("Buy"),
		BrainrotName  = content:FindFirstChild("BrainrotName"),
		Brainrots     = content:FindFirstChild("Brainrots"),
		Required      = content:FindFirstChild("Required"),
		Timer         = rootGui:FindFirstChild("Timer"),
		Close         = header and header:FindFirstChild("Close"),
		Mutations     = lists and lists:FindFirstChild("Mutations"),
		Traits        = lists and lists:FindFirstChild("Traits"),
		supportsStock = supportsStock,
		supportsLists = supportsLists,
		interfaceState = nil,
	}
end

local cyberGui = LocalPlayer.PlayerGui:WaitForChild("CraftingMachine", 10)
local ogGui    = LocalPlayer.PlayerGui:WaitForChild("OGCraftingMachine", 10)

local cyberPanel = cyberGui and buildPanel(cyberGui:FindFirstChild("CraftingMachine"), "CraftingMachine", true, true) or nil
local ogPanel    = ogGui    and buildPanel(ogGui:FindFirstChild("CraftingMachine"),    "OGCraftingMachine", false, false) or nil

local panelsByType = { Cyber = cyberPanel, OG = ogPanel }

local function getActivePanel()
	return panelsByType[getActiveCrafttype()] or cyberPanel or ogPanel
end

local function listButtonOf(itemFrame)
	return itemFrame:FindFirstChild("Button") or itemFrame
end

local timerTrove     = Trove.new()
local selectionTrove = Trove.new()
local listTrove      = Trove.new()

local craftingList      = nil
local selectedIndex     = 1
local lastSelectedIndex = nil

local isCraftAnimating  = false
local isCharging        = nil
local chargingSignal    = Signal.new()

local Controller = {}

local function updateVFX()
	local data = Synchronizer:Get(LocalPlayer)
	if not data or isCraftAnimating then return end

	local craftType = getActiveCrafttype()
	local model     = resolveCraftModel(craftType)
	if not model then return end

	local craftData = data:Get("CraftingMachine")
	if not craftData then return end

	local active = craftData.Rarity and craftData.StartTime and craftData.FinishTime
	local chargeSoundPart = model:FindFirstChild("ChargeSoundPart")

	if craftType == "OG" then
		local vfxFolder = model:FindFirstChild("VFX")
		if active then
			if not isCharging then isCharging = true; chargingSignal:Fire(true) end
			local progress = math.clamp(
				(workspace:GetServerTimeNow() - craftData.StartTime) / (craftData.FinishTime - craftData.StartTime),
				0, 1)
			local rarVfx = vfxFolder and vfxFolder:FindFirstChild(craftData.Rarity)
			local chargingModel = rarVfx and rarVfx:FindFirstChild("ChargingModel")
			if chargingModel then
				pcall(function()
					chargingModel:ScaleTo(math.lerp(0.25, 1, progress))
					local charging  = chargingModel:FindFirstChild("Charging")
					local chargeAtt = charging and charging:FindFirstChild("Charge")
					if chargeAtt then
						VFX.enable(chargeAtt)
						for _, d in chargeAtt:GetDescendants() do
							if d:IsA("ParticleEmitter") then d.TimeScale = math.lerp(0.3, 0.7, progress) end
						end
					end
				end)
			end
			if chargeSoundPart and chargeSoundPart:FindFirstChild("Sound") and not chargeSoundPart.Sound.IsPlaying then
				chargeSoundPart.Sound:Play()
			end
		else
			if isCharging then isCharging = false; chargingSignal:Fire(false) end
			if vfxFolder then VFX.disable(vfxFolder) end
			if chargeSoundPart and chargeSoundPart:FindFirstChild("Sound") and chargeSoundPart.Sound.IsPlaying then
				chargeSoundPart.Sound:Stop()
			end
		end
	else
		if active then
			if not isCharging then isCharging = true; chargingSignal:Fire(true) end
			if chargeSoundPart and chargeSoundPart:FindFirstChild("Sound") and not chargeSoundPart.Sound.IsPlaying then
				chargeSoundPart.Sound:Play()
			end
		else
			if isCharging then isCharging = false; chargingSignal:Fire(false) end
			if chargeSoundPart and chargeSoundPart:FindFirstChild("Sound") and chargeSoundPart.Sound.IsPlaying then
				chargeSoundPart.Sound:Stop()
			end
		end
	end
end

local function updateTimer()
	timerTrove:Clean()
	local data = Synchronizer:Get(LocalPlayer)
	if not data then return end

	local panel = getActivePanel()
	if panel and panel.Time then panel.Time.Visible = false end

	local finishTime = data:Get("CraftingMachine.FinishTime")
	local model      = getActiveModel()

	local selectedEntry = craftingList and craftingList.List and craftingList.List[selectedIndex]
	if panel and panel.Time then
		if selectedEntry then
			panel.Time.Visible = true
			panel.Time.Text = ("Crafting Time (<font color=\"#ffff00\">%*</font>)"):format(TimeUtils:E(selectedEntry.CraftTime))
		else
			panel.Time.Text = ""
		end
	end

	local countdown
	if model then
		local overhead  = model:FindFirstChild("Overhead")
		local billboard = overhead and overhead:FindFirstChild("BillboardGui")
		countdown = billboard and billboard:FindFirstChild("Countdown")
	end
	if not countdown then return end

	local now = workspace:GetServerTimeNow()
	if not finishTime then
		local refreshIn = math.max((craftingList and craftingList.Refresh or 0) - now, 0)
		countdown.Text = ("Refreshes in %*"):format(TimeUtils:E(refreshIn))
	else
		local remaining = math.max(finishTime - now, 0)
		countdown.Text  = remaining <= 0 and "READY" or TimeUtils:E(remaining)
	end
end

local function updateLists()
	local panel = getActivePanel()
	if not panel or not panel.supportsLists or not panel.Mutations or not panel.Traits then return end

	local mutScroll = panel.Mutations:FindFirstChild("ScrollingFrame")
	local trtScroll = panel.Traits:FindFirstChild("ScrollingFrame")
	if not mutScroll or not trtScroll then return end

	for _, child in mutScroll:GetChildren() do
		if child:IsA("Frame") and child.Name ~= "Template" then child:Destroy() end
	end
	for _, child in trtScroll:GetChildren() do
		if child:IsA("Frame") and child.Name ~= "Template" then child:Destroy() end
	end

	local data         = Synchronizer:Get(LocalPlayer)
	local mutationOdds = data and data:Get("CraftingMachine.OutputMutationOdds") or {}
	local traitOdds    = data and data:Get("CraftingMachine.OutputTraitsOdds")   or {}
	local myMutations  = selectedIndex and mutationOdds[selectedIndex] or {}
	local myTraits     = selectedIndex and traitOdds[selectedIndex]    or {}

	local mutTemplate = mutScroll:FindFirstChild("Template")
	local hasMutations = false
	if mutTemplate then
		for mutationName, chance in myMutations do
			local mutData = MutationsData[mutationName]
			if mutData then
				local entry = mutTemplate:Clone()
				entry.Name         = mutationName
				entry.LayoutOrder  = -chance
				entry.Vector.Image = mutData.Icon or ""
				entry.Title.Text   = mutData.UseRichText and mutData.DisplayWithRichText or mutData.DisplayText
				entry.Title.RichText = mutData.UseRichText
				if mutData.GradientPreset then
					entry.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
					Gradients.apply(entry.Title, mutData.GradientPreset)
				else
					entry.Title.TextColor3 = mutData.MainColor
				end
				local _, frac = math.modf(chance)
				entry.Chance.Text = ("%*%%"):format(string.format(frac == 0 and "%d" or "%.2f", chance))
				entry.Visible = true
				entry.Parent  = mutScroll
				hasMutations  = true
			end
		end
	end
	panel.Mutations.Visible = hasMutations

	local trtTemplate = trtScroll:FindFirstChild("Template")
	local hasTraits = false
	if trtTemplate then
		for traitName, chance in myTraits do
			local trData = TraitsData[traitName]
			if trData then
				local entry = trtTemplate:Clone()
				entry.Name           = traitName
				entry.LayoutOrder    = -chance
				entry.Vector.Image   = trData.Icon or ""
				entry.Title.Text     = trData.DisplayWithRichText
				entry.Title.TextColor3 = trData.Color
				entry.Title.RichText = true
				local _, frac = math.modf(chance)
				entry.Chance.Text = ("%*%%"):format(string.format(frac == 0 and "%d" or "%.2f", chance))
				entry.Visible = true
				entry.Parent  = trtScroll
				hasTraits     = true
			end
		end
	end
	panel.Traits.Visible = hasTraits
end

local function updateSelection()
	if lastSelectedIndex == selectedIndex then return end

	local data = Synchronizer:Get(LocalPlayer)
	if not data then return end

	local panel = getActivePanel()
	if not panel then return end

	selectionTrove:Clean()
	updateLists()

	if not craftingList then return end
	if not selectedIndex or not craftingList.List[selectedIndex] then
		selectedIndex = 1
	end

	local entry = craftingList.List[selectedIndex]
	if not entry then
		if panel.Content then panel.Content.Visible = false end
		return
	end

	lastSelectedIndex = selectedIndex
	if panel.Content then panel.Content.Visible = true end

	local nameFrame = panel.BrainrotName
	if nameFrame then
		nameFrame.Title.Text = entry.Name
		local rarityData = RaritiesData[entry.Rarity]
		if rarityData.GradientPreset then
			nameFrame.Title.TextColor3 = Color3.new(1, 1, 1)
			nameFrame.UIStroke.Color   = Color3.new(1, 1, 1)
			selectionTrove:Add(Gradients.apply(nameFrame.Title,   rarityData.GradientPreset))
			selectionTrove:Add(Gradients.apply(nameFrame.UIStroke, rarityData.GradientPreset))
		else
			nameFrame.Title.TextColor3 = rarityData.Color
			nameFrame.UIStroke.Color   = rarityData.Color
		end
		if AnimalsDB[entry.Name] then
			local cleanup = Animals:AttachOnViewport(entry.Name, nameFrame.ViewportFrame, true)
			if cleanup then selectionTrove:Add(cleanup) end
		end
	end

	local requiredLabel        = panel.Required
	local isOutOfStock         = false
	local stockGradientCleanup = nil
	selectionTrove:Add(function()
		if stockGradientCleanup then stockGradientCleanup(); stockGradientCleanup = nil end
	end)

	local stockKey = panel.supportsStock and entry.StockKey or nil
	if requiredLabel then requiredLabel.TextColor3 = Color3.fromRGB(255, 255, 255) end

	if not stockKey then
		if requiredLabel then requiredLabel.Text = "Brainrots Required:" end
	else
		local function refreshStockLabel()
			local stockCount = ReplicatedStorage:GetAttribute("CraftingMachineStock_" .. stockKey)
			if typeof(stockCount) ~= "number" then stockCount = nil end
			local oos = stockCount ~= nil and stockCount <= 0
			if requiredLabel then
				if stockCount == nil then
					requiredLabel.Text       = "Loading..."
					requiredLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				elseif oos then
					requiredLabel.Text       = "SOLD OUT!"
					requiredLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
				else
					requiredLabel.Text       = ("%* LEFT"):format(NumberUtils:Comma(stockCount))
					requiredLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				end
				if not oos then
					if not stockGradientCleanup then
						stockGradientCleanup = Gradients.apply(requiredLabel, "Rainbow")
					end
				else
					if stockGradientCleanup then stockGradientCleanup(); stockGradientCleanup = nil end
				end
			end
		end
		selectionTrove:Add(
			ReplicatedStorage:GetAttributeChangedSignal("CraftingMachineStock_" .. stockKey):Connect(refreshStockLabel)
		)
		refreshStockLabel()
	end

	local ingredientFrames = {}
	local brainrotsHolder  = panel.Brainrots
	local ingredientTemplate = brainrotsHolder and brainrotsHolder:FindFirstChild("Template")

	if brainrotsHolder and ingredientTemplate then
		for i, animalName in entry.Recipe do
			local animalData = AnimalsDB[animalName]
			if animalData then
				local animalRarity = RaritiesData[animalData.Rarity]
				local frame        = selectionTrove:Clone(ingredientTemplate)
				frame.LayoutOrder      = animalRarity.Weight * 100 + i
				frame.Title.Text       = animalName
				frame.Title.TextColor3 = Color3.new(1, 1, 1)
				if animalRarity.GradientPreset then
					frame.UIStroke.Color = Color3.new(1, 1, 1)
					selectionTrove:Add(Gradients.apply(frame.UIStroke, animalRarity.GradientPreset))
				else
					frame.UIStroke.Color = animalRarity.Color
				end
				frame.Visible                   = true
				frame.Return.Visible            = false
				frame.ViewportFrame.ImageColor3 = Color3.new(0, 0, 0)

				local vpCleanup = Animals:AttachOnViewport(animalName, frame.ViewportFrame, true)
				if vpCleanup then selectionTrove:Add(vpCleanup) end

				frame.Parent = brainrotsHolder

				if not ingredientFrames[animalName] then ingredientFrames[animalName] = {} end
				table.insert(ingredientFrames[animalName], frame)

				local returnBtn = selectionTrove:Add(AnimatedButton.new(frame.Return))
				returnBtn:Animate()
				selectionTrove:Add(returnBtn.OnActivated:Connect(function()
					for podiumIdx, podiumData in data:Get("AnimalPodiums") do
						if type(podiumData) == "table"
							and podiumData.Index == animalName
							and podiumData.Machine
							and (podiumData.Machine.Type == "Crafting" or podiumData.Machine.Type == "OGCrafting")
							and not podiumData.Machine.Active then
							ReturnEvent:FireServer(podiumIdx)
							return
						end
					end
				end))
			end
		end
	end

	local buyButton = panel.Buy
	local function updateBrainrotFrames()
		local podiums       = data:Get("AnimalPodiums")
		local availableCount = {}
		for _, podiumData in podiums do
			if type(podiumData) == "table"
				and podiumData.Machine
				and (podiumData.Machine.Type == "Crafting" or podiumData.Machine.Type == "OGCrafting")
				and not podiumData.Machine.Active then
				local n = podiumData.Index
				availableCount[n] = (availableCount[n] or 0) + 1
			end
		end

		local allPresent = true
		for animalName, frames in ingredientFrames do
			local count = availableCount[animalName] or 0
			for idx, frame in frames do
				local present = idx <= count
				frame.Return.Visible            = present
				frame.ViewportFrame.ImageColor3 = present and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
				if not present then allPresent = false end
			end
		end

		if buyButton then
			buyButton.Visible = allPresent
			buyButton.BackgroundColor3 = isOutOfStock and Color3.fromRGB(127, 127, 127) or Color3.fromRGB(81, 158, 86)
		end
	end

	if stockKey then
		local function syncStockState()
			local stockCount = ReplicatedStorage:GetAttribute("CraftingMachineStock_" .. stockKey)
			if typeof(stockCount) ~= "number" then stockCount = nil end
			isOutOfStock = stockCount ~= nil and stockCount <= 0
			updateBrainrotFrames()
		end
		selectionTrove:Add(
			ReplicatedStorage:GetAttributeChangedSignal("CraftingMachineStock_" .. stockKey):Connect(syncStockState)
		)
		local initStock = ReplicatedStorage:GetAttribute("CraftingMachineStock_" .. stockKey)
		isOutOfStock    = typeof(initStock) == "number" and initStock <= 0
	end

	selectionTrove:Add(data:OnChanged("AnimalAddedOrRemoved", updateBrainrotFrames))
	selectionTrove:Add(task.spawn(updateBrainrotFrames))

	if buyButton then
		if buyButton:FindFirstChild("Price") then
			buyButton.Price.Text = ("$%s"):format(NumberUtils:ToString(entry.Cost))
		end
		local buyAnimated = selectionTrove:Add(AnimatedButton.new(buyButton))
		buyAnimated:Animate()
		selectionTrove:Add(buyAnimated.OnActivated:Connect(function()
			if isOutOfStock then return end
			if not StartFunc:InvokeServer(entry.Rarity, entry.Name) then return end
			InterfaceController:SetState(panel.interfaceKey, false)
		end))
	end

	updateTimer()
end

local function updateList()
	listTrove:Clean()
	local panel = getActivePanel()
	if not panel or not panel.List or not craftingList then return end

	for i, listEntry in craftingList.List do
		local rarityData = RaritiesData[listEntry.Rarity]
		if not rarityData then continue end

		local useLimited = panel.supportsStock and listEntry.StockKey ~= nil
		local templateName = useLimited and "TemplateLimited" or "Template"
		local template = panel.List:FindFirstChild(templateName) or panel.List:FindFirstChild("Template")
		if not template then continue end

		local itemFrame = listTrove:Clone(template)
		local btnFrame  = listButtonOf(itemFrame)

		itemFrame.LayoutOrder = i
		btnFrame.Title.Text   = listEntry.Name

		if rarityData.GradientPreset then
			btnFrame.Title.TextColor3 = Color3.new(1, 1, 1)
			btnFrame.UIStroke.Color   = Color3.new(1, 1, 1)
			listTrove:Add(Gradients.apply(btnFrame.Title,    rarityData.GradientPreset))
			listTrove:Add(Gradients.apply(btnFrame.UIStroke, rarityData.GradientPreset))
		else
			btnFrame.Title.TextColor3 = rarityData.Color
			btnFrame.UIStroke.Color   = rarityData.Color
		end

		if useLimited then
			local limitedLabel = btnFrame:FindFirstChild("Limited")
			if limitedLabel then listTrove:Add(Gradients.apply(limitedLabel, "Rainbow")) end
		end

		itemFrame.Visible = true
		itemFrame.Parent  = panel.List

		local btn = listTrove:Add(AnimatedButton.new(btnFrame))
		btn:Animate()
		listTrove:Add(btn.OnActivated:Connect(function()
			selectedIndex = i
			lastSelectedIndex = nil
			updateSelection()
			updateLists()
		end))

		if AnimalsDB[listEntry.Name] then
			local cleanup = Animals:AttachOnViewport(listEntry.Name, btnFrame.ViewportFrame, true)
			if cleanup then listTrove:Add(cleanup) end
		end
	end

	updateSelection()
end

local function rebuildAll()
	lastSelectedIndex = nil
	if not craftingList or not craftingList.List or not craftingList.List[selectedIndex] then
		selectedIndex = 1
	end
	updateList()
	updateTimer()
	task.spawn(updateVFX)
end

local releaseTrack = nil
local insertTrack  = nil
local function getCyberTracks()
	local machineModel = workspace:FindFirstChild("CraftingMachine")
	local animator     = machineModel and machineModel:FindFirstChildWhichIsA("Animator", true)
	if not releaseTrack and animator and script:FindFirstChild("Release") then
		releaseTrack = animator:LoadAnimation(script.Release)
		releaseTrack:GetMarkerReachedSignal("VFX"):Connect(function()
			local machine = machineModel:FindFirstChild("Machine")
			if machine then VFX.emit(machine) end
		end)
	end
	if not insertTrack and animator and script:FindFirstChild("Insert") then
		insertTrack = animator:LoadAnimation(script.Insert)
	end
	return { insertTrack = insertTrack, releaseTrack = releaseTrack }
end

local function playDepositFeedback(craftType)
	if craftType == "OG" then
		task.spawn(function()
			local folder = ReplicatedStorage.Sounds.Sfx:FindFirstChild("Fuse Machine")
			local sound  = folder and folder:FindFirstChild("Deposit")
			if sound then SoundController:PlaySound(sound) end
		end)
	else
		local tracks = getCyberTracks()
		if tracks.insertTrack then tracks.insertTrack:Play() end
		task.spawn(function()
			local folder = ReplicatedStorage.Sounds.Sfx:FindFirstChild("Crafting Machine")
			local sound  = folder and folder:FindFirstChild("Deposit")
			if sound then SoundController:PlaySound(sound) end
		end)
	end
end

local function setupDeliveryHitbox(hitbox)
	return hitbox.Touched:Connect(function(part)
		if part.Name ~= "HumanoidRootPart" then return end
		local player = Players:GetPlayerFromCharacter(part.Parent)
		if not player or player ~= LocalPlayer then return end
		if not player:GetAttribute("StealingIndex") then return end

		local success = DeliveryFunc:InvokeServer(hitbox)
		if not success then return end

		playDepositFeedback(getActiveCrafttype())
		updateTimer()
	end)
end

Controller.Start = function(_)
	for _, panel in { cyberPanel, ogPanel } do
		if panel and panel.root then
			panel.root.Visible = false
			panel.interfaceState = InterfaceController:Register(panel.interfaceKey, panel.root, "TopQuint")
			if panel.Close then panel.interfaceState:AttachCloseButton(panel.Close) end
			panel.interfaceState:Close()
		end
	end

	Synchronizer:WaitAndCall(LocalPlayer, function(playerData)
		local function onCraftChanged()
			task.spawn(updateTimer)
			task.spawn(updateVFX)
		end
		playerData:OnChanged("CraftingMachine",            onCraftChanged)
		playerData:OnChanged("CraftingMachine.Brainrot",   onCraftChanged)
		playerData:OnChanged("CraftingMachine.Rarity",     onCraftChanged)
		playerData:OnChanged("CraftingMachine.FinishTime", onCraftChanged)
		playerData:OnChanged("CraftingMachine.StartTime",  onCraftChanged)
		playerData:OnChanged("CraftingMachine.OutputMutationOdds", function() task.spawn(updateLists) end)
		playerData:OnChanged("CraftingMachine.OutputTraitsOdds",   function() task.spawn(updateLists) end)
		task.spawn(onCraftChanged)
		task.spawn(updateLists)
	end)

	Timer.Simple(1, function()
		task.spawn(updateVFX)
		task.spawn(updateTimer)
	end)

	local function bindCrafttypeListener(model)
		if not model then return end
		model:GetAttributeChangedSignal("Crafttype"):Connect(function()
			task.spawn(rebuildAll)
		end)
	end
	bindCrafttypeListener(workspace:FindFirstChild("CraftingMachine"))
	bindCrafttypeListener(resolveCraftModel("OG"))
	workspace.ChildAdded:Connect(function(child)
		if child.Name == "CraftingMachine" or child.Name == "OG CraftingMachine" then
			bindCrafttypeListener(child)
			task.spawn(rebuildAll)
		end
	end)

	local function setupPrompt(prompt)
		local promptTrove = Trove.new()

		local function updatePromptText()
			local data = Synchronizer:Wait(LocalPlayer)
			if not data then return end
			local startTime  = data:Get("CraftingMachine.StartTime")
			local finishTime = data:Get("CraftingMachine.FinishTime")
			if finishTime and finishTime ~= 0 and finishTime <= workspace:GetServerTimeNow() then
				prompt.ActionText = "Claim"
			elseif startTime and startTime ~= 0 then
				prompt.ActionText = "Craft Now"
			else
				prompt.ActionText = CRAFT_LABELS[getActiveCrafttype()] or "Cyber Craft"
			end
		end

		promptTrove:Add(task.spawn(function()
			local data = Synchronizer:Wait(LocalPlayer)
			if not data then return end
			data:OnChanged("CraftingMachine", updatePromptText)
			promptTrove:Add(Timer.Simple(1, updatePromptText))
			task.spawn(updatePromptText)
		end))

		promptTrove:Add(prompt.Triggered:Connect(function()
			local data = Synchronizer:Get(LocalPlayer)
			if not data then return end
			local startTime  = data:Get("CraftingMachine.StartTime")
			local finishTime = data:Get("CraftingMachine.FinishTime")
			if finishTime and finishTime ~= 0 and finishTime <= workspace:GetServerTimeNow() then
				ClaimEvent:FireServer()
			elseif startTime and startTime ~= 0 then
				CraftNowEvent:FireServer()
			else
				local panel = getActivePanel()
				if panel then InterfaceController:Toggle(panel.interfaceKey) end
			end
		end))

		return function() promptTrove:Destroy() end
	end

	Observers.observeTag("CraftingMachinePrompt", setupPrompt)
	Observers.observeTag("OGCraftingMachinePrompt", setupPrompt)

	Observers.observeTag("CraftingMachineHitbox", function(hitbox)
		local conn = setupDeliveryHitbox(hitbox)
		return function() conn:Disconnect() end
	end)
	Observers.observeTag("OGCraftingMachine", function(model)
		local trove = Trove.new()
		local hitboxes = model:FindFirstChild("Hitboxes")
		if hitboxes then
			for _, hb in hitboxes:GetChildren() do
				trove:Add(setupDeliveryHitbox(hb))
			end
		end
		return function() trove:Destroy() end
	end)

	local activeCraftIds = {}
	CraftNowEvent.OnClientEvent:Connect(function(rarity)
		local craftType = getActiveCrafttype()
		local model     = resolveCraftModel(craftType)
		if not model then return end

		local craftId = HttpService:GenerateGUID(false)
		activeCraftIds[craftId] = true
		isCraftAnimating = next(activeCraftIds) ~= nil

		if craftType == "OG" then
			local vfxFolder = model:FindFirstChild("VFX")
			local rarVfx    = vfxFolder and vfxFolder:FindFirstChild(rarity)
			if rarVfx then
				pcall(function()
					local chargingModel = rarVfx:FindFirstChild("ChargingModel")
					if chargingModel then
						chargingModel:ScaleTo(1)
						local charging  = chargingModel:FindFirstChild("Charging")
						local chargeAtt = charging and charging:FindFirstChild("Charge")
						if chargeAtt then
							for _, d in chargeAtt:GetDescendants() do
								if d:IsA("ParticleEmitter") then d.TimeScale = 1 end
							end
						end
					end
					VFX.enable(rarVfx)
					local soundPart = rarVfx:FindFirstChild("SoundPart")
					local sound = soundPart and soundPart:FindFirstChild("Sound")
					if sound then sound:Play() end
				end)
			end
			local chargeSoundPart = model:FindFirstChild("ChargeSoundPart")
			if chargeSoundPart and chargeSoundPart:FindFirstChild("Sound") and chargeSoundPart.Sound.IsPlaying then
				chargeSoundPart.Sound:Stop()
			end
			task.wait(1.5)
			if rarVfx then
				VFX.disable(rarVfx)
				if rarVfx:FindFirstChild("Burst") then VFX.emit(rarVfx.Burst) end
			end
		else
			local tracks = getCyberTracks()
			if tracks.releaseTrack then tracks.releaseTrack:Play() end
			task.spawn(function()
				local folder = ReplicatedStorage.Sounds.Sfx:FindFirstChild("Crafting Machine")
				local sound  = folder and folder:FindFirstChild("CraftStart")
				if sound then SoundController:PlaySound(sound, model:GetPivot().Position, false) end
			end)
			task.wait(3)
			local chargeStrike = model:FindFirstChild("VFX") and model.VFX:FindFirstChild("ChargeStrike")
			if chargeStrike then VFX.emit(chargeStrike) end
			local spawnZone = model:FindFirstChild("SpawnZone") or model
			task.spawn(function()
				local folder = ReplicatedStorage.Sounds.Sfx:FindFirstChild("Crafting Machine")
				local sound  = folder and folder:FindFirstChild("Craft")
				if sound then SoundController:PlaySound(sound, spawnZone:GetPivot().Position, false) end
			end)
		end

		activeCraftIds[craftId] = nil
		isCraftAnimating = next(activeCraftIds) ~= nil
	end)

	UpdateEvent.OnClientEvent:Connect(function(newList)
		lastSelectedIndex = nil
		craftingList      = newList
		selectedIndex     = 1
		updateList()
	end)

	craftingList = FetchFunc:InvokeServer() or craftingList
	task.spawn(updateList)

	Timer.Simple(1, function()
		local panel = getActivePanel()
		if panel and panel.Timer then
			local refreshIn = (craftingList and craftingList.Refresh or 0) - workspace:GetServerTimeNow()
			panel.Timer.Text = ("Refreshes in %*"):format(TimeUtils:E(math.max(refreshIn, 0)))
		end
	end, true)

	Synchronizer:WaitAndCall(LocalPlayer, function()
		updateList()
	end)

	Observers.observeTag("CraftingMachineVFXEnable", function(vfxPart)
		local conn = chargingSignal:Connect(function()
			if isCharging then VFX.enable(vfxPart) else VFX.disable(vfxPart) end
		end)
		if isCharging then VFX.enable(vfxPart) else VFX.disable(vfxPart) end
		return function() conn:Disconnect() end
	end)

	task.spawn(function()
		local data = Synchronizer:Wait(LocalPlayer)
		if not data then return end
		local palette = {
			Color3.fromRGB(163, 162, 165),
			Color3.fromRGB(93, 176, 55),
			Color3.fromRGB(179, 168, 48),
			Color3.fromRGB(88, 173, 106),
		}
		local rng = Random.new()
		while true do
			local waitTime = 1
			local goal     = 3
			if getActiveCrafttype() == "OG" then
				local now    = workspace:GetServerTimeNow()
				local start  = data:Get("CraftingMachine.StartTime")
				local finish = data:Get("CraftingMachine.FinishTime")
				if start and finish and now < finish then
					local progress = math.clamp((now - start) / (finish - start), 0, 1)
					waitTime = math.lerp(0.5, 0.25, progress)
					goal     = math.lerp(4, 5, progress)
				end
				task.wait(waitTime)
				local model = resolveCraftModel("OG")
				local cubes = model and model:FindFirstChild("Cubes")
				if cubes then
					for _, cube in cubes:GetChildren() do
						Spr.target(cube, 1, goal, { Color = palette[rng:NextInteger(1, #palette)] })
					end
				end
			else
				task.wait(1)
			end
		end
	end)
end

return Controller
