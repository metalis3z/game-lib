-- Generated from ui/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Assets/Title.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Title", { AlwaysOnTop = true, MaxDistance = math.huge, Size = UDim2.fromScale(3, 1.5), StudsOffset = Vector3.new(0.5, 2.5999999, 0) })
		I[2] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(-0.17, -20, 0, 0), Size = UDim2.new(1, 40, 0.9, -1), Text = "Admin", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 12, TextStrokeColor3 = Color3.fromRGB(50, 0, 0), TextStrokeTransparency = 0.5, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
	return I[1]
end

return build
