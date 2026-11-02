-- Generated from ui/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/EquipBest.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "EquipBest", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76298087250695"), Position = UDim2.new(0.5, 243, 1, -416), Size = UDim2.fromOffset(160, 40) })
		I[2] = new("UIStroke", I[1], "Border", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.04 })
			I[3] = new("UIScale", I[2], "Scale", { Scale = 0.04 })
		I[4] = new("TextLabel", I[1], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -20, 1, -12), Text = "Equip Best", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextWrapped = true })
			I[5] = new("UIStroke", I[4], "Border", { Thickness = 3 })
			I[6] = new("UITextSizeConstraint", I[4], "TextSizeConstraint", { MaxTextSize = 18, MinTextSize = 18 })
		I[7] = new("UIScale", I[1], "Scale")
	return I[1]
end

return build
