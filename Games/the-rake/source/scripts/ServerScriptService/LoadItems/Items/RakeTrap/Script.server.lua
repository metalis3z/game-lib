while true do
	wait()
	if script.Parent.Placing.Value == true then
		repeat
			wait()
			script.Parent.Bar.Value = script.Parent.Bar.Value + 1
		until script.Parent.Bar.Value == 138 or script.Parent.Placing.Value == false
	elseif script.Parent.Placing.Value == false then
		script.Parent.Bar.Value = 0
	end
end