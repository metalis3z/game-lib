local SvSt = game:GetService("ServerStorage")
local RS = game:GetService('ReplicatedStorage')



local Animations = SvSt.Assets.Animations
local Emotes = RS.Assets.Emotes



local AnimationService = {}
AnimationService.Loaded = {}



function AnimationService:getAnimationTrack(Character, Animation): AnimationTrack
	return AnimationService:getLoadedAnimations(Character)[Animation]
end


function AnimationService:playAnimation(Character: Model, Animation, Speed, TimePosition, FadeInTime)

	local loadedAnims = AnimationService:getLoadedAnimations(Character)
	local anim: AnimationTrack = loadedAnims[Animation]
	
	if Animation.Parent.Name ~= 'Spawn Animations' then
		for _, Anim in Animations["Spawn Animations"]:GetChildren() do
			AnimationService:stopAnimation(Character, Anim)
		end
	end
	
	if Animation.Parent.Name ~= 'Emotes' then
		for _, Anim in Emotes:GetChildren() do
			AnimationService:stopAnimation(Character, Anim)
		end
	else
		for _, Track: AnimationTrack in AnimationService:getLoadedAnimations(Character) do
			if Track.IsPlaying == true and Track.Animation.Parent.Name == 'Emotes' then
				AnimationService:stopAnimation(Character, Track.Animation)
			end
		end
	end
	
	anim:AdjustWeight(0.001, 0)
	anim:Play(FadeInTime)
	
	
	if Speed then
		anim:AdjustSpeed(Speed)
	end
	
	if TimePosition then
		anim.TimePosition = TimePosition
	end
	
	return anim
end

function AnimationService:adjustSpeed(Character, Animation, Speed)
	AnimationService:getLoadedAnimations(Character)[Animation]:AdjustSpeed(Speed)
end

function AnimationService:stopAnimation(Character, Animation, FadeTime)
	local playingAnims = AnimationService:getLoadedAnimations(Character)
	local anim = playingAnims[Animation]
	
	if anim.IsPlaying == true then
		anim:Stop(FadeTime)
	end
end

function AnimationService:stopAll(Character, FadeTime)
	for _, animation in pairs(Character.Humanoid.Animator:GetPlayingAnimationTracks()) do
		animation:Stop(FadeTime)
	end
end

function AnimationService:getLoadedAnimations(Character)
	if not AnimationService.Loaded[Character] then
		AnimationService:loadAnimations(Character)
	end

	return AnimationService.Loaded[Character]
end

function AnimationService:loadAnimations(Character)
	game:GetService("AnimationClipProvider")
	self.Loaded[Character] = {}

	local Animator = Character.Humanoid.Animator

	for _, animation in pairs(Animations:GetDescendants()) do
		if not animation:IsA("Animation") then continue end
		
		self.Loaded[Character][animation] = Animator:LoadAnimation(animation)
	end
	
	for _, animation in pairs(Emotes:GetDescendants()) do
		if not animation:IsA("Animation") then continue end
		
		self.Loaded[Character][animation] = Animator:LoadAnimation(animation)
	end
end

return AnimationService