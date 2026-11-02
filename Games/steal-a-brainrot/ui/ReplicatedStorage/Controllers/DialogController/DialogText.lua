-- Generated from ui/ReplicatedStorage/Controllers/DialogController/DialogText.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "DialogText", { Active = true, AlwaysOnTop = true, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(10, 2), StudsOffset = Vector3.new(0, 2.8, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_ebb0a4486d" })
		I[2] = new("TextLabel", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), MaxVisibleGraphemes = 0, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(2, 0.8), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_e22ecafd36" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_a5a2a445c0" })
			I[4] = new("UITextSizeConstraint", I[2], "UITextSizeConstraint", { MaxTextSize = 22 }, { ["ViralWorkerRef"] = "vw_5c751c35c9" })
	return I[1]
end

return build
