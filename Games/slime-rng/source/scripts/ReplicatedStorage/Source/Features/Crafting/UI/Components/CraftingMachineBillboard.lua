-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingMachineBillboard, time of decompilation: Sun May  3 10:12:28 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local CurrencyLabel = require(ReplicatedStorage.Source.Features.App.Components.CurrencyLabel)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)

return function(t1: {[any]: any}) -- line: 18
	-- upvalues: Vide (copy), Frame (copy), TextLabel (copy), StylizedButton (copy), CurrencyLabel (copy), CraftingServiceUtils (copy)
	return Vide.create("BillboardGui")({
		Name = "CraftingMachineBillboard",
		ResetOnSpawn = false,
		AlwaysOnTop = true,
		MaxDistance = 40,
		Active = true,
		Size = UDim2.fromOffset(240, 180),
		StudsOffsetWorldSpace = Vector3.new(0, 6, 0),
		Adornee = t1.Root,
		Enabled = function() --[[ Enabled ]] -- line: 28
			-- upvalues: t1 (copy)
			return not t1.Unlocked() or t1.IsAutoCrafting()
		end,
		Frame({
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Vide.show(t1.IsAutoCrafting, function() -- line: 36
				-- upvalues: TextLabel (copy), StylizedButton (copy), t1 (copy)
				return {
					TextLabel({
						Text = "Autocraft in progress",
						TextWrapped = true,
						Size = UDim2.new(1, 0, 0, 58),
						Position = UDim2.fromScale(0.5, 0.32),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Stroke = {},
						DropShadow = {}
					}),
					StylizedButton({
						Theme = "Red",
						Text = "Stop",
						Size = UDim2.fromOffset(150, 56),
						Position = UDim2.fromScale(0.5, 0.68),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Activated = t1.OnStopAutoCraft
					})
				}
			end, function() -- line: 57
				-- upvalues: TextLabel (copy), CurrencyLabel (copy), CraftingServiceUtils (copy), StylizedButton (copy), t1 (copy)
				return {
					TextLabel({
						Text = "CRAFTING MACHINE",
						Size = UDim2.new(1, 0, 0, 48),
						Position = UDim2.fromScale(0.5, 0.25),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Stroke = {},
						DropShadow = {}
					}),
					CurrencyLabel({
						Currency = "coins",
						RedIfInsufficient = true,
						TextSize = 30,
						Amount = CraftingServiceUtils.CRAFTING_MACHINE_UNLOCK_PRICE,
						Size = UDim2.new(1, 0, 0, 30),
						Position = UDim2.fromScale(0.5, 0.45),
						AnchorPoint = Vector2.new(0.5, 0.5)
					}),
					StylizedButton({
						Theme = "Green",
						Text = "Buy",
						Size = UDim2.fromOffset(150, 56),
						Position = UDim2.fromScale(0.5, 0.7),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Activated = t1.OnPurchase
					})
				}
			end)
		})
	})
end
