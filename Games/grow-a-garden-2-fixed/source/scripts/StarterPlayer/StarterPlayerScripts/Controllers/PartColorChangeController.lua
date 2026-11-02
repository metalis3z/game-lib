--credit to prince games studio
return {
	StartOrder = 10,
	Start = function(p1) --[[ Start | Line: 5 ]]
		for v1, v2 in script:GetChildren() do
			if v2:IsA("ModuleScript") then
				task.spawn(function() --[[ Line: 8 | Upvalues: v2 (copy) ]]
					require(v2):Start()
				end)
			end
		end
	end
}