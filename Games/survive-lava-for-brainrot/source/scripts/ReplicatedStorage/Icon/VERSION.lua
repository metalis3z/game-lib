-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_9 = {
	["appVersion"] = "v3.4.0",
	["latestVersion"] = nil,
	["getLatestVersion"] = function()
		-- upvalues: (copy) v_u_9
		local v1 = v_u_9.latestVersion
		if v1 then
			return v1
		end
		while true do
			local v2, v3 = pcall(function()
				return game:GetService("MarketplaceService"):GetProductInfo(117501901079852)
			end)
			if v2 and v3 then
				break
			end
			task.wait(1)
		end
		local v4 = v3.Name
		local v5 = string.match(v4, "^TopbarPlus (.*)$")
		if v5 then
			v5 = v5:gsub("%s+", "")
		end
		v_u_9.latestVersion = v5
		return v5
	end,
	["getAppVersion"] = function()
		-- upvalues: (copy) v_u_9
		return v_u_9.appVersion
	end,
	["isUpToDate"] = function()
		-- upvalues: (copy) v_u_9
		local v6 = v_u_9.getLatestVersion()
		local v7 = v_u_9.getAppVersion()
		local v8
		if v6 == nil then
			v8 = false
		else
			v8 = v6 == v7
		end
		return v8
	end
}
return v_u_9
