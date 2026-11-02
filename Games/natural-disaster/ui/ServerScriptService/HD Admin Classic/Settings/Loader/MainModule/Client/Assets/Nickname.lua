-- Generated from ui/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Client/Assets/Nickname.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Nickname", { AlwaysOnTop = true, MaxDistance = 50, Size = UDim2.new(1, 0, 0.5, 5), SizeOffset = Vector2.new(0, 0.5), StudsOffset = Vector3.new(0, 1.5, 0) })
		I[2] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -200, 0, 0), Size = UDim2.new(0, 400, 1, 0), Text = "", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
	return I[1]
end

return build
