-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/CommunityOutfitsController/filter.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "filter", { AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.0499998), Size = UDim2.fromScale(0.1125526, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 }, nil, { "UIEffectSoundOnly" })
		I[2] = new("TextLabel", I[1], "label", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.0642373, 0.4999997), RichText = true, Size = UDim2.fromScale(0.268564, 0.9), Text = "By asd asaaaaaaaaaaaaa", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 24, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["relativeMargin"] = 1 }, { "ScaledTextSizeAutomaticSizeFix" })
		I[3] = new("ImageLabel", I[1], "icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(-0.0000007, 0.4999998), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.1961422, 0.7), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[4] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[5] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
