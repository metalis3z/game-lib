-- Generated from ui/StarterGui/TimerGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TimerGui", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Timer", { AnchorPoint = Vector2.new(0.5, 0), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.02), Size = UDim2.fromScale(0.16, 0.08), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "0:00", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 45, TextWrapped = true })
		I[3] = new("TextLabel", I[1], "Multiplier", { AnchorPoint = Vector2.new(0, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5358711, 0.0996784), Size = UDim2.fromScale(0.0200586, 0.0346238), Text = "x2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 45, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
	return I[1]
end

return build
