local number = game.Workspace.CurrentRooms.CurrentRoom.Value

if number == 100 then
	script.Parent.Stinker.Text = "0" .. number
	script.Parent.Stinker.Highlight.Text = "0" .. number
	script.Parent.Stinker.Shadow.Text = "0" .. number
end
