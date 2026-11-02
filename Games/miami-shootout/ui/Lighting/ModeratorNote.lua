-- Generated from ui/Lighting/ModeratorNote.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ModeratorNote", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(48, 48, 48), BackgroundTransparency = 0.35, Position = UDim2.fromScale(0.2362205, 0.2668329), Size = UDim2.fromScale(0.527559, 0.4650873) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1376451, 0), Size = UDim2.fromScale(0.7247098, 0.1581769), Text = "🚨 THA BRONX - MODERATOR NOTE 🚨", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 32 })
			I[6] = new("TextLabel", I[2], "Warning", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2968491, 0.1581769), Size = UDim2.fromScale(0.4046434, 0.1635389), Text = "You have received a warning from Game Staff:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 52 })
			I[8] = new("TextLabel", I[2], "WarnMsg", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.2504146, 0.3217158), Size = UDim2.fromScale(0.4975124, 0.2010724), Text = "\"\"", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[9] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 75 })
			I[10] = new("TextButton", I[2], "OkButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.75, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3333333, 0.6380697), Size = UDim2.fromScale(0.331675, 0.1340483), Text = "OK", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[11] = new("UICorner", I[10], "UICorner")
				I[12] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 50 })
			I[13] = new("TextLabel", I[2], "Timer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3088549, 0.7828418), Size = UDim2.fromScale(0.3797678, 0.152815), Text = "[timer]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[14] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 57 })
			I[15] = new("TextLabel", I[2], "Abide", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.2512191, 0.5227882), Size = UDim2.fromScale(0.4975124, 0.077748), Text = "Please abide by the game rules. Repeated offenses may result in harsher punishment.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[16] = new("UITextSizeConstraint", I[15], "UITextSizeConstraint", { MaxTextSize = 28 })
		I[17] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.425187 })
	return I[1]
end

return build
