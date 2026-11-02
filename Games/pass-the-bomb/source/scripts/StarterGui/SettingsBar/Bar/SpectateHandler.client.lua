-- Credits to [-] NoDripDrax and trogspidr

cam = game.Workspace.CurrentCamera

local bar = script.Parent.SpectateMain
local title = bar.PlayerName
local prev = bar.Previous
local nex = bar.Next
local button = script.Parent.SpectateButton

function get()
	for _,v in pairs(game.Players:GetPlayers())do
		if v.Name == title.Text then
			return(_)
		end
	end
end

local debounce = false
button.MouseButton1Click:connect(function()
	if debounce == false then debounce = true
		bar:TweenPosition(UDim2.new(8.5, 0, 1.5, 0),"In","Linear",1,true)
		pcall(function()
			title.Text = game.Players:GetPlayerFromCharacter(cam.CameraSubject.Parent).Name
		end)
	elseif debounce == true then debounce = false
		pcall(function() cam.CameraSubject = game.Players.LocalPlayer.Character.Humanoid end)
		bar:TweenPosition(UDim2.new(8.5, 0, 2.5, 0),"In","Linear",1,true)
	end
end)

prev.MouseButton1Click:connect(function()
	wait(.1)
	local players = game.Players:GetPlayers()
	local num = get()
	if not pcall(function() 
			cam.CameraSubject = players[num-1].Character.Humanoid
		end) then
		cam.CameraSubject = players[#players].Character.Humanoid
	end
	pcall(function()
		title.Text = game.Players:GetPlayerFromCharacter(cam.CameraSubject.Parent).Name
	end)
end)

nex.MouseButton1Click:connect(function()
	wait(.1)
	local players = game.Players:GetPlayers()
	local num = get()
	if not pcall(function() 
			cam.CameraSubject = players[num+1].Character.Humanoid
		end) then
		cam.CameraSubject = players[1].Character.Humanoid
	end
	pcall(function()
		title.Text = game.Players:GetPlayerFromCharacter(cam.CameraSubject.Parent).Name
	end)
end)

