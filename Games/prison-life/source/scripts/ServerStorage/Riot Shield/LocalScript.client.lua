local remote = game.ReplicatedStorage:WaitForChild("RiotShieldConfig"):WaitForChild("EquipShield")
local IsEquiped = false

script.Parent.Equipped:Connect(function(Mouse)
	Mouse.Button1Down:Connect(function()
		if IsEquiped == false then
			IsEquiped = true
			
			remote:FireServer(true)
		else
			IsEquiped = false
			
			remote:FireServer(false)
		end
	end)
end) 