

local t1 = {}

local function SyncAnimators(p1, p2)
	local function syncAnimation(p3)
		if not p3.Animation or not p3.IsPlaying then
			return
		end

		local track = p2:LoadAnimation(p3.Animation)

		track.Looped = p3.Looped
		track.Priority = p3.Priority
		track:Play()
		track:AdjustSpeed(p3.Speed)
		track.TimePosition = p3.TimePosition
		t1[track] = p3
	end

	for _, v7 in p1:GetPlayingAnimationTracks() do
		task.spawn(syncAnimation, v7)
	end

	local connection = p1.AnimationPlayed:Connect(syncAnimation)

	return function()
		for _, v15 in p2:GetPlayingAnimationTracks() do
			v15:Stop()
		end

		connection:Disconnect()
	end
end

game:GetService("RunService").Heartbeat:Connect(function(_)
	for v10, v11 in t1 do
		if not v10.IsPlaying then
			t1[v10] = nil
		elseif not v11.IsPlaying then
			if v10.IsPlaying then
				v10:Stop()
			end
		else
			v10.Looped = v11.Looped
			v10.Priority = v11.Priority
			v10:AdjustSpeed(v10.Speed)
			v10:AdjustWeight(v10.WeightTarget, 0.1)
			v10.TimePosition = v11.TimePosition
		end
	end
end)

return SyncAnimators
