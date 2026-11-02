-- system

status = script.Parent.Parent.Parent.Parent.Handle.switchStatus

wait(2) -- reduce lag (nathdabomb)

while wait() do
	if status.Value == 1 then
		script.Parent.Status.Text = "ONLINE"
		script.Parent.Status.TextColor3 =  Color3.new(0,255,0)
	elseif status.Value == 0 then
		script.Parent.Status.Text = "OFFLINE"
		script.Parent.Status.TextColor3 =  Color3.new(255,0,0)
	end
end