-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if game:GetService("RunService"):IsServer() then
	return require(script.GameAnalytics)
end

return require(script.GameAnalyticsClient)