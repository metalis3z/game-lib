local Part = script.Parent
local Debounce = false

Part.Touched:Connect(function(hit)
	if Debounce == false then
		Debounce = true
		if hit.Parent:FindFirstChild("Humanoid") then
			local plr = game.Players:GetPlayerFromCharacter(hit.Parent).PlayerGui
			script.GUI:Clone().Parent = plr -- replace "ScreenGui" with the name of your ScreenGui
			wait(3) ------ How long you have to wait for the GUI to disappear 
			wait(1)
		end
		wait(1)
		Debounce = false
	end
end)