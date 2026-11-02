-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:47
-- Luau version 6, Types version 3
-- Time taken: 0.000453 seconds

local Functions = require(game:GetService("ReplicatedStorage").Shared.Functions)
local module = {}
for _, v in script:GetChildren() do
	module[Functions.toCamel(v.Name)] = require(v)
end
return module