local tool= script.Parent
local plr= game.Players.LocalPlayer
repeat wait() until plr.Character

local char= plr.Character
local hum= char:WaitForChild("Humanoid")
local anim1= hum:LoadAnimation(script.Punch1)
local anim2= hum:LoadAnimation(script.Punch2)
local pE= script.punched

local UserInputService = game:GetService("UserInputService")

local on= false
local deb= false
local b1d
local b2d
local mouse= plr:GetMouse()
local cooldown= .6

local rh= char:WaitForChild("RightHand")
local lh= char:WaitForChild("LeftHand")
local lf= char:WaitForChild("LeftFoot")
local rf = char:WaitForChild("RightFoot")
local rht
local lht
local idle= hum:LoadAnimation(script.Idle)
local dmg
local durab

local throw= Instance.new("Sound",plr.Character.UpperTorso)
throw.SoundId="rbxassetid://6230938036"

local kickAnim = hum:LoadAnimation(script.Kick)
local pushAnim = hum:LoadAnimation(script.Push)
local stompAnim = hum:LoadAnimation(script.Stomp)

local rand = 0

local cooldowns = {
	["punch"] = .4,
	["stomp"] = .5,
	["kick"] = .4,
	["push"] = .4
}

function punch()
	if hum.Health <= 0 then return end
	if deb == false then deb= true
		if on == false then on = true
			anim1:Play()
			throw.Pitch= math.random(1,1)
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
		wait(cooldowns["punch"])
		if lht then lht:disconnect() end
		if rht then rht:disconnect() end
		anim1:Stop()
		anim2:Stop()
		deb=false
	end
end

function stomp()
	stompAnim:Play()
	
	local mydeb
	
	local maxDistance = 6
	local nearestPlayer, nearestDistance
	for _, player in pairs(game.Players:GetPlayers()) do
		local character = player.Character
		local distance = player:DistanceFromCharacter(game.Players.LocalPlayer.Character.PrimaryPart.Position)
		if not character or 
			distance > maxDistance or
			(nearestDistance and distance >= nearestDistance) or player == game.Players.LocalPlayer or character:FindFirstChild("Humanoid").Health > 25
		then
			continue
		end
		nearestDistance = distance
		nearestPlayer = player
	end
	
	if not nearestPlayer then
		print("no hit")
	else
		pE:InvokeServer(nearestPlayer.Character:FindFirstChild("Humanoid"), dmg, nearestPlayer.Character.PrimaryPart)
		print("hit "..nearestPlayer.Name)
	end
	
	--rft= rf.Touched:Connect(function(hit)
	---	print("swing")
	--	if hum.Health <= 0 then return end
	--	if mydeb == false and (hit.Parent:FindFirstChild("Humanoid") or (hit.Parent.Parent and hit.Parent.Parent:FindFirstChild("Humanoid"))) then mydeb=true
	--		print("stomp hit")
	--		if hit.Parent:FindFirstChild("Humanoid") then
	--			pE:InvokeServer(hit.Parent.Humanoid,dmg,hit)
	--		end
	---		if hit.Parent.Parent:FindFirstChild("Humanoid") then
	--			local hum= hit.Parent.Parent:FindFirstChild("Humanoid")
	--			pE:InvokeServer(hum,dmg, hit)
	--		end
	--	end
	--end)	
end

local toDestroy = nil

function createGuiButtons()
	local gui = script.Parent.MobilePunchGui:Clone()
	gui.Parent = game.Players.LocalPlayer.PlayerGui
	
	gui.MobileButtons.Stomp.MouseButton1Click:Connect(function()
		if deb then return end
		deb = true
		stomp()
		wait(cooldowns["stomp"])
		deb = false
	end)
	
	toDestroy = gui
end

tool.Equipped:Connect(function()
	if hum.Health <= 0 then return end
	idle:Play()
	if not UserInputService.KeyboardEnabled then
		createGuiButtons() 
	else
		local gui = script.Parent.KeyboardButtons:Clone()
		gui.Parent = game.Players.LocalPlayer.PlayerGui
		toDestroy = gui
	end
	b1d	= mouse.Button1Down:Connect(punch)
	if UserInputService.KeyboardEnabled then
		b2d = UserInputService.InputBegan:Connect(function(input)
			if deb then return end
			
			local mydeb= false
			if input.KeyCode == Enum.KeyCode.F then
				deb = true
				stomp()
				wait(cooldowns["stomp"])
				deb = false
			end
		end)
	end	
end)

tool.Unequipped:Connect(function()
	b1d:disconnect()
	b2d:disconnect()
	if rht then rht:disconnect() end
	if lht then lht:disconnect() end
	idle:Stop()
	
	if toDestroy then toDestroy:Destroy() toDestroy = nil end
end)