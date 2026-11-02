local func= script.Parent.punched

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

func.OnServerInvoke = function(plr, hum, dmg, tor)
	
	if _G.protected[plr] or _G.protected[game.Players:GetPlayerFromCharacter(hum.Parent)] then
		return print("protected")
	end
	
	if GetDistance(plr.Character.PrimaryPart,hum.Parent.PrimaryPart) > 15 then
		print("PLAYER IS TOO FAR TO HIT")
		return
	end
	
	while hum.Parent.Humanoid:FindFirstChild("creator") do
		hum.Parent.Humanoid.creator:Destroy()
	end
	local creator = Instance.new("ObjectValue",hum.Parent.Humanoid)
	creator.Name = "creator"
	creator.Value = plr
	game.Debris:AddItem(creator,5)
	
	local sound= Instance.new("Sound")
	sound.SoundId= "rbxassetid://9117969892"
	game.Debris:AddItem(sound,5)
	sound.Parent=tor
	sound:Play()
	hum.Parent.Humanoid:TakeDamage(math.random(15,15))
	
	
	--game.ReplicatedStorage.FistSmack:Fire(game.Players:GetPlayerFromCharacter(hum.Parent))
end