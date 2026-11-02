-- Generated from ui/ReplicatedStorage/Assets/InfoOverlay/Blocks/Description.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Description", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 4, Size = UDim2.new(1, 0, 0, 42), ZIndex = 11 })
		I[2] = new("Configuration", I[1], "settings")
			I[3] = new("NumberValue", I[2], "sort", { Value = 3 })
			I[4] = new("NumberValue", I[2], "maxSizeX", { Value = 200 })
			I[5] = new("NumberValue", I[2], "minSizeX", { Value = 100 })
		I[6] = new("TextLabel", I[1], "desc", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Efficient and durable. Gets the job done!", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
	return I[1]
end

return build
