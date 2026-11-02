local ContainerGui = script:FindFirstAncestorOfClass("ScreenGui")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormModules = ReplicatedStorage.FormModules
local Colors = require(FormModules.Colors)
local Config = require(FormModules.Config)

-- UI
local FormFrame = script.Parent
local Scale = FormFrame.UIScale
local SizeConstraint = FormFrame.UISizeConstraint
local ScrollingFrame = FormFrame.ScrollingFrame
local Contents = ScrollingFrame.Contents

-- Colors
local themeColor = ContainerGui:GetAttribute("ThemeColor")

FormFrame.BackgroundColor3 = themeColor:Lerp(Colors.White, 0.75)
ScrollingFrame.ScrollBarImageColor3 = themeColor:Lerp(Colors.White, 0.25)

-- Sizing
local isTenFootInterface = GuiService:IsTenFootInterface()
if isTenFootInterface then
	Scale.Scale = 1.5
end

local topBarAdjustment = 72
local function updateFrameMaxHeight()
	local containerHeight = ContainerGui.AbsoluteSize.Y
	local canvasHeight = ScrollingFrame.CanvasSize.Y.Offset
	local minHeight = math.min(containerHeight - topBarAdjustment, canvasHeight)
	local scaledMinHeight = minHeight / Scale.Scale
	
	SizeConstraint.MaxSize = Vector2.new(SizeConstraint.MaxSize.X, scaledMinHeight)
end

ContainerGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateFrameMaxHeight)

local function updateCanvasSize()
	local contentsHeight = Contents.AbsoluteSize.Y
	local scaledContentsHeight = contentsHeight / Scale.Scale
	
	ScrollingFrame.CanvasSize = UDim2.new(ScrollingFrame.CanvasSize.X, UDim.new(0, scaledContentsHeight))
	
	updateFrameMaxHeight()
end

Contents:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateCanvasSize)