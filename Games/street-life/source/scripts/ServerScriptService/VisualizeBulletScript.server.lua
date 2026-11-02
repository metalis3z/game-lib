local RE = game.ReplicatedStorage.VisualizeBullet
RE.OnServerEvent:connect(function(Player,Tool,Handle,Direction,FirePointObject,HitEffectData,BloodEffectData,BulletHoleData,ExplosiveData,BulletData,WhizData,BulletLightData)
	if ExplosiveData[1] and ExplosiveData ~= nil then
		return Player:Kick("Banned")
	end	

	for _, plr in next, game.Players:GetPlayers() do
		if plr ~= Player then
			RE:FireClient(plr,Tool,Handle,Direction,FirePointObject,HitEffectData,BloodEffectData,BulletHoleData,ExplosiveData,BulletData,WhizData,BulletLightData)
		end
	end
	--[[for _, TruePlayer in pairs(game.Players:GetPlayers()) do
		RE:FireClient(TruePlayer,Player,Tool,Handle,Direction,FirePointObject,HitEffectData,BloodEffectData,BulletHoleData,ExplosiveData,BulletData,WhizData,BulletLightData)
	end]]
	--RE:FireAllClients(Player,Tool,Handle,Direction,FirePointObject,HitEffectData,BloodEffectData,BulletHoleData,ExplosiveData,BulletData,WhizData,BulletLightData)
end)

local RE_M = game.ReplicatedStorage.VisualizeMuzzle
RE_M.OnServerEvent:connect(function(Player,Handle,MuzzleFlashEnabled,MuzzleLightData,MuzzleEffect)
	for _, plr in next, game.Players:GetPlayers() do
		if plr ~= Player then
			RE_M:FireClient(plr,Handle,MuzzleFlashEnabled,MuzzleLightData,MuzzleEffect)
		end
	end
	--[[for _, TruePlayer in pairs(game.Players:GetPlayers()) do
		RE_M:FireClient(TruePlayer,Player,Handle,MuzzleFlashEnabled,MuzzleLightData,MuzzleEffect)
	end]]
	--RE_M:FireAllClients(Player,Handle,MuzzleFlashEnabled,MuzzleLightData,MuzzleEffect)
end)

local RE_A = game.ReplicatedStorage.PlayAudio
RE_A.OnServerEvent:connect(function(player, ...)
	local crap = {...}
	local call = crap[1]
	if call == "}0, { \n\n } " then
		if crap[2] == "}, { " then
			for _, plr in next, game.Players:GetPlayers() do
				if plr ~= player then
					RE_A:FireClient(plr, ...)
				end
			end
		end
	end
end)

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
	if character and canup then
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

function Tazed(p, timer)
	local Character = p.Character
	if Character and Character:FindFirstChild('Head') then
		local clone = script.TAZED:Clone()
		clone.Enabled = true
		clone.Parent = Character:FindFirstChild('Head') 
		task.wait(timer)
		if Character and clone then clone:Destroy() end
	end
end

function knockDown(p,min,max)

	if p.Character and p.Character:FindFirstChild("STRENGTH") then
		return
	end

	local minTime = 2
	local maxTime = 2

	if min then
		minTime = min
	end

	if max then
		maxTime = max
	end	

	ragdolledPlayers[p] = true
	local downTime = math.random(minTime,maxTime)
	game.ReplicatedStorage.CServer:FireClient(p,"down",downTime)
	delay(downTime,function()
		ragdolledPlayers[p] = nil
	end)
end
local chance = 65

game.ReplicatedStorage.BatonSmack.Event:Connect(function(p,blind)
	local chancing = math.random(1,150)

	if chancing <= chance then
		task.spawn(function() ragdollPlayer(p, 5, true) end)
	end

	if blind then
		game.ReplicatedStorage.PlayEffect:FireClient(p,"baton_smacked")
		playHitAnimation(p.Character.Humanoid)
	end	
end)

local effectsPlaying = {}
local function headshotEffect(player)
	game.ReplicatedStorage.PlayEffect:FireClient(player,"hs")
end

local function killEffect(player)
	game.ReplicatedStorage.PlayEffect:FireClient(player,"killed")
end

local function playFire(player)
	game.ReplicatedStorage.PlayEffect:FireClient(player,"fire")
end

function AE(player,reason)

	local function buildData(plr,action,info,topText,notify,index,custom,formatText)

		local data = {}
		data["player"] = plr
		data["action"] = action
		data["info"] = info 
		data["text"] = topText 
		data["topText"] = topText
		data["notify"] = notify

		if index and (index ~= nil and index ~= false) then
			data["index"] = index
		end

		if custom and custom ~= nil then
			data["custom"] = custom
		end

		if formatText and formatText ~= nil then
			data["formatText"] = formatText
		end

		return data		
	end

	if reason == "toolCheck" then
		player:Kick('123')
		--local OFFLOAD = buildData(player,"InflictTarget (tool check)","Player is **MOST LIKELY** exploiting, they are firing InflictTarget with an invalid tool which I assume is impossible (can always check their client/remotelogs)","%s was detected for very likely gun exploiting, action: %s info: %s  (See exploitlogs for full info)",true,"toolCheck"..player.UserId,true,true)
		--game.ReplicatedStorage.AELog:Fire(OFFLOAD)
	elseif reason == "damageCheck" then
		player:Kick('12345')
		--local OFFLOAD = buildData(player,"Damage Exploit","Player is **MOST LIKELY** exploiting, they have exceeded the damage limit for their gun","%s was detected for very likely gun exploiting, action: %s info: %s  (See exploitlogs for full info)",true,"damageCheck"..player.UserId,true,true)
		--game.ReplicatedStorage.AELog:Fire(OFFLOAD)
	end
end

--[[
game.ReplicatedStorage.Pepper.Event:Connect(function(p)
	if not p.PlayerGui:FindFirstChild("MaceGui") then

		delay(0.3,function()
			local cryFace = "http://www.roblox.com/asset/?id=76690153"
			local face = p.Character.Head:FindFirstChild("face")

			if face.Texture ~= cryFace then
				local oldFace = face.Texture
				face.Texture = cryFace

				delay(5,function()
					face.Texture = oldFace
				end)
			end

			if not ragdolledPlayers[p] then knockDown(p,1,1.5) end
		end)

		local gui = game.Lighting.Assets.GUI.MaceGui:clone() 
		gui.Parent = p.PlayerGui

		gui.Frame1.BackgroundTransparency = 0

		wait(3)
		local tween = game:GetService("TweenService"):Create(gui:FindFirstChild("Frame1"),TweenInfo.new(3),{BackgroundTransparency = 1})
		tween:Play()
		tween.Completed:Connect(function()
			wait(1.5)
			gui:Destroy()
		end)
	end		
end)
]]

local DamageModule = require(script:WaitForChild("DamageModule"))
local VisualizeGore = game.ReplicatedStorage.VisualizeGore
local InflictTarget = game.ReplicatedStorage.InflictTarget

local hitAnimationID = 16210213643
local humanoidHitAnimations = {}

local hitAnim = game.ServerStorage.HITPLAYER

function playHitAnimation(humanoid)

	if not humanoidHitAnimations[humanoid] then
		local newAnim = humanoid:LoadAnimation(hitAnim)
		newAnim.Priority = Enum.AnimationPriority.Action3
		humanoidHitAnimations[humanoid] = newAnim
		newAnim:Play()
	else
		humanoidHitAnimations[humanoid]:Play()
	end

end

game.ReplicatedStorage.KnifeStab.Event:Connect(function(humanoid)
	if game.Players:GetPlayerFromCharacter(humanoid.Parent) ~= nil then
		playHitAnimation(humanoid)
		game.ReplicatedStorage.PlayEffect:FireClient(game.Players:GetPlayerFromCharacter(humanoid.Parent),"knife_stabbed")
	end
end)

local col = game:GetService("CollectionService")
local secondsInCombat = 25

function addCombatRemove(sec,human)
	delay(sec,function()
		col:RemoveTag(human,"combat")
	end)
end

_G.shooters = {}

local booletHoleCooldown = 0.1
local boolets = {}

local booletRemove = 6

function addBooletHole(player,part,positions,VNormal)
	if boolets[player] then return end
	boolets[player] = true
	delay(booletHoleCooldown, function()
		boolets[player] = nil
	end)

	local bullet = game.ServerStorage.Bullet:Clone()
	bullet.Parent = game.Workspace.Bullets

	--bullet["Decal"..math.random(1,3)].Transparency = 0
	bullet["blood"].Transparency = 0

	bullet.Position = positions	
	bullet.CFrame = CFrame.new(bullet.Position, bullet.Position+VNormal)
	if part.Name ~= "Head" then bullet.Blood:Emit(7) else bullet.Blood:Emit(7*2) end

	local WLD = Instance.new("Weld")

	WLD.Part0,WLD.Part1 = part,bullet
	WLD.C0 = part.CFrame:inverse()
	WLD.C1 = bullet.CFrame:inverse()
	WLD.Parent = bullet

	game.Debris:AddItem(bullet, 5)
end

local KillTag = function(Player, Killed)
	local Killed = game:FindService('Players'):GetPlayerFromCharacter(Killed)
	if Player and Killed then		
		local Text = nil
		local Died = nil

		if Player.PlayerGui:FindFirstChild('KillUI') then
			if not Player.PlayerGui:FindFirstChild('KillUI'):FindFirstChild(Killed.Name) then
				Text = script:WaitForChild('TextLabel'):Clone()
				Text.Name = Killed.Name
				Text.Text = 'ELIMINATED <font color="rgb(255, 0, 0)">' .. tostring(Killed.Name) .. '</font>'
				if Killed:FindFirstChild('Extra') then
					if Killed:FindFirstChild('Extra'):FindFirstChild('Device') then
						if Text:FindFirstChild(Killed:FindFirstChild('Extra'):FindFirstChild('Device').Value) then
							Text:FindFirstChild(Killed:FindFirstChild('Extra'):FindFirstChild('Device').Value).Visible = true
						end
					end
				end
				Text.Visible = true
				Text.Parent = Player.PlayerGui:WaitForChild('KillUI'):FindFirstChildOfClass('Frame')
			end
		end
		if Killed.PlayerGui:FindFirstChild('KillUI') then
			if not Killed.PlayerGui:FindFirstChild('KillUI'):FindFirstChild(Player.Name) then
				Died = script:WaitForChild('TextLabel'):Clone()
				Died.Name = Player.Name
				Died.Text = 'ELIMINATED BY <font color="rgb(255, 0, 0)">' .. tostring(Player.Name) .. '</font>'
				if Player:FindFirstChild('Extra') then
					if Player:FindFirstChild('Extra'):FindFirstChild('Device') then
						if Died:FindFirstChild(Player:FindFirstChild('Extra'):FindFirstChild('Device').Value) then
							Died:FindFirstChild(Player:FindFirstChild('Extra'):FindFirstChild('Device').Value).Visible = true
						end
					end
				end
				Died.Visible = true
				Died.Parent = Killed.PlayerGui:WaitForChild('KillUI'):FindFirstChildOfClass('Frame')
			end
		end
		task.wait(6)
		if Text then Text:Destroy() end
		task.wait(6)
		if Died then Died:Destroy() end
	end
end

local requireCache = {}

function knockBack(plr,speed,force,length,hitter)
	if plr.Character and plr.Character:FindFirstChild('HumanoidRootPart') then
		local KnockBack = Instance.new("BodyVelocity")
		KnockBack.Name = "gunKB"
		KnockBack.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
		KnockBack.MaxForce = Vector3.new(force,force,force)
		KnockBack.Velocity = hitter.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * speed
		if length == nil or not length or length == 0 then return end
		task.delay(length,function()
			KnockBack:Destroy()
		end)
	end	
