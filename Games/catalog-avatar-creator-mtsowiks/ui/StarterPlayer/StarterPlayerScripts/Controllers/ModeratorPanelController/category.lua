-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/ModeratorPanelController/category.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "category", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(254, 254, 255), BackgroundTransparency = 0.9, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 46), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true }, nil, { "UIEffectSoundOnly" })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
		I[3] = new("TextLabel", I[1], "label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -28, 1, 0), Text = "Community Outfit Reports", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22, TextTransparency = 0.1, TextXAlignment = Enum.TextXAlignment.Left }, { ["relativeMargin"] = 1.5 })
	return I[1]
end

return build
