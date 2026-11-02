while true do
	wait(script.Parent.Parent.Configurations.Wait.Value)
	local color = math.random(1,5)
	if color == 1 then
		script.Parent.Color = script.Parent.Parent.Configurations.c1.Value
	elseif color == 2 then
		script.Parent.Color = script.Parent.Parent.Configurations.c2.Value
	elseif color == 3 then
		script.Parent.Color = script.Parent.Parent.Configurations.c3.Value
	elseif color == 4 then
		script.Parent.Color = script.Parent.Parent.Configurations.c4.Value
	elseif color == 5 then
		script.Parent.Color = script.Parent.Parent.Configurations.c5.Value
	end
end
