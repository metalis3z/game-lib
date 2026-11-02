--!strict
-- CONFIG
local COLUMNS = 3 -- emote cards per row


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local ScrollList = require(frontend.Components.ScrollList)
local SearchBar = require(frontend.Components.SearchBar)
local EmoteRow = require(frontend.Components.EmoteRow)
local Remote = require(modules.Objects.Remote)
local promptSetFavoriteAsync = require(modules.AssetUtil.promptSetFavoriteAsync)
local Children = Fusion.Children
local sendMessage = Remote.get("SendMessage")
local favoriteEmote = Remote.get("FavoriteEmote")
local getActiveCommands = Remote.get("GetActiveCommands")
local updateActiveCommands = Remote.get("UpdateActiveCommands")


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	idle: UsedAs<boolean>?,
}
type Emote = {
	name: string,
	emoteId: number,
	order: number?,
}


-- COMPONENT
-- The ;emotes grid
return function(scope: Scope, props: Props)
	local emotesFuse = scope:Fuse("everyone", "Emotes")
	local favouritedFuse = scope:Fuse("perm", "FavoritedEmotes")
	local prefixFuse = scope:Fuse("perm", { "YouSettings", "Prefix" })
	local searchText = scope:Value("")
	-- Synced with the server's active-command map so respawns and external stops
	-- clear the highlight
	local activeEmoteId: Fusion.Value<number?> = scope:Value(nil)
	local emoteCommandActive = scope:Value(false)

	local function applyActiveMap(map: any)
		if type(map) == "table" then
			emoteCommandActive:set(map["emote"] == true)
		end
	end
	task.defer(function()
		local success, result = getActiveCommands:invokeServerAsync()
		if success then applyActiveMap(result) end
	end)
	local activeConnection = updateActiveCommands:onClientEvent(applyActiveMap)
	table.insert(scope, function() activeConnection:Disconnect() end)
	scope:Observer(emoteCommandActive):onChange(function()
		if not Fusion.peek(emoteCommandActive) then
			activeEmoteId:set(nil)
		end
	end)

	local function prefix(): string
		local value = Fusion.peek(prefixFuse)
		return if typeof(value) == "string" and value ~= "" then value else ";"
	end
	local function toggleEmote(emoteId: number, emoteName: string)
		local currentlyActive = Fusion.peek(emoteCommandActive) and Fusion.peek(activeEmoteId) == emoteId
		local command = if currentlyActive then prefix() .. "unemote me" else prefix() .. "emote me " .. emoteName
		activeEmoteId:set(if currentlyActive then nil else emoteId)
		task.spawn(function()
			local _, returnDetails = sendMessage:invokeServerAsync(command, "ClientRun")
			if type(returnDetails) == "table" and type((returnDetails :: any).activeCommands) == "table" then
				applyActiveMap((returnDetails :: any).activeCommands)
			end
		end)
	end
	-- Yields until the Roblox prompt is answered
	local function toggleFavourite(emoteId: number, currentlyFavourited: boolean)
		local shouldFavourite = not currentlyFavourited
		local confirmed = promptSetFavoriteAsync(emoteId, shouldFavourite)
		if confirmed then
			favoriteEmote:invokeServerAsync(emoteId, shouldFavourite)
		end
	end

	local rows = scope:Computed(function(use)
		local catalog = use(emotesFuse)
		if typeof(catalog) ~= "table" then return {} end
		local favourited = use(favouritedFuse)
		local hasFavourites = typeof(favourited) == "table"
		local search = use(searchText):lower()

		local function favRecord(emote: Emote): any
			return hasFavourites and (favourited :: any)[tostring(emote.emoteId)]
		end
		local function isFavourited(emote: Emote): boolean
			return favRecord(emote) ~= nil
		end
		local function favTime(emote: Emote): number
			local record = favRecord(emote)
			return if typeof(record) == "table" and typeof(record.addedTime) == "number" then record.addedTime else 0
		end

		local list: { Emote } = {}
		for _, emote in catalog :: any do
			if typeof(emote) ~= "table" or not emote.emoteId then continue end
			if search ~= "" and not emote.name:lower():find(search, 1, true) then continue end
			table.insert(list, emote)
		end
		table.sort(list, function(left, right)
			local leftFav, rightFav = isFavourited(left), isFavourited(right)
			if leftFav ~= rightFav then return leftFav end -- favourites first
			if leftFav then
				local leftTime, rightTime = favTime(left), favTime(right)
				if leftTime ~= rightTime then return leftTime > rightTime end
			end
			local leftOrder, rightOrder = left.order or math.huge, right.order or math.huge
			if leftOrder ~= rightOrder then return leftOrder < rightOrder end
			return left.name < right.name
		end)

		local rowList: { any } = {}
		for index = 1, #list, COLUMNS do
			local cards: { any } = {}
			for column = 0, COLUMNS - 1 do
				local emote = list[index + column]
				if not emote then break end
				local emoteId = emote.emoteId
				local emoteName = emote.name
				table.insert(cards, {
					emoteName = emoteName,
					emoteId = emoteId,
					isFavourited = isFavourited(emote),
					activeEmoteId = activeEmoteId,
					onRun = function() toggleEmote(emoteId, emoteName) end,
					onFavourite = function() toggleFavourite(emoteId, isFavourited(emote)) end,
				})
			end
			table.insert(rowList, { layoutOrder = #rowList + 1, cards = cards, columns = COLUMNS })
		end
		return rowList
	end)

	return scope:New "Frame" {
		Name = "Emotes",
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
					local catalog = use(emotesFuse)
					return typeof(catalog) == "table" and next(catalog :: any) ~= nil
				end),
				items = rows,
				visibleItems = rows,
				useStream = false,
				renderItem = function(itemScope: Scope, row: any)
					return EmoteRow(itemScope, row)
				end,
				padding = UDim.new(0, 8),
				paddingRight = 10,
				layoutOrder = 1,
				idle = props.idle,
				headerGap = UDim.new(0, 8),
				header = SearchBar(scope, {
					searchText = searchText,
					placeholderText = "Search emotes",
					layoutOrder = 0,
				}),
			}),
		},
	}
end
