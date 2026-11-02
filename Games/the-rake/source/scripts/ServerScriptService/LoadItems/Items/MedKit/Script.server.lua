while true do
	wait()
	if script.Parent.Heal.Value == true then
		repeat
			wait()
			script.Parent.Bar.Value = script.Parent.Bar.Value + 1
		until script.Parent.Bar.Value == 138 or script.Parent.Heal.Value == false
	elseif script.Parent.Heal.Value == false then
		script.Parent.Bar.Value = 0		
	end
end