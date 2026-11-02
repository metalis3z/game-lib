--!strict
-- CONFIG
local MENU_HEIGHT_MIN = 5
local MENU_HEIGHT_DEFAULT = 10
local MENU_HEIGHT_MAX = 15
local PIXEL_MIN = 200
local PIXEL_DEFAULT_PREFERRED = 416.4
local MIN_UPPER_HALF_HEADROOM = 60 -- so the upper slider half always grows
local PHONE_SHORT_AXIS_MAX = 500 -- short axis at or under this is a phone, above is a tablet
local SCREEN_EDGE_PADDING_FRACTION = 0.06
local MIN_SCREEN_EDGE_GAP = 4
local PANEL_CHROME_HEIGHT = 45 -- the panel stands this + content tall
local SCALE_BY_DISPLAY = {
	PhonePortrait   = 0.95,
	PhoneLandscape  = 0.80,
	TabletPortrait  = 1.15,
	TabletLandscape = 1.05,
	Medium          = 1.00,
	Large           = 1.60,
}
local POSITION_X_BY_DISPLAY = {
	PhonePortrait   = 0.5,
	PhoneLandscape  = 0.75,
	TabletPortrait  = 0.5,
	TabletLandscape = 0.75,
	Medium          = 0.725,
	Large           = 0.725,
}


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local GuiService = game:GetService("GuiService")
local workspace = game:GetService("Workspace")
local camera = workspace.CurrentCamera
local viewportSizeConn: RBXScriptConnection? = nil
local Fusion = require(packages.Fusion)
local Viewport = {}
local fuseState = require(modules.DataUtil.fuseState)
local scope = Fusion.scoped({
	Value = Fusion.Value,
	Computed = Fusion.Computed,
	Fuse = fuseState,
})


-- PUBLIC
Viewport.MinScreenEdgeGap = MIN_SCREEN_EDGE_GAP


-- LOCAL FUNCTIONS
local function menuHeightToPixels(menuHeight: number, pixelMax: number): number
	menuHeight = math.clamp(menuHeight, MENU_HEIGHT_MIN, MENU_HEIGHT_MAX)
	-- Floor so the curve can't collapse on tiny viewports
	pixelMax = math.max(pixelMax, PIXEL_MIN + MIN_UPPER_HALF_HEADROOM + 10)
	local pixelDefault = math.min(PIXEL_DEFAULT_PREFERRED, pixelMax - MIN_UPPER_HALF_HEADROOM)
	pixelDefault = math.max(pixelDefault, PIXEL_MIN + 10)
	if menuHeight <= MENU_HEIGHT_DEFAULT then
		local alpha = (menuHeight - MENU_HEIGHT_MIN) / (MENU_HEIGHT_DEFAULT - MENU_HEIGHT_MIN)
		return PIXEL_MIN + alpha * (pixelDefault - PIXEL_MIN)
	else
		local alpha = (menuHeight - MENU_HEIGHT_DEFAULT) / (MENU_HEIGHT_MAX - MENU_HEIGHT_DEFAULT)
		return pixelDefault + alpha * (pixelMax - pixelDefault)
	end
end

local function getTopbarHeight()
	return GuiService.TopbarInset.Height
end

local function getViewportInfo()
	local vp = workspace.CurrentCamera.ViewportSize
	local landscape = vp.X > vp.Y
	local shortAxis = math.min(vp.X, vp.Y)
	return {
		displaySize = GuiService.ViewportDisplaySize,
		landscape = landscape,
		shortAxis = shortAxis,
		rawHeight = vp.Y,
		availableHeight = vp.Y - getTopbarHeight(),
	}
end

local viewportInfoValue = scope:Value(getViewportInfo())
local function updateViewport()
	viewportInfoValue:set(getViewportInfo())
end

local function connectCamera()
	if viewportSizeConn then viewportSizeConn:Disconnect() end
	camera = workspace.CurrentCamera
	viewportSizeConn = camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateViewport)
	updateViewport()
end

local function getDisplayKey(info)
	local ds = info.displaySize
	local DisplaySize = Enum.DisplaySize
	if ds == DisplaySize.Small then
		local isPhone = info.shortAxis <= PHONE_SHORT_AXIS_MAX
		if isPhone then
			return if info.landscape then "PhoneLandscape" else "PhonePortrait"
		else
			return if info.landscape then "TabletLandscape" else "TabletPortrait"
		end
	elseif ds == DisplaySize.Medium then
		return "Medium"
	else
		return "Large"
	end
end


-- SETUP
connectCamera()
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(connectCamera)
GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(updateViewport)


-- EXPOSED VALUES
Viewport.ViewportSize = scope:Computed(function(use)
	local info = use(viewportInfoValue)
	return Vector2.new(workspace.CurrentCamera.ViewportSize.X, info.rawHeight)
end)

Viewport.TopbarHeight = scope:Computed(function(use)
	local info = use(viewportInfoValue)
	return info.rawHeight - info.availableHeight
end)

Viewport.Scale = scope:Computed(function(use)
	local info = use(viewportInfoValue)
	return SCALE_BY_DISPLAY[getDisplayKey(info)]
end)

-- Max height the user can drag/slide to (pre-UIScale px)
Viewport.DragMaxHeight = scope:Computed(function(use)
	local info = use(viewportInfoValue)
	local scale = use(Viewport.Scale)
	local maxScreenPixels = info.rawHeight * (1 - 2 * SCREEN_EDGE_PADDING_FRACTION)
	return math.floor(maxScreenPixels / scale)
end)

-- Tallest the content can be before the panel spills past a screen edge
Viewport.PanelFitHeight = scope:Computed(function(use)
	local info = use(viewportInfoValue)
	local scale = use(Viewport.Scale)
	return (info.availableHeight - 2 * MIN_SCREEN_EDGE_GAP) / scale - PANEL_CHROME_HEIGHT
end)

-- User's Menu Height setting mapped to pre-UIScale px
local menuHeightSetting = (scope :: any):Fuse("perm", {"YouSettings", "Display", "MenuHeight"})
Viewport.MenuHeightPixels = scope:Computed(function(use)
	local pixelMax = use(Viewport.DragMaxHeight)
	local stored = use(menuHeightSetting)
	if typeof(stored) ~= "number" then
		stored = MENU_HEIGHT_DEFAULT
	end
	return menuHeightToPixels(stored, pixelMax)
end)

-- Defensive clamp on top of MenuHeightPixels
Viewport.MaxContentHeight = scope:Computed(function(use)
	return math.floor(math.min(use(Viewport.MenuHeightPixels), use(Viewport.DragMaxHeight), use(Viewport.PanelFitHeight)))
end)

Viewport.MenuDefaultPosition = scope:Computed(function(use)
	local info = use(viewportInfoValue)
	local topbarHeight = info.rawHeight - info.availableHeight
	local posX = POSITION_X_BY_DISPLAY[getDisplayKey(info)]
	local panelScreenHeight = (PANEL_CHROME_HEIGHT + use(Viewport.MaxContentHeight)) * use(Viewport.Scale)
	return UDim2.new(posX, 0, 0.5, math.round(topbarHeight / 2 - panelScreenHeight / 2))
end)


return Viewport
