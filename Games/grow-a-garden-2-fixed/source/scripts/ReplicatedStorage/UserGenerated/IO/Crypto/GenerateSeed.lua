--credit to leon games studio
local HttpService = game:GetService("HttpService")

local function GenerateEntropy() --[[ GenerateEntropy | Line: 22 | Upvalues: HttpService (copy) ]]
	local v1 = HttpService:GenerateGUID(false)

	return tonumber(string.sub(v1, 1, 8), 16), tonumber(string.sub(v1, 10, 13) .. string.sub(v1, 25, 28), 16), tonumber(string.sub(v1, 29, 36), 16)
end

return function(p1) --[[ GenerateSeed | Line: 30 | Upvalues: HttpService (copy) ]]
	local v1 = table.create(p1, 0)
	local v2 = p1 // 3

	for i = 0, v2 - 1 do
		local v3 = HttpService:GenerateGUID(false)
		local v5 = tonumber(string.sub(v3, 1, 8), 16)
		local v7 = tonumber(string.sub(v3, 10, 13) .. string.sub(v3, 25, 28), 16)
		local v9 = tonumber(string.sub(v3, 29, 36), 16)

		v1[i * 3 + 1] = v5
		v1[i * 3 + 2] = v7
		v1[i * 3 + 3] = v9
	end

	local v10 = p1 - v2 * 3

	if v10 == 1 then
		local v11 = HttpService:GenerateGUID(false)
		local v13 = tonumber(string.sub(v11, 1, 8), 16)

		tonumber(string.sub(v11, 10, 13) .. string.sub(v11, 25, 28), 16)
		tonumber(string.sub(v11, 29, 36), 16)
		v1[p1] = v13

		return v1
	end

	if v10 == 2 then
		local v16 = HttpService:GenerateGUID(false)
		local v18 = tonumber(string.sub(v16, 1, 8), 16)
		local v20 = tonumber(string.sub(v16, 10, 13) .. string.sub(v16, 25, 28), 16)

		tonumber(string.sub(v16, 29, 36), 16)
		v1[p1 - 1] = v18
		v1[p1] = v20
	end

	return v1
end