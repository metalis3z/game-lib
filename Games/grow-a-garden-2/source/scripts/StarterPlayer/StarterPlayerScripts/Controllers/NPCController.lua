--credit to prince games studio
return {
	Start = function(p1) --[[ Start | Line: 3 ]]
		for v1, v2 in script:GetChildren() do
			require(v2)()
		end
	end
}