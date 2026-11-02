-- Generated from ui/ReplicatedStorage/Modules/UI/Quests2/Quest2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Quest2", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1, 0, 0, 100) })
		I[2] = new("UICorner", I[1], "UICorner")
		I[3] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(243, 243, 243), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0.0201854, 22), Text = "Speedy Bee: Starter", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[4] = new("UICorner", I[3], "UICorner")
			I[5] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(239, 239, 239), Thickness = 5 })
		I[6] = new("UIStroke", I[1], "UIStroke", { Thickness = 7.5999999, Transparency = 0.95 })
		I[7] = new("Frame", I[1], "Tasks", { Active = true, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 45), Size = UDim2.new(0.936, 0, 0, 35) })
			I[8] = new("UICorner", I[7], "UICorner")
			I[9] = new("UIListLayout", I[7], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
			I[10] = new("UIStroke", I[7], "UIStroke", { Thickness = 6, Transparency = 0.95 })
	return I[1]
end

return build
