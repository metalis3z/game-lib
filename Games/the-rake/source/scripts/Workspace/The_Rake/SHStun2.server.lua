local NightDayFunction = script.Parent.Stunning
local AlreadyStun = false
local LastHealth = script.Parent.NPC.Health

NightDayFunction.Changed:Connect(function()
if AlreadyStun then
script.Parent.NPC.WalkSpeed = 0
end
if NightDayFunction.Value == 0 then
workspace.Stunned.Value = 0
		script.Parent.BugValue.Value = 1
		script.Parent.UvFix.UvValue.Value=1
		script.Parent.BugFix.Disabled = true
		script.Parent.UvFix.Disabled=true
		script.Parent.BugValue.Value = 0
		script.Parent.UvFix.UvValue.Value=0
		workspace.Blinded.Value = false
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
script.Parent.Torso.Swing:Stop()
script.Parent.Torso.Anchored = false
script.Parent.NPC.PlatformStand = false
		script.Parent.DamageScript.Disabled = false
		script.Parent.HeavyDamageScript.Disabled = false
script.Parent.SHMainScript.Disabled = false
script.Parent.Stunning.Value = false
script.Parent.NPC.WalkSpeed = script.Parent.Configuration.WalkSpeed.Value
if script.Parent.Configuration.StaticSoundVolume.Value > 0 then
script.Parent.Head.Static:Play()
end
wait(script.Parent.Configuration.StunReload.Value)
AlreadyStun = false
end
end)
