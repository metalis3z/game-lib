-- Generated from ui/ReplicatedStorage/Systems/Player/UI/SidebarHandler/PulloutHolder.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PulloutHolder", { AnchorPoint = Vector2.new(0.05, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(2.75, 0.75), ZIndex = 0 })
		I[2] = new("Frame", I[1], "PulloutFrame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
			I[3] = new("ImageLabel", I[2], "Inverted", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://19000314306"), ImageTransparency = 1, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
			I[4] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(1, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LineHeight = 1.25, Position = UDim2.fromScale(0.9, 0.5), Size = UDim2.fromScale(0, 0.5), Text = "Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 30, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
			I[5] = new("ImageLabel", I[2], "ArtAsset", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://19000068398"), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
	return I[1]
end

return build
