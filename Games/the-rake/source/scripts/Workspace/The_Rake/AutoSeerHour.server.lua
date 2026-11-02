
local Character = script.Parent
local Humanoid = Character:WaitForChild("NPC")
local Awake2 = Humanoid:LoadAnimation(script.Parent.AwakeNH)
local Trap = script.Parent["Right Leg"].BeartrapPart

local RakeHumanoid = script.Parent.NPC
local AlreadyBloodHour = false
local Torso = script.Parent.Torso
local Head = script.Parent.Head
local MainScript = script.Parent.MainScript
local NightmareHourText = workspace.SeerHourText
local NightmareHourFunction = workspace.SeerHourFunction
local SoundSetup = workspace.SoundSetup
local Wander = script.Parent.Wander
local Lighting = game.Lighting
local Stun = script.Parent.Stun
local Stun2 = script.Parent.Stun2

workspace.Values.SeerHour.Changed:Connect(function()
	if workspace.Values.SeerHour.Value == true then
		workspace.NearMode.ModeStarted.Value = true
		workspace.Values.DuringMode.Value = true
		if script.Parent.Configuration.StunTime.Value > 0 then
			wait(4)
			script.Parent.Configuration.StunTime.Value = 0
		end
		workspace.Heartbeat:Play()
		SoundSetup.Shock:Play()
		script.Parent.DisableUvBlind.Disabled = false
		workspace.StopTheme.Value = true
		workspace.SeerHourDebounce.Value = true
		script.Parent.RetreatScript.Disabled = true
		script.Parent.RetreatScript2.Disabled = true
		script.Parent.RandomBloodHour.Disabled = true
		script.Parent.DamageScript.Disabled = true
		script.Parent.HeavyDamageScript.Disabled = true
		script.Parent.RandomShadowHour.Disabled = true
		workspace.PowerOutValue.Value = 1
		workspace.SeerHourFog.Value = 1
		AlreadyBloodHour = true
		workspace.Trapped.Value = true
		script.Parent.Configuration.Damage.Value = 90
		MainScript.Disabled = true
		Wander.Disabled = true
		Stun.Disabled = true
		Stun2.Disabled = true
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
		workspace.DayTimeSong1:Stop()
		workspace.DayTimeSong2:Stop()
		workspace.DayTimeSong3:Stop()
		workspace.DayTimeSong4:Stop()
		Awake2:Play()
		Awake2:AdjustSpeed(0.6+(math.random()*0.1))
		SoundSetup.SeerHourStart:Play()
		SoundSetup.SEERHOURTHEME:Play()
		NightmareHourFunction.Value = true
		workspace.Trapped.Value = false
		script.Parent.NPC.MaxHealth = 2500
		wait()
		script.Parent.NPC.Health = 2500
		wait(5)
		NightmareHourText.Value = true
		wait(2)
		script.Parent.Torso.eyespawn.Enabled = true
		local eye = game.Lighting.Engine:Clone()
		eye.Parent = game.Workspace
		eye.CFrame = script.Parent.Torso.CFrame
		script.Parent.Head.SHSTART2:Play()
		NightmareHourText.Value = false
		--script.Parent.Configuration.WalkSpeed.Value = 12
		--script.Parent.Configuration.RunSpeed.Value = 55
		--script.Parent.Head.NightmareScreaming:Play()
		Awake2:Stop()
		Wander.Disabled = false
		wait()
		eye.AimScript.Disabled = false
		wait(101)
		script.Parent:FindFirstChildOfClass("Humanoid").Health = 0
end
	end)