local v1 = script:WaitForChild("TestUI").Value
local v2 = game:GetService("RunService"):IsStudio()
local v3 = game.PlaceId == 119460199
if v1 and (v2 or game.Players.LocalPlayer.UserId == 1848960) then
	if v3 then
		if game.StarterGui:FindFirstChild("NewUI2025") then
			game.StarterGui.NewUI2025:Destroy()
		end
		if game.Players.LocalPlayer.PlayerGui:FindFirstChild("NewUI2025") then
			game.Players.LocalPlayer.PlayerGui.NewUI2025:Destroy()
		end
	end
	script.LoadingS2.Enabled = true
else
	script.Loading.Enabled = true
end