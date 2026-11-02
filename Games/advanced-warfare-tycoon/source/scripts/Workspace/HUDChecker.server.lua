game.Players.PlayerAdded:connect(function(p)
p.CharacterAdded:connect(function(char)
if p.PlayerGui:FindFirstChild('WeaponHud') then
p.PlayerGui['WeaponHud']:Destroy()
end
end)
end)