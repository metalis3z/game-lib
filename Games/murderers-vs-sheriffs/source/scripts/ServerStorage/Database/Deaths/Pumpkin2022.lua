return function(rag)
	for _,v in pairs(script:GetChildren()) do
		v:Clone().Parent = rag.UpperTorso
	end
end
