-- Generated from ui/StarterGui/LoadingGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LoadingGui", { DisplayOrder = 1, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.None })
		I[2] = new("Frame", I[1], "LoadingScreen", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Interactable = false, LayoutOrder = 1, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 100 })
			I[3] = new("TextLabel", I[2], "YouDied", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2411881, 0.4463734), RichText = true, Size = UDim2.fromScale(0.5160261, 0.1064733), Text = "LOADING...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 6 })
			I[4] = new("ImageLabel", I[2], "Frame2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=16860272249"), Position = UDim2.fromScale(0, 0.8835725), Size = UDim2.fromScale(1, 0.1163304), ZIndex = 5 })
				I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 175)), ColorSequenceKeypoint.new(0.5025907, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(175, 175, 175)) }) })
			I[6] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(81, 81, 81), ImageContent = Content.fromUri("rbxassetid://11856753007"), Position = UDim2.fromScale(0, -0.2), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1.1855493), ZIndex = 4 })
				I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(0.5060449, Color3.fromRGB(249, 249, 249)), ColorSequenceKeypoint.new(1, Color3.fromRGB(49, 49, 49)) }) })
	return I[1]
end

return build
