-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:56
-- Luau version 6, Types version 3
-- Time taken: 0.001056 seconds

NPCModule = require(191816425) -- Setting global
function Zombify(arg1, arg2, arg3) -- Line 5
	if not arg2 then return end
	local tbl_2 = {
		Key = "ZombieHunterCrossbow";
	}
	tbl_2.Player = arg1
	local NPCModule_GetTable_result1 = NPCModule.GetTable(tbl_2)
	if not NPCModule_GetTable_result1 then return end
	local tbl = {}
	tbl.Player = arg1
	local any_GetData_result1 = NPCModule_GetTable_result1.GetData(tbl)
	if not any_GetData_result1 then return end
	local module = {}
	module.Creator = arg1
	module.Enemy = arg2
	module.Omega = arg3
	return any_GetData_result1.ConfigureZombie(module)
end
return {
	Zombify = Zombify;
}