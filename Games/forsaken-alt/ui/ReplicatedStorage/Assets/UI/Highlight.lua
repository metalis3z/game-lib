-- Generated from ui/ReplicatedStorage/Assets/UI/Highlight.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Highlight", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = math.huge, Size = UDim2.new(2, 50, 2, 50), StudsOffset = Vector3.new(0, 4, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18818586848"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("ViewportFrame", I[2], "ViewportFrame", { Ambient = Color3.fromRGB(170, 129, 131), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(120, 120, 120), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, LightColor = Color3.fromRGB(218, 176, 177), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.85, 0.85) })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(16, 0), BottomRightRadius = UDim.new(16, 0), TopLeftRadius = UDim.new(16, 0), TopRightRadius = UDim.new(16, 0) })
				I[5] = new("Part", I[3], "PartCenter", { BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(145.8999939, 4.0999999, -419, 1, 0, 0, 0, 0, -1, 0, 1, 0), Size = Vector3.new(4, 1, 2), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
				I[6] = new("Part", I[3], "ModelCenter", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(146, 3, -420, -1, 0, 0, 0, 1, 0, 0, 0, -1), CanCollide = false, EnableFluidForces = false, Size = Vector3.new(2, 2, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
	return I[1]
end

return build
