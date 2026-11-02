-- Generated from ui/StarterGui/LevelUp.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LevelUp", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "LevelUpFrame", { BackgroundColor3 = Color3.fromRGB(26, 26, 51), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(128, 128, 255), BorderSizePixel = 2, Position = UDim2.fromScale(0.3, 0.4), Size = UDim2.fromScale(0.4, 0.2), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
			I[4] = new("TextLabel", I[2], "LevelDisplay", { BackgroundColor3 = Color3.fromRGB(51, 51, 77), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0026795, 0), Size = UDim2.fromScale(1, 1), Text = "LEVEL 1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0, TextWrapped = true })
				I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint")
			I[6] = new("Sound", I[2], "LevelSound")
	return I[1]
end

return build
