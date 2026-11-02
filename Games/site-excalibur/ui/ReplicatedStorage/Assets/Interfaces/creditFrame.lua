-- Generated from ui/ReplicatedStorage/Assets/Interfaces/creditFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "creditFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.0077963) })
		I[2] = new("ImageButton", I[1], "playerIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("“http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=NotVelluto"), Position = UDim2.fromScale(0.0305369, 0.1851615), Size = UDim2.fromScale(0.3110948, 1.2833368) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
		I[4] = new("Frame", I[1], "informationFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.2901006, 0.1842113), Size = UDim2.fromScale(0.7098994, 0.6410483) })
			I[5] = new("Frame", I[4], "dividerFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.0024322, 0.3805104), Size = UDim2.fromScale(0.9975677, 0.02) })
			I[6] = new("TextLabel", I[4], "positionText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.0024322, 0.4764806), Size = UDim2.fromScale(0.9546566, 0.5319107), Text = "GROUP OWNER", TextColor3 = Color3.fromRGB(240, 240, 240), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[7] = new("UIPadding", I[6], "UIPadding", { PaddingBottom = UDim.new(0.5, 0), PaddingRight = UDim.new(0.4, 0) })
			I[8] = new("TextLabel", I[4], "nameText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.0024322, 0.0018975), Size = UDim2.fromScale(0.9546566, 0.3807424), Text = "NOTVELLUTO", TextColor3 = Color3.fromRGB(240, 240, 240), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[9] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder })
	return I[1]
end

return build
