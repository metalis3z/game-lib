-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/ContentPageController/container.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("CanvasGroup", nil, "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7418831, 0.9110172) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.02, 0), BottomRightRadius = UDim.new(0.02, 0), TopLeftRadius = UDim.new(0.02, 0), TopRightRadius = UDim.new(0.02, 0) })
		I[3] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(247, 245, 255), Thickness = 2, Transparency = 0.5 })
		I[4] = new("TextButton", I[1], "_", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Selectable = false, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = -1 })
		I[5] = new("TextButton", I[1], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 20, Position = UDim2.new(1, -12, 0, 12), Size = UDim2.fromScale(0.0427, 0.0427), SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1, ZIndex = 100 }, nil, { "UIEffect" })
			I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.17, 0), BottomRightRadius = UDim.new(0.17, 0), TopLeftRadius = UDim.new(0.17, 0), TopRightRadius = UDim.new(0.17, 0) })
			I[7] = new("ImageLabel", I[5], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.9, 1, 0.9, 0) })
	return I[1]
end

return build
