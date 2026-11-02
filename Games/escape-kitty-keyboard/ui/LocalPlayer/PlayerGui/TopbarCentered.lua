-- Generated from ui/LocalPlayer/PlayerGui/TopbarCentered.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("ScreenGui", nil, "TopbarCentered", { DisplayOrder = 10, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Holders", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 56) })
			I[3] = new("ScrollingFrame", I[2], "Center", { AutomaticCanvasSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(0, 0, 1, -1), ElasticBehavior = Enum.ElasticBehavior.Never, ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.X, ScrollingEnabled = false, Selectable = false, Size = UDim2.new(1, -24, 1, 0) }, { ["IsAHolder"] = true })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
	return I[1]
end

return build
