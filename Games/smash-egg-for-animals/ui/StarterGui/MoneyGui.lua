-- Generated from ui/StarterGui/MoneyGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MoneyGui", { DisplayOrder = 5, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Holder", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, Position = UDim2.new(0, 18, 1, -14), Size = UDim2.fromOffset(440, 74) }, { ["MobileMult"] = 0.85, ["ScaleMult"] = 0.7692308 }, { "AutoScale" })
			I[3] = new("TextLabel", I[2], "Amount", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic), Position = UDim2.fromOffset(74, 0), Size = UDim2.new(1, -74, 1, 0), Text = "$500", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 5 })
				I[5] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(233, 255, 176)), ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 208, 90)) }), Rotation = 90 })
				I[6] = new("UIScale", I[3], "UIScale")
			I[7] = new("ImageLabel", I[2], "Icon", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://70666404213952"), Position = UDim2.fromOffset(0, 4), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(66, 66) })
	return I[1]
end

return build
