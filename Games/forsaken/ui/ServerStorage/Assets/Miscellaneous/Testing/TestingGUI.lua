-- Generated from ui/ServerStorage/Assets/Miscellaneous/Testing/TestingGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TestingGUI", { ClipToDeviceSafeArea = false, DisplayOrder = 999, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "serverFPS", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8220121, 0.9243873), RichText = true, Size = UDim2.fromScale(0.171969, 0.0735381), Text = "Server FPS: Loading...", TextColor3 = Color3.fromRGB(255, 0, 0), TextSize = 35, TextXAlignment = Enum.TextXAlignment.Right })
		I[3] = new("TextLabel", I[1], "clientFPS", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.822159, 0.8697925), RichText = true, Size = UDim2.fromScale(0.171969, 0.0735381), Text = "Client FPS: Loading...", TextColor3 = Color3.fromRGB(255, 0, 0), TextSize = 35, TextXAlignment = Enum.TextXAlignment.Right })
	return I[1]
end

return build
