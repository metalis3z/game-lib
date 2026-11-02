script.Parent.mopprox.Triggered:Connect(function(plr)
	local char = plr.Character
	local mopprice = 5
	local plrfolder = plr:WaitForChild('PlayerFolder')
	local generatetime = math.random(30,60)
	
	plrfolder.Credits.Value = plrfolder.Credits.Value + mopprice
	
	script.Parent.Parent.Bool.Value = false
	script.Parent.Parent.Spill.Transparency = 1
	script.Parent.mopprox.Enabled = false
	char.Mop.Parent = plr.Backpack
	wait(generatetime)
	script.Parent.Parent.Bool.Value = true
	script.Parent.Parent.Spill.Transparency = 0
end)