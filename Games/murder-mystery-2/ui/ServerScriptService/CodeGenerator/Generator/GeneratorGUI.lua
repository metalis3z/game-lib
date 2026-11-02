-- Generated from ui/ServerScriptService/CodeGenerator/Generator/GeneratorGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GeneratorGUI")
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(0.5, -250, 0.5, -75), Size = UDim2.fromOffset(500, 150), Style = Enum.FrameStyle.DropShadow })
			I[3] = new("Frame", I[2], "BG", { Active = true, BackgroundColor3 = Color3.fromRGB(40, 40, 40), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(50, 50, 50), Size = UDim2.fromScale(1, 1) })
			I[4] = new("TextButton", I[2], "Generate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -100, 1, -60), Size = UDim2.fromOffset(200, 50), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "Generate", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7, ZIndex = 2 })
			I[5] = new("TextLabel", I[2], "Code", { BackgroundColor3 = Color3.fromRGB(43, 43, 43), BorderColor3 = Color3.fromRGB(17, 17, 17), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -150, 0, 10), Size = UDim2.fromOffset(300, 50), Text = "Click Generate", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36 })
	return I[1]
end

return build
