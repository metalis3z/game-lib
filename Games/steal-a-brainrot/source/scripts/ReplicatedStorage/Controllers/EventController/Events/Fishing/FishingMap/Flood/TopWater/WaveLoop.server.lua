---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

-- Decompiled with Bunni.lol Decompiler

if script:IsDescendantOf(workspace) then
	local v_loadanimation = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(script.Parent.AnimationController.WaveLoop)
	v_loadanimation.Looped = true
	v_loadanimation:Play()
	v_loadanimation:AdjustSpeed(0.33)
end