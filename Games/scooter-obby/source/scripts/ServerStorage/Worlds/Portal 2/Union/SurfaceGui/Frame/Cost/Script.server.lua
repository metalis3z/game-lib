local placeid = 15593042384

while true do
	if game.Players.LocalPlayer:GetAttribute("Owned"..tostring(placeid)) then
		script.Parent.Visible = false
	else
		script.Parent.Visible = true
	end
	wait(0.2)
end