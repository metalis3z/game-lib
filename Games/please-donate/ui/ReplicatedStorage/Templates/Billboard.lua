-- Generated from ui/ReplicatedStorage/Templates/Billboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "Billboard", { ClipsDescendants = true, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "DropTheNumber", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://8808087715"), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1) })
		I[3] = new("UIPageLayout", I[1], "UIPageLayout", { EasingDirection = Enum.EasingDirection.InOut, EasingStyle = Enum.EasingStyle.Quint, GamepadInputEnabled = false, ScrollWheelInputEnabled = false, SortOrder = Enum.SortOrder.LayoutOrder, TouchInputEnabled = false })
		I[4] = new("ImageLabel", I[1], "UNOFFICIAL", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://8808127041"), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1) })
		I[5] = new("ImageLabel", I[1], "TypeRace", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://8944252094"), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1) })
		I[6] = new("ImageLabel", I[1], "IdioticInvesting", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://8808156836"), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
