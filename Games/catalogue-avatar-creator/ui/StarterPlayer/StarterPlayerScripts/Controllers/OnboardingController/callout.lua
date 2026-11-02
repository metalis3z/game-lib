-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/OnboardingController/callout.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "callout", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromOffset(400, 0) }, { ["SkipTheme"] = true })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.18, 0), BottomRightRadius = UDim.new(0.18, 0), TopLeftRadius = UDim.new(0.18, 0), TopRightRadius = UDim.new(0.18, 0) })
		I[3] = new("Frame", I[1], "content", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0), ZIndex = 2 })
			I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0, 18), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 18), PaddingTop = UDim.new(0, 16) })
			I[5] = new("TextLabel", I[3], "label", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Size = UDim2.new(1, -36, 0, 0), Text = "Create your dream avatar here", TextColor3 = Color3.fromRGB(25, 25, 32), TextSize = 40, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
			I[6] = new("TextButton", I[3], "closeButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(24, 24), Text = "", ZIndex = 3 }, nil, { "UIEffect" })
				I[7] = new("ImageLabel", I[6], "icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(25, 25, 32), ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8), ZIndex = 3 }, { ["SkipTheme"] = true })
		I[8] = new("ImageLabel", I[1], "caret", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://102739113285028"), Size = UDim2.fromOffset(22, 15) }, { ["SkipTheme"] = true, ["SkipThemeImage"] = true })
	return I[1]
end

return build
