--!strict
-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Popups = require(frontend.Util.Popups)
local PopupItem = require(frontend.Components.PopupItem)
local LayerOrder = require(frontend.Config.LayerOrder)
local Children = Fusion.Children


-- CONFIG
-- These two sit above the layer pool and never move. Sidebar cards are pool
-- members instead, so they take their ZIndex from LayerOrder
local CHANNEL_ZINDEX = {
	top = 1500,
	centre = 2000,
}


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	channel: Popups.Channel,
	parent: UsedAs<Instance>?,
	host: Instance?, -- sidebar only, the cards parent straight into this
}
type Record = {scope: any, instance: Instance}


-- HELPERS
local function makeBackdrop(scope: Scope): (Instance, Instance)
	local anyOpen = scope:Computed(function(use)
		for _, entry in use(Popups.getList("centre")) do
			if not use(entry.exiting) then
				return true
			end
		end
		return false
	end)
	local transparency = scope:Spring(scope:Computed(function(use)
		return if use(anyOpen) then 0.4 else 1
	end), 28, 1)
	-- A press meant for a centre message would otherwise reorder the panel underneath
	LayerOrder.addBlocker(function()
		return Fusion.peek(anyOpen)
	end)
	local function dismissAll()
		local active = {}
		for _, entry in Fusion.peek(Popups.getList("centre")) do
			if not Fusion.peek(entry.exiting) then
				table.insert(active, entry)
			end
		end
		-- Backdrop close only applies with exactly one up so a stray click can't wipe everything
		if #active ~= 1 then return end
		local entry = active[1]
		if not Fusion.peek(entry.settled) then return end
		-- Only a message the user opened themselves closes via the backdrop. Broadcasts
		-- (;message etc) need their own X so a stray click can't dismiss them
		local userOpened = entry.options and entry.options.userOpened
		if not userOpened then return end
		entry.dismissRequested:set(true)
	end
	local dim = scope:New "Frame" {
		Name = "Backdrop",
		Active = false,
		BackgroundColor3 = Color3.fromRGB(15, 15, 15),
		BackgroundTransparency = transparency,
		Selectable = false,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0,
	}
	local catcher = scope:New "TextButton" {
		Name = "BackdropCatcher",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Interactable = anyOpen,
		Selectable = false,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		TextColor3 = Color3.new(),
		TextSize = 1,
		ZIndex = 1,

		[Fusion.OnEvent "Activated"] = dismissAll,
	}
	return dim, catcher
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local channel = props.channel
	local isSidebar = channel == "sidebar"

	local childList = {}
	if channel == "centre" then
		local dim, catcher = makeBackdrop(scope)
		table.insert(childList, dim)
		table.insert(childList, catcher)
	end

	local root: Instance
	if isSidebar then
		root = props.host :: Instance
	else
		root = scope:New "Frame" {
			Name = "PopupLayer_" .. channel,
			Parent = props.parent,
			Active = false,
			BackgroundTransparency = 1,
			Selectable = false,
			Size = UDim2.fromScale(1, 1),
			ZIndex = CHANNEL_ZINDEX[channel],

			[Children] = childList,
		}
	end

	local active: {[string]: Record} = {}
	local function sync()
		local entries = Fusion.peek(Popups.getList(channel))
		local seen: {[string]: boolean} = {}
		for _, entry in entries do
			seen[entry.id] = true
			if not active[entry.id] then
				local itemScope: any = Fusion.scoped(Fusion)
				-- Every card joins the pool under one group, so a press on any of them
				-- brings the whole stack forward while a new arrival comes up alone
				local layerId = if isSidebar then "Notice_" .. entry.id else nil
				local zIndex = if layerId then LayerOrder.register(itemScope, layerId, "sidebar") else nil
				local instance = PopupItem(itemScope, {entry = entry, zIndex = zIndex})
				;(instance :: any).Parent = root
				if layerId then
					LayerOrder.attach(layerId, instance :: any)
				end
				active[entry.id] = {scope = itemScope, instance = instance}
			end
		end
		for id, record in active do
			if not seen[id] then
				Fusion.doCleanup(record.scope)
				active[id] = nil
			end
		end
	end

	scope:Observer(Popups.getList(channel)):onChange(sync)
	sync()

	table.insert(scope, function()
		for id, record in active do
			Fusion.doCleanup(record.scope)
			active[id] = nil
		end
	end)

	return root
end
