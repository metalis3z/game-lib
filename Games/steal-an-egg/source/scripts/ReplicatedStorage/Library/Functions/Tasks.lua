-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local t = {}
	local t2 = {}

	function t.track(p1) --[[ track | Line: 5 | Upvalues: t2 (copy) ]]
		t2[p1] = true
	end
	function t.cleanup() --[[ cleanup | Line: 9 | Upvalues: t2 (copy) ]]
		for k in pairs(t2) do
			if coroutine.status(k) == "dead" then
				t2[k] = nil
			end
		end
	end
	function t.spawn(p1, ...) --[[ spawn | Line: 17 | Upvalues: t (copy) ]]
		t.track(task.spawn(p1, ...))
	end
	function t.defer(p1, ...) --[[ defer | Line: 21 | Upvalues: t (copy) ]]
		t.track(task.defer(p1, ...))
	end
	function t.delay(p1, p2, ...) --[[ delay | Line: 25 | Upvalues: t (copy) ]]
		t.track(task.delay(p1, p2, ...))
	end
	function t.isDone() --[[ isDone | Line: 29 | Upvalues: t2 (copy) ]]
		for k in pairs(t2) do
			if coroutine.status(k) ~= "dead" then
				return false
			end
		end

		return true
	end
	function t.wait() --[[ wait | Line: 38 | Upvalues: t (copy) ]]
		while not t.isDone() do
			task.wait()
		end
	end
	function t.waitFor(p1) --[[ waitFor | Line: 44 | Upvalues: t (copy) ]]
		local v1 = os.clock()

		while not t.isDone() do
			if p1 <= os.clock() - v1 then
				return false
			end

			task.wait()
		end

		return true
	end

	return t
end