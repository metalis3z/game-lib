-- Generated from ui/ServerScriptService/Tadashy/TadashyScript/TadashyPanel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TadashyPanel", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.069242, 0.0900141), Size = UDim2.fromScale(0.8761128, 0.8199719), Visible = false })
			I[3] = new("ScrollingFrame", I[2], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.0931414, 0.1234991), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromOffset(363, 398) })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
			I[5] = new("TextButton", I[2], "refresh", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4352244, 0.4219554), Size = UDim2.fromOffset(200, 50), Text = "Refresh", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[6] = new("TextButton", I[2], "add", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4352244, 0.3121784), Size = UDim2.fromOffset(200, 50), Text = "add", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[7] = new("TextBox", I[2], "TextBox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.6325148, 0.3121784), Size = UDim2.fromOffset(200, 50), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[8] = new("TextButton", I[2], "close", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9568163, 0), Size = UDim2.fromOffset(50, 50), Text = "X", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[9] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.0257289 })
		I[10] = new("TextButton", I[1], "open", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0022255, 0.464135), Size = UDim2.fromScale(0.148368, 0.0703235), Text = "Open", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 4 })
	return I[1]
end

return build
