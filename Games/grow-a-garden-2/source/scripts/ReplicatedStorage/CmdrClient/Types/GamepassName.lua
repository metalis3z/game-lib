--credit to prince games studio
local HttpService = game:GetService("HttpService")

local function makeFuzzyFinder(p1) --[[ makeFuzzyFinder | Line: 3 ]]
	return function(p1, p23) --[[ Line: 4 | Upvalues: p1 (copy) ]]
		local t2 = {}

		for v12, v2 in p1 do
			if v2:lower() == p1:lower() then
				if p23 then
					return v2
				end

				table.insert(t2, 1, v2)

				continue
			end

			if v2:lower():find(p1:lower(), 1, true) then
				table.insert(t2, v2)
			end
		end

		if p23 then
			return t2[1]
		end

		return t2
	end
end

local function getGamepassNames() --[[ getGamepassNames | Line: 19 | Upvalues: HttpService (copy) ]]
	local v1 = workspace:GetAttribute("RemoteGamepasses")

	if type(v1) ~= "string" or v1 == "" then
		return {}
	end

	local ok, result = pcall(HttpService.JSONDecode, HttpService, v1)

	if not ok or type(result) ~= "table" then
		return {}
	end

	local t = {}

	for v2, v3 in result do
		if type(v3) == "table" and type(v3[3]) == "string" then
			table.insert(t, v3[3])
		end
	end

	return t
end

return function(p1) --[[ Line: 33 | Upvalues: getGamepassNames (copy) ]]
	p1:RegisterType("gamepassName", {
		Validate = function(p1) --[[ Validate | Line: 35 | Upvalues: getGamepassNames (ref) ]]
			local v1 = getGamepassNames()

			return (function(p1, p23) --[[ Line: 4 | Upvalues: v1 (copy) ]]
				local t2 = {}

				for v12, v2 in v1 do
					if v2:lower() == p1:lower() then
						if p23 then
							return v2
						end

						table.insert(t2, 1, v2)

						continue
					end

					if v2:lower():find(p1:lower(), 1, true) then
						table.insert(t2, v2)
					end
				end

				if p23 then
					return t2[1]
				end

				return t2
			end)(p1, true) ~= nil, string.format("%q is not a valid gamepass. Valid gamepasses: %s", p1, table.concat(v1, ", "))
		end,
		Autocomplete = function(p1) --[[ Autocomplete | Line: 40 | Upvalues: getGamepassNames (ref) ]]
			local v1 = getGamepassNames()

			local function f2(p1, p23) --[[ Line: 4 | Upvalues: v1 (copy) ]]
				local t2 = {}

				for v12, v2 in v1 do
					if v2:lower() == p1:lower() then
						if p23 then
							return v2
						end

						table.insert(t2, 1, v2)

						continue
					end

					if v2:lower():find(p1:lower(), 1, true) then
						table.insert(t2, v2)
					end
				end

				if p23 then
					return t2[1]
				end

				return t2
			end

			return f2(p1)
		end,
		Parse = function(p1) --[[ Parse | Line: 43 | Upvalues: getGamepassNames (ref) ]]
			local v1 = getGamepassNames()

			local function f2(p1, p23) --[[ Line: 4 | Upvalues: v1 (copy) ]]
				local t2 = {}

				for v12, v2 in v1 do
					if v2:lower() == p1:lower() then
						if p23 then
							return v2
						end

						table.insert(t2, 1, v2)

						continue
					end

					if v2:lower():find(p1:lower(), 1, true) then
						table.insert(t2, v2)
					end
				end

				if p23 then
					return t2[1]
				end

				return t2
			end

			return f2(p1, true)
		end
	})
end