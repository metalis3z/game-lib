-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

return {
	["Create"] = function(p_u_1, p2, p3, p4, p5, p6)
		local v_u_7, v_u_8 = unpack(p2)
		local v_u_9, v_u_10 = unpack(p3)
		local v_u_11 = p_u_1.Image
		local v_u_12 = false
		local v_u_13 = p4 or v_u_9 * v_u_10
		local v_u_14 = 0.016666666666666666 / (p5 or 1)
		local v_u_15 = p6 == nil and true or p6
		coroutine.wrap(function()
			-- upvalues: (copy) p_u_1, (copy) v_u_7, (copy) v_u_8, (copy) v_u_10, (copy) v_u_9, (ref) v_u_12, (copy) v_u_11, (copy) v_u_13, (copy) v_u_14, (ref) v_u_15
			p_u_1.ImageRectSize = Vector2.new(v_u_7, v_u_8)
			p_u_1.ScaleType = Enum.ScaleType.Stretch
			while true do
				local v16 = 0
				for v17 = 0, v_u_10 - 1 do
					for v18 = 0, v_u_9 - 1 do
						if v_u_12 or (p_u_1 == nil or (p_u_1.Parent == nil or p_u_1.Image ~= v_u_11)) then
							return
						end
						if v_u_13 <= v16 then
							break
						end
						v16 = v16 + 1
						p_u_1.ImageRectOffset = Vector2.new(v18 * v_u_7, v17 * v_u_8)
						task.wait(v_u_14)
					end
				end
				if not v_u_15 then
					return
				end
			end
		end)()
		return function()
			-- upvalues: (ref) v_u_12
			v_u_12 = true
		end
	end
}
