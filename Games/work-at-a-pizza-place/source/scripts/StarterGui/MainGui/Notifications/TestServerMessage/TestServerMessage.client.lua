local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.GamepadEnabled or not Enums.IsOnline then
	return
end
workspace.Main.ShowTestServerMessage.OnClientEvent:connect(function()
	while not _G["StartedPlaying"] do wait(1) end
	wait(5)
	script.Parent.Visible = true

end)
