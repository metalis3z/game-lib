-- Generated from ui/ReplicatedStorage/ReplicatedGui/DialogAnswers.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "DialogAnswers", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(15, 5), StudsOffset = Vector3.new(10, -1, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_12faa5e7e1" })
		I[2] = new("Frame", I[1], "Main", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.01, 0), Size = UDim2.fromScale(1, 0.8) }, { ["ViralWorkerRef"] = "vw_4c70a28510" })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_e6d8a74e40" })
			I[4] = new("TextButton", I[2], "Template", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1401165, 0.1098117), RichText = true, Selected = true, SelectionGroup = true, Size = UDim2.fromScale(1, 0.15), Text = "#1 EU QUERO VENDER ISSO AQUI!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["ViralWorkerRef"] = "vw_16ef7b7ced" })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.4 }, { ["ViralWorkerRef"] = "vw_ade59461d5" })
	return I[1]
end

return build
