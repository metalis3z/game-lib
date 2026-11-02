-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-11-22 21:30:13
-- Luau version 6, Types version 3
-- Time taken: 0.001598 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shake_upvr = require(ReplicatedStorage.Packages.Shake)
local ShakePresets_upvr = require(ReplicatedStorage.Shared.ShakePresets)
require(ReplicatedStorage.Packages.Net):RemoteEvent("CameraShakeService/Shake").OnClientEvent:Connect(function(arg1) -- Line 9
	--[[ Upvalues[2]:
		[1]: Shake_upvr (readonly)
		[2]: ShakePresets_upvr (readonly)
	]]
	local any_new_result1 = Shake_upvr.new()
	for i, v in pairs(arg1) do
		any_new_result1[i] = v
	end
	any_new_result1:Start()
end)