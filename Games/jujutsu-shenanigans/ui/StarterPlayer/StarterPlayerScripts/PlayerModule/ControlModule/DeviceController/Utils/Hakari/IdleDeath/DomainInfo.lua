-- Generated from ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Hakari/IdleDeath/DomainInfo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DomainInfo", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 10, 0.3, 0), Size = UDim2.fromScale(0.3, 0.125), Text = "Getting an even number jackpot starts the next jackpot with faster spins, and getting an odd number starts it with advanced probability!", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[3] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -10, 0.1, 0), Size = UDim2.fromScale(0.3, 0.05), Text = "Scenarios:", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
		I[4] = new("TextLabel", I[1], "Scenario2", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -10, 0.2, 0), Size = UDim2.fromScale(0.3, 0.05), Text = "Transit Card Richii (☆ ☆ ★)", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
		I[5] = new("TextLabel", I[1], "Scenario1", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -10, 0.15, 0), Size = UDim2.fromScale(0.3, 0.05), Text = "Transit Card Richii (☆ ☆ ★)", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
		I[6] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 10, 0.2, 0), Size = UDim2.fromScale(0.4, 0.1), Text = "Failing 3 scenarios will guarentee a jackpot on the next one!", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[7] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 10, 0.1, 0), Size = UDim2.fromScale(0.4, 0.1), Text = "Use 2 visual abilities to advance to a richii scenario!", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
