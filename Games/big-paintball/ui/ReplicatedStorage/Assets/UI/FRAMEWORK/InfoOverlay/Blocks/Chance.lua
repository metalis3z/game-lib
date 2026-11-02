-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/Chance.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 6, Size = UDim2.new(1, 0, 0, 22), ZIndex = 11 })
		I[2] = new("Configuration", I[1], "settings")
			I[3] = new("NumberValue", I[2], "maxSizeX", { Value = 300 })
			I[4] = new("NumberValue", I[2], "minSizeX", { Value = 25 })
			I[5] = new("NumberValue", I[2], "sort", { Value = 6 })
		I[6] = new("TextLabel", I[1], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "5%", TextColor3 = Color3.fromRGB(85, 255, 255), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
	return I[1]
end

return build
