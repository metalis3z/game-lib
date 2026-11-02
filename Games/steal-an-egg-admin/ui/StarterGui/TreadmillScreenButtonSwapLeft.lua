-- Generated from ui/StarterGui/TreadmillScreenButtonSwapLeft.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "TreadmillScreenButtonSwapLeft", { AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 1000, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ZOffset = 1 }, { ["_lemonadeUniqueId"] = "phyIub3JphyI" })
		I[2] = new("ImageButton", I[1], "ButtonSwapLeft", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87880712869810"), Position = UDim2.fromScale(0.5, 0.5), Rotation = 180, Size = UDim2.fromScale(0.5, 0.5) }, { ["MuteSounds"] = true, ["_lemonadeUniqueId"] = "tMVtfTzhtMVt" })
			I[3] = new("ImageLabel", I[2], "ConsoleButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonL1@2x.png"), Position = UDim2.fromScale(0.45, 0.5), Rotation = 180, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.33, 0.33), Visible = false, ZIndex = 201 }, { ["ConsoleButton"] = "ButtonLB", ["_lemonadeUniqueId"] = "CWviDix5CWvi" })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "TPvKSLqKTPvK" })
	return I[1]
end

return build
