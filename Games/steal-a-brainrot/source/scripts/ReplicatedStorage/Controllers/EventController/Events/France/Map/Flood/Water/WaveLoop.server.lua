-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-03-18 09:14:00
-- Luau version 6, Types version 3
-- Time taken: 0.000775 seconds

if script:IsDescendantOf(workspace) then
	local any_LoadAnimation_result1 = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(script.Parent.AnimationController.WaveLoop)
	any_LoadAnimation_result1.Looped = true
	any_LoadAnimation_result1:Play()
	any_LoadAnimation_result1:AdjustSpeed(0.33)
end