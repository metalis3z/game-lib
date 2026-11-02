f = script.Parent.Owner

x = game.Players:FindFirstChild(f.Value)

script.Parent.Touched:connect(function(x2)
	if x2.Parent:FindFirstChild("Humanoid") ~= nil and x2.Parent.Name ~= f.Value then
	x.Backpack.Mes.Disabled = true
	script.Parent.Firedamage:remove()
	script.Parent:remove()
	game.Workspace.Scalpel:remove()
	wait(25)
	x.Backpack.Mes.Disabled = false
	end
end)
