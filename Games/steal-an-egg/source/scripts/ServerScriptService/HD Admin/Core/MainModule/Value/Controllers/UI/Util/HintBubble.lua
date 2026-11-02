--!strict


-- LOCAL
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Viewport = require(frontend.Config.Viewport)
local Children = Fusion.Children
local HintBubble = {}
local bubbleScope = Fusion.scoped(Fusion)
local bubbleText = bubbleScope:Value("")
local bubblePosition = bubbleScope:Value(UDim2.new())
local bubbleAnchor = bubbleScope:Value(Vector2.new(0.5, 1))
local bubbleVisible = bubbleScope:Value(false)
local currentHost: GuiObject? = nil
local bubbleInstance: Instance? = nil
local bubbleSize = bubbleScope:Value(UDim2.fromOffset(0, 0))
local activeIcon: GuiObject? = nil
local shownVia: string? = nil -- "hover" | "tap"
local showEpoch = 0
local sizeCache: {[string]: Vector2} = {}
local GAP = 4 -- px between icon and bubble
local MAX_WIDTH = 220
local PADDING_X = 10
local PADDING_Y = 8


-- LOCAL FUNCTIONS
-- Sized by hand because AutomaticSize + TextWrapped + UISizeConstraint don't
-- compose (the clamped width wraps but the auto height never grows)
local function measureText(text: string): Vector2
	local textSize = Fusion.peek(Theme.TextSize.Label) :: number
	local cacheKey = `{textSize}:{text}`
	local cached = sizeCache[cacheKey]
	if cached then return cached end
	local params = Instance.new("GetTextBoundsParams")
	params.Text = text
	params.Font = Font.new(Fusion.peek(Theme.Font.Body), Fusion.peek(Theme.FontWeight.Body))
	params.Size = textSize
	params.Width = MAX_WIDTH - PADDING_X * 2
	local ok, bounds = pcall(function()
		return TextService:GetTextBoundsAsync(params)
	end)
	local result = if ok and typeof(bounds) == "Vector2"
		then bounds
		else Vector2.new(MAX_WIDTH - PADDING_X * 2, textSize + 4)
	sizeCache[cacheKey] = result
	return result
end

local function placeBubble(icon: GuiObject)
	local host = currentHost
	if not host then return end
	local scale = Fusion.peek(Viewport.Scale)
	if typeof(scale) ~= "number" or scale <= 0 then scale = 1 end
	local hostPos = host.AbsolutePosition
	local group = host.Parent :: GuiObject?
	local groupPos = if group then group.AbsolutePosition else hostPos
	local iconPos = icon.AbsolutePosition
	local iconSize = icon.AbsoluteSize

	-- Centre on the icon, clamped so the bubble stays within the panel
	local hostWidth = host.AbsoluteSize.X / scale
	local halfWidth = MAX_WIDTH / 2 + 4
	local relX = (iconPos.X + iconSize.X / 2 - hostPos.X) / scale
	if hostWidth > halfWidth * 2 then
		relX = math.clamp(relX, halfWidth, hostWidth - halfWidth)
	else
		relX = hostWidth / 2
	end

	-- Above the icon, flipping below when too close to the panel top
	local iconTopInGroup = (iconPos.Y - groupPos.Y) / scale
	if iconTopInGroup < 56 then
		bubbleAnchor:set(Vector2.new(0.5, 0))
		bubblePosition:set(UDim2.fromOffset(relX, (iconPos.Y + iconSize.Y - hostPos.Y) / scale + GAP))
	else
		bubbleAnchor:set(Vector2.new(0.5, 1))
		bubblePosition:set(UDim2.fromOffset(relX, (iconPos.Y - hostPos.Y) / scale - GAP))
	end
end


-- FUNCTIONS
-- Rebuilds if the menu re-registers. The host frame should sit inside the
-- menu's CanvasGroup
function HintBubble.registerHost(host: GuiObject)
	if host == currentHost then return end
	currentHost = host
	if bubbleInstance then
		bubbleInstance:Destroy()
		bubbleInstance = nil
	end
	bubbleInstance = bubbleScope:New "TextLabel" {
		Name = "HintBubble",
		Parent = host,
		AnchorPoint = bubbleAnchor,
		BackgroundColor3 = Theme.Color.Neutral,
		Position = bubblePosition,
		Size = bubbleSize,
		FontFace = bubbleScope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
		end),
		Text = bubbleText,
		TextColor3 = Theme.Color.BaseContent,
		TextSize = Theme.TextSize.Label,
		TextWrapped = true,
		Visible = bubbleVisible,
		ZIndex = 50,
		[Children] = {
			bubbleScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			bubbleScope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},
			bubbleScope:New "UIPadding" {
				PaddingTop = UDim.new(0, PADDING_Y),
				PaddingBottom = UDim.new(0, PADDING_Y),
				PaddingLeft = UDim.new(0, PADDING_X),
				PaddingRight = UDim.new(0, PADDING_X),
			},
		},
	}
end

function HintBubble.show(icon: GuiObject, text: string, via: string)
	if not currentHost then return end
	activeIcon = icon
	shownVia = via
	showEpoch += 1
	local myEpoch = showEpoch
	-- Measuring can yield on first use (font load), so reveal once sized
	task.spawn(function()
		local bounds = measureText(text)
		if showEpoch ~= myEpoch or activeIcon ~= icon then return end
		bubbleText:set(text)
		bubbleSize:set(UDim2.fromOffset(
			math.ceil(bounds.X) + PADDING_X * 2 + 2,
			math.ceil(bounds.Y) + PADDING_Y * 2
		))
		placeBubble(icon)
		bubbleVisible:set(true)
	end)
end

-- Hides only when `icon` still owns the bubble (nil = unconditional)
function HintBubble.hide(icon: GuiObject?)
	if icon ~= nil and icon ~= activeIcon then return end
	activeIcon = nil
	shownVia = nil
	bubbleVisible:set(false)
end

function HintBubble.owner(): GuiObject?
	return activeIcon
end

function HintBubble.via(): string?
	return shownVia
end


-- SETUP
-- Tap-anywhere-else dismissal. Presses inside the owning icon are left for its
-- own Activated handler to toggle
UserInputService.InputBegan:Connect(function(input: InputObject)
	if not Fusion.peek(bubbleVisible) then return end
	if input.UserInputType ~= Enum.UserInputType.MouseButton1
		and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end
	local icon = activeIcon
	if icon then
		local topLeft = icon.AbsolutePosition
		local size = icon.AbsoluteSize
		local positionX, positionY = input.Position.X, input.Position.Y
		if positionX >= topLeft.X and positionX <= topLeft.X + size.X
			and positionY >= topLeft.Y and positionY <= topLeft.Y + size.Y then
			return
		end
	end
	HintBubble.hide(nil)
end)


return HintBubble
