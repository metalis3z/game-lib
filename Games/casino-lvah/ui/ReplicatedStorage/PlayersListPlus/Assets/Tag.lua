-- Generated from ui/ReplicatedStorage/PlayersListPlus/Assets/Tag.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Tag", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.525, 0.5), Size = UDim2.fromScale(0, 1), Text = "VIP", TextColor3 = Color3.fromRGB(255, 170, 0), TextScaled = true, TextSize = 16, TextWrapped = true })
		I[2] = new("UITextSizeConstraint", I[1], "UITextSizeConstraint", { MaxTextSize = 25, MinTextSize = 5 })
		I[3] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(30, 30, 30), Thickness = 2 })
	return I[1]
end

return build
