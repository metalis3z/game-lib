-- Generated from ui/StarterGui/PhotoUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "PhotoUI", { ClipsDescendants = true, LightInfluence = 1, MaxDistance = 1000, PixelsPerStud = 300, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://82501337571033"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
		I[3] = new("ImageLabel", I[1], "Dark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
		I[4] = new("ViewportFrame", I[1], "ViewportFrame", { Ambient = Color3.fromRGB(152, 152, 152), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(200, 200, 200), LightDirection = Vector3.new(-1, 1, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[5] = new("WorldModel", I[4], "WorldModel")
			I[6] = new("Part", I[4], "RootPart", { CFrame = CFrame.new(0, -1.2, 0.4, 0.9681025, -0.0163111, 0.2500229, -0.0505947, 0.9645958, 0.2588342, -0.2453929, -0.2632279, 0.9330024), Size = Vector3.new(2.5, 2.5, 1.25), Transparency = 1 })
		I[7] = new("ImageLabel", I[1], "Vignette", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://4576475446"), ImageTransparency = 0.5, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
		I[8] = new("ImageLabel", I[1], "static", { BackgroundColor3 = Color3.fromRGB(28, 28, 40), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(17, 17, 17), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4388380012"), ImageTransparency = 0.5, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
	return I[1]
end

return build
