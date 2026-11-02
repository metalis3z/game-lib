
-- credit wolfawesome123456

function explode(player)
	-- this function will explode a player this is more just for fun to enable it you need to remove the '--' from line 22
	if player.Parent:FindFirstChild("Humanoid") == nil then
		return
	else
		print("EXPLOSION!")
		local explosion =Instance.new('Explosion')
		explosion.Position = player.Position
		explosion.Parent = game.Workspace
		wait(1)
	end
end
--Deletes clonned taco
if script.Parent.Anchored ~= true then
	wait(5) --Time allowed for tacos to fall if tacos are not reaching the floor increase the number but you should increase maxTacos in raining script if you change the time to be longer
	script.Parent:Destroy()
	_G.numberofTacos -=1
end
--script.Parent.Touched:Connect(explode)