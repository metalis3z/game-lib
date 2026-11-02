-- Generated from ui/ReplicatedStorage/Assets/Billboards/MurdererCantCollect.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "MurdererCantCollect", { Active = true, AlwaysOnTop = true, MaxDistance = 80, ResetOnSpawn = false, Size = UDim2.fromScale(15, 6) })
		I[2] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.3), Text = "CANNOT COLLECT \n (Murderer)", TextColor3 = Color3.fromRGB(255, 83, 83), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2, Transparency = 0.35 })
	return I[1]
end

return build
