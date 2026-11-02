-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

if script:IsDescendantOf(workspace) then
	local v1 = script.Parent
	local v2 = v1.Rotate
	local v3 = v1:GetPivot()
	local v4 = 0
	while true do
		v4 = v4 + task.wait()
		local v5 = v4 * 2
		v2:ScaleTo(math.sin(v5) * 0.075 + 0.925)
		v2:PivotTo(v2:GetPivot() * CFrame.Angles(0, 0, 0.017453292519943295))
		v1:PivotTo(v3 * CFrame.new(0, 0, math.sin(v4) * 1))
	end
else
	return
end