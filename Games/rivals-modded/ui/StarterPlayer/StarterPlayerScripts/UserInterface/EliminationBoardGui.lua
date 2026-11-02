-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/EliminationBoardGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "EliminationBoardGui", { Brightness = 1.5, ClipsDescendants = true, MaxDistance = 200, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.0875), Size = UDim2.fromScale(1, 0.12), Text = "Eliminations     • LIVE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[3] = new("ImageLabel", I[1], "Hover", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14801518504"), Position = UDim2.fromScale(0.5, 0.55), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9, 0.75), SliceCenter = Rect.new(128, 128, 128, 128), SliceScale = 0.5 })
		I[4] = new("ScrollingFrame", I[1], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740413"), CanvasSize = UDim2.fromScale(0, 0), MidImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740296"), Position = UDim2.fromScale(0.5, 0.55), ScrollBarThickness = 20, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(0.84, 0.66), TopImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740150"), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
			I[5] = new("Frame", I[4], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, -20, 1, -20), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[6] = new("UIGridLayout", I[5], "Layout", { CellPadding = UDim2.fromOffset(8, 8), CellSize = UDim2.new(0.5, -4, 0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder })
		I[7] = new("ImageLabel", I[1], "LiveBackground", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://13970862697"), Position = UDim2.fromScale(0.76, 0.0875), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.27, 0.16), SliceCenter = Rect.new(31, 31, 31, 31), SliceScale = 0.5, ZIndex = 0 })
	return I[1]
end

return build
