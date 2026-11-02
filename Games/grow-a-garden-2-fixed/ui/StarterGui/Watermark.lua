-- Generated from ui/StarterGui/Watermark.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Watermark", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658237174", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "@frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers @frrazers", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextTransparency = 0.98, TextWrapped = true })
		I[3] = new("TextLabel", I[1], "SessionID", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658237174", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.02, 0.1113861), Size = UDim2.fromScale(0.9622257, 0.0301467), Text = "Session ID - dbd4d1f0-e0c0-460c-a0c7-eb374c3c0477", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextTransparency = 0.8, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[4] = new("TextLabel", I[1], "AccountID", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658237174", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.02, 0.1425377), Size = UDim2.fromScale(0.9622257, 0.0301467), Text = "Account ID - 4585391", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextTransparency = 0.8, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
