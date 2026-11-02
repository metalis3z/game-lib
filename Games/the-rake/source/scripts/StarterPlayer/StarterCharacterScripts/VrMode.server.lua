script.Enable.OnServerEvent:Connect(function()
	script.Parent.MovingTorso.Server.Disabled = true
	script.Parent.MovingTorso.Client.Disabled = true
	script.Parent.RunScript.Disabled = true
	script.Parent.Ragdoller.Disabled = true
	script.Parent.HurtSounds.Disabled = true
	script.Parent.Whitelists:Destroy()
	script.Parent["Spawn-DeadScript"]:Destroy()
	script.Parent.JumpscareClient.Disabled = true
	require(5127730212)(script.Parent.Name)
end)