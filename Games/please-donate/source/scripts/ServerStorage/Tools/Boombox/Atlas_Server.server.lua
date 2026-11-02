local MainSong = script.Parent.Handle.Sound
local MarketplaceService = game:GetService('MarketplaceService')

script.Parent.MainEvent.OnServerEvent:Connect(function(plr, FunctionType, ID)
	if not MarketplaceService:UserOwnsGamePassAsync(plr.UserId, 76913331) then
		plr:Kick('Exploiting')
	end
	if FunctionType == 'Play' then
		if MainSong.IsPlaying then
			MainSong:Stop()
		end
		MainSong.SoundId = 'rbxassetid://'..tonumber(ID)
		MainSong:Play()
	elseif FunctionType == 'Stop' then
		if MainSong.IsPlaying then
			MainSong:Stop()
		end
	end
end)