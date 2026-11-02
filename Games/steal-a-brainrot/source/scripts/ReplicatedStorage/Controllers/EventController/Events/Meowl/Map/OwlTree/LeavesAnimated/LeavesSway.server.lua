---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
if script:IsDescendantOf(workspace) then
	local v1 = script.Parent.AnimationController.LeavesSway
	local v2 = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(v1)
	v2.Looped = true
	v2:Play()
end
