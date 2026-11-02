--!strict
-- CONFIG
local COLUMNS = 2 -- accessory tiles per row


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local ScrollList = require(frontend.Components.ScrollList)
local SearchBar = require(frontend.Components.SearchBar)
local CosmeticCard = require(frontend.Components.CosmeticCard)
local CosmeticMarket = require(frontend.Util.CosmeticMarket)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	idle: UsedAs<boolean>?,
}
type Accessory = {
	id: number,
	name: string,
	order: number?,
	comingSoon: boolean?,
}


-- COMPONENT
-- The Outfits store grid of special accessories
return function(scope: Scope, props: Props)
	local accessoriesFuse = scope:Fuse("everyone", "SpecialAccessories")
	local searchText = scope:Value("")

	local rows = scope:Computed(function(use)
		local catalog = use(accessoriesFuse)
		if typeof(catalog) ~= "table" then return {} end
		local search = use(searchText):lower()

		local list: { Accessory } = {}
		for _, accessory in catalog :: any do
			if typeof(accessory) ~= "table" or not accessory.id then continue end
			-- Search against the title the player actually sees on the card
			local shownName = if accessory.comingSoon == true then "Coming Soon" else tostring(accessory.name)
			if search ~= "" and not shownName:lower():find(search, 1, true) then continue end
			table.insert(list, accessory)
		end
		table.sort(list, function(left, right)
			local leftOrder, rightOrder = left.order or math.huge, right.order or math.huge
			if leftOrder ~= rightOrder then return leftOrder < rightOrder end
			return left.name < right.name
		end)

		local rowList: { any } = {}
		for index = 1, #list, COLUMNS do
			local tiles: { any } = {}
			for column = 0, COLUMNS - 1 do
				local accessory = list[index + column]
				if not accessory then break end
				table.insert(tiles, { id = accessory.id, name = accessory.name, comingSoon = accessory.comingSoon == true })
			end
			table.insert(rowList, { layoutOrder = #rowList + 1, tiles = tiles })
		end
		return rowList
	end)

	local function renderRow(itemScope: Scope, row: any): Instance
		local tileInstances = {}
		for index, tile in row.tiles do
			local id = tile.id
			local comingSoon = tile.comingSoon == true
			local price = itemScope:Value(if comingSoon then 0 else CosmeticMarket.peekPrice(id))
			local favourited = itemScope:Value(if comingSoon then false else CosmeticMarket.peekFavourite(id))
			if not comingSoon then
				CosmeticMarket.seedPrice(id, price)
				CosmeticMarket.seedFavourite(id, favourited)
			end
			tileInstances[index] = CosmeticCard(itemScope, {
				accessoryId = id,
				name = if comingSoon then "Coming Soon" else tile.name,
				robuxPrice = price,
				isFavourited = favourited,
				onFavourite = function()
					if comingSoon then
						CosmeticMarket.notifyComingSoon()
						return
					end
					CosmeticMarket.toggleFavourite(id, favourited)
				end,
				onBuy = function()
					if comingSoon then
						CosmeticMarket.notifyComingSoon()
						return
					end
					CosmeticMarket.buy(id)
				end,
				layoutOrder = index,
			})
		end
		-- Pad short rows so the cards keep their 1/COLUMNS width instead of stretching
		for filler = #row.tiles + 1, COLUMNS do
			tileInstances[filler] = itemScope:New "Frame" {
				Name = "Filler",
				BackgroundTransparency = 1,
				LayoutOrder = filler,
				Size = UDim2.new(0, 0, 0, 0),
			}
		end
		return itemScope:New "Frame" {
			Name = "OutfitsRow",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = row.layoutOrder,
			Size = UDim2.new(1, 0, 0, 0),
			[Children] = {
				itemScope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
				},
				tileInstances,
			},
		}
	end

	return scope:New "Frame" {
		Name = "Outfits",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "UIListLayout" {
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				VerticalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			ScrollList(scope, {
				isReady = scope:Computed(function(use)
					local catalog = use(accessoriesFuse)
					return typeof(catalog) == "table" and next(catalog :: any) ~= nil
				end),
				items = rows,
				visibleItems = rows,
				useStream = false,
				renderItem = renderRow,
				padding = UDim.new(0, 8),
				paddingRight = 10,
				layoutOrder = 1,
				idle = props.idle,
				headerGap = UDim.new(0, 8),
				header = SearchBar(scope, {
					searchText = searchText,
					placeholderText = "Search cosmetics",
					layoutOrder = 0,
				}),
			}),
		},
	}
end
