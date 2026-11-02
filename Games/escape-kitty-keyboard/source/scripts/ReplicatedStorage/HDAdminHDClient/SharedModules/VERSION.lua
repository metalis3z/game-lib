

local _ = _G.HDAdminMain
local u9 = {
	["appVersion"] = "v1.31.8",
	["latestVersion"] = nil,
	["getLatestVersion"] = function() 

		local v1 = u9.latestVersion
		if v1 then
			return v1
		end
		while true do
			local v2, v3 = pcall(function()
				return game:GetService("MarketplaceService"):GetProductInfo(79941590401581)
			end)
			if v2 and v3 then
				break
			end
			task.wait(1)
		end
		local v4 = v3.Name
		local v5 = string.match(v4, "^HD Admin (.*)$")
		if v5 then
			v5 = v5:gsub("%s+", "")
		end
		u9.latestVersion = v5
		return v5
	end,
	["getAppVersion"] = function() 

		return u9.appVersion
	end,
	["isUpToDate"] = function() 

		local v6 = u9.getLatestVersion()
		local v7 = u9.getAppVersion()
		local v8
		if v6 == nil then
			v8 = false
		else
			v8 = v6 == v7
		end
		return v8
	end
}
return u9