-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:27
-- Luau version 6, Types version 3
-- Time taken: 0.001103 seconds

local module_2 = {
	fFlagUtils = require(script.FFlagUtils);
	petUtils = require(script.PetUtils);
	itemUtils = require(script.ItemUtils);
	eggUtils = require(script.EggUtils);
	indexUtils = require(script.IndexUtils);
	auraUtils = require(script.AuraUtils);
	settingUtils = require(script.SettingUtils);
	upgradeUtils = require(script.UpgradeUtils);
}
for _, v in script:GetDescendants() do
	if v:IsA("ModuleScript") then
		local var14 = string.sub(v.Name, 1, 1):lower()..string.sub(v.Name, 2, -1)
		if not module_2[var14] then
			module_2[var14] = require(v)
		end
	end
end
return module_2