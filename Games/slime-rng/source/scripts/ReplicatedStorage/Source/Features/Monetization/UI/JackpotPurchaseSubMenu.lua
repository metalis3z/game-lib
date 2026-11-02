-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: JackpotPurchaseSubMenu, time of decompilation: Sun May  3 10:12:06 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local SubMenu = require(ReplicatedStorage.Source.Features.App.Components.SubMenu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local InventoryServiceClient = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceClient)
local JackpotSpinServiceUtils = require(ReplicatedStorage.Source.Features.JackpotSpins.JackpotSpinServiceUtils)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local t1 = {}

for _, v15 in JackpotSpinServiceUtils.getProductDefinitions() do
	t1[v15.key] = v15.amount
end

local function JackpotPurchaseContent(p1) -- line: 36
	-- upvalues: SubMenu (copy), InventoryServiceClient (copy), JackpotSpinServiceUtils (copy), Frame (copy), TextLabel (copy), ImageLabel (copy), ImageIds (copy), UIListLayout (copy), StylizedButton (copy)
	return Frame({
		Name = "JackpotPurchaseContent",
		Size = UDim2.fromScale(1, 1),
		TextLabel({
			Text = "Unlocked!",
			Rotation = -20,
			ZIndex = 205,
			Size = UDim2.fromOffset(240, 60),
			Position = UDim2.fromScale(0.15, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 4
			},
			DropShadow = {
				Offset = UDim2.fromOffset(4, 5)
			}
		}),
		ImageLabel({
			ZIndex = 202,
			Image = ImageIds.jackpotDice,
			Size = UDim2.fromOffset(170, 170),
			Position = UDim2.fromScale(0.5, 0.32),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			ZIndex = 205,
			Text = function() --[[ Text ]] -- line: 82
				-- upvalues: p1 (copy)
				local v23 = p1()

				if v23 == nil then
					return ""
				end

				return `x{ v23.amount }`
			end,
			Size = UDim2.fromOffset(90, 50),
			Position = UDim2.fromScale(0.65, 0.1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3
			},
			DropShadow = {}
		}),
		Frame({
			Name = "ActionRow",
			Size = UDim2.fromOffset(330, 76),
			Position = UDim2.fromScale(0.5, 0.85),
			AnchorPoint = Vector2.new(0.5, 0.5),
			UIListLayout({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 18)
			}),
			StylizedButton({
				Theme = "Red",
				Text = "Send to Backpack",
				LayoutOrder = 1,
				Activated = function() --[[ closeSubMenu ]] -- line: 37
					-- upvalues: SubMenu (copy)
					SubMenu.setOpenedMenu(nil)
				end,
				Size = UDim2.fromOffset(200, 76),
				ImageLabel({
					ZIndex = 2,
					Image = ImageIds.backpack,
					Size = UDim2.fromOffset(60, 60),
					ScaleType = Enum.ScaleType.Fit,
					Position = UDim2.fromScale(0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.6)
				})
			}),
			StylizedButton({
				Theme = "Green",
				LayoutOrder = 2,
				Text = function() --[[ Text ]] -- line: 127
					-- upvalues: p1 (copy)
					local v24 = p1()

					if v24 == nil or v24.amount <= 1 then
						return "Use Now"
					end

					return `Use Now (x{ v24.amount })`
				end,
				Activated = function() --[[ useNow ]] -- line: 41
					-- upvalues: p1 (copy), InventoryServiceClient (copy), JackpotSpinServiceUtils (copy), SubMenu (copy)
					local v21 = p1()

					if v21 == nil then
						return
					end

					for _ = 1, v21.amount do
						if not InventoryServiceClient:useItem(JackpotSpinServiceUtils.ITEM_ID) then
							return
						end
					end

					SubMenu.setOpenedMenu(nil)
				end,
				Size = UDim2.fromOffset(200, 76)
			})
		})
	})
end

return {
	subMenuId = "JackpotPurchase",
	alwaysMounted = true,
	Component = function() --[[ Component ]] -- line: 143
		-- upvalues: Vide (copy), MonetizationServiceClient (copy), t1 (copy), SubMenu (copy), JackpotPurchaseContent (copy)
		local v19 = Vide.source(nil)
		local connection = MonetizationServiceClient.purchaseCompleted:Connect(function(p2) -- line: 146
			-- upvalues: t1 (copy), v19 (copy), SubMenu (copy)
			if p2 == nil or p2.key == nil then
				return
			end

			local key = p2.key
			local v27 = if key ~= nil then t1[key] else nil

			if v27 == nil then
				return
			end

			v19({
				productKey = p2.key,
				amount = v27
			})
			SubMenu.setOpenedMenu("JackpotPurchase")
		end)

		Vide.cleanup(function() -- line: 163
			-- upvalues: connection (copy)
			connection:Disconnect()
		end)

		return SubMenu.Component({
			subMenuId = "JackpotPurchase",
			ParentMenuId = "Shop",
			Size = UDim2.fromOffset(470, 300),
			ShowTitle = false,
			ShowCloseButton = false,
			JackpotPurchaseContent(v19)
		})
	end
}
