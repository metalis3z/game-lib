-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RobuxButton, time of decompilation: Sun May  3 10:12:09 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local RemoveKeys = require(ReplicatedStorage.Source.Core.Util.RemoveKeys)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local useProduct = require(ReplicatedStorage.Source.Features.Monetization.Hooks.useProduct)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)

require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)

local MonetizationSlice = require(ReplicatedStorage.Source.Features.Monetization.MonetizationSlice)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local t1 = {
	"Product",
	"HideGift",
	"Scale",
	"ButtonSize"
}

return function(t2: {[any]: any}) -- line: 29
	-- upvalues: useProduct (copy), Vide (copy), MonetizationServiceClient (copy), RemoveKeys (copy), t1 (copy), Frame (copy), UIListLayout (copy), StylizedButton (copy), MonetizationSlice (copy), Menu (copy), ImageLabel (copy), ImageIds (copy)
	local v15 = useProduct(t2.Product)
	local v16 = Vide.derive(function() -- line: 32
		-- upvalues: t2 (copy), v15 (copy)
		if t2.HideGift then
			return nil
		end

		return v15().giftId
	end)
	local v17 = Vide.derive(function() -- line: 36
		-- upvalues: MonetizationServiceClient (copy), v15 (copy)
		return MonetizationServiceClient:getProductCostString(v15())
	end)
	local v18 = RemoveKeys(t2, t1)
	local v19 = t2.Scale or 1
	local v20 = t2.Size or UDim2.fromOffset(160 * v19, 65 * v19)

	v18.Theme = "Green"
	v18.Size = t2.ButtonSize or UDim2.fromScale(1, 1)
	v18.Text = v17
	v18.LayoutOrder = 2

	function v18.Activated() -- line: 47
		-- upvalues: MonetizationServiceClient (copy), v15 (copy)
		MonetizationServiceClient:promptProduct(v15())
	end

	return Frame({
		Position = v18.Position,
		AnchorPoint = v18.AnchorPoint,
		Size = v20,
		ZIndex = v18.ZIndex,
		Frame({
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			UIListLayout({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 0)
			}),
			StylizedButton(v18),
			if not v16() then nil else StylizedButton({
				Theme = "Pink",
				HoverScale = 1.1,
				Size = UDim2.fromScale(0.9, 1),
				SizeConstraint = Enum.SizeConstraint.RelativeYY,
				LayoutOrder = 2,
				Activated = function() --[[ Activated ]] -- line: 78
					-- upvalues: MonetizationSlice (copy), v15 (copy), Menu (copy)
					MonetizationSlice.giftingProduct(v15())
					Menu.setOpenedMenu("GiftingMenu")
				end,
				ImageLabel({
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(0.67, 0.67),
					ScaleType = Enum.ScaleType.Fit,
					Position = UDim2.fromScale(0.5, 0.475),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Image = ImageIds.gift
				})
			})
		})
	})
end
