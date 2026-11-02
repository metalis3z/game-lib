-- Generated from ui/StarterGui/LiftWaitVisual.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LiftWaitVisual", { DisplayOrder = 1, Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "FakeEffect", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Interactable = false, Position = UDim2.fromScale(0.5, -0.138505), Size = UDim2.fromScale(1.1, 0.5), ZIndex = -100000 })
			I[3] = new("Frame", I[2], "HideSpectate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Interactable = false, Size = UDim2.fromScale(1, 1), ZIndex = -100000 })
				I[4] = new("Frame", I[3], "Mid", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, Position = UDim2.fromScale(0, 0.25), Size = UDim2.fromScale(1, 0.5), ZIndex = -100000 })
				I[5] = new("ImageLabel", I[3], "Fade_Btm", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://156579757"), Interactable = false, Position = UDim2.new(0, 0, 0.75, -1), Rotation = 180, Size = UDim2.fromScale(1, 0.25), ZIndex = -100000 })
				I[6] = new("ImageLabel", I[3], "Fade_Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://156579757"), Interactable = false, Size = UDim2.fromScale(1, 0.25), ZIndex = -100000 })
		I[7] = new("ImageLabel", I[1], "Vignette", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://506452892"), Interactable = false, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(2, 2) })
	return I[1]
end

return build
