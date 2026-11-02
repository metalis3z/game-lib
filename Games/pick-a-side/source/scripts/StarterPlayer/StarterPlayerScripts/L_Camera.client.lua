-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:53
-- Luau version 6, Types version 3
-- Time taken: 0.001279 seconds

local CameraShaker_upvr = require(game.ReplicatedStorage.Modules.CameraShaker)
local CurrentCamera_upvr = workspace.CurrentCamera
local any_new_result1_upvr = CameraShaker_upvr.new(Enum.RenderPriority.Camera.Value, function(arg1) -- Line 5
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvr (readonly)
	]]
	CurrentCamera_upvr.CFrame *= arg1
end)
any_new_result1_upvr:Start()
game.ReplicatedStorage.Events.Camera.OnClientEvent:Connect(function(arg1) -- Line 11
	--[[ Upvalues[2]:
		[1]: any_new_result1_upvr (readonly)
		[2]: CameraShaker_upvr (readonly)
	]]
	any_new_result1_upvr:Shake(CameraShaker_upvr.Presets[arg1])
end)