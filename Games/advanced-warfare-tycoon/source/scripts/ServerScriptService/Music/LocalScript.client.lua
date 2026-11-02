wait(1)
script.Parent.Parent:WaitForChild("PlayerGui")
local music = script.Sound:Clone()
game.Players.LocalPlayer.MusicId.Value = music.SoundId
print("Confirming, initial setting MusicId to "..music.SoundId)
music.Parent = workspace.CurrentCamera
music:Play()
