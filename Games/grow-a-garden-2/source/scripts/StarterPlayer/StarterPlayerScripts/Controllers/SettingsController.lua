--credit to leon games studio
local t = {}
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local SFXGroup = game.SoundService.SFXGroup
local GameMusic = game.SoundService.Master.GameMusic
local Settings = game.Players.LocalPlayer:WaitForChild("Settings")
local Music_Volume = Settings:WaitForChild("Music_Volume")
local SFX_Volume = Settings:WaitForChild("SFX_Volume")

function t.Init(p1) --[[ Init | Line: 15 | Upvalues: SFXGroup (copy), SFX_Volume (copy), GameMusic (copy), Music_Volume (copy), TweenService (copy), v1 (copy) ]]
	SFXGroup.Volume = SFX_Volume.Value
	GameMusic.Volume = Music_Volume.Value

	local UnixTimestamp = DateTime.now().UnixTimestamp

	SFX_Volume:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 19 | Upvalues: SFXGroup (ref), SFX_Volume (ref) ]]
		SFXGroup.Volume = SFX_Volume.Value
	end)
	Music_Volume:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 22 | Upvalues: UnixTimestamp (copy), TweenService (ref), GameMusic (ref), v1 (ref), Music_Volume (ref) ]]
		if DateTime.now().UnixTimestamp - UnixTimestamp > 3 then
			local v12 = TweenService:Create(GameMusic, v1, {
				Volume = Music_Volume.Value
			})

			v12:Play()
			game.Debris:AddItem(v12, v1.Time)
		else
			GameMusic.Volume = Music_Volume.Value
		end
	end)
end

return t