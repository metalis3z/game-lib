--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
TablesLibrary = {}
function TablesLibrary.DeepCopy(p1) --[[ Line: 7 ]]
	local t = {}

	for v1, v2 in p1 do
		if typeof(v2) == "table" then
			t[v1] = TablesLibrary.DeepCopy(v2)

			continue
		end

		t[v1] = v2
	end

	return setmetatable(t, (getmetatable(p1)))
end
function TablesLibrary.DeepCopyPaste(p1, p2) --[[ Line: 22 ]]
	for v1, v2 in p1 do
		if typeof(v2) == "table" then
			if typeof(p2[v1]) ~= "table" then
				p2[v1] = {}
			end

			TablesLibrary.DeepCopyPaste(v2, p2[v1])

			continue
		end

		p2[v1] = v2
	end

	setmetatable(p2, (getmetatable(p1)))
end

local function LockKeyInTable(p1, p2) --[[ LockKeyInTable | Line: 39 ]]
	local v1 = getmetatable(p1) or {}
	local __index = v1.__index

	function v1.__index(p1, p22) --[[ Line: 43 | Upvalues: p2 (copy), __index (copy) ]]
		if p22 == p2 then
			error((("Attempt to read locked key: %*"):format(p22)))
		end

		if type(__index) == "function" then
			return __index(p1, p22)
		end

		if type(__index) == "table" then
			return __index[p22]
		end
	end
	function v1.__newindex(p1, p22, p3) --[[ Line: 53 | Upvalues: p2 (copy) ]]
		if p22 == p2 then
			error((("Attempt to modify locked key: %*"):format(p22)))
		end

		rawset(p1, p22, p3)
	end
	setmetatable(p1, v1)
end

TablesLibrary.LockKeyInTable = LockKeyInTable
function TablesLibrary.RemoveMetatable(p1) --[[ Line: 65 ]]
	setmetatable(p1, nil)
end

return TablesLibrary