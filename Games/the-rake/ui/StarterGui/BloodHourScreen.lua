-- Generated from ui/StarterGui/BloodHourScreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BloodHourScreen")
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 0.2) })
			I[3] = new("TextLabel", I[2], "Text", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-3.0089996, -0.005), Selectable = true, Size = UDim2.fromScale(7, 1), Text = "RUN FOR YOUR LIFE", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 30, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
	return I[1]
end

return build
