-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Option = require(script.Parent.Option)
local t = {
	Classes = {
		Option = {
			Serialize = function(p1) --[[ Serialize | Line: 73 ]]
				return p1:Serialize()
			end,
			Deserialize = Option.Deserialize
		}
	}
}

function t.SerializeArgs(...) --[[ SerializeArgs | Line: 85 | Upvalues: t (copy) ]]
	local v1 = table.pack(...)

	for i, v in ipairs(v1) do
		if type(v) == "table" then
			local v2 = t.Classes[v.ClassName]

			if v2 then
				v1[i] = v2.Serialize(v)
			end
		end
	end

	return v1
end
function t.SerializeArgsAndUnpack(...) --[[ SerializeArgsAndUnpack | Line: 103 | Upvalues: t (copy) ]]
	local v1 = t.SerializeArgs(...)

	return table.unpack(v1, 1, v1.n)
end
function t.DeserializeArgs(...) --[[ DeserializeArgs | Line: 113 | Upvalues: t (copy) ]]
	local v1 = table.pack(...)

	for i, v in ipairs(v1) do
		if type(v) == "table" then
			local v2 = t.Classes[v.ClassName]

			if v2 then
				v1[i] = v2.Deserialize(v)
			end
		end
	end

	return v1
end
function t.DeserializeArgsAndUnpack(...) --[[ DeserializeArgsAndUnpack | Line: 131 | Upvalues: t (copy) ]]
	local v1 = t.DeserializeArgs(...)

	return table.unpack(v1, 1, v1.n)
end
function t.Serialize(p1) --[[ Serialize | Line: 141 | Upvalues: t (copy) ]]
	if type(p1) == "table" then
		local v1 = t.Classes[p1.ClassName]

		if v1 then
			p1 = v1.Serialize(p1)
		end
	end

	return p1
end
function t.Deserialize(p1) --[[ Deserialize | Line: 156 | Upvalues: t (copy) ]]
	if type(p1) == "table" then
		local v1 = t.Classes[p1.ClassName]

		if v1 then
			p1 = v1.Deserialize(p1)
		end
	end

	return p1
end
function t.UnpackArgs(p1) --[[ UnpackArgs | Line: 171 ]]
	return table.unpack(p1, 1, p1.n)
end

return t