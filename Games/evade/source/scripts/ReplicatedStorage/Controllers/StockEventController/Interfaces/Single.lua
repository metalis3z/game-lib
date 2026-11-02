local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local MachineGui = PlayerGui:WaitForChild("SingleStockMachine").SingleStockMachine
local Content = MachineGui.Content
local CloseButton = MachineGui.Header.Close

local Gradients = require(ReplicatedStorage.Packages.Gradients)
local AnimalsViewport = require(ReplicatedStorage.Shared.Animals)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local TroveClass = require(ReplicatedStorage.Packages.Trove)

require(ReplicatedStorage.Shared.StockMachineTypes)

MachineGui.Visible = false

local Interface = InterfaceController:Register(
	"SingleStockMachine",
	MachineGui,
	"TopQuint"
)

Interface:AttachCloseButton(CloseButton)
Interface:Close()

return {
	Setup = function(_, MachineController, MachineData)
		local Trove = TroveClass.new()
		local Sync = Synchronizer:Wait(LocalPlayer)

		Trove:Add(Interface.OnOpen:Connect(function()
			MachineController:SetOpen(true)
		end))

		Trove:Add(Interface.OnClose:Connect(function()
			MachineController:SetOpen(false)
		end))

		local function SetupAnimalCard(Card, AnimalName)
			local AnimalInfo = AnimalsData[AnimalName]
			if not AnimalInfo then
				return
			end

			local Rarity = Rarities[AnimalInfo.Rarity]
			Card.Title.Text = AnimalName

			if Rarity.GradientPreset then
				Card.UIStroke.Color = Color3.new(1, 1, 1)
				Card.Title.TextColor3 = Color3.new(1, 1, 1)
				Trove:Add(Gradients.apply(Card.UIStroke, Rarity.GradientPreset))
				Trove:Add(Gradients.apply(Card.Title, Rarity.GradientPreset))
			else
				Card.UIStroke.Color = Rarity.Color
				Card.Title.TextColor3 = Rarity.Color
			end

			Card.Visible = true

			local Cleanup = AnimalsViewport:AttachOnViewportWithOptimizations(
				AnimalName,
				Card.ViewportFrame,
				true
			)

			if Cleanup then
				Trove:Add(Cleanup)
			end
		end

		local StockKey, StockData = next(MachineData)
		assert(StockKey)

		SetupAnimalCard(
			MachineGui.Output.Brainrot,
			StockData.Output
		)

		local InputCardsByAnimal = {}

		for Order, AnimalName in StockData.Inputs do
			local AnimalInfo = AnimalsData[AnimalName]
			if not AnimalInfo then
				continue
			end

			local Rarity = Rarities[AnimalInfo.Rarity]
			local Card = Trove:Clone(Content.Template)

			Card.LayoutOrder = Rarity.Weight * 100 + Order
			Card.ViewportFrame.ImageColor3 = Color3.new(0, 0, 0)
			Card.Return.Visible = false
			Card.Visible = true
			Card.Parent = Content

			SetupAnimalCard(Card, AnimalName)

			InputCardsByAnimal[AnimalName] = InputCardsByAnimal[AnimalName] or {}
			table.insert(InputCardsByAnimal[AnimalName], Card)

			local ReturnButton = AnimatedButton.new(Card.Return)
			Trove:Add(ReturnButton)
			ReturnButton:Animate()

			Trove:Add(ReturnButton.OnActivated:Connect(function()
				for PodiumId, Podium in Sync:Get("AnimalPodiums") do
					if type(Podium) == "table"
						and Podium.Index == AnimalName
						and Podium.Machine
						and Podium.Machine.Type == MachineController.MachineName
						and not Podium.Machine.Active
					then
						MachineController:Return(PodiumId)
						return
					end
				end
			end))
		end

		local function RefreshInputs()
			local OwnedAnimals = {}

			for _, Podium in Sync:Get("AnimalPodiums") do
				if type(Podium) == "table"
					and Podium.Machine
					and Podium.Machine.Type == MachineController.MachineName
					and not Podium.Machine.Active
				then
					OwnedAnimals[Podium.Index] = (OwnedAnimals[Podium.Index] or 0) + 1
				end
			end

			local CanSpawn = true

			for AnimalName, Cards in InputCardsByAnimal do
				local Count = OwnedAnimals[AnimalName] or 0

				for Index, Card in Cards do
					local Available = Index <= Count
					Card.Return.Visible = Available
					Card.ViewportFrame.ImageColor3 = Available
						and Color3.new(1, 1, 1)
						or Color3.new(0, 0, 0)

					if not Available then
						CanSpawn = false
					end
				end
			end

			MachineGui.Spawn.Interactable = CanSpawn
			MachineGui.Spawn.BackgroundColor3 = CanSpawn
				and Color3.fromRGB(81, 158, 86)
				or Color3.fromRGB(127, 127, 127)
		end

		Trove:Add(Sync:OnChanged("AnimalAddedOrRemoved", RefreshInputs))
		task.spawn(RefreshInputs)

		local SpawnButton = AnimatedButton.new(MachineGui.Spawn)
		Trove:Add(SpawnButton)
		SpawnButton:Animate()

		Trove:Add(SpawnButton.OnActivated:Connect(function()
			MachineController:Redeem(StockKey)
			Interface:Close()
		end))

		local QuantityLabel = MachineGui.Output.Holder.Quantity
		local QuantityGradient = nil

		local function RefreshStock()
			local Stock = MachineController:GetStock(StockKey)
			QuantityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

			if Stock == nil or Stock > 0 then
				QuantityLabel.Text = Stock
					and (NumberUtils:Comma(Stock) .. " Left")
					or "Loading..."

				if not QuantityGradient then
					QuantityGradient = Gradients.apply(QuantityLabel, "Rainbow")
				end
			else
				QuantityLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
				QuantityLabel.Text = "SOLD OUT"

				if QuantityGradient then
					QuantityGradient()
					QuantityGradient = nil
				end
			end
		end

		Trove:Add(MachineController:OnStockChange(StockKey, RefreshStock))
		task.spawn(RefreshStock)

		Trove:Add(function()
			if QuantityGradient then
				QuantityGradient()
				QuantityGradient = nil
			end
		end)

		return {
			Open = function()
				InterfaceController:SetState("SingleStockMachine", true)
			end,

			Close = function()
				InterfaceController:SetState("SingleStockMachine", false)
			end,

			Toggle = function()
				InterfaceController:Toggle("SingleStockMachine")
			end,

			Destroy = function()
				Trove:Destroy()
			end
		}
	end
}