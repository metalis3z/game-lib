repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Swing1 = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing1)
local Swing2 = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing2)
local Swing3 = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing3)
local Clicked = false
local Debounce = false
local RandomSound = math.random(1,3)
local DamageValue = 400
local Speed = 50
local Force = 30000
local Damage = false

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 2.15
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 5
				local hit = math.random(1,3)
				if hit == 1 then
					script.Parent.Base.Handle.Hammer.Hit1:Play()
				elseif hit == 2 then
					script.Parent.Base.Handle.Hammer.Hit2:Play()
				elseif hit == 3 then
					script.Parent.Base.Handle.Hammer.Hit3:Play()
				end
				script.Parent.Base.Handle.Hammer.Hit.HitEmitter:Emit(10)
				script.Parent.Base.Handle.Hammer.Hit.DamageEmitter:Emit(50)
				local scriptt = script.Parent.Base.DamageScript:Clone()
				scriptt.Parent = game.Workspace.The_Rake.Torso
				scriptt.Disabled = false
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
				workspace.The_Rake.NPC.PlatformStand = true
				wait(0.1)
				workspace.The_Rake.NPC.PlatformStand = false
				if RandomSound == 1 then
					workspace.The_Rake:FindFirstChild("Head").RakeHurt:Play()
				elseif RandomSound == 2 then
					workspace.The_Rake:FindFirstChild("Head").RakeHurt2:Play()
				elseif RandomSound == 3 then
					workspace.The_Rake:FindFirstChild("Head").RakeHurt3:Play()
				end
			end 
		end 
	end 
end

script.Parent.Activated:Connect(function()
if Clicked == false and char.StaminaBar.Stamina.Value > 30 then
Clicked = true
		local anim = math.random(1,3)
		if anim == 1 then
			Swing1:Play()
		elseif anim == 2 then
			Swing2:Play()
		elseif anim == 3 then
			Swing3:Play()
		end
wait(0.14)
char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 30
char.StaminaBar.StaminaRefill.Disabled = true
char.StaminaBar.StaminaRefill.Disabled = false
		wait(0.3)
		local sound = math.random(1,3)
	if sound == 2 then
			script.Parent.Base.Handle.Hammer.Swing1:Play()
	elseif sound == 2 then
			script.Parent.Base.Handle.Hammer.Swing2:Play()
	elseif sound == 3 then
			script.Parent.Base.Handle.Hammer.Swing3:Play()
		end
		script.Parent.Base.Handle.Hammer.Trail.Enabled = true
Damage = true
		wait(0.6)
		script.Parent.Base.Handle.Hammer.Trail.Enabled = false
Damage = false
wait(0.15)
Clicked = false
end
end)

script.Parent.ShockPart.Touched:connect(OnTouched)