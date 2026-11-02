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
	I[1] = new("ScreenGui", nil, "ScreenGui")
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(118, 118, 118), BorderColor3 = Color3.fromRGB(66, 66, 66), BorderSizePixel = 5, Position = UDim2.fromScale(0.3, 0.005), Size = UDim2.fromOffset(140, 50) })
			I[3] = new("TextBox", I[2], "TextBox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Code", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeColor3 = Color3.fromRGB(50, 50, 50), TextStrokeTransparency = 0.3 })
			I[4] = new("TextButton", I[2], "GO", { BackgroundColor3 = Color3.fromRGB(63, 147, 49), BorderColor3 = Color3.fromRGB(42, 97, 32), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(150, 0), Size = UDim2.fromOffset(50, 50), Text = "Enter", TextColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.6 })
	return I[1]
end

return build
