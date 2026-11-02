-- Generated from ui/StarterGui/FixCam.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "FixCam")
		I[2] = new("TextButton", I[1], "Reset", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.01, 0.78), Size = UDim2.fromScale(0.1, 0.05), Text = "Fix Camera", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.5, TextWrapped = true })
	return I[1]
end

return build
