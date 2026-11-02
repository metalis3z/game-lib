-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	preloadAnimArray = function(p1, p2, p3, p4) --[[ preloadAnimArray | Line: 5 ]]
		local t = {}

		for v1, v2 in p2 do
			local Animation = Instance.new("Animation")

			Animation.AnimationId = "rbxassetid://" .. tostring(v2.id)

			local v3 = p1:LoadAnimation(Animation)

			v3.Priority = p4
			v3.Looped = if v2.looped == nil then true else v2.looped
			v3.Name = p3
			t[#t + 1] = {
				anim = v3,
				weight = v2.weight,
				fadeTime = v2.fadeTime,
				speed = v2.speed
			}
		end

		return t
	end
}

function t.preloadAnimList(p1, p2, p3, p4) --[[ preloadAnimList | Line: 27 | Upvalues: t (copy) ]]
	local t2 = {}

	for v1, v2 in p2 do
		t2[v1] = t.preloadAnimArray(p1, v2, p3, p4)
	end

	return t2
end

return t