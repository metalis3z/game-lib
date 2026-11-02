-- Generated from ui/StarterGui/Extensions.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Extensions", { ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "ProductVignete", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=11202863894"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SliceScale = 3, Visible = false, ZIndex = 999 })
		I[3] = new("Frame", I[1], "MonetizationBlackBackground", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
		I[4] = new("TextLabel", I[1], "AuraPurchasedText", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3697024, 0.2691512), Size = UDim2.fromScale(0.2588954, 0.3818923), Text = "PURCHASED", TextColor3 = Color3.fromRGB(255, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 4 })
			I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 3 })
			I[6] = new("ImageLabel", I[4], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 255, 127), ImageContent = Content.fromUri("rbxassetid://10822615828"), ImageTransparency = 0.63, Position = UDim2.fromScale(0.4930342, 0.4998533), Size = UDim2.fromScale(2.0419519, 0.8099043), ZIndex = 0 })
		I[7] = new("Frame", I[1], "ConfettiFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
		I[8] = new("ImageLabel", I[1], "RebirthVignete", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=11202863894"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SliceScale = 3, ZIndex = 999 })
	return I[1]
end

return build
