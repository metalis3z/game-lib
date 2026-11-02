local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")
local CollectionService = game:GetService("CollectionService")

local LocalPlayer = Players.LocalPlayer

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Timer = require(ReplicatedStorage.Packages.Timer)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Net = require(ReplicatedStorage.Packages.Net)

local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)

local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local Animals = require(ReplicatedStorage.Shared.Animals)

local GetStockMachine = Net:RemoteFunction("StockEventService/GetStockMachine")
local SetFocused = Net:RemoteEvent("StockEventService/SetFocused")
local ReturnAnimal = Net:RemoteEvent("StockEventService/Return")
local RedeemStock = Net:RemoteEvent("StockEventService/Redeem")
local DeliverAnimal = Net:RemoteFunction("StockEventService/Delivery")

local StockGui = LocalPlayer.PlayerGui:WaitForChild("SingleStockMachine").SingleStockMachine
local ContentFrame = StockGui.Content
local SpawnButton = StockGui.Spawn
local CloseButton = StockGui.Header.Close

local StockData = GetStockMachine:InvokeServer() or {}
local MainStockMachine = StockData.MainStock

local ScreenController = nil

local function SetupAnimalSlot(SlotFrame, AnimalName)
	local AnimalInfo = AnimalsData[AnimalName]
	if not AnimalInfo then return end

	local RarityInfo = Rarities[AnimalInfo.Rarity]

	SlotFrame.Title.Text = AnimalName
	SlotFrame.Visible = true

	if RarityInfo.GradientPreset then
		SlotFrame.UIStroke.Color = Color3.new(1, 1, 1)
		SlotFrame.Title.TextColor3 = Color3.new(1, 1, 1)
		Gradients.apply(SlotFrame.UIStroke, RarityInfo.GradientPreset)
		Gradients.apply(SlotFrame.Title, RarityInfo.GradientPreset)
	else
		SlotFrame.UIStroke.Color = RarityInfo.Color
		SlotFrame.Title.TextColor3 = RarityInfo.Color
	end

	if SlotFrame.Name ~= "Brainrot" then
		SlotFrame.ViewportFrame.ImageColor3 = Color3.new(0, 0, 0)
	end

	Animals:AttachOnViewport(AnimalName, SlotFrame.ViewportFrame, true)
end

