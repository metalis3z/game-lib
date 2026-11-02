local Tool = script.Parent
local Handle = Tool.Handle
local Cleanup = script.Parent.Cleanup



function Activated(player,mouseHitp)
	if player.Name == script.Parent.Parent.Name then
		Handle.Parent = workspace
		Handle:SetNetworkOwner(player)
		--Handle.CFrame = cframe
		Handle.Velocity = (mouseHitp - Handle.Position).unit * math.random(50,150) + Vector3.new(0,50,0)
		Handle.Name = "Ball"
		Handle.CanCollide = true
		
		local counter = Instance.new("NumberValue",Handle)
		counter.Value = tick()+.5
		counter.Name = "Counter"
		

		local cleanup = Cleanup:clone()
		cleanup.Disabled = false
		cleanup.Parent = Handle
		Tool:Destroy()
	end
end

workspace.Main.Clicked.OnServerEvent:connect(Activated)




function unequip()
	wait()
	Tool.Handle:Destroy()
	Tool:Destroy()
end

Tool.Unequipped:connect(unequip)

