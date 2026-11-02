local db = false 

for i,Tycoon in pairs(game.Workspace.Tycoons:GetChildren()) do
	Tycoon:FindFirstChild("Door").Touched:Connect(function(Hit)
		if Hit.Parent.Name == game.Players.LocalPlayer.Name then
			if Tycoon.Data.Owner.Value == "" then
				if game.Players.LocalPlayer.Data.TycoonOwned.Value == 0 then
					if db == false then
						db = true
						script.Parent.TycoonNumber.Value = tonumber(Tycoon.Name)
						script.Parent.Visible = true
						script.Parent:GetPropertyChangedSignal('Visible'):Connect(function()
							wait(1)
							db = false
						end)
					end
					
				end
			end
		end
		
	end)
end