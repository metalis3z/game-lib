local Character = script.Parent
local Humanoid = Character:WaitForChild("NPC")
local Scream = Humanoid:LoadAnimation(script.Parent.Scream)
local Debounce = false

while true do
	wait()
	if script.Parent.NPC.Health < 990 and Character ~= nil and Debounce == false then
		Debounce = true
		script.Parent.RandomBloodHour.Disabled = true
		script.Parent.RandomNightmareHour.Disabled = true
		script.Parent.RandomShadowHour.Disabled = true
		script.Parent.MainDisabler.Disabled = false
		script.Parent.Stun.Disabled = true
		script.Parent.Stun2.Disabled = true
		local DiedSounds = math.random(1,2)
		if DiedSounds == 1 then
			script.Parent.RakeDied:Play()
		elseif DiedSounds == 2 then
			script.Parent.RakeDied2:Play()
			end
		Scream:Play()
		script.Parent.NPC.WalkSpeed = 0
		workspace.Stunned.Value = 0
		script.Parent.BugValue.Value = 1
		script.Parent.UvFix.UvValue.Value=1
		wait()
		script.Parent.BugFix.Disabled = true
		script.Parent.UvFix.Disabled=true
		wait()
		script.Parent.BugValue.Value = 0
		script.Parent.UvFix.UvValue.Value=0
		script.parent.RagdollPart1.CanCollide = false
		script.parent.RagdollPart2.CanCollide = false
		script.parent.RagdollPart3.CanCollide = false
		script.parent.RagdollPart4.CanCollide = false
		script.Parent.RagdollPart5.CanCollide = false
		script.parent.Torso["Neck"].Part1=script.Parent.Head
		script.parent.Torso["Left Hip"].Part1=script.Parent["Left Leg"]
		script.parent.Torso["Right Hip"].Part1=script.Parent["Right Leg"]
		script.parent.Torso["Left Shoulder"].Part1=script.Parent["Left Arm"]
		script.parent.Torso["Right Shoulder"].Part1=script.Parent["Right Arm"]
		script.Parent.Configuration.StunTime.Value = 0
		script.Parent.NPC.PlatformStand = false
		script.Parent.DamageScript.Disabled = false
		script.Parent.HeavyDamageScript.Disabled = false
		script.Parent.MainScript.Disabled = false
		script.Parent.Stunning.Value = false
		workspace.Trapped.Value = false
		script.Parent.Stun.Disabled = false
		script.Parent.Stun2.Disabled = false
		script.Parent.MainScript.Disabled = true
        wait(700)
		Debounce = false
	end
	end