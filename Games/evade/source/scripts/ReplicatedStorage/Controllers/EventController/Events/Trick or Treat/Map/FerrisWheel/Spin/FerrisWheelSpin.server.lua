-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("RunService")
local v2 = script.Parent
while v2:IsDescendantOf(workspace) do
	local v3 = v1.Heartbeat:Wait()
	local v4 = v2:GetPivot()
	local v5 = CFrame.Angles
	local v6 = -0.5 * v3 * 60
	v2:PivotTo(v4 * v5(math.rad(v6), 0, 0))
end
