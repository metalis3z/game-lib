-- Generated from ui/StarterGui/AnimeZoom.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AnimeZoom", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Frame1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871247455"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[4] = new("ImageLabel", I[2], "Frame2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871251459"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[5] = new("ImageLabel", I[2], "Frame3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871252845"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[6] = new("ImageLabel", I[2], "Frame4", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871258149"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[7] = new("ImageLabel", I[2], "Frame5", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871254900"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[8] = new("ImageLabel", I[2], "Frame6", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871261535"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[9] = new("ImageLabel", I[2], "Frame7", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871261535"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[10] = new("ImageLabel", I[2], "Frame8", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871263167"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[11] = new("ImageLabel", I[2], "Frame9", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871267074"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[12] = new("ImageLabel", I[2], "Frame10", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13871268252"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[13] = new("NumberValue", I[2], "TransparencyValue")
	return I[1]
end

return build
