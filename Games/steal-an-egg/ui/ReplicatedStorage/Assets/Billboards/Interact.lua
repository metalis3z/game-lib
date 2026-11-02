-- Generated from ui/ReplicatedStorage/Assets/Billboards/Interact.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Interact", { Active = true, AlwaysOnTop = true, MaxDistance = 0, ResetOnSpawn = false, Size = UDim2.new(3, 50, 3, 70) })
		I[2] = new("TextButton", I[1], "Button", { AnchorPoint = Vector2.new(0.5, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.8), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[4] = new("Frame", I[2], "Back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[5] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(109, 109, 109), Enabled = false, Thickness = 4 })
				I[6] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
				I[7] = new("Frame", I[4], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[9] = new("Frame", I[4], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.05, 1.05), ZIndex = 0 })
					I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
				I[11] = new("ImageLabel", I[4], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://129165340790586"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[12] = new("ImageLabel", I[4], "CustomIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://124851686625237"), Position = UDim2.fromScale(0.9, 0.9), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.35, 0.35), Visible = false, ZIndex = 20 })
					I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
		I[14] = new("TextLabel", I[1], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "Interact", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(109, 109, 109), TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build
