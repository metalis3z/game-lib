-- Generated from ui/ReplicatedStorage/Assets/Killers/__KillerSonicExe/Behavior/Instances/RunTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "RunTemplate", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.2, 0.15) })
		I[2] = new("ImageLabel", I[1], "N", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126533761317529"), ImageRectOffset = Vector2.new(33, 0), ImageRectSize = Vector2.new(16, 16), Position = UDim2.fromScale(1, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3333, 1) })
		I[3] = new("ImageLabel", I[1], "U", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126533761317529"), ImageRectOffset = Vector2.new(18, 0), ImageRectSize = Vector2.new(16, 16), Position = UDim2.fromScale(0.5, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3333, 1) })
		I[4] = new("ImageLabel", I[1], "R", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126533761317529"), ImageRectOffset = Vector2.new(2, 0), ImageRectSize = Vector2.new(16, 16), Position = UDim2.fromScale(0, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3333, 1) })
	return I[1]
end

return build
