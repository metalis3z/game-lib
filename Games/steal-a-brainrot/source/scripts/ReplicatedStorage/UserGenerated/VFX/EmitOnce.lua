---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
return function(p_u_1)
	local v2 = p_u_1.TimeScale
	if v2 <= 0 then
		return 0
	end
	local v3 = p_u_1.Rate
	local v4 = p_u_1:GetAttribute("EmitCount")
	if type(v4) ~= "number" then
		v4 = v3
	end
	local v_u_5 = math.floor(v4)
	local v6 = v4 - v_u_5
	if v6 > 0 and math.random() < v6 then
		v_u_5 = v_u_5 + 1
	end
	if v_u_5 < 1 then
		return 0
	end
	local v7 = p_u_1:GetAttribute("EmitDelay")
	local v8 = type(v7) ~= "number" and 0 or v7
	if v8 == (1 / 0) then
		return 0
	end
	local v9 = math.max(v8, 0)
	task.delay(v9, function()
		-- upvalues: (copy) p_u_1, (ref) v_u_5
		p_u_1:Emit(v_u_5)
	end)
	return v9 + p_u_1.Lifetime.Max / v2
end
