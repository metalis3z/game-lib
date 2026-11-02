-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/CreateAvatarController/SkinToneStage/hexBox.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "hexBox", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1506154, 0.5), Size = UDim2.fromScale(0.392204, 1) }, { ["SkipTheme"] = true })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) }, { ["SkipTheme"] = true })
		I[3] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(33, 34, 39), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.03 }, { ["SkipTheme"] = true })
		I[4] = new("TextBox", I[1], "input", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(70, 68, 77), PlaceholderText = "Enter HEX, RGB, etc.", Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["SkipTheme"] = true })
	return I[1]
end

return build
