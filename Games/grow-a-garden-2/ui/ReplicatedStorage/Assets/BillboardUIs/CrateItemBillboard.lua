-- Generated from ui/ReplicatedStorage/Assets/BillboardUIs/CrateItemBillboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "CrateItemBillboard", { AlwaysOnTop = true, MaxDistance = 80, Size = UDim2.fromOffset(150, 50), StudsOffset = Vector3.new(0, 4.8700013, 0) })
		I[2] = new("Frame", I[1], "Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[3] = new("TextLabel", I[2], "ItemName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.55), Text = "Pinata", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.75, TextWrapped = true })
				I[4] = new("UIStroke", I[3], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 })
			I[5] = new("TextLabel", I[2], "ItemLuck", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.55), Size = UDim2.fromScale(1, 0.45), Text = "Uncommon - 63%", TextColor3 = Color3.fromRGB(195, 255, 85), TextScaled = true, TextSize = 16, TextStrokeTransparency = 0.75, TextWrapped = true })
				I[6] = new("UIStroke", I[5], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
	return I[1]
end

return build
