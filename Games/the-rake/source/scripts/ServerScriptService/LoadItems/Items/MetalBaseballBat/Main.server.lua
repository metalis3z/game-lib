repeat wait() until script.Parent.Parent:FindFirstChildOfClass("Humanoid")

local char = script.Parent.Parent
local humanoid = char:FindFirstChildOfClass("Humanoid")
local swinganim = humanoid:LoadAnimation(script.Swing)
local debounce = false
local damage = false
local damagevalue = 42
local speed = 32

function OnTouched(Part) 
	if Part.Parent ~= nil then
		if Part.Parent:FindFirstChild("NPC") ~= nil then 
			if damage == true then
				damage = false
				local randomhitsound = math.random(1,3)
				Part.Parent:findFirstChild("NPC"):TakeDamage(damagevalue)
				workspace.The_Rake.Stunning.Value = 1
				workspace.The_Rake.Configuration.StunTime.Value = workspace.The_Rake.Configuration.StunTime.Value + 3
				workspace.The_Rake.Stun.GetStuns.Value = workspace.The_Rake.Stun.GetStuns.Value + 45
				if randomhitsound == 1 then
					script.Parent.HitBox.HitSound:Play()
				elseif randomhitsound == 2 then
					script.Parent.HitBox.HitSound2:Play()	
				elseif randomhitsound == 3 then
					script.Parent.HitBox.HitSound3:Play()	
				end
				local bv = Instance.new("BodyVelocity")
				bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
				bv.Velocity = script.Parent.Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector * speed
				bv.Parent = Part.Parent.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv,0.1)
			end 
		end 
	end 
end

script.Parent.Activated:Connect(function()
	local randomswingsound = math.random(1,3)
	if debounce == false and char.StaminaBar.Stamina.Value > 40 then
		debounce = true
		swinganim:Play()
		wait(0.3)
		if randomswingsound == 1 then
			script.Parent.Base.SwingSound:Play()
		elseif randomswingsound == 2 then
			script.Parent.Base.SwingSound2:Play()	
		elseif randomswingsound == 3 then
			script.Parent.Base.SwingSound3:Play()	
		end
		damage = true
		char.StaminaBar.Stamina.Value = char.StaminaBar.Stamina.Value - 40
		char.StaminaBar.StaminaRefill.Disabled = true
		char.StaminaBar.StaminaRefill.Disabled = false
		wait(0.5)
		damage = false
		wait(0.5)
		debounce = false
	end
end)

script.Parent.HitBox.Touched:Connect(OnTouched)