-- Generated from ui/ReplicatedStorage/ReplicatedGui/Notification.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Notification", { DisplayOrder = 5, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_881f66a4b8" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Notification", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.6689611), Size = UDim2.fromScale(1, 0.4807293), ZIndex = 5 }, { ["ViralWorkerRef"] = "vw_bc491c6add" })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 4 }, { ["ViralWorkerRef"] = "vw_0433d4b822" })
			I[4] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom }, { ["ViralWorkerRef"] = "vw_dbcce4ad34" })
			I[5] = new("TextLabel", I[2], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, RichText = true, Size = UDim2.fromScale(1, 0.12), Text = "NOTIFICATION TEMPLATE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["ViralWorkerRef"] = "vw_337cceefed" })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_0fb0b6277a" }, { "ScreenStroke", "UIStroke" })
				I[7] = new("ImageLabel", I[5], "Avatar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0, 4, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(38, 38), Visible = false, ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_ee06786f66" })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["ViralWorkerRef"] = "vw_3eb2eb0867" })
					I[9] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 }, { ["ViralWorkerRef"] = "vw_80422ec59c" })
				I[10] = new("UIPadding", I[5], "UIPadding", nil, { ["ViralWorkerRef"] = "vw_edd5c69bda" })
	return I[1]
end

return build
