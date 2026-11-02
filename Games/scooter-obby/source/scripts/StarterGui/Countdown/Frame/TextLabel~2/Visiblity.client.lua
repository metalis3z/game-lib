local rs = game:GetService("ReplicatedStorage")

while true do
	if rs.CurrentMultiplier.Value == 1 then
		script.Parent.Visible = false
	else
		script.Parent.Visible = true
		script.Parent.Text = rs.CurrentMultiplier.Value .. "x"
	end
	wait(1)
end