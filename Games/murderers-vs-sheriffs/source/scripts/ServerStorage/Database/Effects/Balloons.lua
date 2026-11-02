return function(boo)
	for _,Emitter in pairs(script:GetChildren()) do
		Emitter:Clone().Parent = boo.Handle
		end
end