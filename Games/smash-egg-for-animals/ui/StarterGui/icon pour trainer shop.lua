-- Generated from ui/StarterGui/icon pour trainer shop.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "icon pour trainer shop", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(90, 90, 100), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://72904655944196"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(60, 60) }, { ["Class"] = "Image" })
		I[3] = new("ImageLabel", I[1], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(90, 90, 100), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://127597913030132"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(60, 60) }, { ["Class"] = "Image" })
		I[4] = new("ImageLabel", I[1], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(90, 90, 100), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://101733309773012"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(60, 60) }, { ["Class"] = "Image" })
		I[5] = new("ImageLabel", I[1], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(90, 90, 100), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://113287848907721"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(60, 60) }, { ["Class"] = "Image" })
	return I[1]
end

return build
