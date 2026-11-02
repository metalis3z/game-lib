-- Generated from ui/StarterGui/SeerHourScreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SeerHourScreen")
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 0.2) })
			I[3] = new("TextLabel", I[2], "Text", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SpecialElite.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-3.0089993, -0.0049999), Selectable = true, Size = UDim2.fromScale(7, 0.8076923), Text = "HE ALWAYS WILL FIND YOU", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 30, TextStrokeColor3 = Color3.fromRGB(85, 0, 255), TextStrokeTransparency = 0.5, TextWrapped = true, Visible = false })
			I[4] = new("TextLabel", I[2], "Text2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.8836832, 1.1321237), Selectable = true, Size = UDim2.fromScale(2.7520592, 0.3979934), Text = "KILL THE EMITING PART TO STOP THE SEER.", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 30, TextStrokeColor3 = Color3.fromRGB(85, 0, 255), TextStrokeTransparency = 0.5, TextWrapped = true, Visible = false })
	return I[1]
end

return build
