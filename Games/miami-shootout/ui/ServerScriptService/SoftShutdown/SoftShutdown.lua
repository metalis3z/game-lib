-- Generated from ui/ServerScriptService/SoftShutdown/SoftShutdown.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SoftShutdown", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("ImageLabel", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(61, 61, 61), BackgroundTransparency = 0.2, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://357069578"), Position = UDim2.new(0.5, -250, 0.362963, -60), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(500, 342), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.08, ZIndex = 999 })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 20), Size = UDim2.new(1, 0, 0, 30), Text = "SERVER SHUTDOWN", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36, TextStrokeTransparency = 0, ZIndex = 999 })
			I[4] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 50), Size = UDim2.new(1, 0, 0, 50), Text = "Rebooting servers for an update.", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), ZIndex = 999 })
			I[5] = new("UICorner", I[2], "UICorner")
			I[6] = new("UICorner", I[2], "UICorner")
	return I[1]
end

return build
