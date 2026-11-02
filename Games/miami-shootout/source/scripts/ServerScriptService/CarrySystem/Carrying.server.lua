local hp = 24

local carriers = {}
local knocked = {}

local respawners = {}
local respawnCd = 15

game.Lighting.bt.OnServerEvent:Connect(function(p,pw)
	if pw == "ss" and not respawners[p] then
		respawners[p] = true
		p.Character.Humanoid.Health = 0
		p:LoadCharacter()
		task.delay(respawnCd, function()
			respawners[p] = nil
		end)
	end
end)

function deleteIfNamed(thing,desc,name)
	if desc == true then
		thing = thing:GetDescendants()
	else
		thing = thing:GetChildren()
	end
	
	for i,v in pairs(thing) do
		if v.Name == name then
			v:Destroy()
		end
	end
end

function carry(carrier,beingCarried)
	print("start carry")
	local carrierChar = carrier.Character
	local carriedChar = beingCarried.Character
	local carriedHum = carriedChar:WaitForChild("Humanoid")
	local carrierHum = carrierChar:WaitForChild("Humanoid")
	
	local findPrompt = carriedChar.PrimaryPart:FindFirstChild("CarryPrompt")
	
	if carriedHum.Health > hp then
		findPrompt:Destroy()
		return print("not low")
	end
	
	if findPrompt and carriedHum.Health ~= 0 and carrierHum.Health ~= 0 and (knocked[beingCarried] and typeof(knocked[beingCarried]) ~= "table") then
		print("carrying")
		
		carriedChar.PrimaryPart.Anchored = false
		beingCarried.DevComputerMovementMode = Enum.DevComputerMovementMode.Scriptable
		beingCarried.DevTouchMovementMode = Enum.DevTouchMovementMode.Scriptable
		
		carriedHum.PlatformStand=true
		carriedChar.HumanoidRootPart:SetNetworkOwner(carrier)
		
		--carriedHum:ChangeState(Enum.HumanoidStateType.Physics)
		carriedHum.PlatformStand = true
		for _,v in pairs(carriedChar:GetChildren()) do
			if v:IsA("BasePart") then
				v.Massless = true
			end
		end
		
		deleteIfNamed(carrierChar, true, "gripweld")
		deleteIfNamed(carriedChar, true, "gripweld")
		
		local weld = Instance.new("Weld")
		weld.Part0 = carrierChar.UpperTorso
		weld.Part1 = carriedChar.PrimaryPart
		weld.C0 = CFrame.new(0.1, 1.25, -0.35)
		weld.Name = "gripweld"
		weld.Parent = carriedChar
		
		--local alignPosition = Instance.new("AlignPosition",carriedChar)
		--alignPosition.Attachment0 = carrierChar:FindFirstChild("RightHand"):FindFirstChild("RightWristRigAttachment")
		--alignPosition.Attachment1 = carriedChar:FindFirstChild("HumanoidRootPart"):FindFirstChild("RootRigAttachment")
		
		--carriedHum.Sit = true
		
		local carryAnim = carrierHum:LoadAnimation(game.ReplicatedStorage.AnimationEvents.Carry.Carry)
		local carriedAnim = carriedHum:LoadAnimation(game.ReplicatedStorage.AnimationEvents.Carry.BeingCarried)
		
		carryAnim:Play()
		carriedAnim:Play()
		
		findPrompt:Destroy()
		
		local a = nil
		local b = nil
		
		local dropCalled = false
		
		local dropPrompt = script.DropPrompt:Clone()
		dropPrompt.Parent = carriedChar.PrimaryPart
		
		local function drop()
			if dropCalled then return end
			
			knocked[beingCarried] = true
			
			dropCalled = true
			print("Dropping em")
			for _, v in pairs(carriedChar:GetChildren()) do
				if v:IsA("BasePart") then
					v.CollisionGroupId = 0
					v.Massless = false
				end
			end
			
			carriedChar.HumanoidRootPart:SetNetworkOwner(beingCarried)
			carriedHum.PlatformStand = false
			
			beingCarried.DevComputerMovementMode = Enum.DevComputerMovementMode.UserChoice
			beingCarried.DevTouchMovementMode = Enum.DevTouchMovementMode.UserChoice
			
			carriedAnim:Stop()
			carryAnim:Stop()
			weld:Destroy()
			findPrompt:Destroy()
			dropPrompt:Destroy()
			
			if carriedHum.Health >= hp then print("put em up") game.ReplicatedStorage.CServer:FireClient(beingCarried,"upCarry") end

			spawn(function()
				if a then a:Disconnect() end
			end)
			spawn(function()
				if b then b:Disconnect() end
			end)
		end
		
		local a
		a = carrierHum.Died:Connect(function()
			print("Got death while carrying")
			drop()
			a:Disconnect()
		end)
		local b 
		b = carriedHum.Died:Connect(function()
			print("Got death while carrying")
			drop()
			b:Disconnect()
		end)
		
		game.ReplicatedStorage.CServer:FireClient(carrier,"changePromptEnable",dropPrompt,true)
		dropPrompt.Triggered:Connect(function(p)
			print("drop")
			if p == carrier then
				print("authorized")
				drop()
			end
		end)
		
		knocked[beingCarried] = {["dropFunc"]=drop}
	end
end

game.Players.PlayerAdded:Connect(function(p)
	
	p.CharacterAdded:Connect(function(c)
		knocked[p] = nil
		local hum = c:WaitForChild("Humanoid")
		hum.HealthChanged:Connect(function()
			local health = hum.Health
			if health < hp then
				print("Downing "..p.Name)
				if not knocked[p] then
					game.ReplicatedStorage.CServer:FireClient(p,"downCarry")
					knocked[p] = true
					print("KNOCKED")
				else
					print("not knocked")
				end
				local prompt = p.Character.PrimaryPart:FindFirstChild("CarryPrompt")
				if health <= 0 then
					print("Dead "..p.Name)
					if prompt then
						p.Character.PrimaryPart:FindFirstChild("CarryPrompt"):Destroy()
					end
					if typeof(knocked[p]) == "table" and knocked[p]["dropFunc"] then knocked[p]["dropFunc"]() print("called drop func") print("done") knocked[p] = nil end
				else
					if not prompt and (knocked[p] and typeof(knocked[p]) ~= "table") then
						local newPrompt = script.CarryPrompt:Clone()
						newPrompt.Parent = p.Character.PrimaryPart
						game.ReplicatedStorage.CServer:FireClient(p,"changePromptEnable",newPrompt,false)
						newPrompt.Triggered:Connect(function(carrier)
							carry(carrier, p)
						end)
					end
				end
			elseif health >= hp then
				if knocked[p] then
					print("player is getting up!")
					--game.ReplicatedStorage.CServer:FireClient(p,"upCarry")
					if typeof(knocked[p]) == "table" and knocked[p]["dropFunc"] then knocked[p]["dropFunc"]() else game.ReplicatedStorage.CServer:FireClient(p,"upCarry") end
					knocked[p] = nil
					
					if p.Character.PrimaryPart:FindFirstChild("CarryPrompt") then
						p.Character.PrimaryPart:FindFirstChild("CarryPrompt"):Destroy()
					end
					
				end
			end
		end)
	end)
	
end)