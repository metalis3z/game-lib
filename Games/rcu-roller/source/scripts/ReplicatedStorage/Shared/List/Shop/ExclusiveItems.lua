-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:05
-- Luau version 6, Types version 3
-- Time taken: 0.000555 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {{
	id = "royalAuraDice";
	stock = 10;
	rewards = {Items.auraDice("royalAuraDice")};
}, {
	id = "epicLuck";
	stock = 10;
	rewards = {Items.exclusive("epicLuck")};
}, {
	id = "potionsBox";
	stock = 10;
	rewards = {Items.box("potionsBox")};
}}