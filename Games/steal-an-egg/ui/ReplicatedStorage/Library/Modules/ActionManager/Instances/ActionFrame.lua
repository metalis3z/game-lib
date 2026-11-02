-- Generated from ui/ReplicatedStorage/Library/Modules/ActionManager/Instances/ActionFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ActionFrame", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(0, 1) }, { ["__syncback_sanitization_auto_save"] = "ActionFrame" })
		I[2] = new("TextButton", I[1], "TouchButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false, ZIndex = 2 }, { ["__syncback_sanitization_auto_save"] = "TouchButton" })
		I[3] = new("Frame", I[1], "ContentFrame", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(0, 1) }, { ["__syncback_sanitization_auto_save"] = "ContentFrame" })
			I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["__syncback_sanitization_auto_save"] = "UIListLayout" })
			I[5] = new("TextLabel", I[3], "ActionLabel", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.new(0, -5, 0.5, 0), Size = UDim2.fromOffset(0, 28), Text = "Keyboard Action", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 }, { ["__syncback_sanitization_auto_save"] = "ActionLabel" })
				I[6] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }, { ["__syncback_sanitization_auto_save"] = "UIPadding" })
				I[7] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) }, { ["__syncback_sanitization_auto_save"] = "UICorner" })
			I[8] = new("Frame", I[3], "InputFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromOffset(48, 48), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 }, { ["__syncback_sanitization_auto_save"] = "InputFrame" })
				I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["__syncback_sanitization_auto_save"] = "UICorner" })
	return I[1]
end

return build