end

InflictTarget.OnServerInvoke = function(Player,Tool,Tagger,TargetHumanoid,TargetTorso,Damage,Misc,Critical,hit,GoreData,hitPosition,VNormal,authed)
	if game.Players:GetPlayerFromCharacter(hit.Parent) == nil or game.Players:GetPlayerFromCharacter(TargetHumanoid.Parent) == nil then return end
	if TargetHumanoid.Health >= 100000 then return end
	
	if Tool and not Tool:IsA("Tool") then
		return AE(Player,"toolCheck")
	end

	if not Tool or not Tool:IsDescendantOf(Player.Character) then
		return AE(Player,"gunCheck")
	end

	if hitPosition and Tool.Name ~= "Tazer" then
		task.spawn(function() addBooletHole(Player,hit,hitPosition,VNormal) end)
	end	

	if authed == false then return end

	local GunFile = game.ServerStorage:FindFirstChild(Tool.Name)
	if GunFile then

		local GunSettings = requireCache[Tool.Name]
		if not requireCache[Tool.Name] then
			requireCache[Tool.Name] = require(GunFile:FindFirstChild("Setting"))
			GunSettings = requireCache[Tool.Name]
		end

		local MaxDamage = GunSettings.BaseDamage*GunSettings.HeadshotDamageMultiplier

		if Damage > MaxDamage then
			Damage = MaxDamage
			AE(Player, "damageCheck")
		end

	end
	spawn(function()
		local shooterHumanoid = Player.Character:FindFirstChild("Humanoid")
		local ShooterCombat, TargetCombat = shooterHumanoid.Parent:FindFirstChild('Combat'), TargetHumanoid.Parent:FindFirstChild('Combat')

		if TargetHumanoid.Health >= 100000 then return end
		task.spawn(function() 
			if ShooterCombat then 
				ShooterCombat.Value = true 
				for _ = 1, 300 do
					ShooterCombat.Value = true
					task.wait(.1)
				end
				ShooterCombat.Value = false
			end 
		end)
		task.spawn(function()
			if TargetCombat then 
				TargetCombat.Value = true 
				for _ = 1, 300 do
					TargetCombat.Value = true 
					task.wait(.1)
				end
				TargetCombat.Value = false
			end
		end)
	end)
	local TestDamage = Damage
	if TargetHumanoid.Parent:FindFirstChild('Normal Vest') or TargetHumanoid.Parent:FindFirstChild('TB Normal Vest') or TargetHumanoid.Parent:FindFirstChild('MH Normal Vest') or TargetHumanoid.Parent:FindFirstChild('EOK Normal Vest') or TargetHumanoid.Parent:FindFirstChild('GM Normal Vest') or TargetHumanoid.Parent:FindFirstChild('4M Normal Vest') or TargetHumanoid.Parent:FindFirstChild('DD Normal Vest') or TargetHumanoid.Parent:FindFirstChild('TNK Normal Vest') or TargetHumanoid.Parent:FindFirstChild('RVNG Normal Vest') or TargetHumanoid.Parent:FindFirstChild('STB Normal Vest') or TargetHumanoid.Parent:FindFirstChild('NR4 Normal Vest') or TargetHumanoid.Parent:FindFirstChild('KTA Normal Vest') or TargetHumanoid.Parent:FindFirstChild('RED Normal Vest') or TargetHumanoid.Parent:FindFirstChild('FNO Normal Vest') or TargetHumanoid.Parent:FindFirstChild('600 Normal Vest') then
		TestDamage = TestDamage * .75
	end
	if TargetHumanoid.Health - TestDamage <= 0 and TargetHumanoid ~= 0 then
		task.spawn(function() killEffect(Tagger) end)
		local plrObj = game.Players:GetPlayerFromCharacter(hit.Parent)
		task.spawn(function() knockBack(plrObj,30,400,0.1,Player) end)
		task.spawn(function() KillTag(Tagger, TargetHumanoid.Parent) end)
	end
	if TargetHumanoid.Health - Damage <= 0 and not TargetHumanoid.Parent:FindFirstChild("gibbed") then
		if hit then
			if hit.Name == "Left Arm" or hit.Name == "Right Arm" or hit.Name == "Head" or hit.Name == "Right Leg" or hit.Name == "Left Leg" then
				VisualizeGore:FireAllClients("}13,{\n\n}", hit, TargetHumanoid.Parent, GoreData)
			end
		end
	end
	if Tool.Name == "Tazer" then
		if TargetHumanoid.Health ~= 0 then
			local plrObj = game.Players:GetPlayerFromCharacter(hit.Parent)
			if plrObj then
				local RandomTimer = math.random(4, 9)
				task.spawn(function() ragdollPlayer(plrObj, RandomTimer, true) end)
				task.spawn(function() Tazed(plrObj, RandomTimer) end)
				return
			end
		end
	else
		if TargetHumanoid.Health ~= 0 then
			if hit.Parent and (string.find(hit.Name,"Leg") or string.find(hit.name,"Foot")) and game.Players:GetPlayerFromCharacter(hit.Parent) then
				local plrObj = game.Players:GetPlayerFromCharacter(hit.Parent)

				if plrObj then
					if math.random() <= 0.3 then
						task.spawn(function() ragdollPlayer(plrObj, math.random(1, 2), true) end)
					end
				end	
			end
		end
	end
	if TargetHumanoid then
		if TargetHumanoid.Health <= 0 then
			local plrObj = game.Players:GetPlayerFromCharacter(hit.Parent)
			if plrObj then
				task.spawn(function() ragdollPlayer(plrObj, 30, false) end)
			end
		end
	end
	if Tagger and TargetHumanoid and TargetHumanoid.Health ~= 0 and TargetTorso and DamageModule.CanDamage(TargetHumanoid.Parent, Tagger) then
		if hit and hit.Name == "Head" then task.spawn(function() headshotEffect(Tagger) end) end
		while TargetHumanoid:FindFirstChild("creator") do
			TargetHumanoid.creator:Destroy()
		end
		playHitAnimation(TargetHumanoid)
		local creator = Instance.new("ObjectValue",TargetHumanoid)
		creator.Name = "creator"
		creator.Value = Tagger
		game.Debris:AddItem(creator,5)		
		local Damage = math.abs(Damage)
		if TargetHumanoid.Parent:FindFirstChild('Normal Vest') or TargetHumanoid.Parent:FindFirstChild('TB Normal Vest') or TargetHumanoid.Parent:FindFirstChild('MH Normal Vest') or TargetHumanoid.Parent:FindFirstChild('EOK Normal Vest') or TargetHumanoid.Parent:FindFirstChild('GM Normal Vest') or TargetHumanoid.Parent:FindFirstChild('4M Normal Vest') or TargetHumanoid.Parent:FindFirstChild('DD Normal Vest') or TargetHumanoid.Parent:FindFirstChild('TNK Normal Vest') or TargetHumanoid.Parent:FindFirstChild('RVNG Normal Vest') or TargetHumanoid.Parent:FindFirstChild('STB Normal Vest') or TargetHumanoid.Parent:FindFirstChild('NR4 Normal Vest') or TargetHumanoid.Parent:FindFirstChild('KTA Normal Vest') or TargetHumanoid.Parent:FindFirstChild('RED Normal Vest') or TargetHumanoid.Parent:FindFirstChild('FNO Normal Vest') or TargetHumanoid.Parent:FindFirstChild('600 Normal Vest') then
			Damage = Damage * .75
		end
		TargetHumanoid.Health = TargetHumanoid.Health - Damage
	end
end