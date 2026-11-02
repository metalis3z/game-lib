-- Generated from ui/StarterGui/ScreenGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ScreenGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "Revives", { BackgroundColor3 = Color3.fromRGB(217, 157, 217), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73393999354784"), Position = UDim2.fromScale(0.0065753, 0.4792387), Size = UDim2.fromOffset(73, 70) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.9), Size = UDim2.fromOffset(73, 20), Text = "Revives", TextColor3 = Color3.fromRGB(241, 241, 241), TextScaled = true, TextSize = 28, TextStrokeColor3 = Color3.fromRGB(222, 65, 206), TextWrapped = true })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) })
		I[5] = new("ImageButton", I[1], "Invite", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://84984692200461"), Position = UDim2.fromScale(0.0071233, 0.3200692), Size = UDim2.fromOffset(73, 70) })
			I[6] = new("TextLabel", I[5], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.8607595), Size = UDim2.fromOffset(73, 17), Text = "Invite", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[7] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
	return I[1]
end

return build
