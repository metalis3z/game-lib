game.ReplicatedStorage.RE.Status.OnClientEvent:Connect(function(what)
	if what == "off" then
			script.Parent.Text = ""
			script.Parent.Visible = false
	else
		script.Parent.Visible = true
	local old = script.Parent.Text
	local text = what
	script.Parent.Text = old
for i = 1, #text do
 script.Parent.Text = string.sub(text, 1, i)
 wait(.03)
end
end
end)