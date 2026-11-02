-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: schedule, time of decompilation: Sun May  3 10:10:49 2026 ]]
return function(s1: string, p1: ((...any) -> ...any)) --[[ schedule ]] -- line: 10
	local t1 = {}
	local n1 = 0
	local u5 = nil

	local function remove(p2) -- line: 18
		-- upvalues: t1 (copy), n1 (ref)
		local v8 = table.find(t1, p2)

		if v8 then
			t1[v8] = t1[n1]
			t1[n1] = nil
			n1 -= 1
		end
	end

	return {
		states = t1,
		update = function(p3, n2: number) --[[ update ]] -- line: 34
			-- upvalues: p1 (copy), remove (copy)
			return p1(p3, n2, remove)
		end,
		step = function(n3: number) --[[ step ]] -- line: 28
			-- upvalues: n1 (ref), p1 (copy), t1 (copy), remove (copy)
			for i = n1, 1, -1 do
				p1(t1[i], n3, remove)
			end
		end,
		add = function(p4) --[[ add ]] -- line: 38
			-- upvalues: t1 (copy), n1 (ref), u5 (ref), s1 (copy), p1 (copy), remove (copy)
			if table.find(t1, p4) then
				return
			end

			table.insert(t1, p4)
			n1 += 1

			if not game or u5 then
				return
			end

			u5 = game:GetService("RunService").Heartbeat:Connect(function(dt) -- line: 50
				-- upvalues: s1 (copy), n1 (ref), p1 (copy), t1 (copy), remove (copy), u5 (ref)
				debug.profilebegin(`Ripple{ s1 }`)

				for i = n1, 1, -1 do
					p1(t1[i], dt, remove)
				end

				debug.profileend()

				if u5 and n1 == 0 then
					u5:Disconnect()
					u5 = nil
				end
			end)
		end,
		remove = remove,
		clear = function() --[[ clear ]] -- line: 62
			-- upvalues: t1 (copy), n1 (ref)
			table.clear(t1)
			n1 = 0
		end
	}
end
