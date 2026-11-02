--!strict
-- CONFIG
local COLUMNS = 3 -- command cards per row


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local ScrollList = require(frontend.Components.ScrollList)
local SearchBar = require(frontend.Components.SearchBar)
local CommandCard = require(frontend.Components.CommandCard)
local OutfitsButton = require(frontend.Components.OutfitsButton)
local Remote = require(modules.Objects.Remote)
local promptSetFavoriteAsync = require(modules.AssetUtil.promptSetFavoriteAsync)
local Children = Fusion.Children
local sendMessage = Remote.get("SendMessage")
local favoriteEmote = Remote.get("FavoriteEmote")


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	idle: UsedAs<boolean>?,
	display: {[string]: any}?, -- booster command key -> {kind, id}, sent by openCommands for the tile thumbnails
}


-- HELPERS
local function thumbUrl(entry: any): string?
	if typeof(entry) ~= "table" then return nil end
	local id = (entry :: any).id
	if typeof(id) ~= "number" then return nil end
	local kind = (entry :: any).kind
	if kind == "Bundle" then
		return `rbxthumb://type=BundleThumbnail&id={id}&w=150&h=150`
	elseif kind == "Image" then
		return `rbxassetid://{id}`
	end
	return `rbxthumb://type=Asset&id={id}&w=150&h=150`
end

-- Bundles and the random pools return nil so only real single emotes get a star
local function emoteIdOf(entry: any): number?
	if typeof(entry) ~= "table" or (entry :: any).kind ~= "Emote" then return nil end
	local id = (entry :: any).id
	return if typeof(id) == "number" then id else nil
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local commandsFuse = scope:Fuse("everyone", "Commands")
	local favouritedFuse = scope:Fuse("perm", "FavoritedEmotes")
	local displayFuse = scope:Fuse("everyone", "BoosterDisplay")
	local searchText = scope:Value("")

	-- Closing this grid is part of dismissing the booster stack, so let Panels
	-- decide whether the "save 20%" nudge should fire now
	table.insert(scope, function()
		local Panels = require(frontend.Config.Panels) :: any
		Panels.notifyBoosterStackClosed("commands")
	end)

	local function runCommand(prefix: any, commandName: string)
		local usePrefix = if typeof(prefix) == "string" and prefix ~= "" then prefix else "/"
		local message = usePrefix .. commandName
		task.spawn(function()
			sendMessage:invokeServerAsync(message, "ClientRun")
		end)
	end
	-- Yields until the Roblox prompt is answered, same flow as the ;emotes grid
	local function toggleFavourite(emoteId: number, currentlyFavourited: boolean)
		local shouldFavourite = not currentlyFavourited
		local confirmed = promptSetFavoriteAsync(emoteId, shouldFavourite)
		if confirmed then
			favoriteEmote:invokeServerAsync(emoteId, shouldFavourite)
		end
	end

	local rows = scope:Computed(function(use)
		local cmds = use(commandsFuse)
		if typeof(cmds) ~= "table" then return {} end
		local search = use(searchText):lower()
		local display = props.display or use(displayFuse)

		-- Every booster command shows regardless of ownership. Running a locked
		-- one routes non-owners back to the Get Booster page
		local function hasBoosterTag(cmd: any): boolean
			local tags = (cmd :: any).tags
			if typeof(tags) ~= "table" then return false end
			for _, tag in tags :: {any} do
				if tag == "_Booster" then return true end
			end
			return false
		end

		local favourited = use(favouritedFuse)
		local hasFavourites = typeof(favourited) == "table"
		local function favRecord(emoteId: number): any
			return hasFavourites and (favourited :: any)[tostring(emoteId)]
		end

		local list: {any} = {}
		local sourceIndex = 0
		for _, cmd in cmds :: any do
			if typeof(cmd) ~= "table" then continue end
			if (cmd :: any).key == "/commands" then continue end -- the opener itself
			if not hasBoosterTag(cmd) then continue end
			local name = (cmd :: any).name
			if typeof(name) ~= "string" then continue end
			if search ~= "" and not name:lower():find(search, 1, true) then continue end
			sourceIndex += 1
			local emoteId = emoteIdOf(display and display[(cmd :: any).key])
			local record = if emoteId then favRecord(emoteId) else nil
			local addedTime = if typeof(record) == "table" and typeof(record.addedTime) == "number" then record.addedTime else 0
			table.insert(list, {
				cmd = cmd,
				sourceIndex = sourceIndex,
				emoteId = emoteId,
				isFavourited = record ~= nil,
				addedTime = addedTime,
			})
		end
		-- Favourites float to the top newest first, the rest keep the source order
		table.sort(list, function(left, right)
			if left.isFavourited ~= right.isFavourited then return left.isFavourited end
			if left.isFavourited and left.addedTime ~= right.addedTime then return left.addedTime > right.addedTime end
			return left.sourceIndex < right.sourceIndex
		end)

		local rowList: {any} = {}
		for index = 1, #list, COLUMNS do
			local cards: {any} = {}
			for column = 0, COLUMNS - 1 do
				local record = list[index + column]
				if not record then break end
				local cmd = record.cmd
				local prefix = (cmd :: any).prefix
				local name = (cmd :: any).name
				local emoteId = record.emoteId
				local isFavourited = record.isFavourited
				table.insert(cards, {
					commandName = name,
					icon = thumbUrl(display and display[(cmd :: any).key]),
					onRun = function() runCommand(prefix, name) end,
					isFavourited = isFavourited,
					onFavourite = if emoteId then function() toggleFavourite(emoteId :: number, isFavourited) end else nil,
				})
			end
			table.insert(rowList, { layoutOrder = #rowList + 1, cards = cards, columns = COLUMNS })
		end
		return rowList
	end)
	
	local function renderRow(itemScope: Scope, row: any): Instance
		local cardInstances: {any} = {}
		for index, card in row.cards do
			cardInstances[index] = CommandCard(itemScope, {
				commandName = card.commandName,
				icon = card.icon,
				isFavourited = card.isFavourited,
				onFavourite = card.onFavourite,
				onRun = card.onRun,
				layoutOrder = index,
			})
		end
		for filler = #row.cards + 1, row.columns do
			cardInstances[filler] = itemScope:New "Frame" {
				Name = "Filler",
				BackgroundTransparency = 1,
				LayoutOrder = filler,
				Size = UDim2.new(0, 0, 0, 0),
			}
		end
		return itemScope:New "Frame" {
			Name = "CommandRow",
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
				cardInstances,
			},
		}
	end

	return scope:New "Frame" {
		Name = "Commands",
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
					return typeof(use(commandsFuse)) == "table"
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
					placeholderText = "Search commands",
					layoutOrder = 0,
					gap = UDim.new(0, 6),
					slot = OutfitsButton(scope, {
						onActivate = function()
							(require(frontend.Config.Panels) :: any).openOutfits()
						end,
					}),
				}),
			}),
		},
	}
end
