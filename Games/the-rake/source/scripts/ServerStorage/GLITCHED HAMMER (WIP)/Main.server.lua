repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Swing = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing)
local Debounce = false
local DamageValue = 10000
local Speed = 600
local Force = 400000
local Damage = false
local b = script.Parent.Base

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 5
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 10
				script.Parent.Base.RAKEHIT:Play()
				game.Workspace.GLHAMMERDAMAGE:Play()
				script.Parent.Base.HIT:Play()
				local p = script.Parent.Base.geffect:Clone()
				p.Parent = game.Workspace.The_Rake.Torso
				p.Enabled = true
				local scr = script.Parent.ShockPart.attacked:Clone()
				scr.Parent = game.Workspace.The_Rake.Torso
				scr.Disabled = false
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
				workspace.The_Rake.NPC.PlatformStand = true
				b.P1NEON.Script.Disabled = true
				b.P2NEON.Script.Disabled = true
				b.P3NEON.Script.Disabled = true
				b.P4.Script.Disabled = true
				b.P5.Script.Disabled = true
				b.P6NEON.Script.Disabled = true
				b.P7NEON.Script.Disabled = true
				b.P8NEON.Script.Disabled = true
				b.P9NEON.Script.Disabled = true
				b.P10.Script.Disabled = true
				b.P11NEON.Script.Disabled = true
				b.P12.Script.Disabled = true
				b.P13NEON.Script.Disabled = true
				b.P14.Script.Disabled = true
				b.P15NEON.Script.Disabled = true
				b.P16NEON.Script.Disabled = true
				b.P17.Script.Disabled = true
				b.P18.Script.Disabled = true
				b.P19NEON.Script.Disabled = true
				b.P20.Script.Disabled = true
				b.P21NEON.Script.Disabled = true
				b.P22.Script.Disabled = true
				b.P23NEON.Script.Disabled = true
				b.P24NEON.Script.Disabled = true
				b.P25NEON.Script.Disabled = true
				b.P26.Script.Disabled = true
				b.P27.Script.Disabled = true
				b.P28.Script.Disabled = true
				b.P29NEON.Script.Disabled = true
				b.P30NEON.Script.Disabled = true
				b.P31NEON.Script.Disabled = true
				b.P1NEON.Script2.Disabled = false
				b.P2NEON.Script2.Disabled = false
				b.P3NEON.Script2.Disabled = false
				b.P4.Script2.Disabled = false
				b.P5.Script2.Disabled = false
				b.P6NEON.Script2.Disabled = false
				b.P7NEON.Script2.Disabled = false
				b.P8NEON.Script2.Disabled = false
				b.P9NEON.Script2.Disabled = false
				b.P10.Script2.Disabled = false
				b.P11NEON.Script2.Disabled = false
				b.P12.Script2.Disabled = false
				b.P13NEON.Script2.Disabled = false
				b.P14.Script2.Disabled = false
				b.P15NEON.Script2.Disabled = false
				b.P16NEON.Script2.Disabled = false
				b.P17.Script2.Disabled = false
				b.P18.Script2.Disabled = false
				b.P19NEON.Script2.Disabled = false
				b.P20.Script2.Disabled = false
				b.P21NEON.Script2.Disabled = false
				b.P22.Script2.Disabled = false
				b.P23NEON.Script2.Disabled = false
				b.P24NEON.Script2.Disabled = false
				b.P25NEON.Script2.Disabled = false
				b.P26.Script2.Disabled = false
				b.P27.Script2.Disabled = false
				b.P28.Script2.Disabled = false
				b.P29NEON.Script2.Disabled = false
				b.P30NEON.Script2.Disabled = false
				b.P31NEON.Script2.Disabled = false
				wait(0.1)
				workspace.The_Rake.NPC.PlatformStand = false
				workspace.The_Rake:FindFirstChild("Head").RakeHurt4:Play()
			end
			wait(1.4)
			b.P1NEON.Script2.Disabled = true
			b.P2NEON.Script2.Disabled = true
			b.P3NEON.Script2.Disabled = true
			b.P4.Script2.Disabled = true
			b.P5.Script2.Disabled = true
			b.P6NEON.Script2.Disabled = true
			b.P7NEON.Script2.Disabled = true
			b.P8NEON.Script2.Disabled = true
			b.P9NEON.Script2.Disabled = true
			b.P10.Script2.Disabled = true
			b.P11NEON.Script2.Disabled = true
			b.P12.Script2.Disabled = true
			b.P13NEON.Script2.Disabled = true
			b.P14.Script2.Disabled = true
			b.P15NEON.Script2.Disabled = true
			b.P16NEON.Script2.Disabled = true
			b.P17.Script2.Disabled = true
			b.P18.Script2.Disabled = true
			b.P19NEON.Script2.Disabled = true
			b.P20.Script2.Disabled = true
			b.P21NEON.Script2.Disabled = true
			b.P22.Script2.Disabled = true
			b.P23NEON.Script2.Disabled = true
			b.P24NEON.Script2.Disabled = true
			b.P25NEON.Script2.Disabled = true
			b.P26.Script2.Disabled = true
			b.P27.Script2.Disabled = true
			b.P28.Script2.Disabled = true
			b.P29NEON.Script2.Disabled = true
			b.P30NEON.Script2.Disabled = true
			b.P31NEON.Script2.Disabled = true
			b.P1NEON.Script.Disabled = false
			b.P2NEON.Script.Disabled = false
			b.P3NEON.Script.Disabled = false
			b.P4.Script.Disabled = false
			b.P5.Script.Disabled = false
			b.P6NEON.Script.Disabled = false
			b.P7NEON.Script.Disabled = false
			b.P8NEON.Script.Disabled = false
			b.P9NEON.Script.Disabled = false
			b.P10.Script.Disabled = false
			b.P11NEON.Script.Disabled = false
			b.P12.Script.Disabled = false
			b.P13NEON.Script.Disabled = false
			b.P14.Script.Disabled = false
			b.P15NEON.Script.Disabled = false
			b.P16NEON.Script.Disabled = false
			b.P17.Script.Disabled = false
			b.P18.Script.Disabled = false
			b.P19NEON.Script.Disabled = false
			b.P20.Script.Disabled = false
			b.P21NEON.Script.Disabled = false
			b.P22.Script.Disabled = false
			b.P23NEON.Script.Disabled = false
			b.P24NEON.Script.Disabled = false
			b.P25NEON.Script.Disabled = false
			b.P26.Script.Disabled = false
			b.P27.Script.Disabled = false
			b.P28.Script.Disabled = false
			b.P29NEON.Script.Disabled = false
			b.P30NEON.Script.Disabled = false
			b.P31NEON.Script.Disabled = false
			end 
		end 
	end

script.Parent.Activated:Connect(function()
	if char.StaminaBar.Stamina.Value > 150 and script.Parent.Canbeused.Value == true and script.Parent.Attacking.Value == false then
		script.Parent.Attacking.Value = true
		script.Parent.Canbeused.Value = false
Swing:Play()
wait(0.14)
		local sound = math.random(1,2)
		if sound == 1 then
			script.Parent.Base.SwingSound:Play()
		elseif sound == 2 then
			script.Parent.Base.SwingSound2:Play()
		end
char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 150
char.StaminaBar.StaminaRefill.Disabled = true
		char.StaminaBar.StaminaRefill.Disabled = false
		script.Parent.Attacking2.Value = true
		script.Parent.Attacking3.Value = true
wait(0.1)
Damage = true
wait(0.7)		
Damage = false
		wait(5)
		script.Parent.Attacking2.Value = false
		script.Parent.Attacking.Value = false
		script.Parent.Attacking3.Value = false
		script.Parent.Canbeused.Value = true
end
end)

script.Parent.ShockPart.Touched:connect(OnTouched)
