-- Generated from ui/StarterGui/TreadmillScreenButtonShare.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "TreadmillScreenButtonShare", { AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 1000, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ZOffset = 1 }, { ["_lemonadeUniqueId"] = "PBXbfWN9PBXb" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "sdqKTQqwsdqK" })
			I[3] = new("ImageButton", I[2], "ShareButton", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90859308705353"), ImageTransparency = 0.2, Position = UDim2.fromScale(0.98, 0.77), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.11856, 0.0912), ZIndex = 3 }, { ["MuteSounds"] = true, ["_lemonadeUniqueId"] = "wYIPATEMwYIP" })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.1248285 }, { ["_lemonadeUniqueId"] = "ZO8wsp1bZO8w" })
	return I[1]
end

return build
