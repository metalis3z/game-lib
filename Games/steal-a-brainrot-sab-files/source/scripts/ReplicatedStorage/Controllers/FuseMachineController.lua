-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Observers = require(ReplicatedStorage.Packages.Observers)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local ShopController = require(ReplicatedStorage.Controllers.ShopController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local FuseMachineData = require(ReplicatedStorage.Datas.FuseMachineData)
local Mutations = require(ReplicatedStorage.Shared.Mutations)
local Animals = require(ReplicatedStorage.Shared.Animals)
local Mutations_2 = require(ReplicatedStorage.Datas.Mutations)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local Index = require(ReplicatedStorage.Shared.Index)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Animals_2 = require(ReplicatedStorage.Datas.Animals)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Traits = require(ReplicatedStorage.Datas.Traits)
local Updates = require(ReplicatedStorage.Shared.Updates)
local Animals = require(ReplicatedStorage.Shared.Animals)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Spr = require(ReplicatedStorage.Packages.Spr)
local VFX = require(ReplicatedStorage.Shared.VFX)
local exclusive_animals = require(ReplicatedStorage.Exclusive)
local shopServicePurchase = Net:RemoteEvent("ShopService/Purchase")

local LocalPlayer = Players.LocalPlayer

local FuseMachine = LocalPlayer.PlayerGui:WaitForChild("FuseMachine").FuseMachine

local WitchFuseScreenGui = LocalPlayer.PlayerGui:WaitForChild("WitchFuse", 5)
local WitchFuseMain = WitchFuseScreenGui and WitchFuseScreenGui:FindFirstChild("WitchFuse")
local SantaFuseScreenGui = LocalPlayer.PlayerGui:WaitForChild("SantaFuse", 5)
local SantaFuseMain = SantaFuseScreenGui and SantaFuseScreenGui:FindFirstChild("SantaFuse")

local NormalFuseScreenGui = LocalPlayer.PlayerGui:WaitForChild("NormalFuse", 5)
local NormalFuseMain = NormalFuseScreenGui and NormalFuseScreenGui:FindFirstChild("NormalFuse")

local Brainrots = FuseMachine.Brainrots
local Fusions = FuseMachine.Fusions
local FusionsOld = FuseMachine.FusionsOld
local Time = FuseMachine.Time
local Buy = FuseMachine.Buy
local Close = FuseMachine.Header.Close

local function buildPanel(root)
	if not root then return nil end
	local lists = root:FindFirstChild("Lists")
	local mutations = lists and lists:FindFirstChild("Mutations")
	local traits = lists and lists:FindFirstChild("Traits")
	return {
		root = root,
		Brainrots = root:FindFirstChild("Brainrots"),
		Fusions = root:FindFirstChild("Fusions"),
		FusionsOld = root:FindFirstChild("FusionsOld"),
		Time = root:FindFirstChild("Time"),
		Buy = root:FindFirstChild("Buy"),
		Lists = lists,
		Mutations = mutations,
		MutationsScroll = mutations and mutations:FindFirstChild("ScrollingFrame"),
		Traits = traits,
		TraitsScroll = traits and traits:FindFirstChild("ScrollingFrame"),
		LuckyIcon = root:FindFirstChild("LuckyIcon"),
		LuckBlur = root:FindFirstChild("LuckBlur"),
		PossibleFusions = root:FindFirstChild("PossibleFusions"),
	}
end

local summerPanelInst = buildPanel(FuseMachine)
local normalPanelInst = NormalFuseMain and buildPanel(NormalFuseMain) or nil
local witchPanelInst  = WitchFuseMain  and buildPanel(WitchFuseMain)  or nil
local santaPanelInst = SantaFuseMain and buildPanel(SantaFuseMain) or nil

local fusePanels = {}
do
	if summerPanelInst then table.insert(fusePanels, summerPanelInst) end
	if normalPanelInst then table.insert(fusePanels, normalPanelInst) end
	if witchPanelInst  then table.insert(fusePanels, witchPanelInst)  end
	if santaPanelInst  then table.insert(fusePanels, santaPanelInst)  end
end
local function getActivePanels()
	local fuseMachineWs = workspace:FindFirstChild("FuseMachine")
	local fuseType = fuseMachineWs and fuseMachineWs:GetAttribute("FuseType")
	if fuseType == "Summer" then
		return summerPanelInst and { summerPanelInst } or {}
	elseif fuseType == "Witch" then
		return witchPanelInst and { witchPanelInst } or {}
	elseif fuseType == "Santa" then
		return santaPanelInst and { santaPanelInst } or {}
	else
		return normalPanelInst and { normalPanelInst } or {}
	end
end

local cleanObj_2 = Trove.new()
local _unused = Trove.new()

local registerResult = nil

local data = {}

local function getBrainrotsInMachine(connections_2)
	local data_2 = {}
	for v48EntryId, v48Entry in connections_2 do
		if v48Entry.Machine and v48Entry.Machine.Type == "Fuse" then
			local ref6 = table.clone(v48Entry)
			ref6.IndexOnPlot = v48EntryId
			table.insert(data_2, ref6)
		end
	end

	return data_2
end

local fn1 = nil
local addObj = Trove.new()

local function SetupBrainrots()

	local getObj_6 = Synchronizer:Get(LocalPlayer)
	if not getObj_6 then
		return
	end
	addObj:Clean()
	local flag_13 = getBrainrotsInMachine(getObj_6:Get("AnimalPodiums"))
	if not flag_13 then
		return
	end

	for _, panel in getActivePanels() do
		local panelBrainrots = panel.Brainrots
		if not panelBrainrots then
			continue
		end
		local template = panelBrainrots:FindFirstChild("Template")
		if not template then
			continue
		end

		for layoutOrder = 1, FuseMachineData.FuseSlots do
			local v57Data = flag_13[layoutOrder]
			if not v57Data or v57Data == "Empty" then
				local returnObj = addObj:Clone(template)
				returnObj.Name = ("Empty.%*"):format(layoutOrder)
				returnObj.LayoutOrder = layoutOrder
				returnObj.Visible = true
				returnObj.BrainrotName.Text = "Empty"
				returnObj.BrainrotName.TextColor3 = Color3.fromRGB(255, 112, 112)
				returnObj.Return:Destroy()
				returnObj.Rarity:Destroy()
				returnObj.Mutation:Destroy()
				returnObj.ViewportFrame:Destroy()
				returnObj.Parent = panelBrainrots
			else
				local animals_2Data = Animals_2[v57Data.Index]
				local rarityData = Rarities[animals_2Data.Rarity]
				local ref7 = addObj:Clone(template)
				ref7.Name = ("%*.%*"):format(animals_2Data.DisplayName, layoutOrder)
				ref7.LayoutOrder = layoutOrder
				ref7.BrainrotName.Text = animals_2Data.DisplayName
				if v57Data.Mutation then
					local mutations_2Data = Mutations_2[v57Data.Mutation]
					ref7.Mutation.Text = if mutations_2Data.UseRichText then mutations_2Data.DisplayWithRichText else mutations_2Data.DisplayText
					ref7.Mutation.RichText = mutations_2Data.UseRichText
					if mutations_2Data.GradientPreset then
						ref7.Mutation.TextColor3 = Color3.fromRGB(255, 255, 255)
						Gradients.apply(ref7.Mutation, mutations_2Data.GradientPreset)
					else
						ref7.Mutation.TextColor3 = mutations_2Data.MainColor
					end
				end
				ref7.Rarity.Text = animals_2Data.Rarity
				if rarityData.GradientPreset then
					ref7.Rarity.TextColor3 = Color3.fromRGB(255, 255, 255)
					Gradients.apply(ref7.Rarity, rarityData.GradientPreset)
				else
					ref7.Rarity.TextColor3 = rarityData.Color
				end
				ref7.Visible = true
				ref7.Parent = panelBrainrots
				local handle = AnimatedButton.new(ref7.Return)
				addObj:Add(handle)
				handle:Animate()
				addObj:Add(handle.OnActivated:Connect(function()

					local flag_14, val10 = FuseMachineData.Remotes.RemoveBrainrot:InvokeServer(v57Data.IndexOnPlot)
					if not flag_14 then
						NotificationController:Error(val10 or "Something went wrong!")
						return
					else
						return
					end
				end))


				local handle_2
				if exclusive_animals[animals_2Data.DisplayName] then
					handle_2 = Animals:AttachOnViewport(animals_2Data.DisplayName, ref7.ViewportFrame, true, nil)
					if handle_2 then
						addObj:Add(handle_2)
					end
					if v57Data.Mutation then
						local animalModel = ref7.ViewportFrame:FindFirstChildWhichIsA("Model", true)
						if animalModel then
							for _, child in animalModel:GetChildren() do
								if child:IsA("Model") then
									local result = Animals:ApplyMutation(child, child.Name, v57Data.Mutation)
									if result then
										addObj:Add(result)
									end
								end
							end
						end
					end
				else
					handle_2 = Animals:AttachOnViewport(animals_2Data.DisplayName, ref7.ViewportFrame, true, v57Data.Mutation and v57Data.Mutation or nil)
					if handle_2 then
						addObj:Add(handle_2)
					end
				end
			end
		end
	end
end

local function UpdateOdds()

	local getObj_7 = Synchronizer:Get(LocalPlayer)
	if not getObj_7 then
		return
	end

	local flag_15 = getObj_7:Get("FuseMachine.OutputRarityOdds")
	local connections_3 = getObj_7:Get("FuseMachine.OutputTraitsOdds") or {}
	local connections_4 = getObj_7:Get("FuseMachine.OutputMutationOdds") or {}

	for _, panel in getActivePanels() do
		if panel.Fusions then panel.Fusions.Visible = false end
		if panel.FusionsOld then panel.FusionsOld.Visible = false end
		if panel.PossibleFusions then panel.PossibleFusions.Visible = false end

		if panel.Fusions then
			for _, child in panel.Fusions:GetChildren() do
				if child:IsA("Frame") and child.Name ~= "Template" then
					child:Destroy()
				end
			end
		end
		if panel.FusionsOld then
			for _, child_2 in panel.FusionsOld:GetChildren() do
				if child_2:IsA("TextLabel") and child_2.Name ~= "Template" then
					child_2:Destroy()
				end
			end
		end
		if panel.MutationsScroll then
			for _, child_3 in panel.MutationsScroll:GetChildren() do
				if child_3:IsA("Frame") and child_3.Name ~= "Template" then
					child_3:Destroy()
				end
			end
		end
		if panel.TraitsScroll then
			for _, child_4 in panel.TraitsScroll:GetChildren() do
				if child_4:IsA("Frame") and child_4.Name ~= "Template" then
					child_4:Destroy()
				end
			end
		end

		if not flag_15 then
			continue
		end

		local mutationsVisible = false
		if panel.MutationsScroll then
			local mutationsTemplate = panel.MutationsScroll:FindFirstChild("Template")
			if mutationsTemplate then
				for v81EntryId, v81Entry in connections_4 do
					local mutations_2Data_2 = Mutations_2[v81EntryId]
					if mutations_2Data_2 then
						local ref8 = mutationsTemplate:Clone()
						ref8.Name = v81EntryId
						ref8.LayoutOrder = -v81Entry
						ref8.Vector.Image = mutations_2Data_2.Icon or ""
						ref8.Title.Text = if mutations_2Data_2.UseRichText then mutations_2Data_2.DisplayWithRichText else mutations_2Data_2.DisplayText
						ref8.Title.RichText = mutations_2Data_2.UseRichText
						if mutations_2Data_2.GradientPreset then
							ref8.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
							Gradients.apply(ref8.Title, mutations_2Data_2.GradientPreset)
						else
							ref8.Title.TextColor3 = mutations_2Data_2.MainColor
						end
						local _, val11 = math.modf(v81Entry)
						ref8.Chance.Text = ("%*%%"):format((string.format(val11 == 0 and "%d" or "%.2f", v81Entry)))
						ref8.Visible = true
						ref8.Parent = panel.MutationsScroll
						mutationsVisible = true
					end
				end
			end
		end
		if panel.Mutations then
			panel.Mutations.Visible = mutationsVisible
		end

		local traitsVisible = false
		if panel.TraitsScroll then
			local traitsTemplate = panel.TraitsScroll:FindFirstChild("Template")
			if traitsTemplate then
				for v80EntryId, v80Entry in connections_3 do
					local traitData = Traits[v80EntryId]
					if traitData then
						local ref9 = traitsTemplate:Clone()
						ref9.Name = v80EntryId
						ref9.LayoutOrder = -v80Entry
						ref9.Vector.Image = traitData.Icon or ""
						ref9.Title.Text = traitData.DisplayWithRichText
						ref9.Title.TextColor3 = traitData.Color
						ref9.Title.RichText = true
						local _, val12 = math.modf(v80Entry)
						ref9.Chance.Text = ("%*%%"):format((string.format(val12 == 0 and "%d" or "%.2f", v80Entry)))
						ref9.Visible = true
						ref9.Parent = panel.TraitsScroll
						traitsVisible = true
					end
				end
			end
		end
		if panel.Traits then
			panel.Traits.Visible = traitsVisible
		end

		local visible = false
		local fusionsOldTemplate = panel.FusionsOld and panel.FusionsOld:FindFirstChild("Template")
		local fusionsTemplate = panel.Fusions and panel.Fusions:FindFirstChild("Template")
		for itemId, item_2 in (table.clone(flag_15)) do
			if item_2 ~= 0 then
				if Rarities[itemId] then
					if fusionsOldTemplate then
						visible = true
						local rarityData_2 = Rarities[itemId]
						local ref1 = fusionsOldTemplate:Clone()
						ref1.Name = itemId
						local _, val1 = math.modf(item_2)
						ref1.Text = ("%* (%*%%)"):format(itemId, (string.format(val1 == 0 and "%d" or "%.2f", item_2)))
						if rarityData_2.GradientPreset then
							ref1.TextColor3 = Color3.fromRGB(255, 255, 255)
							Gradients.apply(ref1, rarityData_2.GradientPreset)
						else
							ref1.TextColor3 = rarityData_2.Color
						end
						ref1.LayoutOrder = -item_2
						ref1.Visible = true
						ref1.Parent = panel.FusionsOld
					end
				elseif Animals_2[itemId] then
					if fusionsTemplate then
						local animals_2Data_2 = Animals_2[itemId]
						local rarityData_3 = Rarities[animals_2Data_2.Rarity]
						local ref2 = fusionsTemplate:Clone()
						ref2.Name = ("%*.%*"):format(itemId, animals_2Data_2.Rarity)
						ref2.BrainrotName.Text = itemId
						local _, val2 = math.modf(item_2)
						ref2.Weight.Text = ("%*%%"):format((string.format(val2 == 0 and "%d" or "%.2f", item_2)))
						if rarityData_3.GradientPreset then
							ref2.Weight.TextColor3 = Color3.fromRGB(255, 255, 255)
							Gradients.apply(ref2.Weight, rarityData_3.GradientPreset)
						else
							ref2.Weight.TextColor3 = rarityData_3.Color
						end
						ref2.LayoutOrder = -item_2
						ref2.Visible = true
						ref2.Parent = panel.Fusions
						if exclusive_animals[animals_2Data_2.DisplayName] then
							Animals:AttachOnViewport(animals_2Data_2.DisplayName, ref2.ViewportFrame, true, nil)
						else
							Animals:AttachOnViewport(animals_2Data_2.DisplayName, ref2.ViewportFrame, true, nil)
						end
					end
				end
			end
		end
		if panel.Fusions then panel.Fusions.Visible = not visible end
		if panel.FusionsOld then panel.FusionsOld.Visible = visible end
		if panel.PossibleFusions then panel.PossibleFusions.Visible = true end
	end
end

for _, panel in fusePanels do
	if panel.Buy then
		local a = AnimatedButton.new(panel.Buy)
		a:Animate()
		panel.buyAnimator = a
	end
end

local function UpdateBuyButton()

	local getObj = Synchronizer:Get(LocalPlayer)
	if not getObj then
		return
	end
	local flag_3 = getObj:Get("FuseMachine.Cost")
	cleanObj_2:Clean()

	for _, panel in getActivePanels() do
		if panel.Buy then
			panel.Buy.Visible = false
		end
	end

	if not flag_3 then
		return
	end
	local flag_4 = getObj:Get("FuseMachine.StartTime")
	if flag_4 and flag_4 ~= 0 then
		return
	end

	for _, panel in getActivePanels() do
		if panel.Buy then
			local priceLabel = panel.Buy:FindFirstChild("Price")
			if priceLabel then
				priceLabel.Text = ("$%*"):format((NumberUtils:ToString(flag_3)))
			end
			panel.Buy.Visible = true
			if panel.buyAnimator then
				cleanObj_2:Add(panel.buyAnimator.OnActivated:Connect(function()
					local flag_5, val3 = FuseMachineData.Remotes.ConfirmFusion:InvokeServer()
					if not flag_5 then
						NotificationController:Error(val3 or "Something went wrong!")
						return
					else
						cleanObj_2:Clean()
						return
					end
				end))
			end
		end
	end
end

local cleanObj = Trove.new()

local function getActiveCountdownEntries()
	local fuseMachineWs = workspace:FindFirstChild("FuseMachine")
	local witchFuseWs = workspace:FindFirstChild("Witch Fuse")
	local fuseType = fuseMachineWs and fuseMachineWs:GetAttribute("FuseType")
	local witchActive = (fuseType == "Witch") and witchFuseWs ~= nil
	local santaFuseWs = fuseMachineWs
		and fuseMachineWs:FindFirstChild("Models")
		and fuseMachineWs.Models:FindFirstChild("Santa")

	local active = {}
	for _, taggedEntry in CollectionService:GetTagged("FuseMachineCountdown") do
		local belongsToWitch = witchFuseWs and taggedEntry:IsDescendantOf(witchFuseWs)

		local belongsToSanta = santaFuseWs and taggedEntry:IsDescendantOf(santaFuseWs)
		local santaActive = (fuseType == "Santa") and santaFuseWs ~= nil

		local belongsToFuse = fuseMachineWs
			and taggedEntry:IsDescendantOf(fuseMachineWs)
			and not belongsToWitch
			and not belongsToSanta

		local isActive
		if witchActive then
			isActive = belongsToWitch == true
		elseif santaActive then
			isActive = belongsToSanta == true
		elseif belongsToFuse then
			isActive = true
		elseif not belongsToWitch and not belongsToSanta then
			isActive = true
		else
			isActive = false
		end

		local billboard = taggedEntry:FindFirstAncestorOfClass("BillboardGui")
		if billboard then
			billboard.Enabled = isActive
		end

		if isActive then
			table.insert(active, taggedEntry)
		end
	end
	return active
end

local function UpdateTimer()
	cleanObj:Clean()
	local getObj_2 = Synchronizer:Get(LocalPlayer)
	if not getObj_2 then
		return
	end

	for _, panel in getActivePanels() do
		if panel.Time then panel.Time.Visible = false end
	end

	local flag_6 = getObj_2:Get("FuseMachine.FinishTime")
	local v131 = getObj_2:Get("FuseMachine.StartTime")

	if flag_6 and v131 and v131 ~= 0 then
		if flag_6 - workspace:GetServerTimeNow() < 0 then
			for _, panel in getActivePanels() do
				if panel.Time then
					panel.Time.Visible = true
					panel.Time.Text = "Fusion Time (<font color=\"#ffff00\">0s</font>)"
				end
			end
			for _, taggedEntry_2 in getActiveCountdownEntries() do
				taggedEntry_2.Text = "READY"
			end
			return
		else
			local serverTimeNow = TimeUtils:E(flag_6 - workspace:GetServerTimeNow())
			local formatted = ("Fusion Time (<font color=\"#ffff00\">%*</font>)"):format(serverTimeNow)
			for _, panel in getActivePanels() do
				if panel.Time then
					panel.Time.Visible = true
					panel.Time.Text = formatted
				end
			end
			for _, taggedEntry_3 in getActiveCountdownEntries() do
				taggedEntry_3.Text = serverTimeNow
			end
			return
		end
	else
		local connections = getObj_2:Get("FuseMachine.OutputRarityOdds")
		local idleText
		if connections then
			local val4 = "Common"
			for v119EntryId, v119Entry in connections do
				if v119Entry > 0 then
					if Rarities[v119EntryId] then
						if Rarities[v119EntryId].Weight > Rarities[val4].Weight then
							val4 = v119EntryId
						end
					else
						local animals_2Data_3 = Animals_2[v119EntryId]
						if not animals_2Data_3 or not animals_2Data_3.Price then
							warn((("Failed to find AnimalsData for %*"):format(v119EntryId)))
						elseif Rarities[animals_2Data_3.Rarity].Weight > Rarities[val4].Weight then
							val4 = animals_2Data_3.Rarity
						end
					end
				end
			end
			local fuseMachineDataData = FuseMachineData.FuseTime[val4] or 900
			idleText = ("Fusion Time (<font color=\"#ffff00\">%*</font>)"):format((TimeUtils:E(fuseMachineDataData)))
		else
			idleText = "Fusion Time (<font color=\"#ffff00\">0s</font>)"
		end

		for _, panel in getActivePanels() do
			if panel.Time then
				panel.Time.Text = idleText
				panel.Time.Visible = connections ~= nil
			end
		end

		local val5 = #getBrainrotsInMachine(getObj_2:Get("AnimalPodiums"))
		for _, taggedEntry in getActiveCountdownEntries() do
			taggedEntry.Text = ("%*/%*"):format(val5, FuseMachineData.FuseSlots)
		end
		return
	end
end

local function UpdateLuckVisibility()
	local getObj_3 = Synchronizer:Get(LocalPlayer)
	if not getObj_3 then return end

	local ref3 = getObj_3:Get("FuseMachine")

	local attributeLuck = data:GetLuck()

	local rawLuck
	if not attributeLuck then
		rawLuck = false
	elseif ref3.StartTime and ref3.StartTime ~= 0 then
		rawLuck = ref3.FuseLuckMultiplier
	else
		rawLuck = attributeLuck
	end

	local isLucky = (rawLuck == true) or (type(rawLuck) == "number" and rawLuck > 1)

	for _, panel in getActivePanels() do
		if panel.LuckyIcon then panel.LuckyIcon.Visible = isLucky end
		if panel.LuckBlur then panel.LuckBlur.Visible = isLucky end
		if panel.Fusions then
			local stroke = panel.Fusions:FindFirstChild("LuckUIStroke")
			if stroke then stroke.Enabled = isLucky end
		end
	end
end
data.GetLuck = function(_)

	return ReplicatedStorage:GetAttribute("FuseMachineLuck") or false
end

data.OnLuckChanged = function(getLuckObj, val6)

	return (ReplicatedStorage:GetAttributeChangedSignal("FuseMachineLuck"):Connect(function()

		val6(getLuckObj:GetLuck())
	end))
end

data.Start = function(enabled)

	task.spawn(pcall, function()

		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	registerResult = InterfaceController:Register("FuseMachine", FuseMachine, "TopQuint")
	registerResult:AttachCloseButton(Close)
	registerResult:Close()

	local normalRegisterResult = nil
	if NormalFuseMain then
		normalRegisterResult = InterfaceController:Register("NormalFuse", NormalFuseMain, "TopQuint")
		local normalHeader = NormalFuseMain:FindFirstChild("Header")
		local normalClose = normalHeader and normalHeader:FindFirstChild("Close")
		if normalClose then
			normalRegisterResult:AttachCloseButton(normalClose)
		end
		normalRegisterResult:Close()
	end
	local santaRegisterResult = nil
	if SantaFuseMain then
		santaRegisterResult = InterfaceController:Register("SantaFuse", SantaFuseMain, "TopQuint")
		local santaHeader = SantaFuseMain:FindFirstChild("Header")
		local santaClose = santaHeader and santaHeader:FindFirstChild("Close")
		if santaClose then
			santaRegisterResult:AttachCloseButton(santaClose)
		end
		santaRegisterResult:Close()
	end
	local witchRegisterResult = nil
	if WitchFuseMain then
		witchRegisterResult = InterfaceController:Register("WitchFuse", WitchFuseMain, "TopQuint")
		local witchHeader = WitchFuseMain:FindFirstChild("Header")
		local witchClose = witchHeader and witchHeader:FindFirstChild("Close")
		if witchClose then
			witchRegisterResult:AttachCloseButton(witchClose)
		end
		witchRegisterResult:Close()
	end

	local animateObj_2 = AnimatedButton.new(FuseMachine.FuseLuck.Buy)
	animateObj_2:Animate()
	animateObj_2.OnActivated:Connect(function()

		shopServicePurchase:FireServer(FuseMachineData.FuseLuckProductId)
	end)

	local function updateFuseLuckVisibility()
		local fuseMachineWs = workspace:FindFirstChild("FuseMachine")
		local currentFuseType = fuseMachineWs and fuseMachineWs:GetAttribute("FuseType")
		local fflagsAllow = FFlags:GetInstant("FuseMachineService/ShowFuseMachineLuck", true)
			and FFlags:GetInstant("FuseMachineService/FuseMachineLuckEnabled", true)

		FuseMachine.FuseLuck.Visible = fflagsAllow and currentFuseType == "Summer"

		if NormalFuseMain then
			local normalFuseLuck = NormalFuseMain:FindFirstChild("FuseLuck")
			if normalFuseLuck then
				normalFuseLuck.Visible = fflagsAllow
					and (currentFuseType == "Normal" or currentFuseType == "Divine")
			end
		end

		if WitchFuseMain then
			local witchFuseLuck = WitchFuseMain:FindFirstChild("FuseLuck")
			if witchFuseLuck then
				witchFuseLuck.Visible = false
			end
		end

		if SantaFuseMain then
			local santaFuseLuck = SantaFuseMain:FindFirstChild("FuseLuck")
			if santaFuseLuck then
				santaFuseLuck.Visible = false
			end
		end
	end
	FFlags:OnUpdate(updateFuseLuckVisibility)
	do
		local fuseMachineWs = workspace:FindFirstChild("FuseMachine")
		if fuseMachineWs then
			fuseMachineWs:GetAttributeChangedSignal("FuseType"):Connect(updateFuseLuckVisibility)
		end
	end
	task.spawn(updateFuseLuckVisibility)
	fn1 = function()

		task.spawn(SetupBrainrots)
		task.spawn(UpdateBuyButton)
		task.spawn(UpdateOdds)
		task.spawn(UpdateTimer)
		task.spawn(UpdateLuckVisibility)
	end
	enabled:OnLuckChanged(UpdateLuckVisibility)
	Mutations.watch(UpdateOdds)
	Synchronizer:WaitAndCall(LocalPlayer, function(onChangedObj)

		onChangedObj:OnChanged("FuseMachine", fn1)
		onChangedObj:OnChanged("FuseMachine.Cost", fn1)
		onChangedObj:OnChanged("FuseMachine.OutputRarityOdds", fn1)
		onChangedObj:OnChanged("FuseMachine.OutputTraitsOdds", fn1)
		onChangedObj:OnChanged("FuseMachine.OutputMutationOdds", fn1)
		onChangedObj:OnChanged("FuseMachine.FuseLuckMultiplier", fn1)
		task.spawn(fn1)
	end)
	Timer.Simple(1, function()

		UpdateTimer()
		UpdateBuyButton()
	end)
	Observers.observeTag("FuseMachinePrompt", function(triggeredObj)

		local managedObj = Trove.new()

		local function UpdatePrompt()
			local getObj_4 = Synchronizer:Wait(LocalPlayer)
			if not getObj_4 then
				return
			else
				local flag_7 = getObj_4:Get("FuseMachine.StartTime")
				local flag_8 = getObj_4:Get("FuseMachine.FinishTime")

				if flag_8 and flag_8 ~= 0 and flag_7 and flag_7 ~= 0 and flag_8 <= workspace:GetServerTimeNow() then
					triggeredObj.ActionText = "Claim"
					return
				elseif flag_7 and flag_7 ~= 0 then
					if (getObj_4:Get("FuseMachine.InstantReveals") or 0) >= 1 then
						triggeredObj.ActionText = "Reveal Now (FREE)"
						return
					else
						triggeredObj.ActionText = "Reveal Now"
						return
					end
				else
					local fuseMachineWs = workspace:FindFirstChild("FuseMachine")
					local currentFuseType = fuseMachineWs and fuseMachineWs:GetAttribute("FuseType")
					if currentFuseType == "Witch" then
						triggeredObj.ActionText = "Witch Fuse"
					elseif currentFuseType == "Summer" then
						triggeredObj.ActionText = "Summer Fuse"
					elseif currentFuseType == "Santa" then
						triggeredObj.ActionText = "Santa's Fuse"
					else
						triggeredObj.ActionText = "Fuse Machine"
					end
					return
				end
			end
		end
		managedObj:Add(task.spawn(function()

			local onChangedObj_2 = Synchronizer:Wait(LocalPlayer)
			if not onChangedObj_2 then
				return
			else
				onChangedObj_2:OnChanged("FuseMachine", UpdatePrompt)
				onChangedObj_2:OnChanged("FuseMachine.Cost", UpdatePrompt)
				onChangedObj_2:OnChanged("FuseMachine.OutputRarityOdds", UpdatePrompt)
				managedObj:Add(Timer.Simple(1, UpdatePrompt))
				task.spawn(UpdatePrompt)
				return
			end
		end))
		managedObj:Add(triggeredObj.Triggered:Connect(function()

			local getObj_5 = Synchronizer:Get(LocalPlayer)
			if not getObj_5 then
				return
			else
				local flag_9 = getObj_5:Get("FuseMachine.StartTime")
				local flag_10 = getObj_5:Get("FuseMachine.FinishTime")
				if flag_10 and flag_10 ~= 0 and flag_10 <= workspace:GetServerTimeNow() then
					local flag_11, val7 = FuseMachineData.Remotes.ClaimBrainrot:InvokeServer()
					if not flag_11 then
						NotificationController:Error(val7 or "Something went wrong!")
						return
					elseif fn1 then
						fn1()
						return
					end
				elseif flag_9 and flag_9 ~= 0 then
					if (getObj_5:Get("FuseMachine.InstantReveals") or 0) >= 1 then
						FuseMachineData.Remotes.RevealNow:FireServer()
						return
					else
						shopServicePurchase:FireServer(FuseMachineData.RevealNowProductId)
						return
					end
				else
					local fuseMachineWs = workspace:FindFirstChild("FuseMachine")
					local currentFuseType = fuseMachineWs and fuseMachineWs:GetAttribute("FuseType")
					if currentFuseType == "Summer" then
						InterfaceController:Toggle("FuseMachine")
					elseif currentFuseType == "Witch" and witchRegisterResult then
						InterfaceController:Toggle("WitchFuse")
					elseif currentFuseType == "Santa" and santaRegisterResult then
						InterfaceController:Toggle("SantaFuse")
					else
						InterfaceController:Toggle("NormalFuse")
					end
				end
				return
			end
		end))

		return function()

			managedObj:Destroy()
		end
	end)
	Observers.observeTag("FuseMachine", function(hitboxesObj)
		local fusetpe = workspace:FindFirstChild("FuseMachine") and workspace:FindFirstChild("FuseMachine"):GetAttribute("FuseType")
		local managedObj_2 = Trove.new()
		for _, child_5 in hitboxesObj.Hitboxes:GetChildren() do
			managedObj_2:Add(child_5.Touched:Connect(function(ref4)

				if ref4.Name ~= "HumanoidRootPart" then
					return
				else
					local playerFromCharacter = Players:GetPlayerFromCharacter(ref4.Parent)
					if not playerFromCharacter or playerFromCharacter ~= LocalPlayer then
						return
					else
						if playerFromCharacter:GetAttribute("StealingIndex") then
							if not FuseMachineData.Remotes.Delivery:InvokeServer(child_5) then
								return
							else
								task.spawn(function()

									local sfxFolderName = (fusetpe == "Witch") and "Witch Fuse" 
										or (fusetpe == "Santa") and "Santa Fuse" 
										or "Fuse Machine"
									local sfxFolder = ReplicatedStorage.Sounds.Sfx:FindFirstChild(sfxFolderName)
									local depositSound = sfxFolder and sfxFolder:FindFirstChild("Deposit")
									if depositSound then
										SoundController:PlaySound(depositSound)
									end
								end)
								if fusetpe ~= "Witch" then
									VFX.emit(hitboxesObj.Vfx.emitfuse)
								end
								fn1()
							end
						end
						return
					end
				end
			end))
		end

		return function()

			managedObj_2:Destroy()
		end
	end)
	local witchRarityColors = {
		["Common"] = Color3.fromRGB(167, 255, 53),
		["Rare"] = Color3.fromRGB(51, 201, 255),
		["Epic"] = Color3.fromRGB(196, 47, 255),
		["Legendary"] = Color3.fromRGB(255, 239, 66),
		["Brainrot God"] = Color3.fromRGB(255, 255, 255),
		["Secret"] = Color3.fromRGB(0, 0, 0),
	}

	local witchIsFusing = false
	local witchMixAnimRef = nil
	local witchReturnAnimRef = nil
	local witchSoundActive = false
	local witchStateData = {}

	local function applyCauldronColor(witchesPot, rarity)
		local sphere = witchesPot:FindFirstChild("Sphere.002")
		local surfaceApp = sphere and sphere:FindFirstChildWhichIsA("SurfaceAppearance")
		local brewpart = witchesPot:FindFirstChild("brewpart")
		if not surfaceApp or not brewpart then
			return
		end

		if rarity == "Brainrot God" then
			surfaceApp:AddTag("RainbowModel")
			brewpart:SetAttribute("IncludeParticles", true)
			brewpart:AddTag("RainbowModel")
		else
			surfaceApp:RemoveTag("RainbowModel")
			brewpart:RemoveTag("RainbowModel")
		end

		local color = witchRarityColors[rarity] or witchRarityColors.Common
		Spr.target(surfaceApp, 1, 0.5, { Color = color })

		local colorSeq = ColorSequence.new(color)
		for _, desc in brewpart:GetDescendants() do
			if desc:IsA("ParticleEmitter") then
				Spr.target(desc, 1, 0.5, { Color = colorSeq })
			end
		end
	end

	Observers.observeTag("WitchFuse", function(witchInstance)
		local mainTrove = Trove.new()
		local activeTrove = nil

		local function deactivate()
			if activeTrove then
				activeTrove:Destroy()
				activeTrove = nil
			end
		end

		local function activate()
			if activeTrove then return end

			local animController = witchInstance:FindFirstChildOfClass("AnimationController")
			if not animController then return end
			local animator = animController:FindFirstChildOfClass("Animator")
			if not animator then return end

			activeTrove = Trove.new()

			local mixAnimSource = script:FindFirstChild("Mix")
			local returnAnimSource = script:FindFirstChild("Return")
			local idleAnimSource = script:FindFirstChild("Idle")
			if not (mixAnimSource and returnAnimSource and idleAnimSource) then
				activeTrove:Destroy()
				activeTrove = nil
				return
			end

			local mixAnimHeader = animator:LoadAnimation(mixAnimSource)
			mixAnimHeader.Priority = Enum.AnimationPriority.Action3
			mixAnimHeader.Looped = true
			witchMixAnimRef = mixAnimHeader
			activeTrove:Add(function()
				mixAnimHeader:Stop()
				mixAnimHeader:Destroy()
				if witchMixAnimRef == mixAnimHeader then
					witchMixAnimRef = nil
				end
			end)

			local returnAnimHeader = animator:LoadAnimation(returnAnimSource)
			returnAnimHeader.Priority = Enum.AnimationPriority.Action4
			returnAnimHeader.Looped = false
			witchReturnAnimRef = returnAnimHeader
			activeTrove:Add(function()
				returnAnimHeader:Stop()
				returnAnimHeader:Destroy()
				if witchReturnAnimRef == returnAnimHeader then
					witchReturnAnimRef = nil
				end
			end)

			local idleAnim = animator:LoadAnimation(idleAnimSource)
			idleAnim.Priority = Enum.AnimationPriority.Idle
			idleAnim.Looped = true
			activeTrove:Add(function()
				idleAnim:Stop()
				idleAnim:Destroy()
			end)

			local mixAnim = animator:LoadAnimation(mixAnimSource)
			mixAnim.Priority = Enum.AnimationPriority.Action
			mixAnim.Looped = true
			activeTrove:Add(function()
				mixAnim:Stop()
				mixAnim:Destroy()
			end)

			local returnAnim = animator:LoadAnimation(returnAnimSource)
			returnAnim.Priority = Enum.AnimationPriority.Action2
			returnAnim.Looped = false
			activeTrove:Add(function()
				returnAnim:Stop()
				returnAnim:Destroy()
			end)

			local stateRecord = {
				currentAnimationStateKey = nil,
				currentAnimationState = nil,
				currentCauldronColor = nil,
			}
			witchStateData[witchInstance] = stateRecord
			activeTrove:Add(function()
				witchStateData[witchInstance] = nil
			end)

			local function setAnimState(targetState, fusionFinished)
				local stateKey = tostring(targetState) .. tostring(fusionFinished)
				if stateRecord.currentAnimationStateKey == stateKey then return end
				if witchIsFusing then return end

				local previousState = stateRecord.currentAnimationState
				stateRecord.currentAnimationState = targetState
				stateRecord.currentAnimationStateKey = stateKey

				local chargeSoundPart = witchInstance.Parent and witchInstance.Parent.Parent
					and witchInstance.Parent.Parent:FindFirstChild("ChargeSoundPart")
				local chargeSound = chargeSoundPart and chargeSoundPart:FindFirstChildWhichIsA("Sound")

				if targetState == "Idle" then
					if not idleAnim.IsPlaying then
						idleAnim:Play()
						mixAnim:Stop()
						if previousState == "Mixing" then
							returnAnim:Play()
						end
					end
					local witchesPot = witchInstance.Parent and witchInstance.Parent:FindFirstChild("Witches Pot")
					if witchesPot then
						local firepart = witchesPot:FindFirstChild("firepart")
						local brewpart = witchesPot:FindFirstChild("brewpart")
						if firepart then VFX.disable(firepart) end
						if fusionFinished then
							if brewpart then VFX.enable(brewpart) end
							if not witchSoundActive and chargeSound then
								witchSoundActive = true
								chargeSound:Play()
								CreateTween(chargeSound, TweenInfo.new(0.5), { Volume = 0.2 })
							end
						else
							if brewpart then VFX.disable(brewpart) end
							if witchSoundActive and chargeSound then
								witchSoundActive = false
								local fadeTween = CreateTween(chargeSound, TweenInfo.new(0.5), { Volume = 0 })
								fadeTween.Completed:Once(function()
									chargeSound:Stop()
								end)
							end
						end
					end
				elseif targetState == "Mixing" then
					if not mixAnim.IsPlaying then
						idleAnim:Stop()
						mixAnim:Play()
					end
					local witchesPot = witchInstance.Parent and witchInstance.Parent:FindFirstChild("Witches Pot")
					if witchesPot then
						local firepart = witchesPot:FindFirstChild("firepart")
						local brewpart = witchesPot:FindFirstChild("brewpart")
						if firepart then VFX.enable(firepart) end
						if brewpart then VFX.enable(brewpart) end
						if not witchSoundActive and chargeSound then
							witchSoundActive = true
							chargeSound:Play()
							CreateTween(chargeSound, TweenInfo.new(0.5), { Volume = 0.2 })
						end
					end
				end
			end

			local function setCauldronColor(fusionFinished)
				if not Synchronizer:Get(LocalPlayer) then return end
				if witchIsFusing then return end
				local colorKey = "Common" .. tostring(fusionFinished)
				if stateRecord.currentCauldronColor == colorKey then return end
				stateRecord.currentCauldronColor = colorKey
				local witchesPot = witchInstance.Parent and witchInstance.Parent:FindFirstChild("Witches Pot")
				if witchesPot then
					applyCauldronColor(witchesPot, "Common")
				end
			end

			local function refreshFromSync()
				local syncObj = Synchronizer:Get(LocalPlayer)
				if not syncObj then return end
				local now = workspace:GetServerTimeNow()
				local startTime = syncObj:Get("FuseMachine.StartTime")
				local finishTime = syncObj:Get("FuseMachine.FinishTime")
				local fusionFinished = false
				if finishTime and finishTime ~= 0 then
					fusionFinished = finishTime <= now
				end
				local isMixing = startTime and startTime ~= 0 and not fusionFinished
				setAnimState(isMixing and "Mixing" or "Idle", fusionFinished)
				setCauldronColor(fusionFinished)
			end

			activeTrove:Add(task.spawn(function()
				local onChangedObj = Synchronizer:Wait(LocalPlayer)
				if not onChangedObj then return end
				onChangedObj:OnChanged("FuseMachine", refreshFromSync)
				onChangedObj:OnChanged("FuseMachine.Cost", refreshFromSync)
				onChangedObj:OnChanged("FuseMachine.OutputRarityOdds", refreshFromSync)
				activeTrove:Add(Timer.Simple(1, refreshFromSync))
				task.spawn(refreshFromSync)
			end))
		end

		local function checkFuseType()
			local fuseMachineWs = workspace:FindFirstChild("FuseMachine")
			local fuseType = fuseMachineWs and fuseMachineWs:GetAttribute("FuseType")
			if fuseType == "Witch" then
				activate()
			else
				deactivate()
			end
		end

		local function bindFuseTypeListener()
			local fuseMachineWs = workspace:FindFirstChild("FuseMachine")
			if fuseMachineWs then
				mainTrove:Add(fuseMachineWs:GetAttributeChangedSignal("FuseType"):Connect(checkFuseType))
			end
		end

		local fuseMachineWs = workspace:FindFirstChild("FuseMachine")
		if fuseMachineWs then
			bindFuseTypeListener()
		else
			mainTrove:Add(workspace.ChildAdded:Connect(function(child)
				if child.Name == "FuseMachine" then
					bindFuseTypeListener()
					checkFuseType()
				end
			end))
		end

		checkFuseType()

		return function()
			mainTrove:Destroy()
		end
	end, { workspace })

	Observers.observeTag("FuseMachineLuckGui", function(ref5)
		local eventObj = enabled:OnLuckChanged(function(enabled_2)

			ref5.Enabled = enabled_2
		end)

		return function()

			eventObj:Disconnect()
		end
	end)
	FuseMachineData.Remotes.FuseAnimation.OnClientEvent:Connect(function(val8, val8_uuid, val8_timestamp)
		local FuseMachine_2 = workspace:FindFirstChild("FuseMachine")
		if not FuseMachine_2 then
			return
		end

		local fuseType = FuseMachine_2:GetAttribute("FuseType")

		if fuseType == "Summer" then
			local summerTrove = Trove.new()
			local summerDoorOpen  = {}
			local summerDoorClose = {}
			local summerLever     = {}

			for _, item in FuseMachine_2:QueryDescendants(".DoorRig") do
				local AnimationController = item:FindFirstChild("AnimationController")
				if AnimationController then
					local Animator = AnimationController:FindFirstChild("Animator")
					if Animator then
						table.insert(summerDoorOpen,  Animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.DoorOpen))
						table.insert(summerDoorClose, Animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.DoorClose))
						table.insert(summerLever,     Animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.LeverMove))
					end
				end
			end

			summerTrove:Add(function()
				for _, anim in summerDoorOpen  do anim:Stop(); anim:Destroy() end
				for _, anim in summerDoorClose do anim:Stop(); anim:Destroy() end
				for _, anim in summerLever     do anim:Stop(); anim:Destroy() end
			end)

			local summerAnimalData = Animals_2[val8]
			local _ = Rarities[summerAnimalData.Rarity]

			for _, anim in summerLever do anim:Play() end
			summerTrove:Add(task.delay(1, function()
				for _, anim in summerLever do anim:AdjustSpeed(0) end
			end))

			task.spawn(function()
				local folder = ReplicatedStorage.Sounds.Sfx["Fuse Machine"]
				local sound = folder:FindFirstChild(summerAnimalData.Rarity)
				if sound then
					SoundController:PlaySound(sound, FuseMachine_2:GetPivot().Position)
				end
			end)

			for _, anim in summerDoorOpen do
				anim:Play()
				summerTrove:Add(anim:GetMarkerReachedSignal("Freeze"):Once(function()
					anim:AdjustSpeed(0)
				end))
			end

			local summerVfx = FuseMachine_2.Vfx:FindFirstChild(summerAnimalData.Rarity)
			if summerVfx then VFX.enable(summerVfx) end

			task.wait(3)
			if summerVfx then VFX.disable(summerVfx) end
			task.wait(1)

			for _, anim in summerLever     do anim:AdjustSpeed(-1) end
			for _, anim in summerDoorClose do anim:Play() end

			local closeWait = 2
			while closeWait > 0 do
				local anyPlaying = false
				for _, anim in summerDoorClose do
					if anim.Length ~= 0 then anyPlaying = true; break end
				end
				if anyPlaying then break end
				closeWait = closeWait - task.wait()
			end

			for _, anim in summerDoorOpen do anim:Stop(0) end
			task.wait(2)
			summerTrove:Destroy()

		elseif fuseType == "Witch" then
			witchIsFusing = true

			local WitchFuseMachine = workspace:FindFirstChild("Witch Fuse")
			if not WitchFuseMachine then
				witchIsFusing = false
				return
			end

			local witchModel = WitchFuseMachine:FindFirstChild("Witch")

			local animals_2Data_witch = Animals_2[val8]
			if not animals_2Data_witch then
				witchIsFusing = false
				return
			end

			local rarityName = animals_2Data_witch.Rarity
			local rarityData_witch = Rarities[rarityName]

			local witchLeverAnims = {}
			for _, item in WitchFuseMachine:QueryDescendants(".DoorRig") do
				local ac = item:FindFirstChild("AnimationController")
				if ac then
					local animator = ac:FindFirstChild("Animator")
					if animator then
						local leverAnim = animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.LeverMove)
						table.insert(witchLeverAnims, leverAnim)
					end
				end
			end

			for _, anim in witchLeverAnims do
				anim:Play()
				anim:AdjustSpeed(2.77)
			end

			local vfxFolder = WitchFuseMachine:FindFirstChild("Vfx")
			local vfxTemplate = vfxFolder and vfxFolder:FindFirstChild(rarityName)
			local vfxClone = nil
			local emitAttachment = nil

			if vfxTemplate then
				vfxClone = vfxTemplate:Clone()
				vfxClone.Parent = workspace
				emitAttachment = vfxClone:FindFirstChild("emit")

				if rarityName == "Brainrot God" then
					vfxClone:SetAttribute("IncludeParticles", true)
					vfxClone:AddTag("RainbowModel")
				end

				VFX.emit(vfxClone)

				local witchPot = witchModel and witchModel:FindFirstChild("Witches Pot")
				if witchPot then
					task.spawn(function()
						local rarityColor = rarityData_witch.Color or Color3.fromRGB(255, 255, 255)
						for _, desc in witchPot:GetDescendants() do
							if desc:IsA("ParticleEmitter") then
								desc.Color = ColorSequence.new(rarityColor)
								desc.Enabled = true
							elseif desc:IsA("PointLight") then
								desc.Color = rarityColor
								desc.Enabled = true
							end
						end

						task.wait(6)

						for _, desc in witchPot:GetDescendants() do
							if desc:IsA("ParticleEmitter") then
								desc.Enabled = false
							elseif desc:IsA("PointLight") then
								desc.Enabled = false
							end
						end
					end)
				end

				task.spawn(function()
					local chargeSoundPart = WitchFuseMachine:FindFirstChild("ChargeSoundPart")
					local sfxFolder = ReplicatedStorage.Sounds.Sfx:FindFirstChild("Witch Fuse")
					local sound = sfxFolder and sfxFolder:FindFirstChild(rarityName) or sfxFolder:FindFirstChild("Secret")
					if sound and chargeSoundPart then
						SoundController:PlaySound(sound, chargeSoundPart:GetPivot().Position)
					end
				end)
			end

			local finishTime = val8_timestamp + 6
			local billboardDisabled = false
			local hiddenOverhead = nil
			local originalScale = nil

			task.delay(finishTime - workspace:GetServerTimeNow() + 3, function()
				if emitAttachment then
					emitAttachment:Destroy()
					emitAttachment = nil
				end
				if vfxClone then
					vfxClone:Destroy()
					vfxClone = nil
				end
			end)

			task.delay(finishTime - workspace:GetServerTimeNow(), function()
				witchIsFusing = false
				if witchReturnAnimRef then
					witchReturnAnimRef:Play()
				end
				if witchMixAnimRef then
					witchMixAnimRef:Stop()
				end
				for _, anim in witchLeverAnims do
					anim:Stop()
				end
			end)

			local renderConn
			renderConn = RunService.PreRender:Connect(function(_dt)
				local remaining = finishTime - workspace:GetServerTimeNow()
				local progress = 1 - math.max(remaining, 0) / 6

				if progress >= 1 then
					renderConn:Disconnect()

					if hiddenOverhead then
						hiddenOverhead.Enabled = true
						hiddenOverhead = nil
					end

					return
				end

				local animalData = AnimalController:GetAnimals()[val8_uuid]
				if not animalData then
					return
				end

				if not billboardDisabled and animalData.Overhead then
					billboardDisabled = true
					hiddenOverhead = animalData.Overhead
					hiddenOverhead.Enabled = false
				end

				local animalModel = animalData.AnimalModel
				if not animalModel then
					return
				end

				if not originalScale then
					originalScale = animalModel:GetScale()
				end

				local spawnPart = WitchFuseMachine:FindFirstChild("VisualSpawnCFrame")
				local levitatePart = WitchFuseMachine:FindFirstChild("VisualLevitateCFrame")
				local outsidePart = WitchFuseMachine:FindFirstChild("OutsideZone")
				if not spawnPart or not levitatePart or not outsidePart then
					return
				end

				local spawnCFrame = spawnPart.CFrame
				local levitateCFrame = levitatePart.CFrame
				local riseProgress = progress / 0.6
				local riseAlpha = math.clamp(riseProgress, 0, 1)
				local easedProgress = TweenService:GetValue(
					math.clamp(progress, 0, 1),
					Enum.EasingStyle.Quint,
					Enum.EasingDirection.Out
				)

				local currentCFrame = spawnCFrame:Lerp(levitateCFrame, riseAlpha)
				local currentScale = originalScale * riseAlpha
				animalModel:ScaleTo(math.max(currentScale, 0.01))

				if progress >= 0.6 then
					local spawnRotation = spawnCFrame.Rotation
					local levitatePos = levitateCFrame.Position
					local outsidePos = outsidePart.CFrame.Position
					local controlPoint = levitatePos:Lerp(outsidePos, 0.85) + Vector3.new(0, 20, 0)

					local bezierT = (progress - 0.6) / 0.4
					local easedBezier = TweenService:GetValue(
						math.clamp(bezierT, 0, 1),
						Enum.EasingStyle.Quint,
						Enum.EasingDirection.Out
					)

					local bezierPos =
						(1 - easedBezier)^2 * levitatePos
						+ 2 * (1 - easedBezier) * easedBezier * controlPoint
						+ easedBezier^2 * outsidePos

					currentCFrame = CFrame.new(bezierPos) * spawnRotation
				end

				local finalCFrame = currentCFrame * CFrame.Angles(0, 125.66370614359172 * easedProgress, 0)
				animalModel:PivotTo(finalCFrame)

				if emitAttachment then
					emitAttachment.WorldCFrame = finalCFrame * CFrame.new(0, animalModel:GetExtentsSize().Y * 0.5, 0)
				end
			end)

		elseif fuseType == "Santa" then
			local SantaModel = FuseMachine_2:FindFirstChild("Models")
				and FuseMachine_2.Models:FindFirstChild("Santa")
			if not SantaModel then
				return
			end

			local animals_2Data_4 = Animals_2[val8]
			if not animals_2Data_4 then
				return
			end

			local santaTrove = Trove.new()
			local rig = SantaModel:FindFirstChild("Rig")
			local animator = rig
				and rig:FindFirstChild("AnimationController")
				and rig.AnimationController:FindFirstChild("Animator")
			if not animator then
				santaTrove:Destroy()
				return
			end

			local doorOpenAnim  = animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.DoorOpen_Santa)
			local doorCloseAnim = animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.DoorClose_Santa)
			local leverMoveAnim = animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.LeverMove)

			santaTrove:Add(function()
				doorOpenAnim:Stop();  doorOpenAnim:Destroy()
				doorCloseAnim:Stop(); doorCloseAnim:Destroy()
				leverMoveAnim:Stop(); leverMoveAnim:Destroy()
			end)

			leverMoveAnim:Play()
			santaTrove:Add(task.delay(1, function()
				leverMoveAnim:AdjustSpeed(0)
			end))

			task.spawn(function()
				local sfxFolder = ReplicatedStorage.Sounds.Sfx:FindFirstChild("Santa Fuse")
				local sound = sfxFolder and sfxFolder:FindFirstChild(animals_2Data_4.Rarity)
				if sound then
					SoundController:PlaySound(sound, SantaModel:GetPivot().Position)
				end
			end)

			doorOpenAnim:Play()
			santaTrove:Add(doorOpenAnim:GetMarkerReachedSignal("Freeze"):Once(function()
				doorOpenAnim:AdjustSpeed(0)
			end))

			local santaVfxFolder = FuseMachine_2:FindFirstChild("Vfx")
			local rarityVfx = santaVfxFolder and santaVfxFolder:FindFirstChild(animals_2Data_4.Rarity)
			if rarityVfx then
				VFX.enable(rarityVfx)
			end

			task.wait(3)

			if rarityVfx then
				VFX.disable(rarityVfx)
			end

			task.wait(1)

			leverMoveAnim:AdjustSpeed(-1)
			doorCloseAnim:Play()

			local timeout = 2
			while doorCloseAnim.Length == 0 and timeout > 0 do
				timeout = timeout - task.wait()
			end

			doorOpenAnim:Stop(0)
			task.wait(2)
			santaTrove:Destroy()

		else
			local managedObj_3 = Trove.new()
			local data_3 = {}
			local data_4 = {}
			local data_5 = {}

			for _, item in FuseMachine_2:QueryDescendants(".DoorRig") do
				local AnimationController = item:FindFirstChild("AnimationController")
				if AnimationController then
					local Animator = AnimationController:FindFirstChild("Animator")
					if Animator then
						table.insert(data_3, Animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.DoorOpen))
						table.insert(data_4, Animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.DoorClose))
						table.insert(data_5, Animator:LoadAnimation(ReplicatedStorage.Animations.FuseMachine.LeverMove))
					end
				end
			end

			managedObj_3:Add(function()
				for _, v171Entry in data_3 do
					v171Entry:Stop()
					v171Entry:Destroy()
				end
				for _, v172Entry in data_4 do
					v172Entry:Stop()
					v172Entry:Destroy()
				end
				for _, v173Entry in data_5 do
					v173Entry:Stop()
					v173Entry:Destroy()
				end
			end)

			local animals_2Data_4 = Animals_2[val8]
			local _unused = Rarities[animals_2Data_4.Rarity]

			for _, v173Entry_2 in data_5 do
				v173Entry_2:Play()
			end

			managedObj_3:Add(task.delay(1, function()
				for _, v173Entry_3 in data_5 do
					v173Entry_3:AdjustSpeed(0)
				end
			end))

			task.spawn(function()
				local sfxFolder = ReplicatedStorage.Sounds.Sfx["Fuse Machine"]
				local flag = sfxFolder and sfxFolder:FindFirstChild(animals_2Data_4.Rarity)
				if flag then
					SoundController:PlaySound(flag, FuseMachine_2:GetPivot().Position)
				end
			end)

			for _, v171Entry_2 in data_3 do
				v171Entry_2:Play()
				managedObj_3:Add(v171Entry_2:GetMarkerReachedSignal("Freeze"):Once(function()
					v171Entry_2:AdjustSpeed(0)
				end))
			end

			local flag_2 = FuseMachine_2.Vfx:FindFirstChild(animals_2Data_4.Rarity) or FuseMachine_2.Vfx:FindFirstChild("Secret")
			if flag_2 then
				VFX.enable(flag_2)
			end

			task.wait(3)
			VFX.disable(flag_2)
			task.wait(1)

			for _, v173Entry_4 in data_5 do
				v173Entry_4:AdjustSpeed(-1)
			end

			for _, v172Entry_2 in data_4 do
				v172Entry_2:Play()
			end

			local val9 = 2
			while val9 > 0 do
				local flag_12 = false
				for _, v172Entry_3 in data_4 do
					if v172Entry_3.Length ~= 0 then
						flag_12 = true
						break
					end
				end
				if not flag_12 then
					val9 = val9 - task.wait()
				else
					break
				end
			end

			for _, v171Entry_3 in data_3 do
				v171Entry_3:Stop(0)
			end

			task.wait(2)
			managedObj_3:Destroy()
		end
	end)
	FuseMachineData.Remotes.ForceUpdate.OnClientEvent:Connect(function()

		fn1()
	end)

	local function updateUIColor()
		local fuseMachineWorkspace = workspace:FindFirstChild("FuseMachine")
		local fuseType = fuseMachineWorkspace and fuseMachineWorkspace:GetAttribute("FuseType")
		local isDivine = (fuseType == "Divine")

		local targetGui = NormalFuseMain
		if not targetGui then return end

		local headerBackgroundColor3 = if isDivine then Color3.fromRGB(248, 202, 37) else Color3.fromRGB(85, 112, 127)
		local mutationsBackgroundColor3 = if isDivine then Color3.fromRGB(138, 138, 84) else Color3.fromRGB(51, 66, 73)
		targetGui.Header.BackgroundColor3 = headerBackgroundColor3
		targetGui.BackgroundColor3 = mutationsBackgroundColor3
		targetGui.Lists.Mutations.Header.BackgroundColor3 = headerBackgroundColor3
		targetGui.Lists.Mutations.BackgroundColor3 = mutationsBackgroundColor3
		targetGui.Lists.Traits.Header.BackgroundColor3 = headerBackgroundColor3
		targetGui.Lists.Traits.BackgroundColor3 = mutationsBackgroundColor3
	end

	local fuseMachineWorkspace = workspace:FindFirstChild("FuseMachine")
	if fuseMachineWorkspace then
		fuseMachineWorkspace:GetAttributeChangedSignal("FuseType"):Connect(function()
			updateUIColor()
		end)
	end

	Updates.OnUpdateEnabled:Connect(updateUIColor)
	Updates.OnUpdateDisabled:Connect(updateUIColor)
	task.spawn(updateUIColor)
end

return data