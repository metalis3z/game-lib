-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/LoadingController/loading.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "loading", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
		I[2] = new("Frame", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.3136018, 0.3547904) })
			I[3] = new("ImageLabel", I[2], "runner", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://89184048328840"), Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(2, 3) }, { ["SkipThemeImage"] = true })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
		I[5] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.02, 0), BottomRightRadius = UDim.new(0.02, 0), TopLeftRadius = UDim.new(0.02, 0), TopRightRadius = UDim.new(0.02, 0) })
	return I[1]
end

return build
