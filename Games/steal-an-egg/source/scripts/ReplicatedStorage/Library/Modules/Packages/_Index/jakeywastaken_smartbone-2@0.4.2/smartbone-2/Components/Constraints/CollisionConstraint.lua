-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ Line: 1 ]]
	local t = {}
	local t2 = {}

	for v1, v2 in p3 do
		local v3 = v2:GetCollisions(p2, p1.Radius)

		if #v3 > 0 then
			table.insert(t, v2:GetObject())
		end

		for v4, v5 in v3 do
			table.insert(t2, v5)
		end
	end

	for v6, v7 in t2 do
		p2 = v7.ClosestPoint + v7.Normal * p1.Radius
	end

	p1.CollisionsData = t2
	p1.CollisionHits = t

	return p2
end