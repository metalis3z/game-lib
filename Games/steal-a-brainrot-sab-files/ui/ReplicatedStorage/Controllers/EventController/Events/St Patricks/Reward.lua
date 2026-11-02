-- Generated from ui/ReplicatedStorage/Controllers/EventController/Events/St Patricks/Reward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Reward", { Active = true, ClipsDescendants = true, LightInfluence = 1.5, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(4.5, 2), StudsOffset = Vector3.new(0, 0, 2.2), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "nWahrHXNnWah" })
		I[2] = new("TextLabel", I[1], "CurrencyGoldCoins", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1), Text = "+10", TextColor3 = Color3.fromRGB(209, 169, 48), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "3c1CzX1j3c1C" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "Gmy2xxeyGmy2" })
		I[4] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(-0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "IVAwI31zIVAw" })
		I[5] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116762624882914"), ImageTransparency = 1, Position = UDim2.fromScale(0.02, 0), Rotation = -25, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["_lemonadeUniqueId"] = "Hx5cPU4oHx5c" })
			I[6] = new("ImageLabel", I[5], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116762624882914"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["_lemonadeUniqueId"] = "INZAcf7tINZA" })
	return I[1]
end

return build
