local nomer = game.Workspace.CurrentRooms.CurrentRoom.Value

if nomer > 99 then
	script.Parent.Text = "0"..nomer
else
	if nomer > 9 then
		script.Parent.Text = "00"..nomer
	else
		if nomer < 10 then
			script.Parent.Text = "000"..nomer
		end
	end
end