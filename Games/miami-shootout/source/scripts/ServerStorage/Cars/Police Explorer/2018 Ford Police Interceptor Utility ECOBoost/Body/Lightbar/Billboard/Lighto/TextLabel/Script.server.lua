local images = {script.Parent.TextLabel}

while wait() do 
	for _,v in pairs(images) do
		local temp = v.Position.X.Scale
		if (temp <= -v.Size.X.Scale) then
			temp = 1.0
		end
		v.Position = UDim2.new(temp - 0.01, 0, 0, 0)
	end
end