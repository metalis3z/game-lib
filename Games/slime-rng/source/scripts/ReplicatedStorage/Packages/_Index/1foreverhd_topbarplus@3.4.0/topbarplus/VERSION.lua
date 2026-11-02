-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: VERSION, time of decompilation: Sun May  3 10:09:29 2026 ]]
local t1 = {
	appVersion = "v3.4.0",
	latestVersion = nil
}

function t1.getLatestVersion() -- line: 14
	-- upvalues: t1 (copy)
	local latestVersion = t1.latestVersion

	if latestVersion then
		return latestVersion
	end

	local result = nil

	while true do
		local ok

		ok, result = pcall(function() -- line: 22
			return game:GetService("MarketplaceService"):GetProductInfo(117501901079852)
		end)

		if ok and result then
			break
		end

		task.wait(1)
	end

	local resultName = result.Name
	local match = string.match(resultName, "^TopbarPlus (.*)$")

	if match then
		match = match:gsub("%s+", "")
	end

	t1.latestVersion = match

	return match
end
function t1.getAppVersion() -- line: 39
	-- upvalues: t1 (copy)
	return t1.appVersion
end
function t1.isUpToDate() -- line: 43
	-- upvalues: t1 (copy)
	local v7 = t1.getLatestVersion()
	local v8 = t1.getAppVersion()

	return v7 ~= nil and v7 == v8
end

return t1
