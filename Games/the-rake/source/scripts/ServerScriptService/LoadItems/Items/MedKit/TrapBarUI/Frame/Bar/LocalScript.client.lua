local Bar = game.Players.LocalPlayer.Character.MedKit.Bar

while true do
	wait()
	script.Parent:TweenSize(UDim2.new(Bar.Value/35.5,0,0,34),"In","Linear",0.05)
end