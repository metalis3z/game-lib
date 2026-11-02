local tool= script.Parent
local plr= game.Players.LocalPlayer
repeat wait() until plr.Character

local char= plr.Character
local hum= char:WaitForChild("Humanoid")
local anim1= hum:LoadAnimation(script.Punch1)
local anim2= hum:LoadAnimation(script.Punch2)
local pE= script.punched

local on= false
local deb= false
local b1d
local mouse= plr:GetMouse()
local cooldown= .4

local rh= char:WaitForChild("RightHand")
local lh= char:WaitForChild("LeftHand")
local rht
local lht
local idle= hum:LoadAnimation(script.Idle)
local dmg
local durab

local throw= Instance.new("Sound",plr.Character.UpperTorso)
throw.SoundId="rbxassetid://711753382"


tool.Equipped:Connect(function()
	if hum.Health <= 0 then return end
	idle:Play()
	b1d= mouse.Button1Down:Connect(function()
		if hum.Health <= 0 then return end
		if deb == false then deb= true
		if on == false then on = true
			anim1:Play()
			throw.Pitch= math.random(1,2)
			throw:Play()
			local mydeb= false
			rht= rh.Touched:Connect(function(hit)
				if hum.Health <= 0 then return end
				if mydeb == false then mydeb=true
				if hit.Parent:FindFirstChild("Humanoid") then
					pE:InvokeServer(hit.Parent.Humanoid,dmg, hit)
				end
				if hit.Parent.Parent:FindFirstChild("Humanoid") then
					pE:InvokeServer(hit.Parent.Parent.Humanoid,dmg,hit)
				end
				end
			end)
		elseif on == true then on = false
			anim2:Play()
			throw.Pitch= math.random(1,2)
			throw:Play()
			local mydeb= false
			lht= lh.Touched:Connect(function(hit)
				if hum.Health <= 0 then return end
				if mydeb == false then mydeb=true
				if hit.Parent:FindFirstChild("Humanoid") then
					pE:InvokeServer(hit.Parent.Humanoid,dmg,hit)
				end
				if hit.Parent.Parent:FindFirstChild("Humanoid") then
					local hum= hit.Parent.Parent:FindFirstChild("Humanoid")
					pE:InvokeServer(hum,dmg, hit)
				end
				end
			end)		
		end
		wait(cooldown)
		if lht then lht:disconnect() end
		if rht then rht:disconnect() end
		anim1:Stop()
		anim2:Stop()
		deb=false
		end
	end)
end)

tool.Unequipped:Connect(function()
	b1d:disconnect()
	if rht then rht:disconnect() end
	if lht then lht:disconnect() end
	idle:Stop()
end)