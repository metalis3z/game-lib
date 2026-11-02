-- Generated from ui/ReplicatedStorage/Systems/Character/Game/SurvivorRequests/RequestUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "RequestUI", { Active = true, AlwaysOnTop = true, ExtentsOffset = Vector3.new(0, 0, -1), LightInfluence = 1, MaxDistance = math.huge, Size = UDim2.fromOffset(200, 50), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromOffset(200, 50), Text = "Needs help!", TextColor3 = Color3.fromRGB(127, 255, 127), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.25, TextWrapped = true })
	return I[1]
end

return build
