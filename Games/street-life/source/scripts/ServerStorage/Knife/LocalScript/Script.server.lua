 local func= script.Parent.punched

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

func.OnServerInvoke = function(plr, hum, dmg)

	local HitChar = hum.Parent
	local TheOneThatPunchCHar = plr.Character

	if HitChar == TheOneThatPunchCHar then return end
	
	if not plr.Character:FindFirstChild('Knife') then
		return
	end

	if GetDistance(plr.Character.PrimaryPart, hum.Parent.PrimaryPart) > 7 then
		return
	end

	while hum.Parent.Humanoid:FindFirstChild("creator") do
		hum.Parent.Humanoid.creator:Destroy()
	end
	
	local creator = Instance.new("ObjectValue",hum.Parent.Humanoid)
	creator.Name = "creator"
	creator.Value = plr
	game.Debris:AddItem(creator, 1)

	local sound= Instance.new("Sound")
	sound.SoundId= "rbxassetid://566593606"
	sound.RollOffMaxDistance = 30
	game.Debris:AddItem(sound,5)
	sound.Parent = hum.Parent.HumanoidRootPart
	sound:Play()
	hum.Parent.Humanoid:TakeDamage(math.random(11, 15))

	game.ReplicatedStorage.KnifeStab:Fire(hum.Parent.Humanoid)
	
	task.spawn(function()
		if HitChar:FindFirstChild('Combat') then
			HitChar:FindFirstChild('Combat').Value = true
			task.wait(10)
			HitChar:FindFirstChild('Combat').Value = false
		end
	end)

	if TheOneThatPunchCHar:FindFirstChild('Combat') then
		TheOneThatPunchCHar:FindFirstChild('Combat').Value = true
		task.wait(10)
		TheOneThatPunchCHar:FindFirstChild('Combat').Value = false
	end
end