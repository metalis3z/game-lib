-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FastDefer, time of decompilation: Sun May  3 10:10:32 2026 ]]
--!native
local t1 = table.create(500)

local function RunFunction(p1: ((...any) -> ...any), p2: thread, ...) -- line: 6
	-- upvalues: t1 (copy)
	p1(...)
	table.insert(t1, p2)
end
local function Yield() -- line: 11
	-- upvalues: RunFunction (copy)
	while true do
		RunFunction(coroutine.yield())
	end
end

return function(p3: ((...any) -> ...any), ...) --[[ FastDefer ]] -- line: 17
	-- upvalues: t1 (copy), Yield (copy)
	local v7 = #t1
	local v8

	if v7 > 0 then
		v8 = t1[v7]
		t1[v7] = nil
	else
		v8 = coroutine.create(Yield)
		coroutine.resume(v8)
	end

	return task.defer(v8, p3, v8, ...)
end
