local bike = script.Parent.Parent
local F = {}

F.updateSounds = function(tbl)
	for _,i in pairs(tbl) do
		if i[2]~=i[1].Pitch then i[1].Pitch = i[2] end
		if i[3]~=i[1].Volume then i[1].Volume = i[3] end
	end
end

F.playSound = function(snd)
	snd:Play()
end

F.stopSound = function(snd)
	snd:Stop()
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	F[Fnc](...)
end)

bike.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		F.stopSound(bike.DriveSeat.Rev)
		--F.stopSound(Your sound here)
	end
end)