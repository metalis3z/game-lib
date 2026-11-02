-- Generated from ui/StarterGui/CutsceneUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CutsceneUI", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "2v53SHNH2v53" })
		I[2] = new("Frame", I[1], "Black", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1, 1.1), Visible = false }, { ["_lemonadeUniqueId"] = "nBZsnArfnBZs" })
		I[3] = new("ImageLabel", I[1], "Vignette", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://104574024062008"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 10 }, { ["_lemonadeUniqueId"] = "NAyF9y0wNAyF" })
		I[4] = new("Frame", I[1], "MonstersAreComing", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false }, { ["_lemonadeUniqueId"] = "TTTmLc1nTTTm" })
			I[5] = new("ImageLabel", I[4], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139288615872038"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false }, { ["OldId"] = "rbxassetid://103383580093445", ["_lemonadeUniqueId"] = "tD5yeJvVtD5y" })
				I[6] = new("UIGradient", I[5], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "I0s0QdPJI0s0" })
			I[7] = new("TextLabel", I[4], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.3872332), RichText = true, Size = UDim2.fromScale(0.4000002, 0.1089494), Text = "MONSTERS ARE", TextColor3 = Color3.fromRGB(137, 188, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "mcQ9we7PmcQ9" })
				I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(151, 201, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 138, 138)) }), Rotation = -90 }, { ["_lemonadeUniqueId"] = "i951gUwIi951" })
				I[9] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(46, 25, 116), Thickness = 3 }, { ["_lemonadeUniqueId"] = "1g2JT1yY1g2J" })
					I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(151, 201, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 138, 138)) }), Rotation = -90 }, { ["_lemonadeUniqueId"] = "PFXltzN9PFXl" })
			I[11] = new("TextLabel", I[4], "SubTitle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4961827), RichText = true, Size = UDim2.fromScale(0.4000002, 0.1559103), Text = "COMING...", TextColor3 = Color3.fromRGB(137, 188, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "MipiXm0MMipi" })
				I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(151, 201, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 138, 138)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "T9a2SsiAT9a2" })
				I[13] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(46, 25, 116), Thickness = 3 }, { ["_lemonadeUniqueId"] = "tcXbv1LRtcXb" })
					I[14] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(151, 201, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 138, 138)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "QZnSitUoQZnS" })
			I[15] = new("TextLabel", I[4], "TimeRemaining", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8146552), RichText = true, Size = UDim2.fromScale(0.5, 0.05), Text = "6:23:59:57", TextColor3 = Color3.fromRGB(0, 242, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "HPY4rlMwHPY4" })
				I[16] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(3, 230, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 107, 138)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "ZZGxYvawZZGx" })
				I[17] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(19, 93, 116), Thickness = 3 }, { ["_lemonadeUniqueId"] = "435GwhmK435G" })
	return I[1]
end

return build
