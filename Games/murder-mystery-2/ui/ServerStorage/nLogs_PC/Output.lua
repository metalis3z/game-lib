-- Generated from ui/ServerStorage/nLogs_PC/Output.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Output")
		I[2] = new("TextButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 300, 1, -50), Selectable = false, Size = UDim2.fromOffset(50, 50), SizeConstraint = Enum.SizeConstraint.RelativeYY, Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Logs", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 3 })
		I[3] = new("Frame", I[1], "Logs", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.new(0, 0, 0.5, -200), Size = UDim2.new(1, 0, 0, 400) })
			I[4] = new("Frame", I[3], "Old", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, Position = UDim2.fromScale(0, -1), Size = UDim2.fromScale(1, 1) })
			I[5] = new("ScrollingFrame", I[3], "Container", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 100), Position = UDim2.fromScale(0, -1), Size = UDim2.fromScale(1, 1) })
		I[6] = new("TextButton", I[1], "Button2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Modal = true, Position = UDim2.new(0, 350, 1, -50), Selectable = false, Size = UDim2.fromOffset(50, 50), SizeConstraint = Enum.SizeConstraint.RelativeYY, Style = Enum.ButtonStyle.RobloxRoundButton, Text = "HTTP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 3 })
	return I[1]
end

return build
