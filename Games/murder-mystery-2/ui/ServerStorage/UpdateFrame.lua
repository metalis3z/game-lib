-- Generated from ui/ServerStorage/UpdateFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "UpdateFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Position = UDim2.fromOffset(0, 50), Size = UDim2.new(1, 0, 0, 42) })
		I[2] = new("TextLabel", I[1], "Date", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(2, 20), Size = UDim2.new(1, 0, 0, 18), Text = "28 minutes ago", TextColor3 = Color3.fromRGB(177, 177, 177), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left })
		I[3] = new("TextLabel", I[1], "Update", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(2, 0), Size = UDim2.new(1, 0, 0, 20), Text = "New map added.", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextXAlignment = Enum.TextXAlignment.Left })
		I[4] = new("NumberValue", I[1], "Time")
	return I[1]
end

return build
