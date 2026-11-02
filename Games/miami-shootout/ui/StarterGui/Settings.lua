-- Generated from ui/StarterGui/Settings.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Settings", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(98, 98, 98), BackgroundTransparency = 0.45, Position = UDim2.fromScale(0.3493254, 0.3478803), Size = UDim2.fromScale(0.3013493, 0.3029925) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("TextButton", I[2], "cameraBobbing", { BackgroundColor3 = Color3.fromRGB(0, 170, 0), FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.2024695, 0.0781893), Size = UDim2.fromScale(0.5897589, 0.1975309), Text = "CAMERA BOBBING: ON", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[5] = new("UICorner", I[4], "UICorner")
				I[6] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 46 })
			I[7] = new("TextButton", I[2], "noF", { BackgroundColor3 = Color3.fromRGB(170, 0, 0), FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.5174129, 0.728395), Size = UDim2.fromScale(0.4577115, 0.1893004), Text = "NO", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
				I[8] = new("UICorner", I[7], "UICorner")
				I[9] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 46 })
			I[10] = new("TextButton", I[2], "autoRP", { BackgroundColor3 = Color3.fromRGB(0, 170, 0), FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.2024695, 0.3127572), Size = UDim2.fromScale(0.5897589, 0.1975309), Text = "AUTO RP: OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[11] = new("UICorner", I[10], "UICorner")
				I[12] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 46 })
		I[13] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.6633416 })
	return I[1]
end

return build
