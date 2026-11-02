-- Generated from ui/StarterPlayer/StarterPlayerScripts/Elements/ItemButton/label.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "label", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0, 0.146) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.35, 0), BottomRightRadius = UDim.new(0.35, 0), TopLeftRadius = UDim.new(0.35, 0), TopRightRadius = UDim.new(0.35, 0) })
		I[3] = new("TextLabel", I[1], "value", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(43, 45, 51), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.9), Text = "3,168/6,000 left", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["relativeMargin"] = 1 }, { "ScaledTextSizeAutomaticSizeFix" })
			I[4] = new("UICorner", I[3], "UICorner")
	return I[1]
end

return build
