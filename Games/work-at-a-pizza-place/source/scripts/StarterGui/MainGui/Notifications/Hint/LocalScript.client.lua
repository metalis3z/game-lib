local Hint = script.Parent

function ShowHint(text,duration)
	Hint.Label.Text = text
	Hint.Visible = true
	wait(duration)
	Hint.Visible = false
end


workspace.MessageService.ShowHint.OnClientEvent:connect(function(text,duration)
	ShowHint(text,duration)
end)

workspace.MessageService.ShowHint.ShowHint.Event:connect(function(text,duration)
	ShowHint(text,duration)
end)