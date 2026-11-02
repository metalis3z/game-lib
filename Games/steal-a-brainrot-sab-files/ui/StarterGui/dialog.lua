-- Generated from ui/StarterGui/dialog.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "dialog", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "dialogResponses", { BackgroundColor3 = Color3.fromRGB(51, 51, 51), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.575, 0.4), Size = UDim2.new(0.4, 0, 0.08, 50) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { Padding = UDim.new(0.06, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[4] = new("ImageButton", I[2], "template", { AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(51, 51, 51), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.0000006, 0), Size = UDim2.fromScale(0, 0.465), Visible = false })
				I[5] = new("TextLabel", I[4], "text", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0248626, 0.5), RichText = true, Size = UDim2.fromScale(0, 0.8), Text = "1.) temp text", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[6] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5, Transparency = 0.4 })
	return I[1]
end

return build
