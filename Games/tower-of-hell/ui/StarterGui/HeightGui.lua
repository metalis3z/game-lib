-- Generated from ui/StarterGui/HeightGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HeightGui", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BorderSizePixel = 0, Position = UDim2.fromScale(0.975, 0.5), Size = UDim2.fromScale(0.015, 0.75) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[4] = new("Frame", I[1], "Players", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.975, 0.5), Size = UDim2.fromScale(0.015, 0.75), ZIndex = 2 })
			I[5] = new("Frame", I[4], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 170, 127), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(2, 0.005), Visible = false, ZIndex = 2 })
				I[6] = new("ImageLabel", I[5], "Thumbnail", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Selectable = true, Size = UDim2.fromScale(0.5, 12) })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
	return I[1]
end

return build
