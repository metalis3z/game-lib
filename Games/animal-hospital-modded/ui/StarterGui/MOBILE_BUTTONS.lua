-- Generated from ui/StarterGui/MOBILE_BUTTONS.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MOBILE_BUTTONS", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Cam", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.1981379, 0.1438463), Size = UDim2.fromOffset(40, 43) })
			I[3] = new("TextButton", I[2], "Base", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 170, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0166667, 0.0166667), Size = UDim2.fromScale(1, 0.9999999), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[4] = new("TextLabel", I[3], "BUTTON_NAME", { BackgroundColor3 = Color3.fromRGB(255, 129, 2), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 129, 2), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0166667, 0.0166667), Size = UDim2.fromScale(0.9666666, 0.9666666), Text = "Cam", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 45, TextStrokeTransparency = 0.75, TextWrapped = true, ZIndex = 3 })
					I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 18 })
					I[6] = new("UIStroke", I[4], "UIStroke", { Thickness = 2 })
				I[7] = new("UITextSizeConstraint", I[3], "UITextSizeConstraint", { MaxTextSize = 14 })
				I[8] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.370242, Color3.fromRGB(85, 255, 255)), ColorSequenceKeypoint.new(0.589965, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.740933, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Offset = Vector2.new(0, 0.05), Rotation = 100, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0878187, 0), NumberSequenceKeypoint.new(0.206983, 0.73125), NumberSequenceKeypoint.new(0.292493, 0), NumberSequenceKeypoint.new(0.369077, 0.75), NumberSequenceKeypoint.new(0.458853, 0), NumberSequenceKeypoint.new(0.687032, 0.51875), NumberSequenceKeypoint.new(0.924221, 0), NumberSequenceKeypoint.new(1, 0.1625) }) })
				I[9] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 3), BottomRightRadius = UDim.new(1, 3), TopLeftRadius = UDim.new(1, 3), TopRightRadius = UDim.new(1, 3) })
			I[10] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(24, 24, 24), Thickness = 4 })
			I[11] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(1, 3), BottomRightRadius = UDim.new(1, 3), TopLeftRadius = UDim.new(1, 3), TopRightRadius = UDim.new(1, 3) })
	return I[1]
end

return build
