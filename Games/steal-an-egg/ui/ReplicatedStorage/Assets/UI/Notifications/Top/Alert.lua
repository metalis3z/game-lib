-- Generated from ui/ReplicatedStorage/Assets/UI/Notifications/Top/Alert.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Alert", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
		I[2] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 2), Size = UDim2.fromScale(0.95, 0.25), Text = "Quest Completed!", TextColor3 = Color3.fromRGB(255, 245, 106), TextScaled = true, TextSize = 18, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
		I[4] = new("TextLabel", I[1], "Desc", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.new(0.8, 0, 0.7, -2), Text = "Short desc", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
			I[5] = new("UIStroke", I[4], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[6] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 34 })
	return I[1]
end

return build
