-- Generated from ui/ReplicatedStorage/Controllers/EventController/Events/Gingerbread Town/Reward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Reward", { Active = true, ClipsDescendants = true, LightInfluence = 1.5, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(9.4499998, 4.1999998), StudsOffset = Vector3.new(0, 0, 4.6200004), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_90f938294f" })
		I[2] = new("TextLabel", I[1], "CurrencyCandyCane", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1), Text = "+10", TextColor3 = Color3.fromRGB(255, 64, 64), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_fa66b8f632" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_25e3b123c5" })
		I[4] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(-0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_8bdb363a5b" })
		I[5] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81083444361233"), ImageTransparency = 1, Position = UDim2.fromScale(0.02, 0), Rotation = -25, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["ViralWorkerRef"] = "vw_e04728215b" })
			I[6] = new("ImageLabel", I[5], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81083444361233"), Position = UDim2.fromScale(0.5, 0.5), Rotation = -25, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["ViralWorkerRef"] = "vw_270921c03d" })
	return I[1]
end

return build
