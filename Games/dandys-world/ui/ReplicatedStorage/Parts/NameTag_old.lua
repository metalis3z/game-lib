-- Generated from ui/ReplicatedStorage/Parts/NameTag_old.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "NameTag_old", { Active = true, Brightness = 1.33, Enabled = false, ExtentsOffsetWorldSpace = Vector3.new(0, 5, 0), MaxDistance = 30, Size = UDim2.fromScale(6, 3), StudsOffsetWorldSpace = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "NameTag" })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("TextLabel", I[2], "GroupRank", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3, -0.1), RichText = true, Size = UDim2.fromScale(0.4, 0.2), Text = "[Owner]", TextColor3 = Color3.fromRGB(255, 135, 163), TextDirection = Enum.TextDirection.LeftToRight, TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[4] = new("TextLabel", I[2], "DisplayName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.4), RichText = true, Size = UDim2.fromScale(0.8, 0.3), Text = "Rox", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[5] = new("TextLabel", I[2], "UserName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.2), RichText = true, Size = UDim2.fromScale(0.8, 0.18), Text = "(@RoxSerpent)", TextColor3 = Color3.fromRGB(114, 117, 130), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
		I[6] = new("Frame", I[1], "Outline", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.125, 0.7), Size = UDim2.fromScale(0.75, 0.025), Visible = false })
			I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
	return I[1]
end

return build
