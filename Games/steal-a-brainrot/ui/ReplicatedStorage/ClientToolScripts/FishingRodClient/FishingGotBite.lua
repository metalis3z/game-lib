-- Generated from ui/ReplicatedStorage/ClientToolScripts/FishingRodClient/FishingGotBite.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "FishingGotBite", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 40, Size = UDim2.fromScale(2.5, 2.5), StudsOffset = Vector3.new(0, 2.5, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_55947892a6" })
		I[2] = new("Sound", I[1], "Exclamation", { AcousticSimulationEnabled = false, RollOffMaxDistance = 60, RollOffMode = Enum.RollOffMode.InverseTapered }, { ["ViralWorkerRef"] = "vw_6ab1867fcb" })
		I[3] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), RichText = true, Size = UDim2.fromScale(1, 1), Text = "!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_b4cd164a64" })
			I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 247, 8)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 47, 47)) }) }, { ["ViralWorkerRef"] = "vw_0f53ad5d91" })
			I[5] = new("UIStroke", I[3], "UIStroke", nil, { ["ViralWorkerRef"] = "vw_fa5c153eb4" })
	return I[1]
end

return build
