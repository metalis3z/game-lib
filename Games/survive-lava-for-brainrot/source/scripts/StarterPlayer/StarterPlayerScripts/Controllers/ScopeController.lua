-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {
	["PRODUCTION"] = "PRODUCTION",
	["DEV"] = "DEV",
	["STAGING"] = "STAGING"
}
local v_u_2 = ({
	[9668081526] = v1.DEV,
	[9649298941] = v1.PRODUCTION
})[game.GameId] or v1.STAGING
return {
	["ScopeEnums"] = v1,
	["GetScope"] = function(_)
		-- upvalues: (copy) v_u_2
		return v_u_2
	end
}
