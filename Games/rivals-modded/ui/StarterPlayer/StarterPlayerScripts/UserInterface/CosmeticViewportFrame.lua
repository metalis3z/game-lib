-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/CosmeticViewportFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ViewportFrame", nil, "CosmeticViewportFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), LightDirection = Vector3.new(0, -1, -0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75) })
		I[2] = new("Sky", I[1], "Sky", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://14147881792"), SkyboxDownContent = Content.fromUri("rbxassetid://14147882149"), SkyboxFrontContent = Content.fromUri("rbxassetid://14147882761"), SkyboxLeftContent = Content.fromUri("rbxassetid://14147883091"), SkyboxRightContent = Content.fromUri("rbxassetid://14147882405"), SkyboxUpContent = Content.fromUri("rbxassetid://14147881297") })
	return I[1]
end

return build
