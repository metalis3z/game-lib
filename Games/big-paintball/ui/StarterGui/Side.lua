-- Generated from ui/StarterGui/Side.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Side", { DisplayOrder = 5, ResetOnSpawn = false })
		I[2] = new("ImageLabel", I[1], "Currency", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.25, 0, 0.03, 21), SliceCenter = Rect.new(20, 20, 80, 80) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 5 })
			I[4] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.585, 0.5), Size = UDim2.fromScale(0.78, 0.75), Text = "999M", TextColor3 = Color3.fromRGB(255, 223, 62), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[5] = new("UIScale", I[4], "UIScale")
			I[6] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 223, 62), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3701177967"), Position = UDim2.fromScale(0.1, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 0.5) })
			I[7] = new("Folder", I[2], "Effect")
		I[8] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0.005, 4), PaddingLeft = UDim.new(0.003, 4), PaddingRight = UDim.new(0.003, 4), PaddingTop = UDim.new(0.005, 4) })
	return I[1]
end

return build
