-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/DropdownSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "DropdownSlot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromOffset(692, 654), Size = UDim2.fromOffset(461, 154), ZIndex = 2 })
		I[2] = new("ImageLabel", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7730822940"), Position = UDim2.fromOffset(-6, -6), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 18, 1, 12), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
		I[3] = new("ScrollingFrame", I[1], "List", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, BottomImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740413"), CanvasSize = UDim2.fromOffset(0, 5000), MidImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740296"), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 5, ScrollingDirection = Enum.ScrollingDirection.Y, Selectable = false, Size = UDim2.new(1, 6, 5, 0), TopImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740150"), VerticalScrollBarInset = Enum.ScrollBarInset.Always })
			I[4] = new("Frame", I[3], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, -6, 0.113, 0), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[5] = new("UIGridLayout", I[4], "Layout", { CellPadding = UDim2.fromScale(0, 0), CellSize = UDim2.fromScale(1, 1), SortOrder = Enum.SortOrder.LayoutOrder })
	return I[1]
end

return build
