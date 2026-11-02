-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/RemoveItemsController/subCategoryRow.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "subCategoryRow", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.163), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
		I[3] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Transparency = 0.65 })
		I[4] = new("UIPadding", I[1], "UIPadding", { PaddingLeft = UDim.new(0.08, 0) })
		I[5] = new("Frame", I[1], "checkbox", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.04, 0.5), Size = UDim2.fromScale(0.13, 0.6) })
			I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { DominantAxis = Enum.DominantAxis.Height })
			I[7] = new("ImageLabel", I[5], "unchecked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108840008135273"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
			I[8] = new("ImageLabel", I[5], "checked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://71418101941296"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
		I[9] = new("TextLabel", I[1], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1682074, 0.4999998), Size = UDim2.fromScale(0.6617926, 0.55), Text = "Sub", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[10] = new("TextButton", I[1], "button", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 2 })
	return I[1]
end

return build
