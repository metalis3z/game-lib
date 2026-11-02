local StunStickStamina = game.Players.LocalPlayer.Character:WaitForChild("Stamina")

while true do
	wait()
	script.Parent:TweenSize(UDim2.new(StunStickStamina.Value/3.8,0,0,34),"In","Linear",0.05)
end