-- Generated from animations/ServerStorage/RBX_ANIMSAVES/Brainrot~30/Idle Bananito Delfinito.rbxm by _tools/rbxm2lua.luau
-- Animation pack: require(this)() returns the KeyframeSequence / Animation instances

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
	I[1] = new("KeyframeSequence", nil, "Idle Bananito Delfinito", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1786747323" })
		I[2] = new("AnimationRigData", I[1], "BrainrotAnimationRigData")
	return I[1]
end

return build
