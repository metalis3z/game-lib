-- Generated from ui/ServerStorage/e/Effects~2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "Effects", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 100), Size = UDim2.new(1, 0, 0, 50), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Effects", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
		I[2] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=339605303"), Position = UDim2.fromOffset(-5, -5), Size = UDim2.fromOffset(37, 37), SizeConstraint = Enum.SizeConstraint.RelativeYY })
	return I[1]
end

return build
