-- Generated from ui/ServerScriptService/Overhead/PlayerDisplay.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "PlayerDisplay", { Active = true, MaxDistance = math.huge, Size = UDim2.fromScale(5, 1.75), StudsOffset = Vector3.new(0, 2, 0) })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("TextLabel", I[2], "RankDisplay", { Active = true, AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.35), Text = "Unknown Rank", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.625, TextWrapped = true })
			I[4] = new("Frame", I[2], "Badges", { Active = true, AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0001), Size = UDim2.fromScale(1, 0.3) })
				I[5] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[6] = new("ImageLabel", I[4], "Booster", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6455437156"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1199671, 1), Visible = false })
				I[7] = new("ImageLabel", I[4], "DevForum", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6455451490"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1199671, 1), Visible = false })
				I[8] = new("ImageLabel", I[4], "Developer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6455502439"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1199671, 1), Visible = false })
				I[9] = new("ImageLabel", I[4], "Admin", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6455511791"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1199671, 1), Visible = false })
			I[10] = new("TextLabel", I[2], "NameDisplay", { Active = true, AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.fromScale(1, 0.35), Text = "Unknown User", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.625, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[11] = new("TextLabel", I[2], "VIPDisplay", { Active = true, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), RichText = true, Size = UDim2.fromScale(1, 0.3), Text = "VIP | SUPER | MEGA | ULTRA", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.625, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
	return I[1]
end

return build
