-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:08
-- Luau version 6, Types version 3
-- Time taken: 0.000394 seconds

local RunService = game:GetService("RunService")
if RunService:IsServer() then
	return require(script.KnitServer)
end
local KnitServer = script:FindFirstChild("KnitServer")
if KnitServer and RunService:IsRunning() then
	KnitServer:Destroy()
end
return require(script.KnitClient)