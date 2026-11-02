

script.Parent.NewSong.OnServerEvent:Connect(function(player, songid)
	if songid == 0 then
		script.Parent.Handle.Sound:Stop()
	else
		script.Parent.Handle.Sound.SoundId = "rbxassetid://".. songid
		script.Parent.Handle.Sound:Play()
	end
end)