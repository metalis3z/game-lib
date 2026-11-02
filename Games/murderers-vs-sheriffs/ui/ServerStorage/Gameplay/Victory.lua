-- Generated from ui/ServerStorage/Gameplay/Victory.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Victory", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, ExtentsOffsetWorldSpace = Vector3.new(0, 3.75, 0), MaxDistance = math.huge, Size = UDim2.fromScale(5, 0.9), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["Player"] = "KingvonMM2Holder" }, { "VictoryBillboard" })
		I[2] = new("TextLabel", I[1], "Sheriff", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Victory!", TextColor3 = Color3.fromRGB(0, 115, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(22, 4, 4), TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
		I[3] = new("TextLabel", I[1], "Murderer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Victory!", TextColor3 = Color3.fromRGB(222, 41, 41), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(22, 4, 4), TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
		I[4] = new("TextLabel", I[1], "Assassin", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Victory!", TextColor3 = Color3.fromRGB(222, 41, 41), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(22, 4, 4), TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
		I[5] = new("TextLabel", I[1], "Hero", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Victory!", TextColor3 = Color3.fromRGB(255, 191, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(22, 4, 4), TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
		I[6] = new("TextLabel", I[1], "Team2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "MVP 🏆", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(22, 4, 4), TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
		I[7] = new("TextLabel", I[1], "Team1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "MVP 🏆", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(22, 4, 4), TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
		I[8] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
	return I[1]
end

return build
