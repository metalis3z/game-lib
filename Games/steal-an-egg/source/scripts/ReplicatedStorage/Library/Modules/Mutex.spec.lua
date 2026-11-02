-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 12 ]]
	local Mutex = require(script.Parent.Mutex)

	p1:Describe("Mutex contention", function() --[[ Line: 15 | Upvalues: p1 (copy), Mutex (copy) ]]
		p1:Test("releases many queued waiters without synchronous wakeup recursion", function() --[[ Line: 16 | Upvalues: Mutex (ref), p1 (ref) ]]
			local v1 = Mutex.new()
			local v2 = assert(v1:tryLock())
			local v3 = 0

			for i = 1, 256 do
				task.spawn(function() --[[ Line: 23 | Upvalues: v1 (copy), v3 (ref) ]]
					v1:run(function() --[[ Line: 24 | Upvalues: v3 (ref) ]]
						v3 = v3 + 1
					end)
				end)
			end

			local v4 = os.clock() + 5

			while #v1.waiters < 256 and os.clock() < v4 do
				task.wait()
			end

			p1:Expect(#v1.waiters):ToBe(256)
			v1:unlock(v2)

			local v5 = os.clock() + 15

			while v3 < 256 and os.clock() < v5 do
				task.wait()
			end

			p1:Expect(v3):ToBe(256)
			v1:Destroy()
		end)
	end)
end