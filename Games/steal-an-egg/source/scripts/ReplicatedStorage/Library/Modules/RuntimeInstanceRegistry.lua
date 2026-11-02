-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {}
local t2 = {
	Changed = require(ReplicatedStorage.Library.Modules.Packages.Signal).new()
}

function t2.Set(p1, p2, p3) --[[ Set | Line: 21 | Upvalues: Asserts (copy), t (copy), t2 (copy) ]]
	Asserts.string(p1)
	Asserts.string(p2)
	Asserts.Instance(p3)

	local v1 = t[p1]

	if v1 == nil then
		v1 = {}
		t[p1] = v1
	end

	v1[p2] = p3
	t2.Changed:Fire(p1, p2, p3)
end
function t2.Get(p1, p2) --[[ Get | Line: 34 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.string(p1)
	Asserts.string(p2)

	local v1 = t[p1]
	local v2 = if v1 == nil then nil else v1[p2]

	if v2 == nil or v2.Parent == nil then
		return nil
	end

	return v2
end
function t2.Require(p1, p2) --[[ Require | Line: 42 | Upvalues: t2 (copy) ]]
	local v1 = t2.Get(p1, p2)

	assert(v1 ~= nil, (("Missing runtime instance \"%*/%*\""):format(p1, p2)))

	return v1
end
function t2.Clear(p1, p2) --[[ Clear | Line: 48 | Upvalues: Asserts (copy), t (copy), t2 (copy) ]]
	Asserts.string(p1)
	Asserts.optional.string(p2)

	if p2 == nil then
		if t[p1] ~= nil then
			t[p1] = nil
			t2.Changed:Fire(p1, nil, nil)
		end
	else
		local v1 = t[p1]

		if v1 == nil or v1[p2] == nil then
			return
		end

		v1[p2] = nil
		t2.Changed:Fire(p1, p2, nil)
	end
end

return t2