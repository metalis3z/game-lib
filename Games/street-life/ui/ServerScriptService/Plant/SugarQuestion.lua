-- Generated from ui/ServerScriptService/Plant/SugarQuestion.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SugarQuestion", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Question", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.05, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.499613, 0.5), Size = UDim2.fromScale(0.2134826, 0.2604403) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
			I[5] = new("TextLabel", I[2], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0171143, 0.025816), Size = UDim2.fromScale(0.962919, 0.3038917), Text = "How much do you want to process?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UIStroke", I[5], "UIStroke")
			I[7] = new("TextButton", I[2], "5", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(200, 200, 200), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.9402789, 0.2247094), Text = "5 Plants", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UIStroke", I[7], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[9] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 50, MinTextSize = 10 })
				I[10] = new("UICorner", I[7], "UICorner")
				I[11] = new("UIStroke", I[7], "UIStroke", { Thickness = 2 })
			I[12] = new("TextButton", I[2], "15", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(200, 200, 200), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.85), Size = UDim2.fromScale(0.940279, 0.2247094), Text = "15 Plants", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[13] = new("UIStroke", I[12], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[14] = new("UITextSizeConstraint", I[12], "UITextSizeConstraint", { MaxTextSize = 50, MinTextSize = 10 })
				I[15] = new("UICorner", I[12], "UICorner")
				I[16] = new("UIStroke", I[12], "UIStroke", { Thickness = 2 })
			I[17] = new("TextLabel", I[2], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7766103, 0.706997), Rotation = 15, Size = UDim2.fromScale(0.315961, 0.1404379), Text = "RECOMMENDED ", TextColor3 = Color3.fromRGB(46, 255, 220), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build
