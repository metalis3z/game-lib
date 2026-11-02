-- Generated from ui/StarterPlayer/StarterPlayerScripts/Elements/ItemButton/contextButtonsHeadShape.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "contextButtonsHeadShape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.358), Size = UDim2.fromScale(1, 0.716), ZIndex = 30 }, { ["SkipTheme"] = true })
		I[2] = new("TextButton", I[1], "tryOn", { AnchorPoint = Vector2.new(0.5, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.498, 0.9458326), Size = UDim2.fromScale(0.78, 0.25), Text = "Try On", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
			I[4] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingTop = UDim.new(0.15, 0) }, { ["SkipTheme"] = true })
		I[5] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) }, { ["SkipTheme"] = true })
		I[6] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize }, { ["SkipTheme"] = true })
	return I[1]
end

return build
