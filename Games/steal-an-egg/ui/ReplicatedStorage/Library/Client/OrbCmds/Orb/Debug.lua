-- Generated from ui/ReplicatedStorage/Library/Client/OrbCmds/Orb/Debug.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Debug", { AlwaysOnTop = true, ClipsDescendants = true, MaxDistance = 0, Size = UDim2.fromOffset(1000, 80), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["Rojo_Target_Adornee"] = "44fe70c04c491d0e07ba4403000097aa", ["__syncback_sanitization_auto_save"] = "Debug" })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["__syncback_sanitization_auto_save"] = "Frame" })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 3, RichText = true, Size = UDim2.fromScale(1, 1), Text = "777.00, 777.00, 777.00<br/>test", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 40, TextWrapped = true }, { ["__syncback_sanitization_auto_save"] = "TextLabel" })
	return I[1]
end

return build
