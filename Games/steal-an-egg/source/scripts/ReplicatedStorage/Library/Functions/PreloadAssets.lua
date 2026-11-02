-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ContentProvider = game:GetService("ContentProvider")

local function v1(p1, p2) --[[ insertAsset | Line: 8 | Upvalues: v1 (copy) ]]
	if typeof(p2) == "Instance" or type(p2) == "string" then
		table.insert(p1, p2)
	else
		if type(p2) == "number" then
			table.insert(p1, (("rbxassetid://%d"):format(p2)))

			return
		end

		if type(p2) ~= "table" then
			error(("Unknown type: %s"):format((type(p2))))
		end

		for k, v in pairs(p2) do
			v1(p1, v)
		end
	end
end

local function preloadWithRetry(p1, p2) --[[ preloadWithRetry | Line: 25 | Upvalues: ContentProvider (copy) ]]
	local v1 = table.clone(p1)

	for i = 1, 3 do
		local t = {}

		local function onStatus(p1, p2) --[[ onStatus | Line: 32 | Upvalues: t (ref) ]]
			if p2 == Enum.AssetFetchStatus.Success then
				return
			end

			table.insert(t, p1)
		end

		local ok, result = pcall(ContentProvider.PreloadAsync, ContentProvider, v1, onStatus)

		if not ok then
			warn(("PreloadAsync threw on attempt %d: %s"):format(i, result), p2)
			t = v1
		end

		if #t == 0 then
			return true
		end

		v1 = t
		task.wait(i * 0.5)
	end

	return false, v1
end

return function(...) --[[ Line: 55 | Upvalues: v1 (copy), preloadWithRetry (copy) ]]
	local v12 = table.pack(...)
	local t = {}

	for i = 1, v12.n do
		v1(t, v12[i])
	end

	local v2 = debug.traceback()
	local v3, v4 = preloadWithRetry(t, v2)

	if v3 then
		return t
	end

	warn(("still failing after %d retries:"):format(3), v4, v2)

	return t
end