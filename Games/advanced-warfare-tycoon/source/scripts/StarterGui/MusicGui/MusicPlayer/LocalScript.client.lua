game.StarterGui.ResetPlayerGuiOnSpawn = false

music = workspace.CurrentCamera:WaitForChild("Sound")

wait()
function changeMusic(id)
	music:Stop()
	music.SoundId = "http://roblox.com/asset?id="..id
	game.ReplicatedStorage.MasterKey:FireServer("Music",id)
	print("[LUMBER TYCOON] Changing local music to http://roblox.com/asset?id="..id)
	print("[LUMBER TYCOON] Confirming: MusicId is now "..game.Players.LocalPlayer.MusicId.Value)
	music:Play()
end

for i,v in pairs(script.Parent.Buttons:GetChildren()) do
	v.MouseButton1Click:connect(function()
		changeMusic(v.Name)
	end)
end

script.Parent.Close.MouseButton1Click:connect(function()
	script.Parent.Visible = false
end)

script.Parent.Parent.ImageButton.MouseButton1Click:connect(function()
	if script.Parent.Visible == true then
		script.Parent.Visible = false
	else
		script.Parent.Visible = true
	end
end)

script.Parent.Click.MouseButton1Click:connect(function()
	local numb = tonumber(script.Parent.TextBox.Text)
	if numb and numb > 0 then
		changeMusic(numb)
	end
end)
