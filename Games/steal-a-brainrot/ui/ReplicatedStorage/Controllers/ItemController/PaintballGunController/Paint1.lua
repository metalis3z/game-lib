-- Generated from ui/ReplicatedStorage/Controllers/ItemController/PaintballGunController/Paint1.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Paint1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12865453992"), Position = UDim2.fromScale(0.3495276, 0.5185972), Size = UDim2.fromScale(0.2361673, 0.3719447) }, { ["ViralWorkerRef"] = "vw_88e8bacab5" })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", nil, { ["ViralWorkerRef"] = "vw_376bf6f603" })
	return I[1]
end

return build
