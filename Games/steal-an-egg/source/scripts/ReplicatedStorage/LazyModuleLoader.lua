-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Functions = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Functions")
local KeyToString = require(Functions:WaitForChild("KeyToString"))
local InstanceCheck = require(Functions:WaitForChild("InstanceCheck"))
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

local function processKey(p1, p2) --[[ processKey | Line: 23 ]]
	local v1 = p1:gsub("^(.-)%s*|%s*", "")

	if p2.keyParser then
		local v2 = p2.keyParser(v1)

		if not v2 then
			p2.warn(("Invalid key: %s"):format(p1))

			return
		end

		v1 = v2
	end

	return v1
end

return function(p1, p2, p3) --[[ Line: 38 | Upvalues: Asserts (copy), InstanceCheck (copy), KeyToString (copy), Constants (copy) ]]
	Asserts.Instance(p1)
	Asserts.table(p2)
	Asserts.optional.table(p3)

	local v1 = p3 or {}
	local v2 = v1.rootName or "script"
	local v3 = v1.typeCast and ("::%s"):format(v1.typeCast) or ""
	local v4 = v1.warn or warn

	v1.warn = v4
	p2.__lazy_directory = true
	p2.__lazy_cache = {}

	local v5 = true
	local t = {}

	local function injectMetadata(p1, p2, p3) --[[ injectMetadata | Line: 56 | Upvalues: v1 (copy) ]]
		if not v1.shouldInject or type(p3) ~= "table" then
			return
		end

		if p3._id == nil then
			p3._id = p2
		end

		if p3._script ~= nil then
			return
		end

		p3._script = p1
	end

	local function applyLazyMetatable(p1) --[[ applyLazyMetatable | Line: 67 | Upvalues: v5 (ref), v2 (copy), InstanceCheck (ref), v1 (copy) ]]
		local v22 = if typeof(p1) == "table" then p1 or {
	__lazy_directory = true,
	__lazy_cache = {}
} else {
	__lazy_directory = true,
	__lazy_cache = {}
}

		if v22.__lazy_directory and not v22.__lazy_directory_loaded then
			v22.__lazy_directory_loaded = true

			local t = {
				__metatable = "Locked",
				__index = function(p1, p2) --[[ __index | Line: 76 | Upvalues: v22 (ref), v5 (ref), v2 (ref), InstanceCheck (ref), v1 (ref) ]]
					local v12 = v22.__lazy_cache[p2]

					if not (v12 or v5) then
						error(("Unknown entry \'%s\', for \'%s\'"):format(tostring(p2), v2))
					end

					if v5 or not InstanceCheck(v12, "ModuleScript") then
						return v12
					end

					local v23 = require(v12)

					v22.__lazy_cache[p2] = nil
					rawset(p1, p2, v23)

					if v1.shouldInject and type(v23) == "table" then
						if v23._id == nil then
							v23._id = p2
						end

						if v23._script == nil then
							v23._script = v12
						end
					end

					return v23
				end,
				__newindex = function(p1, p2, p3) --[[ __newindex | Line: 95 | Upvalues: v5 (ref), v22 (ref) ]]
					if not v5 then
						error(("Tried to set key \'%s\' on read-only table!"):format(p2))
					end

					rawset(v22, p2, p3)
				end
			}

			return setmetatable(v22, t)
		end

		return v22
	end

	applyLazyMetatable(p2)

	local function v6(p1, p22, p3, p4, p5) --[[ loadModule | Line: 109 | Upvalues: v1 (copy), p2 (copy), applyLazyMetatable (copy), v6 (copy), t (ref), KeyToString (ref), v3 (copy), Constants (ref), v4 (copy) ]]
		local v12 = p3 or 0

		if p1:GetAttribute("NOLOAD") then
			return
		end

		if p1:IsA("Folder") then
			if v1.maxDepth and v1.maxDepth <= v12 then
				return
			end

			local v2 = p2
			local v32 = ("%s:WaitForChild(\"%s\")"):format(p22, p1.Name)
			local v42

			if v1.structureDirectories then
				local v5 = p1.Name
				local v62 = v1
				local v7 = v5:gsub("^(.-)%s*|%s*", "")
				local v8

				if v62.keyParser then
					local v9 = v62.keyParser(v7)

					if v9 then
						v7 = v9
						v8 = v9
					else
						v62.warn(("Invalid key: %s"):format(v5))
						v8 = nil
					end
				else
					v8 = v7
				end

				p4[v8] = p4[v8] or applyLazyMetatable()
				v2 = p4[v8]
				v42 = {}
			else
				v42 = p5
			end

			for i, v in ipairs(p1:GetChildren()) do
				v6(v, v32, v12 + 1, v2, v42)
			end
		else
			if not p1:IsA("ModuleScript") then
				return
			end

			local v11 = p1.Name
			local v122 = v1
			local v13 = v11:gsub("^(.-)%s*|%s*", "")
			local v14

			if v122.keyParser then
				local v15 = v122.keyParser(v13)

				if v15 then
					v13 = v15
					v14 = v15
				else
					v122.warn(("Invalid key: %s"):format(v11))
					v14 = nil
				end
			else
				v14 = v13
			end

			if not v14 then
				return
			end

			if p5[v14] then
				v4(("Duplicate entry: %s"):format(v14))
			else
				p5[v14] = true

				local v16 = p4[v14]

				if v16 then
					if v1.shouldInject and type(v16) == "table" then
						if v16._id == nil then
							v16._id = v14
						end

						if v16._script == nil then
							v16._script = p1
						end
					end

					local v17 = os.clock()
					local v18 = require(p1)
					local v20 = math.ceil((os.clock() - v17) * 1000)

					if v20 >= 25 and Constants.IS_STUDIO then
						v4("[SlowModule]", p1, ("%dms"):format(v20))
					end

					if v16 ~= v18 then
						return v4(("Mismatched entry: %s"):format(v14))
					end
				else
					if not v1.noPrint then
						table.insert(t, ("[%s] = require(%s:WaitForChild(\"%s\"))%s"):format(KeyToString(v14), p22, p1.Name, v3))
					end

					p4.__lazy_cache[v14] = p1
				end
			end
		end
	end

	local t2 = {}

	for i, v in ipairs(p1:GetChildren()) do
		v6(v, v2, 0, p2, t2)
	end

	for k in pairs(p2) do
		if not (t2[k] or k:match("__lazy_")) then
			v4(("Unknown entry: %s"):format(k))
		end
	end

	if not (#t > 0) or v1.noPrint then
		t = nil
		v5 = nil

		return p2
	end

	table.sort(t)
	v4(("Unadded entries: \n\n%s\n"):format(table.concat(t, ",\n") .. ",\n"))
	t = nil
	v5 = nil

	return p2
end