--// Services \\--

local Players = game:GetService('Players')
local RS = game:GetService('ReplicatedStorage')
local SvSt = game:GetService('ServerStorage')
local W = game:GetService('Workspace')



--// Bindables \\--

local Bindables = SvSt.Bindables

local SpnDmy = Bindables.SpawnDummy



--// Server Modules \\--

local SvModules = SvSt.Modules

local AnimationService = require(SvModules.AnimationService)



--// Variables \\--

local LiveFolder = W.Live



--// Functions \\--

function HumanoidDied(Character: Model, InitialHp: number)
	if Character:HasTag('Destroying') then return end
	
	local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')

	if not Humanoid then
		return
	else
		if not Character:HasTag('DontDoDieFunction') then
			if Humanoid.BreakJointsOnDeath then
				for _,Val: ObjectValue in Character.Motor6D:GetChildren() do
					local Part: BasePart = Val.Value.Part1

					Part.AssemblyLinearVelocity = Vector3.new(math.random(0, 360), math.random(0, 360), math.random(0, 360))
					Part.AssemblyAngularVelocity = Vector3.new(math.random(0, 360), math.random(0, 360), math.random(0, 360))

					Val.Value:Destroy()
				end

				Character.Motor6D:Destroy()

				require(SvModules.StunHandler):Stun(Character, 5)
			else
				Character:AddTag('CantRagdollCancel')

				require(SvModules.RagdollHandler).ragdoll(Humanoid, 5)
			end
		end
	end

	require(SvModules.iFramesService):RemoveAlliFrames(Character)

	task.wait(Players.RespawnTime)

	spawnDummy(nil, InitialHp)
	Character:Destroy()
end

function spawnDummy(CF: CFrame, InitialHp: number, ScriptName: string)
	local DidDieFunction = false
	local Dummy = script["Weakest Dummy"]:Clone()
	local HumRP = Dummy.HumanoidRootPart
	local Humanoid = Dummy.Humanoid
	Dummy.Parent = LiveFolder
	
	wait()
	
	if ScriptName and script.Scripts:FindFirstChild(ScriptName) then
		local Script: Script = script.Scripts[ScriptName]:Clone()
		Script.Parent = Dummy
		Script.Enabled = true
	end

	AnimationService:loadAnimations(Dummy)
	
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	
	
	Dummy.Humanoid.Died:Once(function()
		if DidDieFunction == true then return end
		DidDieFunction = true

		HumanoidDied(Dummy, InitialHp)
	end)

	Dummy.HumanoidRootPart:GetPropertyChangedSignal('Parent'):Connect(function()
		if DidDieFunction == true or not Dummy or not Dummy.Parent or not Dummy:FindFirstChild('HumanoidRootPart') then return end
		DidDieFunction = true
		
		HumanoidDied(Dummy, InitialHp)
	end)
	
	if CF then
		HumRP.CFrame = CF
	end
	
	if InitialHp then
		Dummy.Health.Enabled = false
		Humanoid.Health = InitialHp
	end
end



SpnDmy.Event:Connect(function(CF: CFrame, InitialHp: number, ScriptName: string)
	spawnDummy(CF, InitialHp, ScriptName)
end)

spawnDummy()