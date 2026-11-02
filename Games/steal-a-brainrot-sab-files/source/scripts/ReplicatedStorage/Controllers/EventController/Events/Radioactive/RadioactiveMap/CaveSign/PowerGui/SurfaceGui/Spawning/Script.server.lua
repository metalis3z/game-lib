

if script:IsDescendantOf(workspace) then
	local v1 = script.Parent
	while script:IsDescendantOf(workspace) do
		v1.Visible = not v1.Visible
		task.wait(0.5)
	end
end
