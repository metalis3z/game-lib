-- services --

local TS = game.TweenService
local Debris = game.Debris


-- player variables --

local Player = game.Players.LocalPlayer
local Character: Model = Player.Character or Player.CharacterAdded:Wait()
local Humanoid: Humanoid = Character:WaitForChild("Humanoid", 1)
local Animator: Animator = Humanoid:WaitForChild("Animator", 1)
local HumRP = Character:WaitForChild("HumanoidRootPart", 1)

Player:GetPropertyChangedSignal('Character'):Connect(function()
	Character = Character
	Humanoid = Character:WaitForChild("Humanoid", 1)
	HumRP = Character:WaitForChild("HumanoidRootPart", 1)
end)


-- functions --

local function playSound(CustomProperties)
    local Sound = Instance.new("Sound")
    Sound.SoundGroup = game.SoundService.Sounds
    Sound.Played:Once(function()
        Sound.Ended:Once(function()
			Debris:AddItem(Sound, 0)
        end)
	end)
	
	for Name, Value in CustomProperties do
		Sound[Name] = Value
	end
	
    return Sound
end


-- walk sounds table --

local WalkSoundTable = {
    [Enum.Material.Grass] = {
        id = {
            7456850767, 
            7456850856, 
            7456850976
        }, 
        volume = 0.16, 
        add = 0.8, 
        default = 1
	}, 
	
    [Enum.Material.LeafyGrass] = {
        id = {
            7455224448, 
            7455224380, 
            7455224324
        }, 
        volume = 0.1, 
        add = 0.8, 
        default = 1
	}, 
	
    [Enum.Material.Mud] = {
        id = {
            7807902004, 
            7807902091, 
            7807902210
        }, 
        volume = 0.12, 
        add = 0.8, 
        default = 1
	}, 
	
    [Enum.Material.WoodPlanks] = {
        id = {
            7278039716, 
            7278039763, 
            7278039806
        }, 
        volume = 0.2, 
        default = 0.9, 
        add = 1
	}, 
	
    [Enum.Material.Slate] = {
        id = {
            7455224144, 
            7455246815, 
            7455224490
        }, 
        volume = 0.12, 
        default = 1, 
        add = 1
	}, 
	
    [Enum.Material.Sand] = {
        id = {
            7278083537, 
            7278083583, 
            7278083623
        }, 
        volume = 0.75, 
        default = 0.7, 
        add = 0.9
	}, 
	
    [Enum.Material.Ground] = {
        id = {
            6540746817, 
            549000724, 
            6441160246
        }, 
        volume = 0.3, 
        default = 0.7, 
        add = 0.9
	}
	
}

WalkSoundTable[Enum.Material.Wood] = WalkSoundTable[Enum.Material.WoodPlanks]
WalkSoundTable[Enum.Material.Concrete] = WalkSoundTable[Enum.Material.Slate]
WalkSoundTable[Enum.Material.SmoothPlastic] = WalkSoundTable[Enum.Material.Slate]
WalkSoundTable[Enum.Material.Pavement] = WalkSoundTable[Enum.Material.Slate]
WalkSoundTable[Enum.Material.Rock] = WalkSoundTable[Enum.Material.Slate]
WalkSoundTable[Enum.Material.Plastic] = WalkSoundTable[Enum.Material.Slate]


local startTick = tick()
local moveSpeed = 0
local Running = nil

Animator.AnimationPlayed:Connect(function(animationTrack: AnimationTrack)
	local Animation = animationTrack.Animation
	
	if Animation.AnimationId == "rbxassetid://114488284687525" then
		local StepConnection = animationTrack:GetMarkerReachedSignal('runfootstep'):Connect(function()
			if tick() - startTick >= .125 then
				startTick = tick()
				
				local currWalkSound = rawget(WalkSoundTable, Humanoid.FloorMaterial)
				if currWalkSound then
					playSound({
						Volume = currWalkSound.volume, 
						PlaybackSpeed = 1, 
						SoundId = "rbxassetid://" .. currWalkSound.id[math.random(#currWalkSound.id)], 
						RollOffMaxDistance = 40, 
						Parent = HumRP
					}):Play()
				end
			end
		end)
		
		animationTrack.Stopped:Once(function()
			StepConnection:Disconnect()
		end)
	end
end)

Humanoid.Running:Connect(function(speed)
	moveSpeed = speed
end)

Humanoid.StateChanged:Connect(function(_, newState)
	if newState == Enum.HumanoidStateType.Jumping then
		playSound({
			SoundId = "rbxassetid://7005105940", 
			Parent = HumRP, 
			Volume = 0.125, 
			RollOffMaxDistance = 30
		}):Play()
	elseif newState == Enum.HumanoidStateType.Landed then
		playSound({
			SoundId = "rbxassetid://7005105964", 
			Parent = HumRP, 
			Volume = 0.175, 
			RollOffMaxDistance = 30
		}):Play()
	end
end)