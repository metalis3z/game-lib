-- Generated from ui/ReplicatedStorage/Assets/Billboards/NestCountBillBoard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "NestCountBillBoard", { MaxDistance = 100, Size = UDim2.fromScale(3.5, 1.3), StudsOffset = Vector3.new(0, 4, 0) })
		I[2] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 215, 0), BorderSizePixel = 2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "5/5", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.7 })
	return I[1]
end

return build
