--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Children = Fusion.Children
local Viewport = require(frontend.Config.Viewport)
local Panels = require(frontend.Config.Panels)
local PanelGui = require(script.Parent.PanelGui)
local PopupLayer = require(script.Parent.PopupLayer)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	parent: UsedAs<Instance>?,
	menuVisible: Fusion.Value<boolean>?,
	onClose: (() -> ())?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	-- Lifted so Panels can snapshot the main drag at popup open
	local mainDragOffset: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	Panels.init(scope, mainDragOffset)
	local panelsState = Panels.getState()

	-- Keyed by id so ForPairs leaves surviving popups alone when one closes
	local panelsById = scope:Computed(function(use)
		local byId: { [string]: any } = {}
		for _, panel in use(panelsState) do
			byId[panel.id] = panel
		end
		return byId
	end)

	local root = scope:New "Frame" {
		Name = "ViewportGui",
		Parent = props.parent,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Active = false,
		Selectable = false,

		[Children] = {
			PopupLayer(scope, {channel = "top"}),
			PopupLayer(scope, {channel = "centre"}),

			PanelGui(scope, {
				position = Viewport.MenuDefaultPosition,
				visible = props.menuVisible,
				onClose = props.onClose,
				dragOffset = mainDragOffset,
			}),

			Fusion.ForPairs(scope, panelsById, function(_, innerScope, _panelId, panel)
				local panelPosition = innerScope:Computed(function(use)
					local basePos = use(Viewport.MenuDefaultPosition)
					local vp = use(Viewport.ViewportSize)
					local scale = use(Viewport.Scale)

					local snap = panel.spawnDragSnapshot
					local mainCenterX = basePos.X.Scale * vp.X + basePos.X.Offset + snap.X
					local mainTopY = basePos.Y.Scale * vp.Y + basePos.Y.Offset + snap.Y

					local mult = panel.cascadeMultiplier
					local popX = mainCenterX + Panels.POPUP_OFFSET.X * mult * scale
					local popY = mainTopY + Panels.POPUP_OFFSET.Y * mult * scale

					local halfW = (Panels.POPUP_PANEL_WIDTH * scale) / 2
					local minVisibleH = Panels.POPUP_MIN_VISIBLE_HEIGHT * scale
					popX = math.clamp(popX, halfW, math.max(halfW, vp.X - halfW))
					popY = math.clamp(popY, 0, math.max(0, vp.Y - minVisibleH))

					return UDim2.fromOffset(popX, popY)
				end)
				return panel.id, PanelGui(innerScope, {
					mode = "fitContent",
					profilePanel = panel,
					position = panelPosition,
					visible = innerScope:Value(true),
					dragOffset = panel.dragOffset,
					onClose = function()
						Panels.close(panel.id)
					end,
				})
			end),
		},
	}

	-- Notice cards live alongside the panels instead of inside a shared frame
	PopupLayer(scope, {channel = "sidebar", host = root})

	return root
end
