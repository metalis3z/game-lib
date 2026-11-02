local StunStickStamina = game.Players.LocalPlayer.Character:WaitForChild("ProtoStunStick").Stamina

while true do
	wait()
	if StunStickStamina.Value == 0 then
		script.Parent.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		script.Parent.Parent.TextLabel.Visible = true
	elseif StunStickStamina.Value == 10 then
		script.Parent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		script.Parent.Parent.TextLabel.Visible = false
	end
end