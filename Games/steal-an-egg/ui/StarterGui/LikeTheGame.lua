-- Generated from ui/StarterGui/LikeTheGame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LikeTheGame", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "TopBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.442939, 0.1222222) })
			I[3] = new("Frame", I[2], "InPlot", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.544516) })
				I[4] = new("TextLabel", I[3], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4934393, 2.2564888), RichText = true, Size = UDim2.fromScale(1, 1), Text = "🔥 JOIN DISCORD FOR FREE MODERATOR + CMDS ! 🔥", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[5] = new("UIStroke", I[4], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
					I[6] = new("UIGradient", I[4], "ModdedRainbow", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 127)) }), Offset = Vector2.new(0, 0.1), Rotation = -16 })
				I[7] = new("TextLabel", I[3], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4998514, 2.9095109), RichText = true, Size = UDim2.fromScale(0.9428434, 1.0129414), Text = "🎮 JOIN OUR DISCORD SERVER FOR FREE MODERATOR ROLE + COMMANDS! 🔥", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[8] = new("UIStroke", I[7], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
					I[9] = new("UIGradient", I[7], "ModdedRainbow", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 127)) }), Offset = Vector2.new(0, 0.1), Rotation = -16 })
			I[10] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 6.439394 })
	return I[1]
end

return build
