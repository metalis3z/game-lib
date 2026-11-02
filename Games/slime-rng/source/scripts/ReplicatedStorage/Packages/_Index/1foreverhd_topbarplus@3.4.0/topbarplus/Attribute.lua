-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Attribute, time of decompilation: Sun May  3 10:09:27 2026 ]]
task.defer(function() -- line: 21
	local RunService = game:GetService("RunService")
	local VERSION = require(script.Parent.VERSION)
	local v3 = VERSION.getAppVersion()
	local v4 = VERSION.getLatestVersion()
	local v5 = VERSION.isUpToDate()

	if not RunService:IsStudio() then
		print(`🍍 Running TopbarPlus { v3 } by @ForeverHD & HD Admin`)
	end

	if not v5 then
		warn(`A new version of TopbarPlus ({ v4 }) is available: https://devforum.roblox.com/t/topbarplus/1017485`)
	end
end)

return {}
