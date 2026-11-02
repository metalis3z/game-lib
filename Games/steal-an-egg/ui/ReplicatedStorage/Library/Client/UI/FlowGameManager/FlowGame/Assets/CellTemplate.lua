-- Generated from ui/ReplicatedStorage/Library/Client/UI/FlowGameManager/FlowGame/Assets/CellTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CellTemplate", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 0, 4), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromOffset(100, 100) }, { ["__syncback_sanitization_auto_save"] = "CellTemplate" })
		I[2] = new("Frame", I[1], "Effects", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(33, 33, 33), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["__syncback_sanitization_auto_save"] = "Effects" })
		I[3] = new("TextButton", I[1], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(10, 10, 10), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -2, 1, -2), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = -1 }, { ["__syncback_sanitization_auto_save"] = "Button" })
	return I[1]
end

return build
