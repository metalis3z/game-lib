-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/LuckyFoodTemplateContent/Quantity.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Quantity", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.2536249), Size = UDim2.fromScale(0.8999999, 0.076783), Text = "x2", TextColor3 = Color3.fromRGB(195, 195, 195), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 25 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Thickness = 2.3625, Transparency = 0.5 }, { ["oldp_Thickness"] = 3 })
	return I[1]
end

return build
