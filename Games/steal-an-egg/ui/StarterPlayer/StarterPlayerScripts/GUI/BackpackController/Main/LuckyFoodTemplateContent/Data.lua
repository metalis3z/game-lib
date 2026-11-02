-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/LuckyFoodTemplateContent/Data.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Data", { Active = true, AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, Position = UDim2.fromScale(0.5, 0.9800001), Selectable = true, Size = UDim2.fromScale(0.95, 0.35), ZIndex = 25 })
		I[2] = new("TextLabel", I[1], "Boosts", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(76, 52, 35), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Selectable = true, Size = UDim2.fromScale(0.95, 1), Text = "X1 Stock", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 27 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(77, 77, 77), Thickness = 2 }, { ["OriginalColor"] = Color3.fromRGB(122, 81, 0) })
		I[4] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
	return I[1]
end

return build
