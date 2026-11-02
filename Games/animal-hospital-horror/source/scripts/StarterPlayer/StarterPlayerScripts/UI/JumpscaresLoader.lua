task.spawn(function() --[[ Line: 3 ]]
	repeat
		task.wait()
	until game:IsLoaded()

	local Local = game:GetService("ReplicatedStorage"):WaitForChild("AnomalyEvents"):WaitForChild("Local")

	require(Local:WaitForChild("TallMonsterLocal"))
	require(Local:WaitForChild("ShadowCamera"))
end)

return {}