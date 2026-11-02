local Tycoon = script.Parent.Parent

script.Parent.Touched:Connect(function(Hit)
	pcall(function()
		if Hit.Name == "Drop" then
			if Hit:FindFirstChild("Collected").Value == false then
				Hit.Collected.Value = true
				local Cash = Hit.CashReward.Value
				Hit:Destroy()
				if game.Players:FindFirstChild(Tycoon.Data.Owner.Value) then
					game.Players:FindFirstChild(Tycoon.Data.Owner.Value).Data.Cash.Value += Cash
				end
			end
		end
	end)
end)