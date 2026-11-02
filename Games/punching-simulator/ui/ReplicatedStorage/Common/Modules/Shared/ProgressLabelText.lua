-- Generated from ui/ReplicatedStorage/Common/Modules/Shared/ProgressLabelText.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "ProgressLabelText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9), RichText = true, Size = UDim2.fromScale(0.441009, 0.1890103), Text = "<stroke color= \"rgb(40, 40, 40)\" joins=\"round\" thickness=\"2\" transparency=\"0\">^^ Reach <font color= \"rgb(0, 255, 0)\">100 Strength</font> for a new fireball ^^</stroke>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 1, TextWrapped = true })
		I[2] = new("UITextSizeConstraint", I[1], "UITextSizeConstraint", { MaxTextSize = 39 })
		I[3] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(40, 40, 40), Thickness = 4 })
	return I[1]
end

return build
