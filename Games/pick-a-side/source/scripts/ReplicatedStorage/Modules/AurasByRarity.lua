-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:18
-- Luau version 6, Types version 3
-- Time taken: 0.000706 seconds

local module = {}
for _, v in game.ReplicatedStorage.Auras:GetChildren() do
	local Rarity = v:GetAttribute("Rarity")
	if not module[Rarity] then
		module[Rarity] = {}
	end
	table.insert(module[Rarity], v)
end
return module