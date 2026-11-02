local Audio = {}

function Audio.PlaySound(id, parent, replicates, volume, pitch)
	if not id or not parent then
		return
	end
	volume = volume or 1
	pitch = pitch or 1
	local s = Instance.new("Sound")
	s.Parent = parent
	s.SoundId = id
	s.Volume, s.Pitch = volume, pitch
	s:Play()
	spawn(function()
		wait(1)
		wait(s.TimeLength)
		s:Destroy()
	end)
	if replicates then
		--Network:bounce("replicateaudio", id, parent, volume, pitch)
	end
end

return Audio
