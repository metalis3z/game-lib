local Tool = script.Parent;

function onActivated()
	if not Tool.Enabled then
		return
	end
	script.Parent.Parent.SpeedScript.Drinked.Value = true
	
	wait(3)

	local p = Tool.Handle:Clone()
	p.CanCollide = true
	local d = Tool.Drop:Clone()
	d.Parent = p
	d.Disabled = false
	p.Parent = game.Workspace


	script.Parent:Destroy()

end

script.Parent.Activated:connect(onActivated)
