-- Generated from ui/StarterGui/Overlay.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Overlay", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "UpperText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.001227), Size = UDim2.fromOffset(242, 31), Text = "SITE EXCALIBUR | V.16 | FILTERING ENABLED", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true })
		I[3] = new("TextLabel", I[1], "LowerText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.0282209), Size = UDim2.fromOffset(95, 31), Text = "DOUBLE PRESS ", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[4] = new("TextLabel", I[3], "TextMiddle", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5494418, -0.0040372), Size = UDim2.fromOffset(99, 31), Text = "\"M\"", TextColor3 = Color3.fromRGB(170, 0, 0), TextSize = 14 })
			I[5] = new("TextLabel", I[3], "TextRight", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9969696, -0.0052642), Size = UDim2.fromOffset(95, 31), Text = "TO MENU", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
	return I[1]
end

return build
