-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/SignedPREVIOUS.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "SignedPREVIOUS", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 20) })
		I[2] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(249, 64, 255), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(22, 22) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
		I[4] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[5] = new("Configuration", I[1], "settings", nil, { ["boundsX"] = Vector2.new(150, 300) })
		I[6] = new("TextLabel", I[1], "title", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "BuildIntoGames", TextColor3 = Color3.fromRGB(249, 64, 255), TextSize = 20, TextWrapped = true, ZIndex = 2 })
	return I[1]
end

return build
