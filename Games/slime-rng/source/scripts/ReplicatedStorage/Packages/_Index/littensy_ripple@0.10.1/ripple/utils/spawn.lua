-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: spawn, time of decompilation: Sun May  3 10:10:50 2026 ]]
local u1 = nil

local function run(p1: thread, p2: ((...any) -> ...any), ...) -- line: 3
	-- upvalues: u1 (ref)
	u1 = nil
	p2(...)
	u1 = p1
end
local function runner() -- line: 9
	-- upvalues: run (copy)
	while true do
		run(coroutine.yield())
	end
end

return not task and function(p3: ((...any) -> ...any), ...) --[[ call ]] -- line: 20
	p3(...)
end or function(p4: ((...any) -> ...any), ...) --[[ spawn ]] -- line: 15
	-- upvalues: u1 (ref), runner (copy)
	local v7 = u1 or task.spawn(runner)

	task.spawn(v7, v7, p4, ...)
end
