-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/FilmGrain.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "FilmGrain", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://93476575277146"), ImageTransparency = 0.825, Position = UDim2.fromScale(0.5, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(2, 2), TileSize = UDim2.fromOffset(1024, 1024), ZIndex = -999 })
	return I[1]
end

return build
