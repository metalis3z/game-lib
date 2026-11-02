-- Generated from ui/ReplicatedStorage/LevelDisplayUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LevelDisplayUI", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "LevelDisplayUI", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.01, 1), Size = UDim2.fromScale(0.2, 0.2) })
			I[3] = new("TextLabel", I[2], "LevelLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.0925508, 0.2832554), Size = UDim2.fromScale(1.3, 0.395), Text = "Level", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 60, TextXAlignment = Enum.TextXAlignment.Left })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
				I[5] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
			I[6] = new("TextLabel", I[2], "MoneyLabel", { AnchorPoint = Vector2.new(0, 1), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.new(-0.0498101, 10, 1.497227, -60), Size = UDim2.fromScale(0.4, 0.571), Text = "$1", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 60, TextXAlignment = Enum.TextXAlignment.Left })
				I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[8] = new("UIStroke", I[6], "UIStroke", { Thickness = 3 })
			I[9] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4070275, 0.1657177), Size = UDim2.fromScale(0.8302101, 0.3925886), Text = "LEVEL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
				I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 3 })
			I[11] = new("UIScale", I[2], "UIScale")
	return I[1]
end

return build
