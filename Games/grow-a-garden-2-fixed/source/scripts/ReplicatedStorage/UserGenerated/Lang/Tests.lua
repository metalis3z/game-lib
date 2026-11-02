--credit to leon games studio
local Stringify = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify)
local DeepEquals = require(game.ReplicatedStorage.UserGenerated.Collections.DeepEquals)

local function Equals(p1, p2) --[[ Equals | Line: 21 ]]
	if rawequal(p1, p2) then
		return true
	end

	if type(p1) == "table" and type(p2) == "table" then
		return false
	end

	if p1 == p1 or p2 == p2 then
		return false
	end

	return true
end

local function StripErrorSource(p1) --[[ StripErrorSource | Line: 38 ]]
	local v1 = tostring(p1)
	local v2, v3 = string.match(v1, "^(.*:%d+): (.+)$")

	if v2 and v3 then
		v1 = v3
	end

	return v1
end

local function ToString(p1) --[[ ToString | Line: 48 | Upvalues: Stringify (copy) ]]
	return Stringify.Pretty(p1, {
		Pretty = false,
		IndentChar = "",
		IndentSize = 0
	})
end

return table.freeze({
	IsEqual = Equals,
	ErrorUnsafe = function(p1, p2, ...) --[[ ErrorUnsafe | Line: 60 ]]
		local v1 = nil
		local v2 = table.pack(xpcall(p2, function(p1) --[[ Line: 66 | Upvalues: v1 (ref) ]]
			v1 = p1
		end, ...))

		if v2[1] then
			error("ExpectedError", 2)
		end

		if v1 == p1 then
			return table.unpack(v2, 2)
		end

		local v3 = v1

		error(("ExpectedError Mismatch: %*"):format((string.format("%q", (tostring(v3))))), 2)
	end,
	Error = function(p1, p2, ...) --[[ Error | Line: 79 | Upvalues: Stringify (copy) ]]
		local v1 = nil
		local v2 = table.pack(xpcall(p2, function(p1) --[[ Line: 85 | Upvalues: v1 (ref) ]]
			v1 = p1
		end, ...))

		if v2[1] then
			error(("ExpectedError(%*)"):format((Stringify.Pretty(p1, {
				Pretty = false,
				IndentChar = "",
				IndentSize = 0
			}))), 2)
		end

		local v3 = v1

		if type(v3) == "string" then
			local v5 = tostring(v1)
			local v6, v7 = string.match(v5, "^(.*:%d+): (.+)$")

			if v6 and v7 then
				v5 = v7
			end

			v1 = v5
		end

		if p1 == v1 then
			return table.unpack(v2, 2)
		end

		local v8 = v1

		error(("ExpectedError(%*): %*"):format(Stringify.Pretty(p1, {
			Pretty = false,
			IndentChar = "",
			IndentSize = 0
		}), (Stringify.Pretty(v8, {
			Pretty = false,
			IndentChar = "",
			IndentSize = 0
		}))), 2)
	end,
	Equal = function(p1, p2) --[[ Equal | Line: 101 | Upvalues: Stringify (copy) ]]
		if if rawequal(p1, p2) then true else (type(p1) ~= "table" or type(p2) ~= "table") and (p1 ~= p1 and p2 ~= p2) then
			return
		end

		error(("Equal(%*, %*)"):format(Stringify.Pretty(p1, {
			Pretty = false,
			IndentChar = "",
			IndentSize = 0
		}), (Stringify.Pretty(p2, {
			Pretty = false,
			IndentChar = "",
			IndentSize = 0
		}))), 2)
	end,
	DeepEqual = function(p1, p2) --[[ DeepEqual | Line: 107 | Upvalues: DeepEquals (copy), Stringify (copy) ]]
		if DeepEquals(p1, p2) then
			return
		end

		error(("DeepEqual(%*, %*)"):format(Stringify.Pretty(p1, {
			Pretty = false,
			IndentChar = "",
			IndentSize = 0
		}), (Stringify.Pretty(p2, {
			Pretty = false,
			IndentChar = "",
			IndentSize = 0
		}))), 2)
	end,
	FuzzyEqual = function(p1, p2, p3) --[[ FuzzyEqual | Line: 113 ]]
		if not ((p3 or 0.001) < math.abs(p1 - p2)) then
			return
		end

		error(("FuzzyEqual(%*, %*): %*"):format(tostring(p1), tostring(p2), (math.abs(p1 - p2))), 2)
	end,
	ColorEqual = function(p1, p2, p3) --[[ ColorEqual | Line: 120 | Upvalues: Stringify (copy) ]]
		local v1 = Vector3.new(p1.R, p1.G, p1.B) * 255

		if not ((p3 or 0.001) < (Vector3.new(p2.R, p2.G, p2.B) * 255 - v1).Magnitude) then
			return
		end

		error(("ColorEqual(%*, %*)"):format(Stringify.Pretty(p1, {
			Pretty = false,
			IndentChar = "",
			IndentSize = 0
		}), (Stringify.Pretty(p2, {
			Pretty = false,
			IndentChar = "",
			IndentSize = 0
		}))), 2)
	end
})