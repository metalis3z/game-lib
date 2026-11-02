
local player = game.Players.LocalPlayer

repeat wait() until player.Character

local currentgui = nil

script.Parent.Equipped:Connect(function(mouse)
	mouse.Button1Down:Connect(function()
		if currentgui == nil then
			currentgui = script.Parent.RadioGui:Clone()
			currentgui.Parent = player.PlayerGui
		end
	end)
end)

script.Parent.Unequipped:Connect(function()
	if currentgui ~= nil then
		currentgui:Destroy()
	end
	
	script.Parent.NewSong:FireServer(0)
end)