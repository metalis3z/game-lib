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
	I[1] = new("BillboardGui", nil, "Reward", { Active = true, ClipsDescendants = true, LightInfluence = 1.5, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(4.5, 2), StudsOffset = Vector3.new(0, 0, 2.2), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_84fb1077f3" })
		I[2] = new("TextLabel", I[1], "CurrencyGoldCoins", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1), Text = "+10", TextColor3 = Color3.fromRGB(209, 169, 48), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_758b7d7dcf" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_60eafd523f" })
		I[4] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116762624882914"), ImageTransparency = 1, Position = UDim2.fromScale(0.02, 0), Rotation = -25, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["ViralWorkerRef"] = "vw_450e63d190" })
			I[5] = new("ImageLabel", I[4], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116762624882914"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["ViralWorkerRef"] = "vw_020892ffb6" })
		I[6] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(-0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_1597a18bac" })
	return I[1]
end

return build
