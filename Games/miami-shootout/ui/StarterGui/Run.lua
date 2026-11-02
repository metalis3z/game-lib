-- Generated from ui/StarterGui/Run.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Run", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Bar", { BackgroundColor3 = Color3.fromRGB(9, 1, 255), BackgroundTransparency = 0.7, Position = UDim2.fromScale(0.0405938, 0.5209876), Size = UDim2.fromScale(0.1316239, 0.017284) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 11.000001 })
			I[4] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(24, 0, 144), ImageContent = Content.fromUri("rbxassetid://9525535512"), Position = UDim2.fromScale(1.0802139, -0.4705882), Size = UDim2.fromScale(0.2142857, 2.2857144) })
			I[5] = new("Frame", I[2], "Bar", { BackgroundColor3 = Color3.fromRGB(12, 0, 140), BackgroundTransparency = 0.7, Position = UDim2.fromScale(-0.0257734, -0.2406285), Size = UDim2.fromScale(1.0584415, 1.3593185) })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 8.565217 })
				I[7] = new("UICorner", I[5], "UICorner")
			I[8] = new("UICorner", I[2], "UICorner")
	return I[1]
end

return build
