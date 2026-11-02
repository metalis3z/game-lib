-- Generated from ui/StarterGui/Crosshair.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Crosshair", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("ImageLabel", I[1], "Hitmarker", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3694247430"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(25, 25) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
		I[4] = new("Folder", I[1], "OrginalCrosshair")
			I[5] = new("Frame", I[4], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(25, 25) })
				I[6] = new("Frame", I[5], "Frame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(1, 0.5), Size = UDim2.new(0.3, 0, 0, 2) })
				I[7] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
				I[8] = new("Frame", I[5], "cntr", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(2, 2) })
				I[9] = new("Frame", I[5], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0.3, 0, 0, 2) })
				I[10] = new("Frame", I[5], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0, 2, 0.3, 0) })
				I[11] = new("Frame", I[5], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0.5, 1), Size = UDim2.new(0, 2, 0.3, 0) })
	return I[1]
end

return build
