return function(Knife)
	for _, Effect in script:GetChildren() do
		Effect:Clone().Parent = Knife.Handle
	end
end