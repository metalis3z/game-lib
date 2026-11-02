local DropsThatGotUpgraded = {}

script.Parent.Touched:Connect(function(Hit)
	if Hit.Parent == script.Parent.Parent.Parent.Parent.Drops then
		if game.Players:FindFirstChild(script.Parent.Parent.Parent.Parent.Data.Owner.Value) then
			if not table.find(DropsThatGotUpgraded,Hit) then
				if script.Parent.Parent.Data.Enabled.Value == true then
								table.insert(DropsThatGotUpgraded,Hit)
			Hit.CashReward.Value = Hit.CashReward.Value*2
				end

		end
		end
		
	end
end)