return {
	Setup = function()
		local PlayerData = Synchronizer:Wait(LocalPlayer)
		if not PlayerData then return end

		local Hidden = false

		local Tagged = CollectionService:GetTagged("StockMachine")
		if Tagged[1] and Tagged[1]:GetAttribute("Hidden") == true then
			return
		end

		if Hidden then return end

		ContentFrame.Visible = true
		SetupAnimalSlot(StockGui.Output.Brainrot, MainStockMachine.Output)
		Gradients.apply(StockGui.Output.Holder.Quantity, "Rainbow")

		local InputSlots = {}

		for Index, AnimalName in MainStockMachine.Inputs do
			local AnimalInfo = AnimalsData[AnimalName]
			if not AnimalInfo then continue end

			local RarityInfo = Rarities[AnimalInfo.Rarity]
			local Slot = ContentFrame.Template:Clone()

			Slot.LayoutOrder = RarityInfo.Weight * 100 + Index
			Slot.Return.Visible = false
			Slot.Parent = ContentFrame

			SetupAnimalSlot(Slot, AnimalName)

			InputSlots[AnimalName] = InputSlots[AnimalName] or {}
			table.insert(InputSlots[AnimalName], Slot)

			local ReturnButton = AnimatedButton.new(Slot.Return)
			ReturnButton:Animate()

			ReturnButton.OnActivated:Connect(function()
				for PodiumId, PodiumData in PlayerData:Get("AnimalPodiums") do
					if type(PodiumData) ~= "table" then continue end
					if PodiumData.Index ~= AnimalName then continue end
					if not PodiumData.Machine then continue end
					if PodiumData.Machine.Type ~= "MainStock" then continue end
					if PodiumData.Machine.Active then continue end

					ReturnAnimal:FireServer(PodiumId)
					return
				end
			end)
		end

		local function UpdateSpawnAvailability()
			local OwnedAnimals = {}

			for _, PodiumData in PlayerData:Get("AnimalPodiums") do
				if type(PodiumData) ~= "table" then continue end
				if not PodiumData.Machine then continue end
				if PodiumData.Machine.Type ~= "MainStock" then continue end
				if PodiumData.Machine.Active then continue end

				OwnedAnimals[PodiumData.Index] = (OwnedAnimals[PodiumData.Index] or 0) + 1
			end

			local CanSpawn = true

			for AnimalName, Slots in InputSlots do
				local Count = OwnedAnimals[AnimalName] or 0

				for SlotIndex, Slot in Slots do
					local Available = SlotIndex <= Count
					Slot.Return.Visible = Available
					Slot.ViewportFrame.ImageColor3 = Available and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)

					if not Available then
						CanSpawn = false
					end
				end
			end

			SpawnButton.Interactable = CanSpawn
			SpawnButton.BackgroundColor3 = CanSpawn
				and Color3.fromRGB(81, 158, 86)
				or Color3.fromRGB(127, 127, 127)
		end

		PlayerData:OnChanged("AnimalAddedOrRemoved", UpdateSpawnAvailability)
		task.spawn(UpdateSpawnAvailability)

		local SpawnAnimatedButton = AnimatedButton.new(SpawnButton)
		SpawnAnimatedButton:Animate()
		SpawnAnimatedButton.OnActivated:Connect(function()
			RedeemStock:FireServer("MainStock", "Tuff Toucan")
			InterfaceController:SetState("SingleStockMachine", false)
		end)

		local QuantityLabel = StockGui.Output.Holder.Quantity
		local StockAttributeName = ("StockEvent_%s"):format(string.gsub("Tuff Toucan", "%s", "_"))

		local function UpdateQuantity()
			local Quantity = ReplicatedStorage:GetAttribute(StockAttributeName)
			QuantityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

			if Quantity == nil or Quantity > 0 then
				QuantityLabel.Text = Quantity and ("%s Left"):format(NumberUtils:Comma(Quantity)) or "Loading..."
				Gradients.apply(QuantityLabel, "Rainbow")
			else
				for _, Child in QuantityLabel:GetChildren() do
					if Child:IsA("UIGradient") then
						Child:Destroy()
					end
				end

				QuantityLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
				QuantityLabel.Text = "SOLD OUT"
			end
		end

		ReplicatedStorage:GetAttributeChangedSignal(StockAttributeName):Connect(UpdateQuantity)
		task.spawn(UpdateQuantity)
	end,

	Start = function(Self)
		StockGui.Visible = false
		ScreenController = InterfaceController:Register("SingleStockMachine", StockGui, "TopQuint")
		ScreenController:AttachCloseButton(CloseButton)
		ScreenController:Close()

		ScreenController.OnOpen:Connect(function()
			SetFocused:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", "MainStock", true)
		end)

		ScreenController.OnClose:Connect(function()
			SetFocused:FireServer("2298b248-44dd-4a34-bbfe-e1174e8ae1b4", "MainStock", false)
		end)

		task.spawn(Self.Setup, Self)

		Observers.observeTag("StockMachinePrompt", function(Prompt)
			local PromptTrove = Trove.new()
			local StateTrove = PromptTrove:Extend()
			local LastState = nil

			local function UpdatePrompt()
				if not Synchronizer:Wait(LocalPlayer) then return end

				Prompt.ObjectText = "Limited Quantity Truck"
				Prompt.ActionText = "Open"

				local EndTime = FFlags:GetInstant("StockEventEndTime", nil)
				local Enabled = EndTime == nil or DateTime.now().UnixTimestamp < EndTime
				Prompt.Enabled = Enabled

				if LastState ~= Enabled then
					LastState = Enabled
					StateTrove:Clean()
				end
			end

			PromptTrove:Add(task.spawn(function()
				if Synchronizer:Wait(LocalPlayer) then
					PromptTrove:Add(Timer.Simple(1, UpdatePrompt))
					task.spawn(UpdatePrompt)
				end
			end))

			PromptTrove:Add(Prompt.Triggered:Connect(function()
				if Synchronizer:Get(LocalPlayer) then
					InterfaceController:Toggle("SingleStockMachine")
				end
			end))

			return function()
				PromptTrove:Destroy()
			end
		end)

		Observers.observeTag("StockMachineDelivery", function(Part)
			local PartTrove = Trove.new()

			if Part:IsA("BasePart") then
				PartTrove:Add(Part.Touched:Connect(function(Hit)
					if Hit.Name ~= "HumanoidRootPart" then return end

					local Player = Players:GetPlayerFromCharacter(Hit.Parent)
					if Player ~= LocalPlayer then return end
					if not Player:GetAttribute("StealingIndex") then return end

					local Success = DeliverAnimal:InvokeServer("MainStock", Part)
					if Success then
						task.spawn(function()
							SoundController:PlaySound(ReplicatedStorage.Sounds.Sfx["Fuse Machine"].Deposit)
						end)
					end
				end))
			end

			return function()
				PartTrove:Destroy()
			end
		end)
	end
}