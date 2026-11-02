-- Generated from ui/StarterPlayer/StarterCharacterScripts/dots.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "dots", { Active = true, ClipsDescendants = true, MaxDistance = math.huge, Size = UDim2.fromScale(4, 4), StudsOffset = Vector3.new(0, 4, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "one", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3147875748"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.35, 0.65), Size = UDim2.fromScale(0.05, 0.05), Visible = false })
		I[3] = new("ImageLabel", I[1], "two", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3147875748"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.fromScale(0.05, 0.05), Visible = false })
		I[4] = new("ImageLabel", I[1], "three", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3147875748"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.65, 0.65), Size = UDim2.fromScale(0.05, 0.05), Visible = false })
	return I[1]
end

return build
