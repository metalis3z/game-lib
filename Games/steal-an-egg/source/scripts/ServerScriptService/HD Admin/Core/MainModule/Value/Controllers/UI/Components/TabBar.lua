--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
export type Tab = {
label: string,
icon: string?,
visible: UsedAs<boolean>?, -- hidden tabs leave no gap, the rest reflow to fill the bar
}
type Props = {
tabs: { Tab },
activeTab: Fusion.Value<number>,
onTabChange: ((newIdx: number, prevIdx: number?) -> ())?,
layoutOrder: UsedAs<number>?,
collapseInactive: UsedAs<boolean>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
local tabs = props.tabs
local activeTab = props.activeTab
local onTabChange = props.onTabChange
local collapseInactive = props.collapseInactive or false

-- Ipairs so tabIdx stays 1, 2, 3 regardless of ForValues quirks
local tabButtons: { any } = {
scope:New "UIListLayout" {
FillDirection = Enum.FillDirection.Horizontal,
HorizontalFlex = Enum.UIFlexAlignment.Fill,
Padding = UDim.new(0, 9),
SortOrder = Enum.SortOrder.LayoutOrder,
},
}

for idx, tab in tabs do
local tabIdx = idx

local isActive = scope:Computed(function(use)
return use(activeTab) == tabIdx
end)

-- Only tabs with an icon can drop their label, a bare word has nothing to shrink to
local isCollapsed = scope:Computed(function(use)
return use(collapseInactive) == true and not use(isActive) and tab.icon ~= nil
end)

table.insert(tabButtons, Pressable(scope, {
name = "Tab_" .. tab.label,
automaticSize = scope:Computed(function(use)
return if use(collapseInactive) == true and use(isActive)
then Enum.AutomaticSize.XY
else Enum.AutomaticSize.Y
end),
size = UDim2.new(0, 0, 0, 0),
visible = tab.visible,
backgroundColor = scope:Computed(function(use)
return if use(isActive) then use(Theme.Color.Primary) else use(Theme.Color.Neutral)
end),
layoutOrder = tabIdx,
clipsDescendants = true,
onActivate = function()
local prev = Fusion.peek(activeTab)
if prev == tabIdx then return end
activeTab:set(tabIdx)
if onTabChange then
onTabChange(tabIdx, prev)
end
end,

[Children] = {
scope:New "UIFlexItem" {
FlexMode = scope:Computed(function(use)
return if use(collapseInactive) == true and use(isActive)
then Enum.UIFlexMode.None
else Enum.UIFlexMode.Fill
end),
},
scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
scope:New "UIPadding" {
PaddingTop = scope:Computed(function(use)
return UDim.new(0, if use(collapseInactive) == true then 8 else 6)
end),
PaddingBottom = scope:Computed(function(use)
return UDim.new(0, if use(collapseInactive) == true then 8 else 6)
end),
PaddingBottom = scope:Computed(function(use)
return UDim.new(0, if use(collapseInactive) == true then 8 else 6)
end),
PaddingBottom = scope:Computed(function(use)
return UDim.new(0, if use(collapseInactive) == true then 8 else 6)
end),
PaddingLeft = scope:Computed(function(use)
return UDim.new(0, if use(isCollapsed) then 0 else 16)
end),
PaddingRight = scope:Computed(function(use)
return UDim.new(0, if use(isCollapsed) then 0 else 16)
end),
},
scope:New "UIListLayout" {
FillDirection = Enum.FillDirection.Horizontal,
HorizontalAlignment = Enum.HorizontalAlignment.Center,
SortOrder = Enum.SortOrder.LayoutOrder,
VerticalAlignment = Enum.VerticalAlignment.Center,
},

scope:New "UIStroke" {
ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
Color = scope:Computed(function(use)
return if use(isActive) then use(Theme.Color.Primary) else use(Theme.Color.NeutralStroke)
end),
[Children] = {
scope:New "UIGradient" {
Color = scope:Computed(function(use)
if use(isActive) then
local primary = use(Theme.Color.Primary)
return ColorSequence.new({
ColorSequenceKeypoint.new(0, primary:Lerp(Color3.new(1, 1, 1), 0.1)),
ColorSequenceKeypoint.new(1, primary),
})
else
return ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
})
end
end),
Rotation = 90,
},
},
},

scope:New "Frame" {
Name = "IconText",
AutomaticSize = scope:Computed(function(use)
return if use(collapseInactive) == true then Enum.AutomaticSize.X else Enum.AutomaticSize.XY
end),
Size = scope:Computed(function(use)
return if use(collapseInactive) == true then UDim2.fromOffset(0, 18) else UDim2.new()
end),
BackgroundTransparency = 1,
[Children] = {
scope:New "UIListLayout" {
FillDirection = Enum.FillDirection.Horizontal,
HorizontalAlignment = Enum.HorizontalAlignment.Center,
Padding = UDim.new(0, 4),
SortOrder = Enum.SortOrder.LayoutOrder,
VerticalAlignment = Enum.VerticalAlignment.Center,
},
if tab.icon ~= nil
then scope:New "ImageLabel" {
Name = "Icon",
BackgroundTransparency = 1,
Image = tab.icon,
ImageColor3 = scope:Computed(function(use)
return if use(isActive)
then use(Theme.Color.PrimaryContent)
else use(Theme.Color.NeutralContentDark)
end),
Size = UDim2.fromOffset(18, 18),
}
else nil,
scope:New "TextLabel" {
Name = "Label",
AutomaticSize = Enum.AutomaticSize.XY,
BackgroundTransparency = 1,
Visible = scope:Computed(function(use)
return not use(isCollapsed)
end),
FontFace = scope:Computed(function(use)
return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
end),
Text = tab.label,
TextColor3 = scope:Computed(function(use)
return if use(isActive)
then use(Theme.Color.PrimaryContent)
else use(Theme.Color.NeutralContentDark)
end),
TextSize = Theme.TextSize.Subtitle,
TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Top,
},
},
},
},
}))
end

return scope:New "Frame" {
Name = "TabBar",
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
LayoutOrder = props.layoutOrder or 0,
Size = UDim2.new(1, 0, 0, 0),
[Children] = tabButtons,
}
end