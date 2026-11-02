---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
if script:IsDescendantOf(workspace) then
	local v1 = script.Parent
	while script:IsDescendantOf(workspace) do
		v1.Visible = not v1.Visible
		task.wait(0.5)
	end
end
