-- Generated from ui/ServerStorage/Crosshairs/DotCrosshair/cntr.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "cntr", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0.499082, 0.4404072), Size = UDim2.fromOffset(20, 19) })
		I[2] = new("UICorner", I[1], "UICorner")
	return I[1]
end

return build
