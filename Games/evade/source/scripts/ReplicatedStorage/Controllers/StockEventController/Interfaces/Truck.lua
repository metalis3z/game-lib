local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local MachineGui = PlayerGui:WaitForChild("StockMachine").StockMachine
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
	"StockMachine",
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

		local ControllerApi = {}

		for StockKey, StockInfo in MachineData do
			local RecipeFrame = Content.Template:Clone()
			RecipeFrame.Visible = true
			RecipeFrame.LayoutOrder = StockInfo.Order or 1
			RecipeFrame.Parent = Content

			RecipeFrame.Output.LayoutOrder = 999999999
			SetupAnimalCard(RecipeFrame.Output, StockInfo.Output)

			local InputCardsByAnimal = {}

			for Order, AnimalName in StockInfo.Inputs do
				local AnimalInfo = AnimalsData[AnimalName]
				if not AnimalInfo then
					continue
				end

				local Rarity = Rarities[AnimalInfo.Rarity]
				local Card = Trove:Clone(RecipeFrame.Input)

				Card.LayoutOrder = Rarity.Weight * 100 + Order
				Card.ViewportFrame.ImageColor3 = Color3.new(0, 0, 0)
				Card.Return.Visible = false
				Card.Visible = true
				Card.Parent = RecipeFrame

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

			local function RefreshRecipe()
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

				RecipeFrame.Output.Spawn.Interactable = CanSpawn
				RecipeFrame.Output.Spawn.BackgroundColor3 = CanSpawn
					and Color3.fromRGB(81, 158, 86)
					or Color3.fromRGB(127, 127, 127)
			end

			Trove:Add(Sync:OnChanged("AnimalAddedOrRemoved", RefreshRecipe))
			task.spawn(RefreshRecipe)

			local SpawnButton = AnimatedButton.new(RecipeFrame.Output.Spawn)
			Trove:Add(SpawnButton)
			SpawnButton:Animate()

			Trove:Add(SpawnButton.OnActivated:Connect(function()
				MachineController:Redeem(StockKey)
				ControllerApi:Close()
			end))

			local QuantityLabel = RecipeFrame.Output.Quantity
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

			Trove:Add(function()
				if QuantityGradient then
					QuantityGradient()
					QuantityGradient = nil
				end
			end)

			Trove:Add(MachineController:OnStockChange(StockKey, RefreshStock))
			task.spawn(RefreshStock)
		end

		function ControllerApi.Toggle()
			InterfaceController:Toggle("StockMachine")
		end

		function ControllerApi.Open()
			InterfaceController:SetState("StockMachine", true)
		end

		function ControllerApi.Close()
			InterfaceController:SetState("StockMachine", false)
		end

		function ControllerApi.Destroy()
			Trove:Destroy()
		end

		return ControllerApi
	end
}