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
		I[2] = new("ImageLabel", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(61, 61, 61), BackgroundTransparency = 0.2, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://357069578"), Position = UDim2.fromScale(0.5, 0.1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.2640264, 0.1598466), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.08, ZIndex = 999 })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.28125), Text = "SERVER SHUTDOWN", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36, TextStrokeTransparency = 0, ZIndex = 999 })
			I[4] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.28125), Size = UDim2.fromScale(1, 0.3909801), Text = "Rebooting servers for an update.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, ZIndex = 999 })
				I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[6] = new("UICorner", I[2], "UICorner")
			I[7] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
			I[8] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.7265625), Size = UDim2.fromScale(1, 0.2734375), Text = ".gg/StreetLife", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), ZIndex = 999 })
				I[9] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 50, MinTextSize = 30 })
	return I[1]
end

return build
