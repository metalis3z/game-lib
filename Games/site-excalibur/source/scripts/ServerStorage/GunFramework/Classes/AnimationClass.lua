AnimationService = {}

function AnimationService:LoadAnimations(Data, Humanoid)
	local Table = {}
		for i,v in pairs(Data) do
			if v then
				local Id = v.Id or v.ID
				local Animation = Instance.new("Animation", Humanoid)
				Animation.AnimationId = Id
				Animation.Name = i
				local AnimationTrack = Humanoid:LoadAnimation(Animation)
				Table[i] = AnimationTrack
			end
		end
	return Table
end

function AnimationService:GetLenght(Anims, Name, ...)
	local Animation = Anims[Name]
	if Animation ~= nil then
		return Animation.Length
	end
	
	return 0
end


function AnimationService:PlayAnimation(Anims, Name, ...)
	local Animation = Anims[Name]
	if Animation ~= nil and Animation.IsPlaying == false then
		Animation:Play(...)
	end
end

function AnimationService:StopAnimation(Anims, Name, ...)
	local Animation = Anims[Name]
	if Animation ~= nil and Animation.IsPlaying == true then
		Animation:Stop(...)
	end
end

function AnimationService:StopAllAnimations(Humanoid)
	for _,Animation in pairs(Humanoid:GetPlayingAnimationTracks()) do
		if Animation and Animation.IsPlaying == true then
			Animation:Stop()
		end
	end
end

function AnimationService:StopAnimationsFromTable(Table)
	for i,v in pairs(Table) do
		if Table then
			AnimationService:StopAnimation(Table, i)
		end
	end
end

return AnimationService