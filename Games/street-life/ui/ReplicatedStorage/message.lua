-- Generated from ui/ReplicatedStorage/message.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "message", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.2784504, 0.7865031), Size = UDim2.fromScale(0.4430993, 0.0723926) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2514086, 0.9768894), Size = UDim2.fromScale(0.4971828, 0.7257855), Text = "Releasing in ", TextColor3 = Color3.fromRGB(26, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build
