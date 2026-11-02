local F = {}
local DriveSeat = script.Parent.Parent:WaitForChild("DriveSeat")
local car = DriveSeat.Parent

F.SoundUpdate = function(volume)
	if DriveSeat.Brakes.Volume ~= volume then
		DriveSeat.Brakes.Volume = volume
	end
end

F.SoundPlay = function()
	DriveSeat.Brakes:Play()
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)