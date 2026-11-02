-- Generated from ui/ServerStorage/EventScript_Halloween2021/OpenCrate/OldItem.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "OldItem", { BackgroundColor3 = Color3.fromRGB(106, 106, 106), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, -60), Size = UDim2.fromOffset(120, 120), ZIndex = 2 })
		I[2] = new("TextLabel", I[1], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 2 })
	return I[1]
end

return build
