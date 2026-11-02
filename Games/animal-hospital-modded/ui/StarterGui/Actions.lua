-- Generated from ui/StarterGui/Actions.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Actions", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "inv", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.213218, 0.6714836), Selectable = true, SelectionGroup = true, Size = UDim2.fromScale(0.166701, 0.4421961) })
			I[3] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
			I[4] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(252, 252, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 165, 167)) }), Rotation = 90 })
			I[5] = new("ScrollingFrame", I[2], "ActionFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.025884, 0.0804254), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.9375836, 0.8944056) })
				I[6] = new("UICorner", I[5], "UICorner")
				I[7] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[8] = new("ImageButton", I[5], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.1610183, 0.4217968), SelectionGroup = true, Size = UDim2.fromOffset(195, 50), Visible = false })
					I[9] = new("UIStroke", I[8], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
					I[10] = new("TextLabel", I[8], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000959, 0.4982209), Size = UDim2.fromScale(1.0062175, 0.996443), Text = "TEMPLATE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
						I[11] = new("UIStroke", I[10], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
						I[12] = new("UIPadding", I[10], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
					I[13] = new("UIGradient", I[8], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
				I[14] = new("UIGridLayout", I[5], "UIGridLayout", { CellPadding = UDim2.fromScale(-0.025, 0.01), CellSize = UDim2.fromScale(1, 0.1), FillDirectionMaxCells = 5 })
			I[15] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.7511886 })
		I[16] = new("TextLabel", I[1], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2122463, 0.4480886), Size = UDim2.fromScale(0.1324304, 0.0506072), Text = "Actions", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
			I[17] = new("UIStroke", I[16], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
			I[18] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint", { AspectRatio = 4.5210814 })
			I[19] = new("UIPadding", I[16], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
	return I[1]
end

return build
