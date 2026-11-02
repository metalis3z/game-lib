local car = script.Parent.Parent
local F = {}
local lastTable

F.updateSounds = function(tbl)
	for _,i in pairs(tbl) do
		local sound = i[1]
		local pitch = i[2]
		local volume  = i[3]
		sound.Pitch = pitch
		if volume>0.002 then
			sound.Volume = volume
		else
			sound.Pitch = 0
			sound.Volume = 1
		end
	end
	lastTable = tbl
end

F.playSound = function(snd) snd:Play() end

F.stopSound = function(snd) snd:Stop() end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...) F[Fnc](...) end)

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		pcall(function() 
			for _,i in pairs(lastTable) do
				local sound = i[1]
				local pitch = i[2]
				local volume  = i[3]
				local newSound = Instance.new("Sound",sound.Parent)
				newSound.Name = sound.Name
				newSound.SoundId = sound.SoundId
				newSound.EmitterSize = sound.EmitterSize
				newSound.Looped = sound.Looped
				newSound.MaxDistance = sound.MaxDistance
				newSound.Pitch = pitch
				newSound.Volume = volume
				sound:Destroy()
			end 
		end)
	end
end)