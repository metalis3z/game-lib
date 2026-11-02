-- Generated from ui/ReplicatedFirst/UISelector/LoadingS2/Loading.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Loading", { DisplayOrder = 15, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(8, 8, 8), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 8 })
			I[3] = new("Frame", I[2], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
				I[4] = new("ImageLabel", I[3], "Grey", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15587895429"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 9 })
				I[5] = new("ImageLabel", I[3], "Color", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15587874912"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 6 })
				I[6] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
				I[7] = new("TextLabel", I[3], "LoadingText", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370747", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.1), Text = "Loading...", TextColor3 = Color3.fromRGB(71, 71, 71), TextScaled = true, TextSize = 42, TextWrapped = true, Visible = false, ZIndex = 10 })
			I[8] = new("Frame", I[2], "LoadingBar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.8), Size = UDim2.fromScale(1, 0.07), Visible = false, ZIndex = 10 })
				I[9] = new("Frame", I[8], "BarContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 18), BorderColor3 = Color3.fromRGB(53, 53, 53), BorderSizePixel = 5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4, 0.7), ZIndex = 10 })
					I[10] = new("Frame", I[9], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(72, 77, 70), BorderColor3 = Color3.fromRGB(35, 35, 35), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0, 1), ZIndex = 11 })
					I[11] = new("TextLabel", I[9], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Loading Inventory...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.3, TextWrapped = true, ZIndex = 12 })
	return I[1]
end

return build
