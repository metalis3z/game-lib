-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: XpTransferMachineBillboard, time of decompilation: Sun May  3 10:12:37 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local CurrencyLabel = require(ReplicatedStorage.Source.Features.App.Components.CurrencyLabel)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local XpTransferServiceUtils = require(ReplicatedStorage.Source.Features.XpTransfer.XpTransferServiceUtils)

return function(t1: {[any]: any}) -- line: 16
	-- upvalues: Vide (copy), Frame (copy), TextLabel (copy), CurrencyLabel (copy), XpTransferServiceUtils (copy), StylizedButton (copy)
	return Vide.create("BillboardGui")({
		Name = "XpTransferMachineBillboard",
		ResetOnSpawn = false,
		AlwaysOnTop = true,
		MaxDistance = 40,
		Active = true,
		Size = UDim2.fromOffset(270, 180),
		StudsOffsetWorldSpace = Vector3.new(0, 6, 0),
		Adornee = t1.Root,
		Enabled = function() --[[ Enabled ]] -- line: 26
			-- upvalues: t1 (copy)
			return not t1.Unlocked()
		end,
		Frame({
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			TextLabel({
				Text = "XP TRANSFER",
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
				Amount = XpTransferServiceUtils.XP_TRANSFER_MACHINE_UNLOCK_PRICE,
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
		})
	})
end
