-- Script made by DK1221 --

-- v1.0 --
wait()
game.Players.LocalPlayer.PlayerGui:WaitForChild("Aux")
local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Aux")

local player = gui.Parent.Parent
local PlayButton = gui.AudioPlayerGui.PlayButton
local PauseButton = gui.AudioPlayerGui.PauseButton
local VolUpButton = gui.AudioPlayerGui.VolUp
local VolDownButton = gui.AudioPlayerGui.VolDown
local ChangeButton = gui.AudioPlayerGui.ChangeButton


local carSeat = script.Car.Value.DriveSeat
--local Screen = carSeat.Parent.AudioPlayerScreen.SurfaceGui <-- soon
--local Song = script.Parent.AudioPlayerGui.Song
--local Audio = carSeat.Audio

vol = 1



function playSong()

	local id = gui.AudioPlayerGui.TextBox.Text
	carSeat.AuidoPlayerEvent:FireServer(id,1)
	--Screen.Song.Text = game:GetService("MarketplaceService"):GetProductInfo(id).Name
--	Song.Text = game:GetService("MarketplaceService"):GetProductInfo(id).Name
	--Screen.ID.Text = id

end

function stopSong()
	
	carSeat.AuidoPlayerEvent:FireServer(nil,2)
	
end

function volUp()

	if vol + 0.1 <= 5 then
		vol = vol + 0.1
		carSeat.AuidoPlayerEvent:FireServer(vol,3)
		--gui.AudioPlayerGui.Vol.Text = tostring(vol*100) .. "%"
		--Screen.Vol.Text = tostring(vol*100) .. "%"
	end
	
end

function volDown()
		
	if vol - 0.1 >= 0 then
		vol = vol - 0.1
		carSeat.AuidoPlayerEvent:FireServer(vol,3)
	--	gui.AudioPlayerGui.Vol.Text = tostring(vol*100) .. "%"
		--Screen.Vol.Text = tostring(vol*100) .. "%"
	end
	
end



VolUpButton.MouseButton1Click:connect(function()
	
	volUp()
	
end)

VolDownButton.MouseButton1Click:connect(function()
	
	volDown()
	
end)

PlayButton.MouseButton1Click:connect(function()
	
	playSong()
	
end)

PauseButton.MouseButton1Click:connect(function()
	
	stopSong()
	
end)

-- Original: 268109886, 7/9/2015 --
