-- Reference copy for study. Game: Jujutsu Shenanigans (jujutsu-shenanigans)
-- Original: ReplicatedStorage/Modules/Utility/TriggerAwkMusic.luau  (luau, 26 lines)
-- Categories: sound-music 13.3
-- What it does: Fades a group of sounds under an attachment in or out (1 s linear tween), remembering each original volume in an attribute; honors a per-player Awakening Music setting.

local TS = game:GetService('TweenService')

return function(Att: Attachment, State: boolean)
	for _, Player: Player in game.Players:GetPlayers() do
		local AwakeningMusicConfig: BoolValue = Player:FindFirstChild('Configuration'):FindFirstChild('Awakening Music')
		
		if not AwakeningMusicConfig then continue end
		
		if State == true then
			if AwakeningMusicConfig.Value == true then
				for _, Sound: Sound in Att:GetDescendants() do
					if Sound:IsA('Sound') then
						TS:Create(Sound, TweenInfo.new(1, Enum.EasingStyle.Linear), { Volume = Sound:GetAttribute('Volume') or 1 }):Play()
					end
				end
			end
		else
			for _, Sound: Sound in Att:GetDescendants() do
				if Sound:IsA('Sound') then
					Sound:SetAttribute('Volume', Sound.Volume)
					TS:Create(Sound, TweenInfo.new(1, Enum.EasingStyle.Linear), { Volume = 0 }):Play()
				end
			end
		end
	end
end