--credit to leon games studio
local MemoryStoreService = game:GetService("MemoryStoreService")
local RunService = game:GetService("RunService")
local v1 = nil
local ok, result = pcall(function() --[[ Line: 21 | Upvalues: MemoryStoreService (copy) ]]
	return MemoryStoreService:GetHashMap("MailIndex_v1")
end)

if ok then
	v1 = result
else
	warn((("[MailIndex] GetHashMap failed; mail index disabled for this server: %*"):format(result)))
end

local function keyFor(p1) --[[ keyFor | Line: 32 ]]
	return tostring(p1)
end

local function clampNonNeg(p1) --[[ clampNonNeg | Line: 36 ]]
	if p1 < 0 then
		return 0
	end

	return p1
end

local function update(p1, p2) --[[ update | Line: 40 | Upvalues: v1 (ref), RunService (copy) ]]
	if not v1 then
		return false
	end

	if RunService:IsStudio() then
		return true
	end

	local v12 = os.time()
	local ok, result = pcall(function() --[[ Line: 49 | Upvalues: v1 (ref), p1 (copy), p2 (copy), v12 (copy) ]]
		v1:UpdateAsync(tostring(p1), function(p1) --[[ Line: 50 | Upvalues: p2 (ref), v12 (ref) ]]
			local v1 = if p1 then p1 else {
	C = 0,
	T = 0,
	V = 0
}
			local v2 = (v1.C or 0) + p2

			v1.C = if v2 < 0 then 0 else v2

			if p2 > 0 then
				v1.T = v12
			end

			v1.V = (v1.V or 0) + 1

			return v1
		end, 1209600)
	end)

	if ok then
		return true
	end

	warn((("[MailIndex] UpdateAsync failed for user %* (delta %*): %*"):format(p1, p2, result)))

	return false
end

local t = {
	Increment = function(p1, p2) --[[ Increment | Line: 70 | Upvalues: update (copy) ]]
		if typeof(p1) ~= "number" or p1 <= 0 then
			return false
		end

		if typeof(p2) == "number" and not (p2 <= 0) then
			return update(p1, (math.floor(p2)))
		end

		return false
	end,
	Decrement = function(p1, p2) --[[ Decrement | Line: 76 | Upvalues: update (copy) ]]
		if typeof(p1) ~= "number" or p1 <= 0 then
			return false
		end

		if typeof(p2) == "number" and not (p2 <= 0) then
			return update(p1, -math.floor(p2))
		end

		return false
	end,
	Get = function(p1) --[[ Get | Line: 82 | Upvalues: v1 (ref), RunService (copy) ]]
		if not v1 then
			return nil
		end

		if typeof(p1) ~= "number" or p1 <= 0 then
			return nil
		end

		if RunService:IsStudio() then
			return nil
		end

		local v12 = nil
		local ok, result = pcall(function() --[[ Line: 88 | Upvalues: v12 (ref), v1 (ref), p1 (copy) ]]
			v12 = v1:GetAsync((tostring(p1)))
		end)

		if ok then
			return v12
		end

		warn((("[MailIndex] GetAsync failed for user %*: %*"):format(p1, result)))

		return nil
	end
}

return table.freeze(t)