if not script:IsDescendantOf(workspace) then
	return
else
	require(script.Parent).Start()
end