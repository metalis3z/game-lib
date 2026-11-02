
wait(5)

repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid")


while true do
	
	local t = math.random(1,10)
	
	script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	
	if t == 1 then
		script.Parent.TextLabel.Text = "!Remember To Like And Favourite The Game!"
		
	elseif t == 2 then
		script.Parent.TextLabel.Text = "!You can reduce lag through the settings button!"
		
	elseif t == 3 then
		script.Parent.TextLabel.Text = "!Actions are ingame (e.g. /hands, /lean, /sit)!"
	elseif t == 4 then
		script.Parent.TextLabel.Text = "!Buy From BadFunSeeker For Custom Guns"
	elseif t == 5 then
		script.Parent.TextLabel.Text = "!Make sure you check out the gamepasses!"
	elseif t == 6 then
		script.Parent.TextLabel.Text = "!Join The Community Server Under Game!"
	elseif t == 7 then
		script.Parent.TextLabel.Text = "!This Game Is Semi RK Semi RP Doesnt Mean RK Repeatly!"
	elseif t == 8 then
		script.Parent.TextLabel.Text = "!Invite Friends To Play And Start GangWars!"
	elseif t == 9 then
		script.Parent.TextLabel.Text = "!Have Fun And Dont Beg For Admin!"
	elseif t == 10 then
		script.Parent.TextLabel.Text = "! RK Can Result in a BAN"

		
		
	else
		script.Parent.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 4)
		script.Parent.TextLabel.Text = "!EXPLOITING IS ALWAYS AN AUTOMATIC PERMANENT BAN, DONT DO IT ITS NOT WORTH IT!"
	
		
	end
	
	for i = 1,25 do
		wait()
		script.Parent.TextLabel.TextTransparency = script.Parent.TextLabel.TextTransparency - 0.05
		
		
	end
	
	
	wait(10)
	
	for i = 1,25 do
		wait()
		script.Parent.TextLabel.TextTransparency = script.Parent.TextLabel.TextTransparency + 0.05
		
		
	end
	

end