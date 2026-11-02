local Tycoon = script.Parent.Parent.Parent
local db = false



script.Parent.ClickDetector.MouseClick:Connect(function(Player)
	if Player.Name == Tycoon.Data.Owner.Value then
		if db == false then
			db = true
			
			if Tycoon.Data.LazersEnabled.Value == false then
				Tycoon.Data.LazersEnabled.Value = true
				Tycoon.Door.Color = Color3.fromRGB(255, 89, 89)
				
			else
				
				Tycoon.Data.LazersEnabled.Value = false
				Tycoon.Door.Color = Color3.fromRGB(0, 255, 0)
			end
			
			wait(1)
			db = false
		end
	end
end)