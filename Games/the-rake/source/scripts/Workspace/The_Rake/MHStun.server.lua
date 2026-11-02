local NightDayFunction = script.Parent.Stunning
local AlreadyStun = false
local LastHealth = script.Parent.NPC.Health

NightDayFunction.Changed:Connect(function()
if AlreadyStun then
script.Parent.NPC.WalkSpeed = 0
end
if NightDayFunction.Value == 1 then
AlreadyStun = true
LastHealth = script.Parent.NPC.Health
		workspace.Stunned.Value = 1
script.Parent.UvFix.Disabled=false
script.Parent.BugFix.Disabled = false
		script.Parent.MHMainScript.Disabled = true
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
script.GetStuns.Value = script.GetStuns.Value + 1
script.Parent.Torso.Swing:Stop()
		script.Parent.DamageScript.Disabled = true
		script.Parent.HeavyDamageScript.Disabled = true
script.Parent.Head.RakeTheme:Stop()
script.Parent.NPC.WalkSpeed = 0
local StunDebounce = Instance.new("BoolValue",script.Parent)
StunDebounce.Name = "LatestStunDebounce"
game:GetService("Debris"):AddItem(StunDebounce,script.Parent.Configuration.StunTime.Value*1.25)
local force = Instance.new("BodyVelocity",script.Parent.Torso)
force.Velocity = script.Parent.Head.CFrame.LookVector * math.random(-16,16)
force.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
force.P = 5000
game:GetService("Debris"):AddItem(force,0)
wait(script.Parent.Configuration.StunReload.Value)
AlreadyStun = false
end
end)
