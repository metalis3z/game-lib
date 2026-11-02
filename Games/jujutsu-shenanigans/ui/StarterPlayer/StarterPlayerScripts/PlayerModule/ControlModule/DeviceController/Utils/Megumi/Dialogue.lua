-- Generated from ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Megumi/Dialogue.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Dialogue", { Active = true, MaxDistance = math.huge, Size = UDim2.fromScale(15, 15), StudsOffset = Vector3.new(0, 0, 2), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Chat1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.fromScale(0.65, 0.4), Size = UDim2.fromScale(0.15, 0.15) })
			I[3] = new("TextLabel", I[2], "Sub", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.85, 0.9), Text = "OH      WHATEVER... HERE WE GO!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
		I[4] = new("TextLabel", I[1], "Text2", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.7, 0.65), Size = UDim2.fromScale(0.2, 0.1), Text = "WITH NO BOUNDARIES!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
			I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 1 })
		I[6] = new("TextLabel", I[1], "Text1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.3, 0.25), Size = UDim2.fromScale(0.2, 0.1), Text = "PICTURE IT IN YOUR HEAD!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
			I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 1 })
	return I[1]
end

return build
