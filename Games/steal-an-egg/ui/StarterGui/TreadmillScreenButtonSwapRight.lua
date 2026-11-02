-- Generated from ui/StarterGui/TreadmillScreenButtonSwapRight.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "TreadmillScreenButtonSwapRight", { AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 1000, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ZOffset = 1 })
		I[2] = new("ImageButton", I[1], "ButtonSwapRight", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87880712869810"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.5) }, { ["MuteSounds"] = true })
			I[3] = new("ImageLabel", I[2], "ConsoleButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonR1@2x.png"), Position = UDim2.fromScale(0.45, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.33, 0.33), Visible = false, ZIndex = 201 }, { ["ConsoleButton"] = "ButtonRB" })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
	return I[1]
end

return build
