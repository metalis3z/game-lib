--!strict
-- LOCAL
local UI = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local fuseState = require(modules.DataUtil.fuseState)
local ScreenGui = require(script.Containers.ScreenGui)
local Navigate = require(script.Util.Navigate)
local AboutPreload = require(script.Util.AboutPreload)
local Permissions = require(script.Util.Permissions)
local LayerOrder = require(script.Config.LayerOrder)
local Icons = require(script.Config.Icons)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer


-- SCOPE
local scope = Fusion.scoped({
	Value = Fusion.Value,
	Computed = Fusion.Computed,
	Fuse = fuseState,
	New = Fusion.New,
	ForValues = Fusion.ForValues,
	Spring = Fusion.Spring,
	Observer = Fusion.Observer,
})


-- START
task.defer(function()

	-- We only build the dashboard upfront, everything else loads on navigate
	local playerGui = localPlayer:WaitForChild("PlayerGui")

	local menuVisible = scope:Value(false)

	LayerOrder.init(scope)

	local screenGui = ScreenGui(scope, {
		parent = playerGui,
		menuVisible = menuVisible,
		onClose = function()
			menuVisible:set(false)
		end,
	})

	-- The command bar builds itself lazily, and only for users who can access it
	require(script.Util.Cmdbar.Setup)(scope, screenGui)
	
	local appIcon = require(modules.References.appIcon)
	appIcon:bindEvent("toggled", function(icon, isSelected: boolean, sourceName: string)
		if sourceName == "MenuForceClosed" then
			return -- stops feedback loop
		end
		menuVisible:set(isSelected)
	end)

	-- Opening pre-loads the About page so it doesn't appear jarring when opened
	scope:Observer(menuVisible):onChange(function()
		if Fusion.peek(menuVisible) then
			AboutPreload.warm()
		elseif (appIcon :: any).isSelected then
			appIcon:deselect("MenuForceClosed")
		end
	end)

	-- Icon permission decides whether the icon shows and whether it opens the full
	-- menu or just the Commands page. PanelGui roots itself from the same computed
	local iconMode = Permissions.iconMode(scope)
	local function applyIconMode()
		local mode = Fusion.peek(iconMode)
		if mode == "None" then
			-- Closing the menu is safe because PreviewController keeps a sidebar
			-- card up with its own End Preview button for the preview case
			menuVisible:set(false)
			appIcon:setEnabled(false)
			return
		end
		local images = if mode == "Commands" then Icons.Topbar.Commands else Icons.Topbar.Menu
		appIcon:setImage(images.deselected, "deselected")
		appIcon:setImage(images.selected, "selected")
		appIcon:setImageScale(images.deselectedScale, "deselected")
		appIcon:setImageScale(images.selectedScale, "selected")
		appIcon:setEnabled(true)
	end
	applyIconMode()
	scope:Observer(iconMode):onChange(applyIconMode)

	Navigate.bindPanelVisibility({
		setVisible = function(visible: boolean)
			menuVisible:set(visible)
			if visible and not (appIcon :: any).isSelected then
				appIcon:select()
			elseif not visible and (appIcon :: any).isSelected then
				appIcon:deselect("MenuForceClosed")
			end
		end,
		isVisible = function()
			return Fusion.peek(menuVisible)
		end,
	})

end)


return UI
