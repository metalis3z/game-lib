-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local SchemaFields = require(script.Parent.SchemaFields)
local t = {
	Inventory = true
}

local function validateChangedField(p1, p2) --[[ validateChangedField | Line: 15 | Upvalues: SchemaFields (copy) ]]
	local v1 = SchemaFields[p1]

	if not v1 then
		return true
	end

	local v2, v3 = v1(p2)

	if v2 then
		return true
	end

	return false, ("Invalid profile field \'%*\': %*"):format(p1, v3 or "schema mismatch")
end

return function(p1, p2) --[[ KeyScopedProfileValidator | Line: 29 | Upvalues: SchemaFields (copy), t (copy) ]]
	if typeof(p1) ~= "table" then
		return false, "profile data must be a table"
	end

	if typeof(p2) == "table" then
		for v3 in SchemaFields do
			local v1, v2
			local v4 = p1[v3]
			local v5 = p2[v3]

			if (v4 ~= v5 or not t[v3]) and v4 ~= v5 then
				local v6 = SchemaFields[v3]

				if v6 then
					local v7, v8 = v6(v4)

					if v7 then
						v1 = true
						v2 = nil
					else
						v1, v2 = false, ("Invalid profile field \'%*\': %*"):format(v3, v8 or "schema mismatch")
					end
				else
					v1 = true
					v2 = nil
				end

				if not v1 then
					return false, v2
				end
			end
		end
	else
		for v12 in SchemaFields do
			local v10, v11
			local v13 = p1[v12]
			local v14 = SchemaFields[v12]

			if v14 then
				local v15, v16 = v14(v13)

				if v15 then
					v10 = true
					v11 = nil
				else
					v10, v11 = false, ("Invalid profile field \'%*\': %*"):format(v12, v16 or "schema mismatch")
				end
			else
				v10 = true
				v11 = nil
			end

			if not v10 then
				return false, v11
			end
		end
	end

	return true
end