-- Generated from ui/ServerScriptService/Cylinders/CylinderSurface.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "CylinderSurface", { CanvasSize = Vector2.new(100, 100), Face = Enum.NormalId.Top })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(83, 83, 83), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0, 20, 0.7, 0) })
		I[3] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(83, 83, 83), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.7, 0, 0, 20) })
	return I[1]
end

return build
