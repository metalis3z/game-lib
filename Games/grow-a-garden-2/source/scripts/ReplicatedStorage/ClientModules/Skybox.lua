--credit to quartz games studio
local t = {
	List = {}
}
local v1 = nil

local function AdjustSkyboxes() --[[ AdjustSkyboxes | Line: 7 | Upvalues: t (copy), v1 (ref) ]]
	local v12 = nil
	local v2 = nil

	for v3, v4 in t.List do
		if not v12 or v12 <= v4 then
			v12 = v4
			v2 = v3
		end
	end

	if v1 and v1 ~= v2 then
		v1.Parent = script
	end

	v1 = v2
	v2.Parent = game.Lighting
end

function t.SetOrder(p1, p2) --[[ SetOrder | Line: 28 | Upvalues: t (copy), AdjustSkyboxes (copy) ]]
	t.List[p1] = p2
	AdjustSkyboxes()
end
t.SetOrder(game.Lighting.Sky, 1)

return t