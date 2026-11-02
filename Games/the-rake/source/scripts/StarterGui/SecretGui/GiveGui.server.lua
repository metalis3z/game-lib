local Player = script.Parent.Parent.Parent
if Player.Name == "MediumSmac" or Player.Name == "AIDENCDCAA" then
	if Player.Character.Humanoid.Health > 0 then
	--local Gui = game.ServerScriptService.SecretGui:Clone()
	--Gui.Parent = script.Parent
	--script.Disabled = true
	--script:Destroy()
	repeat wait()
		script.Parent.Enabled = true
		until script.Parent.Enabled == true
	end
else
	script.Parent:Destroy()
	end