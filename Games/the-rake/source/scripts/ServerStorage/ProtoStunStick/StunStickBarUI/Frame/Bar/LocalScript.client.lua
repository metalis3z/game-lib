local StunStickStamina = game.Players.LocalPlayer.Character:WaitForChild("ProtoStunStick").Stamina

while true do
	wait()
	script.Parent:TweenSize(UDim2.new(StunStickStamina.Value/3.8,0,0,34),"Out","Quint",0.15)
end