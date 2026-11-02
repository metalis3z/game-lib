-- Generated from ui/ReplicatedStorage/PDLocker.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PDLocker", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(93, 93, 93), BackgroundTransparency = 0.15, Position = UDim2.fromScale(0.3174031, 0.234414), Size = UDim2.fromScale(0.3642921, 0.6147132) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1683168, 0), Size = UDim2.fromScale(0.6633663, 0.1196755), Text = "Police Locker \n⚠️ Handcuff abuse will not be tolerated. You will be banned.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 59 })
			I[6] = new("Folder", I[2], "Tools")
				I[7] = new("ScrollingFrame", I[6], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(85, 85, 85), BackgroundTransparency = 0.25, Position = UDim2.fromScale(0.2079208, 0.1359026), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.5866337, 0.703854) })
					I[8] = new("UIListLayout", I[7], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
			I[9] = new("TextButton", I[2], "close", { BackgroundColor3 = Color3.fromRGB(170, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2524753, 0.8640974), Size = UDim2.fromScale(0.4950495, 0.1014199), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UICorner", I[9], "UICorner")
				I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 50 })
		I[12] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.3827931 })
	return I[1]
end

return build
