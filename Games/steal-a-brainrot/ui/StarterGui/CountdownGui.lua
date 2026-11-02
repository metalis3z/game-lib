-- Generated from ui/StarterGui/CountdownGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CountdownGui", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_1696051434" })
		I[2] = new("TextLabel", I[1], "TopText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4995697, 0.0806366), Size = UDim2.fromOffset(334, 56), Text = "UPDATE IN:", TextColor3 = Color3.fromRGB(85, 255, 127), TextScaled = true, TextSize = 100, TextStrokeTransparency = 0, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_e2022f28fb" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_d1f852227f" })
			I[4] = new("UITextSizeConstraint", I[2], "UITextSizeConstraint", { MinTextSize = 8 }, { ["ViralWorkerRef"] = "vw_8ee570505d" })
		I[5] = new("TextLabel", I[1], "TimeText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4940303, 0.1525681), Size = UDim2.fromOffset(189, 58), Text = "1h 32m 33s", TextColor3 = Color3.fromRGB(85, 255, 127), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_83a081b129" })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_dcb43b6d84" })
			I[7] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MinTextSize = 10 }, { ["ViralWorkerRef"] = "vw_09ceb56654" })
	return I[1]
end

return build
