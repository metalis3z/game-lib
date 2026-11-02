if not game:IsLoaded() then game.Loaded:Wait() end

local tool= script.Parent
local plr= game.Players.LocalPlayer
local char= plr.Character or plr.CharacterAdded:Wait()
local hum= char:WaitForChild("Humanoid")
local hrp = char:WaitForChild('HumanoidRootPart')
char:WaitForChild('Head')

local idle
local anim1
local anim2
local pE= script:WaitForChild('punched')


local on= false
local deb= false
local b1d
local mouse= plr:GetMouse()
local cooldown= .5

local rh= char:WaitForChild("RightHand")
local lh= char:WaitForChild("LeftHand")
local rht
local lht
local dmg = 5
local durab

local throw = script.Parent.Knife:FindFirstChild('throw')

tool.Equipped:Connect(function()
	if hum.Health <= 0 then return end
	idle = hum:LoadAnimation(script:WaitForChild('Idle'))
	anim1 = hum:LoadAnimation(script:WaitForChild('Punch1'))
	anim2 = hum:LoadAnimation(script:WaitForChild('Punch2'))
	idle:Play()
	b1d= mouse.Button1Down:Connect(function()
		if hum.Health <= 0 then return end
		if deb == false then deb= true
			if on == false then on = true
				anim1:Play()
				throw.Pitch = math.random(1,1)
				throw:Play()
				local mydeb= false
				rht= rh.Touched:Connect(function(hit)
					if hum.Health <= 0 then return end
					if mydeb == false then mydeb=true
						if hit.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent:FindFirstChild("Humanoid"), 5)
						end
						if hit.Parent.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent.Parent:FindFirstChild("Humanoid"), 5)
						end
					end
				end)
			elseif on == true then on = false
				anim2:Play()
				throw.Pitch = math.random(1,2)
				throw:Play()
				local mydeb= false
				lht= lh.Touched:Connect(function(hit)
					if hum.Health <= 0 then return end
					if mydeb == false then mydeb=true
						if hit.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent:FindFirstChild("Humanoid"), 5 )
						end
						if hit.Parent.Parent:FindFirstChild("Humanoid") then
							pE:InvokeServer(hit.Parent.Parent:FindFirstChild("Humanoid"), 5)
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