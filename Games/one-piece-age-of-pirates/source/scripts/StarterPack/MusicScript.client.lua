repeat wait() until script.Parent.Parent.Character ~= nil

wait(1)

if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
	return
end
	
x = math.random(1, 7)

if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
	return
end

if x == 1 then
	script.Disabled = true
	script.Music.SoundId = "rbxassetid://142322188"
	script.Music:Play()
	for i = 1, 90 do
		if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
			script.Music:Stop()
			script.Disabled = true
		end
		wait(1)
	end
	script.Music:Stop()
	script.Disabled = true
	script.Disabled = false
end

if x == 2 then
	script.Disabled = true
	script.Music.SoundId = "rbxassetid://142322500"
	script.Music:Play()
	for i = 1, 75 do
		if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
			script.Music:Stop()
			script.Disabled = true
		end
		wait(1)
	end
	script.Music:Stop()
	script.Disabled = true
	script.Disabled = false
end

if x == 3 then
	script.Disabled = true
	script.Music.SoundId = "rbxassetid://142322480"
	script.Music:Play()
	for i = 1, 114 do
		if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
			script.Music:Stop()
			script.Disabled = true
		end
		wait(1)
	end
	script.Music:Stop()
	script.Disabled = true
	script.Disabled = false
end

if x == 4 then
	script.Disabled = true
	script.Music.SoundId = "rbxassetid://142323032"
	script.Music:Play()
	for i = 1, 60 do
		if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
			script.Music:Stop()
			script.Disabled = true
		end
		wait(1)
	end
	script.Music:Stop()
	script.Disabled = true
	script.Disabled = false
end

if x == 5 then
	script.Disabled = true
	script.Music.SoundId = "rbxassetid://178129702"
	script.Music:Play()
	for i = 1, 120 do
		if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
			script.Music:Stop()
			script.Disabled = true
		end
		wait(1)
	end
	script.Music:Stop()
	script.Disabled = true
	script.Disabled = false
end

if x == 6 then
	script.Disabled = true
	script.Music.SoundId = "rbxassetid://143116565"
	script.Music:Play()
	for i = 1, 45 do
		if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
			script.Music:Stop()
			script.Disabled = true
		end
		wait(1)
	end
	script.Music:Stop()
	script.Disabled = true
	script.Disabled = false
end

if x == 7 then
	script.Disabled = true
	script.Music.SoundId = "rbxassetid://178135153"
	script.Music:Play()
	for i = 1, 56 do
		if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
			script.Music:Stop()
			script.Disabled = true
		end
		wait(1)
	end
	script.Music:Stop()
	script.Disabled = true
	script.Disabled = false
end