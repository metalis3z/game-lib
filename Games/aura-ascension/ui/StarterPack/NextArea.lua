-- Generated from ui/StarterPack/NextArea.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("CanvasGroup", nil, "NextArea", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.13), Size = UDim2.fromScale(0.5114155, 0.2503821) })
		I[2] = new("TextLabel", I[1], "AreaBoost", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 10, Position = UDim2.fromScale(0.5, 0.199383), RichText = true, Size = UDim2.fromScale(0.6625821, 0.2513083), Text = "<font face=\"Montserrat\" weight=\"900\"><font color=\"rgb(255, 255, 255)\">~ </font>Reach <font color=\"rgb(0, 255, 255)\" weight=\"900\">100M</font> <font color=\"rgb(190, 0, 255)\" weight=\"900\">Aura</font> - <font color=\"rgb(255, 140, 0)\" weight=\"900\">Fire Bath</font><font color=\"rgb(255, 255, 255)\"> ~</font></font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.08 })
		I[4] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://80985659773685"), LayoutOrder = 5, Position = UDim2.fromScale(0.0353815, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3158625, 0.3987661), Visible = false })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 3.667901 })
		I[6] = new("Folder", I[1], "Folder")
	return I[1]
end

return build
