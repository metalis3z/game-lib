-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KeyToString = require(ReplicatedStorage.Library.Functions.KeyToString)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

return function(p1, p2, p3) --[[ Line: 21 | Upvalues: Asserts (copy), Constants (copy), KeyToString (copy), MakeTableStrict (copy) ]]
	Asserts.Instance(p1)
	Asserts.table(p2)
	Asserts.optional.table(p3)

	local v1 = p3 or {}
	local v2 = v1.rootName or "script"
	local v3 = v1.typeCast and ("::%s"):format(v1.typeCast) or ""
	local v4 = v1.warn or warn
	local t = {}
	local t2 = {}

	local function injectMetadata(p1, p2, p3) --[[ injectMetadata | Line: 35 | Upvalues: v1 (copy) ]]
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

	local function v5(p1, p22) --[[ loadModule | Line: 46 | Upvalues: v5 (copy), v1 (copy), v4 (copy), t (copy), Constants (ref), p2 (copy), t2 (copy), KeyToString (ref), v3 (copy) ]]
		if p1:GetAttribute("NOLOAD") then
			return
		end

		if p1:IsA("Folder") then
			for i, v in ipairs(p1:GetChildren()) do
				v5(v, ("%s:WaitForChild(\"%s\")"):format(p22, p1.Name))
			end
		else
			if not p1:IsA("ModuleScript") then
				return
			end

			local v12 = p1.Name:gsub("^(.-)%s*|%s*", "")

			if v1.keyParser then
				local v2 = v1.keyParser(v12)

				if not v2 then
					v4(("Invalid key: %s"):format(v12))

					return
				end

				v12 = v2
			end

			if t[v12] then
				v4(("Duplicate entry: %s"):format(v12))
			else
				t[v12] = true

				local v32 = os.clock()
				local v42 = require(p1)
				local v6 = math.ceil((os.clock() - v32) * 1000)

				if v1.verifier then
					v1.verifier(v42, v12)
				end

				if v6 >= 25 and Constants.IS_STUDIO then
					v4("[SlowModule]", p1.Name, ("%dms"):format(v6))
				end

				if v1.shouldInject and type(v42) == "table" then
					if v42._id == nil then
						v42._id = v12
					end

					if v42._script == nil then
						v42._script = p1
					end
				end

				if p2[v12] then
					if p2[v12] ~= v42 then
						v4(("Mismatched entry: %s"):format(v12))
					end
				else
					if not v1.noPrint then
						table.insert(t2, ("[%s] = require(%s:WaitForChild(\"%s\"))%s"):format(KeyToString(v12), p22, p1.Name, v3))
					end

					p2[v12] = v42
				end
			end
		end
	end

	for i, v in ipairs(p1:GetChildren()) do
		if v1.loadAsync then
			task.spawn(v5, v, v2)

			continue
		end

		v5(v, v2)
	end

	if #t2 > 0 and not v1.noPrint then
		table.sort(t2)
		v4(("Unadded entries: \n\n%s\n"):format(table.concat(t2, ",\n") .. ",\n"))
	end

	for k in pairs(p2) do
		if not t[k] then
			v4(("Unknown entry: %s"):format(k))
		end
	end

	if v1.addStrictMetatable then
		MakeTableStrict(p2, v2)
	end

	return p2
end