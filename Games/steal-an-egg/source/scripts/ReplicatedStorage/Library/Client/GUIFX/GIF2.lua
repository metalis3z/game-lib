-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Create = function(p1, p2, p3, p4, p5, p6) --[[ Create | Line: 9 ]]
		local v1, v2 = unpack(p2)
		local v3, v4 = unpack(p3)
		local Image = p1.Image
		local v5 = false
		local v6 = p4 or v3 * v4
		local v7 = 1 / 60 / (p5 or 1)
		local v8 = if p6 == nil then true else p6

		coroutine.wrap(function() --[[ Line: 26 | Upvalues: p1 (copy), v1 (copy), v2 (copy), v4 (copy), v3 (copy), v5 (ref), Image (copy), v6 (copy), v7 (copy), v8 (copy) ]]
			p1.ImageRectSize = Vector2.new(v1, v2)

			repeat
				local count = 0

				for i = 0, v4 - 1 do
					for j = 0, v3 - 1 do
						if v5 or (p1.Parent == nil or p1.Image ~= Image) then
							return
						end

						if v6 <= count then
							break
						end

						p1.ImageRectOffset = Vector2.new(j * v1, i * v2)
						task.wait(v7)
						count = count + 1
					end
				end
			until not v8
		end)()

		return function() --[[ Line: 49 | Upvalues: v5 (ref) ]]
			v5 = true
		end
	end
}