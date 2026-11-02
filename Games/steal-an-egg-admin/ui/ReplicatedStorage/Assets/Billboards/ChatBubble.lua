-- Generated from ui/ReplicatedStorage/Assets/Billboards/ChatBubble.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "ChatBubble", { Active = true, AlwaysOnTop = true, LightInfluence = 1, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(15, 2), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "1nnIkOmY1nnI" })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 7.5211267 }, { ["_lemonadeUniqueId"] = "OqZJkRlLOqZJ" })
		I[3] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.25, 0.5) }, { ["_lemonadeUniqueId"] = "MYbXWNagMYbX" })
			I[4] = new("TextLabel", I[3], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 1), Text = "Papa", TextColor3 = Color3.fromRGB(40, 40, 40), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "VS9F8w4sVS9F" })
			I[5] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "in4oEcpfin4o" })
			I[6] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "5gZNDW9d5gZN" })
			I[7] = new("ImageLabel", I[3], "Pointer_Down", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94836978140510"), Position = UDim2.fromScale(0.5, 1.09), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.4) }, { ["_lemonadeUniqueId"] = "P5bFvAWaP5bF" })
				I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "bTYCKSK4bTYC" })
	return I[1]
end

return build
