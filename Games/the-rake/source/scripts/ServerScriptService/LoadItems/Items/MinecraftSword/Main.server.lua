repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Swing = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing)
local Swing2 = char:WaitForChild("Humanoid"):LoadAnimation(script.Swing2)
local Clicked = false
local Debounce = false
local DamageValue = 25
local Speed = 25
local Force = 40000
local Damage = false

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if Damage == true then
				Damage = false
				Part.Parent:findFirstChild("NPC"):TakeDamage(DamageValue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 2
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 30
				script.Parent.Base.HitSound:Play()
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * Speed
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
			end 
		end 
	end 
end

script.Parent.Activated:Connect(function()
if Clicked == false and char.StaminaBar.Stamina.Value > 30 then
Clicked = true
		local SwingAnims = math.random(1,2)
		if SwingAnims == 1 then
			Swing:Play()
		elseif SwingAnims == 2 then
			Swing2:Play()
		end
wait(0.1)
		script.Parent.Base.SwingSound:Play()
		script.Parent.Base.Trail.Enabled = true
char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 30
char.StaminaBar.StaminaRefill.Disabled = true
char.StaminaBar.StaminaRefill.Disabled = false
Damage = true
wait(0.3)		
		Damage = false
		script.Parent.Base.Trail.Enabled = false
wait(0.4)
Clicked = false
end
end)

script.Parent.Base.Touched:connect(OnTouched)