local Character = script.Parent

local animate = Character:WaitForChild("Animate")
animate.Disabled = true
animate:Destroy()


local Humanoid = Character:WaitForChild("Humanoid")
local Head = Character:WaitForChild("Head")
local OriginalFace = Head:WaitForChild("face")
local OriginalFaceTexture = OriginalFace.Texture
local RigType = (Humanoid.RigType == Enum.HumanoidRigType.R15 and "R15") or "R6"


local AnimationData = {
	
	Idle = {R6 = 180435571, R15 = 507766388,Priority = Enum.AnimationPriority.Movement, Weight = 0.4},
	Jump = {R6 = 125750702, R15 = 507765000,Priority = Enum.AnimationPriority.Movement,Weight = 0.7},
	Walk = {R6 = 180426354, R15 = 507777826,Priority = Enum.AnimationPriority.Movement, Weight = 0.6},
	Run = {R6 = 180426354, R15 = 507767714,Priority = Enum.AnimationPriority.Movement, Weight = 1},
	Swim = {R6 = 865902879, R15 = 507784897,Priority = Enum.AnimationPriority.Movement},
	SwimIdle = {R6 = 865918502, R15 = 507785072,Priority = Enum.AnimationPriority.Movement, Weight = 0.5},
	Fall = {R6 = 180436148, R15 = 507767968,Priority = Enum.AnimationPriority.Movement,Weight = 0.7},
	Climb = {R6 = 180436334, R15 = 507765644,Priority = Enum.AnimationPriority.Movement},
	
	SitSeat = {R6 = 178130996, R15 = 507768133,Priority = Enum.AnimationPriority.Movement,Weight = .99},
	Driving = {R6 = 178130996, R15 = 866020346,Priority = Enum.AnimationPriority.Movement},
	SleepSeat = {R6 = 869468579, R15 = 869454065,Priority = Enum.AnimationPriority.Action,Volume = .3,SoundId=868409374,SoundLooped = true,FaceId=66329905,MovementCancel = true},

	ToolHold = {R6 = 182393478, R15 = 507768375,Priority = Enum.AnimationPriority.Action},
	
	Wave = {R6 = 128777973, R15 = 507770239,Priority = Enum.AnimationPriority.Action}, 
	Point = {R6 = 128853357, R15 = 507770453,Priority = Enum.AnimationPriority.Action},
	Dance = {R6 = 182435998, R15 = 507771019,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	Dance2 = {R6 = 182436842, R15 = 507776043,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	Dance3 = {R6 = 182436935, R15 = 507777268,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	Laugh = {R6 = 129423131, R15 = 507770818,Priority = Enum.AnimationPriority.Action},
	Cheer = {R6 = 129423030, R15 = 507770677,Priority = Enum.AnimationPriority.Action,SoundId=154157524,FaceId=27802003},
	
	Swing = {R6 = nil, R15 = 867712012,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	Twist = {R6 = nil, R15 = 867708782,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	Easy = {R6 = nil, R15 = 867707598,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	Shuffle = {R6 = nil, R15 = 867706152,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	HipHop = {R6 = nil, R15 = 867703959,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	HipHop2 = {R6 = nil, R15 = 867704764,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	Flair = {R6 = nil, R15 = 867701010,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	Marashin = {R6 = nil, R15 = 867685946,Priority = Enum.AnimationPriority.Action,MovementCancel = true},


	
	Amazed = {R6 = 154174346, R15 = 154174346,Priority = Enum.AnimationPriority.Action,SoundId=154157291,FaceId=45528113},
	Angry = {R6 = 154168543, R15 = 867275109,Priority = Enum.AnimationPriority.Action,SoundId=154157312,FaceId=14020216},
	Bye = {R6 = 154179312, R15 = 867286113,Priority = Enum.AnimationPriority.Action,SoundId=154157386},
	Confused = {R6 = 154183110, R15 = 867207299,Priority = Enum.AnimationPriority.Action,SoundId=154157416,FaceId=120250454},
	Glee = {R6 = 154159852, R15 = 867266586,Priority = Enum.AnimationPriority.Action,SoundId=154157524,FaceId=27802003},
	Hi = {R6 = 154179312, R15 = 867286113,Priority = Enum.AnimationPriority.Action,SoundId=154147007},
	Laugh = {R6 = 154166518, R15 = 867167112,Priority = Enum.AnimationPriority.Action,SoundId=154157543,FaceId=32063242},
	Point = {R6 = 154188723, R15 = 867172216,Priority = Enum.AnimationPriority.Action,SoundId=154157593},
	Sad = {R6 = 153230853, R15 = 867309991,Priority = Enum.AnimationPriority.Action,SoundId=154146535,FaceId=76690153},
	Scared = {R6 = 154170755, R15 = 867226524,Priority = Enum.AnimationPriority.Action,SoundId=154157563,FaceId=47206380},
	Think = {R6 = 154185274, R15 = 867186419,Priority = Enum.AnimationPriority.Action,SoundId=154157584,FaceId=29716203},
	Sleep = {R6 = 868450390, R15 = 868398961,Priority = Enum.AnimationPriority.Action,Volume = .3,SoundId=868409374,SoundLooped = true,FaceId=66329905,MovementCancel = true},
	Sit = {R6 = 868508890, R15 = 868506496,Priority = Enum.AnimationPriority.Action,MovementCancel = true},
	Clap = {R6 = 868730451, R15 = 868638275,Priority = Enum.AnimationPriority.Action,SoundId=868687813},
	Whistle = {R6 = 180435571, R15 = 507766388,Priority = Enum.AnimationPriority.Action, Weight = 0.4,FaceId=22877631},
	
	
	
	ConfusionOrb = {R6 = 866550588, R15 = 866541157,Priority = Enum.AnimationPriority.Action},
	ThrowCoin = {R6 = 156055482, R15 = 867194400,Priority = Enum.AnimationPriority.Action},
}


workspace.Main.LoadSoundsIntoHead:FireServer(AnimationData)


--add object field
for animationName,data in pairs(AnimationData) do
	if data[RigType] ~= nil then
		local animation = Instance.new("Animation")
		animation.Name = animationName
		animation.AnimationId = "rbxassetid://" .. tostring(data[RigType])
		AnimationData[animationName].Object = animation
	end
end

local faceIds = {}
for name,data in pairs(AnimationData) do
	if data.FaceId then
		table.insert(faceIds,data.FaceId)
	end
end

workspace.Main.LoadFaces:FireServer(faceIds)




local movementCancelMode = false  --stop an animation once the players moves
local movementCancelName = nil
local currentAnimationObjects = {} --three layers by priority
local currentAnimationTracks = {}
local currentSoundObject
local currentFaceDecalResetConnection




local function ResetFaceAndSound()
	
	if currentSoundObject then
		currentSoundObject:Stop()
	end
			
	if currentFaceDecalResetConnection then currentFaceDecalResetConnection:disconnect() end
	workspace.Main.ChangeFace:FireServer(OriginalFace,OriginalFaceTexture)
	
end






local function PlayAnimation(name,transitionTime)

	local newAnimationData = AnimationData[name]
	local newAnimationObject = newAnimationData.Object
	local newAnimationPriority = newAnimationData.Priority
	local newAnimationLooped = newAnimationData.Looped
	local newAnimationWeight = newAnimationData.Weight
	
	local lastAnimationTrack = currentAnimationTracks[newAnimationPriority]
	
	if newAnimationObject and (newAnimationObject ~= currentAnimationObjects[newAnimationPriority] or currentAnimationTracks[newAnimationPriority].IsPlaying == false) then --if not already player
		


		if newAnimationPriority == Enum.AnimationPriority.Action then --dont let walking and idle reset the face and sounds
			ResetFaceAndSound()
			
			if newAnimationData.MovementCancel then --detect when the player moves and again so anaimation can be canceld
				movementCancelMode = true
				movementCancelName = name
			else
				movementCancelMode = false
				movementCancelName = nil
			end
			if lastAnimationTrack then --stop old track
				workspace.Animation.AnimationStopped:FireServer(lastAnimationTrack.Name)
				workspace.Animation.AnimationStopped.AnimationStopped:Fire(lastAnimationTrack.Name)
			end
			workspace.Animation.AnimationStarted:FireServer(name)
			workspace.Animation.AnimationStarted.AnimationStarted:Fire(name)

		end
		
		
		
		if lastAnimationTrack then --stop old track
			lastAnimationTrack:Stop(transitionTime)
		end
		
		local newAnimationTrack = Humanoid:LoadAnimation(newAnimationObject) --play new track
		newAnimationTrack.Priority = newAnimationPriority
		newAnimationTrack.Name = name
		newAnimationTrack:Play(transitionTime,newAnimationWeight)
				
		currentAnimationTracks[newAnimationPriority] = newAnimationTrack --make current
		currentAnimationObjects[newAnimationPriority] = newAnimationObject
		

		if newAnimationData.FaceId then
			workspace.Main.ChangeFace:FireServer(OriginalFace,"rbxassetid://" .. tostring(newAnimationData.FaceId))
			currentFaceDecalResetConnection = newAnimationTrack.Stopped:connect(function()
				ResetFaceAndSound()
			end)
		end
		
		if newAnimationData.SoundId then
			Character.Head[name]:Play()
			currentSoundObject = Character.Head[name]
		end
		
		
		
	end	
end


local function StopAnimation(name,transtionTime)
				
	for priority,track in pairs(currentAnimationTracks) do
		if track.Name == name then
			track:Stop(transtionTime)
			currentAnimationTracks[track.Priority] = nil
			currentAnimationObjects[track.Priority] = nil
			
			if priority == Enum.AnimationPriority.Action then
				ResetFaceAndSound()
				workspace.Animation.AnimationStopped:FireServer(name)
				workspace.Animation.AnimationStopped.AnimationStopped:Fire(name)

			end
			break			
		end
	end
end

local function SetAnimationSpeed(name,speed)
	for priority,track in pairs(currentAnimationTracks) do
		if track.Name == name then
			track:AdjustSpeed(speed)
			break
		end
	end
end

local function StopAllAnimations()
	for priority,track in pairs(currentAnimationTracks) do
		StopAnimation(track.Name)
	end
end


local running = false

Humanoid.Running:connect(function(speed)
	if speed > .01 then
		
		if speed > 16 then
			local scale = 26
			PlayAnimation("Run",.5)
			SetAnimationSpeed("Run",speed/scale)
		else
			local scale = 16
			PlayAnimation("Walk",.1)
			SetAnimationSpeed("Walk",speed/scale)
		end
		
		if movementCancelMode and speed > Character.Humanoid.WalkSpeed/2 then  --prevents animation cancel when player is bumped by an object --walk speed never reaches max walk speed
			movementCancelMode = false
			StopAnimation(movementCancelName,0)
		end
	else
		PlayAnimation("Idle",.2)
	end
end)

Humanoid.Died:connect(function()
	StopAllAnimations()
end)

Humanoid.Jumping:connect(function()
	PlayAnimation("Jump",.1)
	if movementCancelMode then  --prevents animation cancel when player is bumped by an object --walk speed never reaches max walk speed
		movementCancelMode = false
		StopAnimation(movementCancelName,0)
	end
end)

local scale = (RigType == "R15" and 5) or 10
Humanoid.Climbing:connect(function(speed)
	PlayAnimation("Climb",.1)
	SetAnimationSpeed("Climb",speed/scale)
end)

Humanoid.GettingUp:connect(function()
	StopAllAnimations()
end)


Humanoid.FreeFalling:connect(function()
	PlayAnimation("Fall",.2)
end)

Humanoid.FallingDown:connect(function()
	StopAllAnimations()
end)


Humanoid.Seated:connect(function(active,seat)
	if active then
		if seat and seat:FindFirstChild("Animation") then
			PlayAnimation(seat.Animation.Value,.1)
		else
			PlayAnimation("SitSeat",.1)
		end
	end
	
end)

Humanoid.PlatformStanding:connect(function()
	StopAllAnimations()
end)

Humanoid.Swimming:connect(function(speed)
	if speed > 1 then
		local scale = 10
		PlayAnimation("Swim",.4)
		SetAnimationSpeed("Climb",speed/scale)
	else
		PlayAnimation("SwimIdle",.4)
	end
end)


Character.ChildAdded:connect(function(child)
	if child:IsA("Tool") then
		PlayAnimation("ToolHold",.2)
	end
end)

Character.ChildRemoved:connect(function(child)
	if child:IsA("Tool") then
		StopAnimation("ToolHold",.2)
	end
end)




workspace.Animation.PlayAnimation.OnClientEvent:connect(function(name,transtitionSpeed) PlayAnimation(name,transtitionSpeed) end)
workspace.Animation.PlayAnimation.PlayAnimation.Event:connect(function(name,transtitionSpeed) PlayAnimation(name,transtitionSpeed) end)
workspace.Animation.StopAnimation.OnClientEvent:connect(function(name,transtitionSpeed) StopAnimation(name,transtitionSpeed) end)
workspace.Animation.StopAnimation.StopAnimation.Event:connect(function(name,transtitionSpeed) StopAnimation(name,transtitionSpeed) end)













local phrases = {
	{"Glee",{"*cheers","woo!","yay","yeah!","woot","omg yes","hooray", "hoorah","@glee@","@sweet","thx", "thank you"}},
	{"Sad",{"whaa","waa","*cries","@awww","@cry@","nooo","nuuu","@sad@","@cry@","DX@"}},
	{"Laugh",{"xd@","lol","rofl","*laughs","haha","lulz","@laugh@","hehe","lele"}},
	{"Angry",{"grr","omg stop","go away","stop it","shut up","stfu","gtfo","@fu@","nooo","@angry@","@mad@","wtf"}},
	{"Scared",{ "ahh","*screams","@run away","gasp","help!","@scared@","@oh no"}},
	{"Amazed",{"wow","woah","@amazing", "cool!", "awesome!","@omg@","@omg!@","@amazed@","holy crap"}},
	{"Hi",{"@hi","hi ", "@hello","@hey","@sup@","@sup" , "@yo " }},
	{"Bye",{"@bye","cya","nice meeting", "so long","see ya","@goodbye","g2g"}},
	{"Confused",{"huh","@confused@"}},
	{"Think",{"hmm","*thinks","@um@","@think@"}},
	{"Point",{"@look at","*points","look!","@point@", "@no u@"}}
	}
	
workspace.Main.Chatted.Chatted.Event:connect(function(msg)
	local msg = "@" .. string.lower(msg) .. "@"
	for i=1,#phrases do
		local emotion = phrases[i][1]
		local words = phrases[i][2]
		for phrase=1,#words do
			if string.match(msg,words[phrase]) then
				PlayAnimation(emotion,.1)
			end
		end
	end
end)




PlayAnimation("Idle", 0.1, Humanoid)






if RigType == "R15" then
	local camera = workspace.CurrentCamera
	
	
	while not _G.StartedPlaying do
		wait(.1)
	end
	
	
	
	local RtoLAnimation = Instance.new("Animation")
	RtoLAnimation.Name = "TorsoCameraTwist"
	RtoLAnimation.AnimationId = "rbxassetid://866369257"
	
	--local UtoDAnimation = Instance.new("Animation")
	--UtoDAnimation.AnimationId = "rbxassetid://866363400"
	
	
	
	local LtoRTrack = Humanoid:LoadAnimation(RtoLAnimation) --play new track
	LtoRTrack.Priority = Enum.AnimationPriority.Movement
	LtoRTrack:Play(0,.6,0)
	
	--[[local UtoRDrack = Humanoid:LoadAnimation(UtoDAnimation) --play new track
	UtoRDrack.Priority = Enum.AnimationPriority.Movement
	UtoRDrack:Play(0.05,.2,0)]]
	
	local MAX_ANGLE = 90
	local MIDDLE_TIME_POSITION_OFFCENTER = .4 --regular camera angle makes player look down a little, offset it a little
	local MIDDLE_TIME_POSITION = .5
	local offset = 45

	
	game:GetService("RunService"):BindToRenderStep("MoveBodyWithCamera", Enum.RenderPriority.First.Value, function()
		
		--local radius = (camera.CoordinateFrame.p - Character.Head.Position).magnitude
		--local y = camera.CoordinateFrame.p.Y - Character.Head.Position.Y
	--	local angleUD = math.deg(math.asin(y/radius))
		
		if Character:FindFirstChild("HumanoidRootPart") then
			local cameraDirection = camera.CoordinateFrame.lookVector
			local torsoDirection = Character.HumanoidRootPart.CFrame.lookVector
			local angleLR = math.deg(math.atan2(torsoDirection.X,torsoDirection.Z) - math.atan2(cameraDirection.X,cameraDirection.Z))
				
			
			--if angleUD < 0 then angleUD = angleUD + 360 end
			if angleLR < 0 then angleLR = angleLR + 360 end
		
		
			if angleLR < MAX_ANGLE then
				LtoRTrack.TimePosition = MIDDLE_TIME_POSITION + ((angleLR/MAX_ANGLE)/2)
			elseif angleLR > 360 - MAX_ANGLE then
				LtoRTrack.TimePosition = MIDDLE_TIME_POSITION - (((360-angleLR)/MAX_ANGLE)/2)
			end
		
		
			
			--if angleUD < MAX_ANGLE then
			--	UtoRDrack.TimePosition = MIDDLE_TIME_POSITION_OFFCENTER + ((angleUD/MAX_ANGLE)/2)
			--elseif angleUD > 360 - MAX_ANGLE then
				--UtoRDrack.TimePosition = MIDDLE_TIME_POSITION_OFFCENTER + (((-(360-angleUD))/MAX_ANGLE)/2)
			--end
		end
		
	end)
	
	
	game.Players.PlayerAdded:connect(function(player)
		local connection
		connection = player.CharacterAdded:connect(function()
			connection:disconnect()
			wait(2)
			LtoRTrack:Play(0.05,.6,0)  --need to replay so the new player can see the animation
		end)
		
	end)
	
end





--[[for _,id in ipairs({182435998,182491037,182491065,182436842,182491248,182491277,182436935,182491368,182491423,42163425}) do
	game:GetService("ContentProvider"):Preload("http://www.roblox.com/asset/?id=" .. id)
end]]



