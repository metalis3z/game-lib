-- Generated from ui/StarterGui/Stamina.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Stamina", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.045, 0.65), Size = UDim2.fromOffset(121, 12) })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2, Transparency = 0.2 })
			I[4] = new("UICorner", I[2], "UICorner")
			I[5] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://14977832546"), Position = UDim2.fromScale(1.0688616, -0.4166667), Size = UDim2.fromScale(0.1877515, 1.8254795) })
			I[6] = new("Frame", I[2], "HealthDisplay", { BackgroundColor3 = Color3.fromRGB(35, 6, 255), BorderColor3 = Color3.fromRGB(35, 6, 255), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0019383, -0.0234833), Size = UDim2.fromScale(1.0061275, 1) })
				I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 0 })
				I[8] = new("UICorner", I[6], "UICorner")
	return I[1]
end

return build
