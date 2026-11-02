-- Generated from ui/ReplicatedStorage/Modules/EventTimerController/EventFrameTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "EventFrameTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Position = UDim2.fromScale(0.3372968, -0.0065896), Size = UDim2.fromScale(0.4323434, 1.0111704) })
		I[2] = new("TextLabel", I[1], "NameLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.081788, -0.1777264), Size = UDim2.fromScale(1.1633252, 0.3817596), Text = "Low Gravity", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["OriginalText"] = "Secret Lucky Block" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 })
		I[4] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[5] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139866299084982"), Position = UDim2.fromScale(0.0879853, 0.0869727), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8681757, 0.8153548) }, { ["MoonIcon"] = "rbxassetid://135035957472933", ["OGIcon"] = "rbxassetid://133391403342736" })
			I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
		I[7] = new("TextLabel", I[1], "DurationLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.8), Size = UDim2.fromScale(1, 0.275), Text = "3:00", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["OriginalText"] = "Secret Lucky Block" })
			I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build
