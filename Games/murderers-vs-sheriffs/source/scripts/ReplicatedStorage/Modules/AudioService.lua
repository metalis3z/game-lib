-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {}
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

l_Remotes_0:WaitForChild("Inventory"):WaitForChild("PlaySong").OnClientEvent:Connect(function(v3, v4)
	if v3.SoundId == v4 and v3.IsPlaying then
		v3:Stop()
	else
		v3:Stop()
		v3.SoundId = v4
		v3:Play()
	end
end)

return v0