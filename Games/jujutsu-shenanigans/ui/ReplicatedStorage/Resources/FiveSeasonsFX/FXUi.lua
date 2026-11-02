-- Generated from ui/ReplicatedStorage/Resources/FiveSeasonsFX/FXUi.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "FXUi", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Vignette", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=192776775"), ImageTransparency = 1, Position = UDim2.new(0, -3, -0.0953704, -3), Size = UDim2.new(1, 5, 1.1, 5) })
		I[3] = new("ImageLabel", I[1], "Vignette2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=192776775"), ImageTransparency = 1, Position = UDim2.new(0, -3, -0.0953704, -3), Size = UDim2.new(1, 5, 1.1, 5) })
		I[4] = new("ImageLabel", I[1], "FiveSeasons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18461885601"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 150 })
		I[5] = new("ImageLabel", I[1], "FiveSeasonsDots", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17356805968"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 155 })
		I[6] = new("ImageLabel", I[1], "Punches", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347809692"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
		I[7] = new("ImageLabel", I[1], "White", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=14846394635"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 100 })
		I[8] = new("Folder", I[1], "ImpactFrames")
			I[9] = new("ImageLabel", I[8], "1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17346970224"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1) })
			I[10] = new("ImageLabel", I[8], "2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347684206"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 12 })
			I[11] = new("ImageLabel", I[8], "3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347686924"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 13 })
			I[12] = new("ImageLabel", I[8], "4", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347690212"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[13] = new("ImageLabel", I[8], "5", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347685782"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[14] = new("ImageLabel", I[8], "6", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347708539"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[15] = new("ImageLabel", I[8], "7", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347708315"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[16] = new("ImageLabel", I[8], "8", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347707975"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[17] = new("ImageLabel", I[8], "9", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347707700"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[18] = new("ImageLabel", I[8], "10", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347707474"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[19] = new("ImageLabel", I[8], "11", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347707209"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[20] = new("ImageLabel", I[8], "12", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347707014"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[21] = new("ImageLabel", I[8], "13", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347706806"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[22] = new("ImageLabel", I[8], "14", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347706466"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[23] = new("ImageLabel", I[8], "15", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347706137"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[24] = new("ImageLabel", I[8], "16", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347705829"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[25] = new("ImageLabel", I[8], "17", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347705579"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[26] = new("ImageLabel", I[8], "18", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347705251"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[27] = new("ImageLabel", I[8], "19", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347704883"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[28] = new("ImageLabel", I[8], "20", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347704516"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[29] = new("ImageLabel", I[8], "21", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347704069"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[30] = new("ImageLabel", I[8], "22", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347703745"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[31] = new("ImageLabel", I[8], "23", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347703368"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[32] = new("ImageLabel", I[8], "24", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347703007"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[33] = new("ImageLabel", I[8], "25", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347702728"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[34] = new("ImageLabel", I[8], "26", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347702433"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[35] = new("ImageLabel", I[8], "27", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347702120"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[36] = new("ImageLabel", I[8], "28", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347701445"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[37] = new("ImageLabel", I[8], "29", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347701136"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[38] = new("ImageLabel", I[8], "30", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347700792"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[39] = new("ImageLabel", I[8], "31", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347700354"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[40] = new("ImageLabel", I[8], "32", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347700035"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[41] = new("ImageLabel", I[8], "33", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347699788"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[42] = new("ImageLabel", I[8], "34", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347699461"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[43] = new("ImageLabel", I[8], "35", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347699145"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[44] = new("ImageLabel", I[8], "36", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347698620"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[45] = new("ImageLabel", I[8], "37", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347698120"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[46] = new("ImageLabel", I[8], "38", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347697854"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[47] = new("ImageLabel", I[8], "39", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347697646"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
			I[48] = new("ImageLabel", I[8], "40", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17347697646"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1, 1), ZIndex = 14 })
	return I[1]
end

return build
