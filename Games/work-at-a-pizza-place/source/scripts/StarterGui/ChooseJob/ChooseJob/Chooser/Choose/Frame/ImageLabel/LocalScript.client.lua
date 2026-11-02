local parent = script.Parent.Parent

function resize()
	script.Parent.Size = UDim2.new(0,script.Parent.AbsoluteSize.Y,1,0)
	script.Parent.Position = UDim2.new(0,(parent.AbsoluteSize.X/2) - (script.Parent.AbsoluteSize.X/2),0,0)
end


parent.Changed:connect(function(prop)
	if prop == "AbsoluteSize" then
		resize()
	end
end)

resize()
