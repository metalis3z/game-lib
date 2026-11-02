local number = game.Workspace.CurrentRooms.CurrentRoom.Value

while wait(0.1) do
	if number == 100 then
		script.Parent.Stinker.Text = "0" .. number
		script.Parent.Stinker.Highlight.Text = "0" .. number
		script.Parent.Stinker.Shadow.Text = "0" .. number
	else
		if number < 100 and number > 9 then
			script.Parent.Stinker.Text = "00" .. number
			script.Parent.Stinker.Highlight.Text = "00" .. number
			script.Parent.Stinker.Shadow.Text = "00" .. number
		else
			if number < 10 then
				script.Parent.Stinker.Text = "000" .. number
				script.Parent.Stinker.Highlight.Text = "000" .. number
				script.Parent.Stinker.Shadow.Text = "000" .. number
			end
		end
	end
end