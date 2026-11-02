-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/SavedOutfitsController/selectOverlay.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "selectOverlay", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 15 })
		I[2] = new("Frame", I[1], "selStroke", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.7158), ZIndex = 16 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.06, 0), BottomRightRadius = UDim.new(0.06, 0), TopLeftRadius = UDim.new(0.06, 0), TopRightRadius = UDim.new(0.06, 0) })
			I[4] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(51, 95, 255), Thickness = 3, Transparency = 1 })
		I[5] = new("Frame", I[1], "badge", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(24, 25, 33), BackgroundTransparency = 0.25, Position = UDim2.fromScale(0.93, 0.04), Size = UDim2.fromScale(0.2, 0.2), ZIndex = 18 })
			I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
			I[7] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { DominantAxis = Enum.DominantAxis.Height })
			I[8] = new("ImageLabel", I[5], "unchecked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://108840008135273"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.74, 0.74), ZIndex = 18 })
			I[9] = new("ImageLabel", I[5], "checked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(51, 95, 255), ImageContent = Content.fromUri("rbxassetid://71418101941296"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.74, 0.74), ZIndex = 19 })
		I[10] = new("TextButton", I[1], "selectButton", { AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 20 })
	return I[1]
end

return build
