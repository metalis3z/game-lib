--!strict
-- LOCATION: ServerScriptService/Controllers/IncomeController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local IncomeController = {}

local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local PlayerController -- Lazy load

local CYCLE_RATE = 1.0
local INCOME_SCALING = 1.125 
local VIP_MULTIPLIER = 1.5 -- VIP gives +50% Income

local MUTATION_MULTIPLIERS = {
	["Normal"] = 1,
	["Gold"] = 1.2,
	["Golden"] = 2,
	["Diamond"] = 1.45,
	["Ruby"] = 4,
	["Neon"] = 5,
	-- Event mutations
	["Acid"] = 6,
	["Love"] = 6,
	["Brazil"] = 6,
	["Matteo"] = 6,
	["Aquatic"] = 6,
	["Tecnologia"] = 6,
	["Lava"] = 1.2,
	["Hacker"] = 6,
}

function IncomeController:Init(controllers)
	PlayerController = controllers.PlayerController
end

function IncomeController:Start()
	task.spawn(function()
		while true do
			task.wait(CYCLE_RATE)

			for _, player in ipairs(Players:GetPlayers()) do
				local profile = PlayerController:GetProfile(player)
				if profile and profile.Data.Plots then

					-- ## ADDED: Check VIP Status ##
					local isVip = PlayerController:IsVIP(player)
					local vipMult = isVip and VIP_MULTIPLIER or 1

					local plotModel = Workspace:FindFirstChild("Plot_" .. player.Name)

					local totalIncomePerSecond = 0

					for floorName, floorSlots in pairs(profile.Data.Plots) do
						local floorModel = plotModel and plotModel:FindFirstChild(floorName)
						local slotsFolder = floorModel and floorModel:FindFirstChild("Slots")

						for slotName, slotData in pairs(floorSlots) do
							if slotData.Item then
								if type(slotData.Stored) ~= "number" then slotData.Stored = 0 end

								local itemConf = ItemConfigurations.GetItemData(slotData.Item.Name)
								if itemConf then
									local base = itemConf.Income
									local mutMult = MUTATION_MULTIPLIERS[slotData.Item.Mutation] or 1
									local levelMult = INCOME_SCALING ^ (slotData.Level - 1)

									local reb = profile.Data.Rebirths or 0
									local rebMult = 1 + (reb * 0.5)

									-- ## INGREDIENT BONUS ##
									-- IngredientBonus is a multiplier (e.g., 1 = no bonus, 10 = 10x production)
									local ingredientBonus = slotData.Item.IngredientBonus or 1

									-- ## APPLIED VIP MULT HERE ##
									local income = base * mutMult * levelMult * rebMult * vipMult * ingredientBonus

									-- ## EVENT MULTIPLIER ##
									-- Read EventMultiplier from the visual item on the slot
									local slotMod = slotsFolder and slotsFolder:FindFirstChild(slotName)
									if slotMod then
										local spawnPart = slotMod:FindFirstChild("Spawn")
										if spawnPart then
											local visualItem = spawnPart:FindFirstChild("VisualItem")
											if visualItem then
												local eventMult = visualItem:GetAttribute("EventMultiplier")
												if eventMult and type(eventMult) == "number" and eventMult > 1 then
													income = income * eventMult
												end
											end
										end
									end

									totalIncomePerSecond += income
									slotData.Stored += income

									-- Visual Update
									if slotMod then
										local colPart = slotMod:FindFirstChild("CollectTouch")
										local gui = colPart and colPart:FindFirstChild("CollectGUI")
										local frame = gui and gui:FindFirstChild("CollectFrame")
										local label = frame and frame:FindFirstChild("Price") :: TextLabel

										if label then
											local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
											label.Text = "$" .. NumberFormatter.Format(slotData.Stored)
											label.Visible = true
										end
									end
								end
							end
						end
					end

					player:SetAttribute("IncomePerSecond", totalIncomePerSecond)
				end
			end
		end
	end)
end

return IncomeController