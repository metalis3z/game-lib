-- Generated from ui/StarterGui/SpawnCelestialGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "SpawnCelestialGui", { ClipsDescendants = true, LightInfluence = 1, MaxDistance = 1000, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "SpawnCelestialGui" })
		I[2] = new("ImageButton", I[1], "Upgrade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://72681982464787"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.5) }, { ["AvoidOverride"] = true, ["ProductId"] = 3526247219 }, { "UIButton" })
			I[3] = new("TextLabel", I[2], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "SPAWN NOW!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextWrapped = true })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
			I[5] = new("UIScale", I[2], "UIScale")
	return I[1]
end

return build
