--credit to quartz games studio
local HideCollectProximityPrompts = game.Players.LocalPlayer:WaitForChild("HideCollectProximityPrompts")
local CollectionService = game:GetService("CollectionService")

local function TrackPrompt(p1, p2) --[[ TrackPrompt | Line: 12 | Upvalues: HideCollectProximityPrompts (copy) ]]
	p1[p2] = true

	if HideCollectProximityPrompts.Value == true then
		p2.Enabled = false
	end

	p2.Destroying:Once(function() --[[ Line: 17 | Upvalues: p1 (copy), p2 (copy) ]]
		p1[p2] = nil
	end)
end

local t = {}
local t2 = {}

for v1, v2 in CollectionService:GetTagged("HarvestPrompt") do
	t[v2] = true

	if HideCollectProximityPrompts.Value == true then
		v2.Enabled = false
	end

	v2.Destroying:Once(function() --[[ Line: 17 | Upvalues: t (copy), v2 (copy) ]]
		t[v2] = nil
	end)
end

for v3, v4 in CollectionService:GetTagged("StealPrompt") do
	t2[v4] = true

	if HideCollectProximityPrompts.Value == true then
		v4.Enabled = false
	end

	v4.Destroying:Once(function() --[[ Line: 17 | Upvalues: t2 (copy), v4 (copy) ]]
		t2[v4] = nil
	end)
end

CollectionService:GetInstanceAddedSignal("HarvestPrompt"):Connect(function(p1) --[[ Line: 30 | Upvalues: t (copy), HideCollectProximityPrompts (copy) ]]
	local v1 = t

	v1[p1] = true

	if HideCollectProximityPrompts.Value == true then
		p1.Enabled = false
	end

	p1.Destroying:Once(function() --[[ Line: 17 | Upvalues: v1 (copy), p1 (copy) ]]
		v1[p1] = nil
	end)
end)
CollectionService:GetInstanceAddedSignal("StealPrompt"):Connect(function(p1) --[[ Line: 34 | Upvalues: t2 (copy), HideCollectProximityPrompts (copy) ]]
	local v1 = t2

	v1[p1] = true

	if HideCollectProximityPrompts.Value == true then
		p1.Enabled = false
	end

	p1.Destroying:Once(function() --[[ Line: 17 | Upvalues: v1 (copy), p1 (copy) ]]
		v1[p1] = nil
	end)
end)
HideCollectProximityPrompts:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 38 | Upvalues: HideCollectProximityPrompts (copy), t (copy), t2 (copy) ]]
	local v1 = HideCollectProximityPrompts.Value

	for v2 in t do
		v2.Enabled = not v1
	end

	for v3 in t2 do
		v3.Enabled = not v1
	end
end)