-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")

return {
	new = function(p1, p2, p3, p4) --[[ new | Line: 5 | Upvalues: RunService (copy) ]]
		assert(if type(p1) == "number" then true else false)
		assert(if type(p2) == "number" then true else false)
		assert(if type(p3) == "number" then true else false)
		assert(if type(p4) == "function" then true else false)

		local t = {}
		local v5 = false
		local t2 = {}

		function t.get(p12, p2, p3, ...) --[[ get | Line: 15 | Upvalues: v5 (ref), p1 (copy), t2 (copy), p4 (copy) ]]
			assert(if p12 == nil then false else true)

			if p2 ~= nil then
				assert(type(p2) == "number")
				assert(if p2 == p2 then true else false)
				assert(if p2 >= 0 then true else false)
			end

			assert(if p3 == nil then true elseif type(p3) == "boolean" then true else false)
			assert(not v5)

			local v7 = if p2 then p2 else p1
			local v8 = t2[p12]

			if v8 then
				v8.usedTimestamp = os.clock()
			else
				v8 = {
					usedTimestamp = os.clock()
				}
				t2[p12] = v8
			end

			if not p3 and (not v8.executeTimestamp or v7 <= os.clock() - v8.executeTimestamp) then
				if v8.executing then
					repeat
						task.wait()
					until not v8.executing

					v8.usedTimestamp = os.clock()
				else
					v8.executing = true

					local v9 = nil
					local ok, result = pcall(function(...) --[[ Line: 42 | Upvalues: p4 (ref), p12 (copy), v9 (ref), v8 (ref) ]]
						local v1, v2 = p4(p12, ...)

						if not v1 then
							return
						end

						v9 = os.clock()
						assert(v9)
						v8.valueTimestamp = v9
						v8.value = v2
					end, ...)

					v9 = v9 or os.clock()

					local v11 = v9

					assert(v11)
					v8.executeTimestamp = v9
					v8.usedTimestamp = v9
					v8.executing = false

					if not ok then
						print(("SmartCache.get(%*, %*, %*, ...) failed: %*"):format(p12, v7, p3, (tostring(result))))
					end
				end
			end

			return v8.value
		end
		function t.clear(p1) --[[ clear | Line: 66 | Upvalues: v5 (ref), t2 (copy) ]]
			assert(p1 ~= nil)
			assert(not v5)
			t2[p1] = nil
		end
		function t.set(p1, p2, p3) --[[ set | Line: 72 | Upvalues: v5 (ref), t2 (copy) ]]
			assert(if p1 == nil then false else true)
			assert(not v5)

			local v3 = os.clock()
			local v4 = t2[p1]

			if v4 then
				v4.usedTimestamp = v3
			else
				local t = {
					usedTimestamp = v3
				}

				t2[p1] = t
				v4 = t
			end

			if not p3 then
				v4.executeTimestamp = v3
				v4.valueTimestamp = v3
			end

			v4.value = p2
		end
		function t.gc() --[[ gc | Line: 90 | Upvalues: v5 (ref), t2 (copy), p2 (copy) ]]
			if v5 then
				return
			end

			local v1 = os.clock()

			for k, v in pairs(t2) do
				if not v.executing and p2 <= v1 - v.usedTimestamp then
					t2[k] = nil
				end
			end
		end

		local v6 = nil
		local v7 = math.random() * p3

		v6 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 103 | Upvalues: v5 (ref), v6 (ref), v7 (ref), p3 (copy), t (copy) ]]
			if v5 then
				if v6 then
					v6:Disconnect()
				end
			else
				v7 = v7 + p1

				if not (p3 <= v7) then
					return
				end

				v7 = 0
				t.gc()
			end
		end)
		function t.destroy() --[[ destroy | Line: 117 | Upvalues: v5 (ref), v6 (ref) ]]
			if v5 then
				return
			end

			v5 = true

			if not v6 then
				return
			end

			v6:Disconnect()
		end

		return t
	end
}