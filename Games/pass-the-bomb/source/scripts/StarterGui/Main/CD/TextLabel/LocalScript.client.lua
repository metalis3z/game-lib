game.ReplicatedStorage.RE.CD.OnClientEvent:Connect(function(what)
	if what == "off" then
			script.Parent.Text = ""
			script.Parent.Parent.Visible = false
			script.Parent.Parent.Parent.PlayersRemain.Visible = false
	else
		script.Parent.Parent.Visible = true
	script.Parent.Text = what
	script.Parent.Parent.Parent.PlayersRemain.Visible = true
	end
end)