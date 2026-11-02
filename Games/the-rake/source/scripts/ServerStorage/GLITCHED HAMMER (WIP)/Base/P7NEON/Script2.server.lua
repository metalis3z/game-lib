while true do
	wait(script.Parent.Parent.Configurations.Wait.Value)
	local color = math.random(1,3)
	if color == 1 then
		script.Parent.Color = script.Parent.Parent.Configurations.c1hit.Value
	elseif color == 2 then
		script.Parent.Color = script.Parent.Parent.Configurations.c2hit.Value
	elseif color == 3 then
		script.Parent.Color = script.Parent.Parent.Configurations.c3hit.Value
	end
end
