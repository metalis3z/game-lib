-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/CatalogController/horizontalScrollCategoryButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "horizontalScrollCategoryButton", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000033, 0.5), RichText = true, Size = UDim2.fromScale(0, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "", TextColor3 = Color3.fromRGB(244, 244, 244), TextSize = 14, TextWrapped = true }, { ["margin"] = 3 }, { "UIEffectSoundOnly" })
		I[2] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0.125, 0), PaddingTop = UDim.new(0.125, 0) })
		I[3] = new("TextLabel", I[1], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(-0.2973991, 150, 0.8999999, 0), Text = "Hair", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.35, TextWrapped = true }, nil, { "ScaledTextSizeAutomaticSizeFix" })
	return I[1]
end

return build
