-- Generated from ui/ServerScriptService/PoliceScripts/NYPDBC.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "NYPDBC", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Bodycam", { BackgroundColor3 = Color3.fromRGB(53, 53, 53), BackgroundTransparency = 0.4, Position = UDim2.fromScale(0.6330974, 0.0162095), Size = UDim2.fromScale(0.2252252, 0.084788) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("ImageLabel", I[2], "Logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5167151324"), Position = UDim2.fromScale(0.6266667, -0.365126), Size = UDim2.fromScale(0.4133333, 1.8235294) })
			I[5] = new("TextLabel", I[2], "NYPD", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5781327, 0.5882353), Size = UDim2.fromScale(0.1233333, 0.4117647), Text = "NYPD", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 15 })
			I[7] = new("TextLabel", I[2], "TheirName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4481327, 0.3382353), Size = UDim2.fromScale(0.2533333, 0.4117647), Text = "@Player1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 20 })
			I[9] = new("TextLabel", I[2], "Recording", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0214661, 0.0882353), Size = UDim2.fromScale(0.2066667, 0.3382353), Text = "REC", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 23 })
			I[11] = new("Frame", I[2], "RECFrame", { BackgroundColor3 = Color3.fromRGB(255, 75, 82), Position = UDim2.fromScale(0.2066667, 0.0882353), Size = UDim2.fromScale(0.0766667, 0.3382353) })
				I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) })
			I[13] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4069059, 0.0260911), Size = UDim2.fromScale(0.32, 0.3970588), Text = "AXON BODY 2™", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[14] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 14 })
		I[15] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.6608479 })
	return I[1]
end

return build
