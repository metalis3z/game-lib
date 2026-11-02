-- Generated from ui/ReplicatedStorage/Resources/LegacyReplication/Death.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Death", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://12717783355"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[3] = new("ScrollingFrame", I[2], "TitlesSF", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 1000), Position = UDim2.fromScale(0.5, 0.4999999), ScrollBarThickness = 6, Size = UDim2.fromScale(0.96, 0.9999999), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar, Visible = false })
				I[4] = new("UIGridLayout", I[3], "UIGridLayout", { CellPadding = UDim2.fromOffset(60, 7), CellSize = UDim2.fromScale(0.95, 0.075), FillDirectionMaxCells = 1, SortOrder = Enum.SortOrder.LayoutOrder })
				I[5] = new("TextButton", I[3], "TextButton", { BackgroundColor3 = Color3.fromRGB(24, 24, 24), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Size = UDim2.fromOffset(200, 50), Text = "OWNER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
					I[6] = new("Frame", I[5], "Frame", { BackgroundColor3 = Color3.fromRGB(130, 255, 116), BackgroundTransparency = 0.2, BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -2), Size = UDim2.new(1, 0, 0, 2), ZIndex = 2 })
					I[7] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 14 })
					I[8] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 20.2666664 })
	return I[1]
end

return build
