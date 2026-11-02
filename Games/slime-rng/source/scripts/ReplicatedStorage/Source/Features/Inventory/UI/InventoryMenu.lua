-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: InventoryMenu, time of decompilation: Sun May  3 10:11:27 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local InventoryServiceClient = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceClient)
local TutorialSlice = require(ReplicatedStorage.Source.Features.Tutorial.TutorialSlice)
local EquippedSlimesFrame = require(ReplicatedStorage.Source.Features.Inventory.UI.Components.EquippedSlimesFrame)
local ItemsInventoryPage = require(ReplicatedStorage.Source.Features.Inventory.UI.Components.ItemsInventoryPage)
local SlimeInventoryScrollingFrame = require(ReplicatedStorage.Source.Features.Inventory.UI.Components.SlimeInventoryScrollingFrame)
local getUpgradeOwnership = require(ReplicatedStorage.Source.Features.Upgrades.Sources.getUpgradeOwnership)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local v13 = Vide.source("Inventory")

local function setCurrentPage(s1: string) -- line: 19
	-- upvalues: v13 (copy)
	v13(s1)
end
local function SlimesPage() -- line: 36
	-- upvalues: TutorialSlice (copy), Frame (copy), StylizedButton (copy), InventoryServiceClient (copy), EquippedSlimesFrame (copy), SlimeInventoryScrollingFrame (copy)
	local v17 = TutorialSlice.completed()

	return Frame({
		Name = "SlimesPage",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		StylizedButton({
			HoverScale = 1.05,
			Name = "EquipBestButton",
			Theme = "Blue",
			Text = "EQUIP BEST",
			ZIndex = 99,
			Size = UDim2.fromOffset(150, 54),
			Position = UDim2.fromScale(0.85, -0.005),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Visible = function() --[[ Visible ]] -- line: 53
				-- upvalues: v17 (copy)
				return v17()
			end,
			Activated = function() --[[ Activated ]] -- line: 56
				-- upvalues: InventoryServiceClient (copy)
				InventoryServiceClient:equipBest()
			end
		}),
		EquippedSlimesFrame(),
		SlimeInventoryScrollingFrame()
	})
end

return {
	menuId = "Inventory",
	alwaysMounted = true,
	Component = function() --[[ Component ]] -- line: 66
		-- upvalues: getUpgradeOwnership (copy), TutorialSlice (copy), Vide (copy), Menu (copy), v13 (copy), setCurrentPage (copy), ImageIds (copy), SlimesPage (copy), ItemsInventoryPage (copy)
		local v18 = getUpgradeOwnership("backpack")
		local v19 = TutorialSlice.completed()

		Vide.effect(function() -- line: 70
			-- upvalues: v18 (copy), Menu (copy)
			if v18() or Menu.openedMenu() ~= "Inventory" then
				return
			end

			Menu.setOpenedMenu(nil)
		end)

		return Menu.Component({
			menuId = "Inventory",
			Title = "Backpack",
			CurrentPageSource = v13,
			SetCurrentPage = setCurrentPage,
			SideBarButtons = {
				Inventory = {
					Text = "Slimes",
					Title = "Backpack",
					LayoutOrder = 1,
					Image = ImageIds.backpack,
					Visible = v18
				},
				Items = {
					Text = "Items",
					Title = "Items",
					LayoutOrder = 2,
					Image = ImageIds.lootIcon,
					Visible = function() --[[ Visible ]] -- line: 96
						-- upvalues: v18 (copy), v19 (copy)
						return v18() and v19()
					end
				}
			},
			Pages = {
				Inventory = SlimesPage(),
				Items = ItemsInventoryPage()
			}
		})
	end,
	openSlimesPage = function() --[[ openSlimesPage ]] -- line: 23
		-- upvalues: Menu (copy), v13 (copy)
		if Menu.openedMenu() == "Inventory" and v13() == "Inventory" then
			Menu.setOpenedMenu(nil)

			return
		end

		v13("Inventory")

		if Menu.openedMenu() ~= "Inventory" then
			Menu.setOpenedMenu("Inventory")
		end
	end
}
