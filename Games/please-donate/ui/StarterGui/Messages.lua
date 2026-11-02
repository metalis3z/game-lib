-- Generated from ui/StarterGui/Messages.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Messages", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Folder", I[1], "ActiveMessages")
		I[3] = new("Frame", I[1], "BanTemplate", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, -0.04), Visible = false }, { ["Size"] = 0.04 })
			I[4] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12259533293"), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Selectable = true, Size = UDim2.fromOffset(25, 25), ZIndex = 2 })
				I[5] = new("UIScale", I[4], "UIScale")
			I[6] = new("TextLabel", I[3], "TextLabel", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), RichText = true, Text = "@Username just got Banned from the Game!", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[7] = new("UISizeConstraint", I[6], "UISizeConstraint", { MaxSize = Vector2.new(500, 60) })
			I[8] = new("UICorner", I[3], "UICorner")
			I[9] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 15), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[10] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0, 15), PaddingLeft = UDim.new(0, 20), PaddingRight = UDim.new(0, 20), PaddingTop = UDim.new(0, 15) })
	return I[1]
end

return build
