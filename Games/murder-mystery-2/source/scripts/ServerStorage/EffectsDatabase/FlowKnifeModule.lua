return function(Knife)
	for _,v in pairs(script:GetChildren()) do
		v:Clone().Parent = Knife.Handle
	end
end