-- Generated from ui/ReplicatedStorage/Assets/Billboards/NightEggTimeSkip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "NightEggTimeSkip", { Active = true, AlwaysOnTop = true, Brightness = 2, ClipsDescendants = true, MaxDistance = 150, ResetOnSpawn = false, Size = UDim2.fromScale(20, 5), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "xiHZkqYUxiHZ" })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.6), ZIndex = -1 }, { ["_lemonadeUniqueId"] = "32on8E7p32on" })
			I[3] = new("ImageLabel", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4, 1.2) }, { ["_lemonadeUniqueId"] = "FOefYuBJFOef" })
				I[4] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131317614803230"), Position = UDim2.fromScale(0.4771324, 0.4472229), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 1.006) }, { ["_lemonadeUniqueId"] = "g3IRKAugg3IR" })
			I[5] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 1.3) }, { ["_lemonadeUniqueId"] = "NaDxBNYcNaDx" })
				I[6] = new("TextLabel", I[5], "DisplayName", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.75, 0.3), RichText = true, Size = UDim2.fromScale(0.5, 0.3), Text = "Egg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 45, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "jMJ5zGSojMJ5" })
					I[7] = new("UIStroke", I[6], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "1qePtg5h1qeP" })
				I[8] = new("UIListLayout", I[5], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "Gd89AVAqGd89" })
				I[9] = new("Frame", I[5], "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 3, Position = UDim2.fromScale(0.75, 0.8), Size = UDim2.fromScale(1, 0.3) }, { ["_lemonadeUniqueId"] = "XyQz18ASXyQz" })
					I[10] = new("TextLabel", I[9], "Multiplier", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(0.7, 0.94), RichText = true, Size = UDim2.fromScale(0.5, 0.85), Text = "(x30)", TextColor3 = Color3.fromRGB(0, 255, 8), TextScaled = true, TextSize = 45, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom }, { ["_lemonadeUniqueId"] = "qWzMzi8kqWzM" })
						I[11] = new("UIStroke", I[10], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "SnW6gK42SnW6" })
					I[12] = new("TextLabel", I[9], "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.75, 0.8), RichText = true, Size = UDim2.fromScale(0, 1), Text = "3m10s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 45, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom }, { ["_lemonadeUniqueId"] = "wvS1xr0QwvS1" })
						I[13] = new("UIStroke", I[12], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "EHsGH5SYEHsG" })
					I[14] = new("UIListLayout", I[9], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom }, { ["_lemonadeUniqueId"] = "tb6RF4Tjtb6R" })
	return I[1]
end

return build
