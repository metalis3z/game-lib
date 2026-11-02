-- Generated from ui/ReplicatedStorage/Controllers/ItemController/ConfettiLauncherController/ConfettiSizes/9.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "9", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(55, 255, 125), BorderSizePixel = 0, Position = UDim2.fromScale(0.4898785, 0.3788523), Size = UDim2.fromScale(0.1906916, 0.1022469), ZIndex = -1 }, { ["ViralWorkerRef"] = "vw_beb9fc6543" })
	return I[1]
end

return build
