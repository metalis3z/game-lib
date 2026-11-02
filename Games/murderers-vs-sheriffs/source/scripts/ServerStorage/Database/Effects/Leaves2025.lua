return function(Knife)
	for i,v in pairs(script:GetChildren()) do
		v:Clone().Parent = Knife.Handle
	end
end