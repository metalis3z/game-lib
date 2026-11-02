local func= script.Parent.punched

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

local ragdolledPlayers = {}
function ragdollPlayer(p,downtime,canup)
	ragdolledPlayers[p] = true
	local character = p.Character
	if not character:FindFirstChild('RAGDOLLED') then
		for _, v in pairs(character:GetDescendants()) do 
			if v:IsA("Motor6D") and v.Parent.Name ~= 'Handle' then
				local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
				a0.CFrame = v.C0
				a1.CFrame = v.C1
				a0.Parent = v.Part0
				a1.Parent = v.Part1
				local b = Instance.new("BallSocketConstraint")
				b.Attachment0 = a0
				b.Attachment1 = a1
				b.Parent = v.Part0
				v.Enabled = false
			end
			if v.Name == "HumanoidRootPart" then
				v.CanCollide = false
			end
		end
		game.ReplicatedStorage.RagdollClient:FireClient(p,"ragdoll")
		local RAGDOLLED = Instance.new('BoolValue', character)
		RAGDOLLED.Name = 'RAGDOLLED'
	end
	wait(downtime)
	if character and canup and character.Humanoid.Health >= 1 then
		for _,v in pairs(character:GetDescendants()) do 
			if v.Parent.Name ~= 'Handle' then
				if v:IsA('Motor6D') then
					v.Enabled = true
				end
				if v.Name == 'BallSocketConstraint' then
					v:Destroy()
				end
				if v.Name == 'Attachment' then
					v:Destroy()
				end
			end
			if v.Name == "HumanoidRootPart" then
				v.CanCollide = true
			end
		end
		game.ReplicatedStorage.RagdollClient:FireClient(p,"unragdoll")
		if character:FindFirstChild('RAGDOLLED') then
			character:FindFirstChild('RAGDOLLED'):Destroy()
		end
	end
	ragdolledPlayers[p] = nil
end

func.OnServerInvoke = function(plr, hum, extra)
	
	local HitChar = hum.Parent
	local TheOneThatPunchCHar = plr.Character
	
	if HitChar == TheOneThatPunchCHar then return end
	
	if not plr.Character:FindFirstChild('Fist') then
		return
	end
	
	if plr.Character.PrimaryPart and hum.Parent.PrimaryPart then
		if GetDistance(plr.Character.PrimaryPart, hum.Parent.PrimaryPart) > 7 then
			return
		end
	else
		return
	end
	
	while hum.Parent.Humanoid:FindFirstChild("creator") do
		hum.Parent.Humanoid.creator:Destroy()
	end
	
	local GymStrength = plr:FindFirstChild('stored'):FindFirstChild('GymStrength').Value
	local Damage = math.random(5, 8) + GymStrength / 35
	
	local creator = Instance.new("ObjectValue",hum.Parent.Humanoid)
	creator.Name = "creator"
	creator.Value = plr
	game.Debris:AddItem(creator, 1)
	
	local sound= Instance.new("Sound")
	sound.SoundId= "rbxassetid://9117969892"
	sound.RollOffMaxDistance = 30
	game.Debris:AddItem(sound, 5)
	sound.Parent = hum.Parent.HumanoidRootPart
	sound:Play()
	if extra == 'Stomp' then
		hum.Parent.Humanoid:TakeDamage(math.random(3, 7))
	elseif extra == 'Punch' then
		hum.Parent.Humanoid:TakeDamage(Damage)
	end
	
	game.ReplicatedStorage.KnifeStab:Fire(hum.Parent.Humanoid)
	
	if extra == 'Punch' then
		if math.random() <= 0.075 then
			task.spawn(function() ragdollPlayer(game:FindService('Players'):GetPlayerFromCharacter(hum.Parent), math.random(2, 5), true) end)
		end
	end
	
	task.spawn(function()
		if HitChar:FindFirstChild('Combat') then
			HitChar:FindFirstChild('Combat').Value = true
			task.wait(5)
			HitChar:FindFirstChild('Combat').Value = false
		end
	end)

	if TheOneThatPunchCHar:FindFirstChild('Combat') then
		TheOneThatPunchCHar:FindFirstChild('Combat').Value = true
		task.wait(5)
		TheOneThatPunchCHar:FindFirstChild('Combat').Value = false
	end
end