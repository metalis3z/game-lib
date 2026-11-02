--!nonstrict
local areColorsEqual = require(script.Parent.areColorsEqual)

local function areValuesEqual(v1: any, v2: any)
	local valueTypesToString = {
		["CFrame"] = true,
		["Vector3"] = true,
	}
	if type(v1) == "table" and type(v2) == "table" then
		return doTablesMatch(v1, v2)
	end
	local v1Type =  typeof(v1)
	local v2Type =  typeof(v2)
	if v1Type == "Color3" and v2Type == "Color3" then
		return areColorsEqual(v1, v2)
	end
	if valueTypesToString[v1Type] and valueTypesToString[v2Type] then
		v1 = tostring(v1)
		v2 = tostring(v2)
	end
	return v1 == v2
end

function doTablesMatch(t1: any, t2: any, cancelOpposites: boolean?)
	if type(t1) ~= "table" or type(t2) ~= "table" then
		return false
	end
	t1 = t1 :: {any}
	t2 = t2 :: {any}
	for key, value in t1 do
		if (typeof(value) == "table") then
			if (doTablesMatch(t2[key], value :: any) == false) then
				return false
			end
		else
			if not areValuesEqual(value, t2[key]) then
				return false
			end
		end
	end
	if not cancelOpposites then
		if not doTablesMatch(t2, t1, true) then
			return false
		end
	end
	return true
end

return areValuesEqual