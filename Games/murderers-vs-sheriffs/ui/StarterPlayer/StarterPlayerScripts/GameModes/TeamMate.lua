-- Generated from ui/StarterPlayer/StarterPlayerScripts/GameModes/TeamMate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TeamMate", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, Enabled = false, ExtentsOffsetWorldSpace = Vector3.new(0, 3.5, 0), MaxDistance = math.huge, Size = UDim2.fromOffset(20, 20), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(200, 0, 50), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Rotation = 45, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
