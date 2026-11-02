-- Generated from ui/StarterGui/LoadingGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LoadingGUI", { DisplayOrder = 999999999, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(34, 34, 34), Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("Frame", I[2], "IntroTextFrameHolder", { BackgroundColor3 = Color3.fromRGB(62, 62, 62), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0.3423611, 0.4248061), Size = UDim2.fromScale(0.3152778, 0.1488372) })
				I[4] = new("TextLabel", I[3], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Fondamento.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.001713, 0.0514069), Size = UDim2.fromScale(1, 0.8854167), Text = "SCP Tycoon", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("Frame", I[2], "LoadBarHolder", { BackgroundColor3 = Color3.fromRGB(49, 49, 49), Position = UDim2.fromScale(0.3756944, 0.5), Size = UDim2.fromScale(0.2486111, 0.0403101) })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 33333), BottomRightRadius = UDim.new(0, 33333), TopLeftRadius = UDim.new(0, 33333), TopRightRadius = UDim.new(0, 33333) })
				I[7] = new("Frame", I[5], "LoadBar", { BackgroundColor3 = Color3.fromRGB(99, 99, 99), Position = UDim2.fromScale(-0.0014006, 0), Size = UDim2.fromScale(0, 1) })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0, 33333), BottomRightRadius = UDim.new(0, 33333), TopLeftRadius = UDim.new(0, 33333), TopRightRadius = UDim.new(0, 33333) })
				I[9] = new("TextLabel", I[5], "LoadingLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Fondamento.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1089385, 1.5384616), Size = UDim2.fromScale(0.7793295, 1.1153846), Text = "Loading Assets (0/100)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
