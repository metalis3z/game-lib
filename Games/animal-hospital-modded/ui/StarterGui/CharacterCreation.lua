-- Generated from ui/StarterGui/CharacterCreation.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CharacterCreation", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "inv", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.1725676, 0.522815), Selectable = true, SelectionGroup = true, Size = UDim2.fromScale(0.446821, 0.8430836) })
			I[3] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
			I[4] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(252, 252, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 165, 167)) }), Rotation = 90 })
			I[5] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.7511886 })
			I[6] = new("TextLabel", I[2], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4995483, 0.4998498), Size = UDim2.fromScale(0.6369609, 0.56769), Text = "Still a WIP! Come back soon!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
				I[7] = new("UIStroke", I[6], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
				I[8] = new("UIPadding", I[6], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
			I[9] = new("TextButton", I[2], "close", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(207, 26, 38), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9827774, 0.0133232), Size = UDim2.fromScale(0.1076109, 0.0773268), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
				I[11] = new("UIStroke", I[9], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 14, 0), Thickness = 2 })
	return I[1]
end

return build
