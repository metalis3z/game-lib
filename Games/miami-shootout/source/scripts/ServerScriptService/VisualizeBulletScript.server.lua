local RE = game.ReplicatedStorage.VisualizeBullet
local gunExploitBan = game:GetService("DataStoreService")
local dataGunBans = gunExploitBan:GetDataStore("bangun1")

game.Players.PlayerAdded:Connect(function(p)
	local banned = dataGunBans:GetAsync(p.UserId)
	if banned then
		p:Kick("banned for exploiting guns | unbanned never")
	end
end)

RE.OnServerEvent:connect(function(Player,Tool,Handle,Direction,FirePointObject,HitEffectData,BloodEffectData,BulletHoleData,ExplosiveData,BulletData,WhizData,BulletLightData)
	if ExplosiveData[1] and ExplosiveData ~= nil then
		dataGunBans:SetAsync(Player.UserId, true)
		return Player:Kick("enjoy ya ban LOL")
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
function ragdollPlayer(p,downtime)
	--ragdolledPlayers[p] = true
	--[[
	local character = p.Character
	for _, v in pairs(character:GetDescendants()) do  --ragdoll
		if v:IsA("Motor6D") then
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
	wait(downtime)
	for _,v in pairs(character:GetDescendants()) do  --unragdoll
		if v:IsA('Motor6D') then
			v.Enabled = true
		end
		if v.Name == 'BallSocketConstraint' then
			v:Destroy()
		end
		if v.Name == 'Attachment' then
			v:Destroy()
		end
		if v.Name == "HumanoidRootPart" then
			v.CanCollide = true
		end
	end
	game.ReplicatedStorage.RagdollClient:FireClient(p,"unragdoll")
	ragdolledPlayers[p] = nil
	--]]
end

function taser(p)
	
	if p.Character and p.Character:FindFirstChild("STRENGTH") then
		return
	end
	
	ragdolledPlayers[p] = true
	local downTime = math.random(6,12)
	game.ReplicatedStorage.CServer:FireClient(p,"taze",downTime)
	local clo = script["TASER_DEPLOY"]:Clone()
	clo.Parent = p.Character.PrimaryPart
	clo:Play()
	
	local ah = script["AH"]:Clone()
	ah.Parent = p.Character.PrimaryPart
	ah:Play()
	
	game.Debris:AddItem(clo,clo.TimeLength)
	game.Debris:AddItem(ah,ah.TimeLength)

	delay(downTime,function()
		ragdolledPlayers[p] = nil
	end)
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
	local chancing = math.random(1,100)

	if not ragdolledPlayers[p] and chancing <= chance then
		spawn(function() knockDown(p) end)	
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

local function playFire(player)
	game.ReplicatedStorage.PlayEffect:FireClient(player,"fire")
end

-- this sends a message to adonis's antiexploit, showing all admins in game this player might be exploiting
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
	
	if reason == "gunCheck" then
		
		--local OFFLOAD = buildData(player,"InflictTarget","Player may be faking their InflictTarget on another humanoid (kill aura/all)","%s was detected for possible gun exploiting, action: %s info: %s  (See exploitlogs for full info)",false,"gunCheck"..player.UserId,true,true)
		
		--game.ReplicatedStorage.AELog:Fire(OFFLOAD)
		print("SENT OUT")
	elseif reason == "toolCheck" then
		local OFFLOAD = buildData(player,"InflictTarget (tool check)","Player is **MOST LIKELY** exploiting, they are firing InflictTarget with an invalid tool which I assume is impossible (can always check their client/remotelogs)","%s was detected for very likely gun exploiting, action: %s info: %s  (See exploitlogs for full info)",true,"toolCheck"..player.UserId,true,true)
		
		game.ReplicatedStorage.AELog:Fire(OFFLOAD)
		print("SENT OUT")
	elseif reason == "damageCheck" then
		local OFFLOAD = buildData(player,"Damage Exploit","Player is **MOST LIKELY** exploiting, they have exceeded the damage limit for their gun","%s was detected for very likely gun exploiting, action: %s info: %s  (See exploitlogs for full info)",true,"damageCheck"..player.UserId,true,true)
		
		game.ReplicatedStorage.AELog:Fire(OFFLOAD)
		print("SENT OUT")
	end
end

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
		print("REMOVING")
		local tween = game:GetService("TweenService"):Create(gui:FindFirstChild("Frame1"),TweenInfo.new(3),{BackgroundTransparency = 1})
		tween:Play()
		tween.Completed:Connect(function()
			print("remove3")
			wait(1.5)
			gui:Destroy()
		end)
	end		
end)

local DamageModule = require(script:WaitForChild("DamageModule"))
local VisualizeGore = game.ReplicatedStorage.VisualizeGore
local InflictTarget = game.ReplicatedStorage.InflictTarget

local hitAnimationID = 11461400017
local humanoidHitAnimations = {}

local hitAnim = game.ServerStorage.HITPLAYER

function playHitAnimation(humanoid)
	
	if not humanoidHitAnimations[humanoid] then
		local newAnim = humanoid:LoadAnimation(hitAnim)
		humanoidHitAnimations[humanoid] = newAnim
		newAnim:Play()
	else
		humanoidHitAnimations[humanoid]:Play()
	end
	
end

game.ReplicatedStorage.KnifeStab.Event:Connect(function(humanoid)
	playHitAnimation(humanoid)
	game.ReplicatedStorage.PlayEffect:FireClient(game.Players:GetPlayerFromCharacter(humanoid.Parent),"knife_stabbed")
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
	
	game.Debris:AddItem(bullet,booletRemove)
end

local InflictCar = game.ReplicatedStorage.InflictCar
local dmgDebounce = {}


InflictCar.OnServerInvoke = function(Player,Tool,TargetCar,Dmg)
	if Tool and not Tool:IsA("Tool") then
		print("likely exploit found")
		--return AE(Player,"toolCheck")
		return
	end
	if not Tool or not Tool:IsDescendantOf(Player.Character) then
		print("Possible exploit found")
		return
		--return AE(Player,"gunCheck")
	end
	
	if Tool.Name == "Taser" then
		return
	end
	
	if not TargetCar:FindFirstChild("Health") then
		return print("no health found in ",TargetCar:GetFullName())
	end
	
	if dmgDebounce[TargetCar] then return end
	
	dmgDebounce[TargetCar] = true
	delay(0.2,function()
		dmgDebounce[TargetCar] = nil
	end)
	
	local CarHP = TargetCar:FindFirstChild("Health")
	local NewHP = CarHP.Value - Dmg
	
	NewHP = math.clamp(NewHP,0,TargetCar:FindFirstChild("MaxHealth").Value)
	CarHP.Value = NewHP
end

local requireCache = {}

function knockBack(plr,speed,force,length,hitter)
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

InflictTarget.OnServerInvoke = function(Player,Tool,Tagger,TargetHumanoid,TargetTorso,Damage,Misc,Critical,hit,GoreData,hitPosition,VNormal,authed)
	--GORE
	
	if Tagger == "f" then
		if TargetHumanoid.Health <= 0 then
			print("pushing")
			local plrObj = game.Players:GetPlayerFromCharacter(TargetHumanoid.Parent)
			knockBack(plrObj,35,4000,0.1,Player)
		end
	end
	
	if Tool and not Tool:IsA("Tool") then
		-- this dude def exploiting bruh :skull:
		print("likely exploit found")
		return AE(Player,"toolCheck")
	end
	
	if not Tool or not Tool:IsDescendantOf(Player.Character) then
		print("Possible exploit found")
		return AE(Player,"gunCheck")
	end
	
	if hitPosition and Tool.Name ~= "Taser" then
		addBooletHole(Player,hit,hitPosition,VNormal)
	else
		-- exploiting prob
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
		else
			print("Player is within reasonable damage.")
		end
		
	end
	
	--[[
	if not humanoidHitAnimations[TargetHumanoid] then
		local load = TargetHumanoid:LoadAnimation(hitAnim)
		humanoidHitAnimations[TargetHumanoid] = load
	else
		humanoidHitAnimations[TargetHumanoid]:Play()
	end
	--]]
	
	-- COMBAT SYSTEM!
	spawn(function()
		local shooterHumanoid = Player.Character:FindFirstChild("Humanoid")
		_G.combatTimers[shooterHumanoid] = time()
		_G.combatTimers[TargetHumanoid] = time()
		_G.shooters[shooterHumanoid] = time()
		--if not col:HasTag(shooterHumanoid,"combat") then 
			--_G.combatTimers[shooterHumanoid] = time()
		--	col:AddTag(shooterHumanoid,"combat") 
			--_G.combatTimers[shooterHumanoid] = time()
		--	addCombatRemove(secondsInCombat,shooterHumanoid)
	--	end
		--if not col:HasTag(TargetHumanoid,"combat") then 
		--	--col:AddTag(TargetHumanoid,"combat") 
			--_G.combatTimers[TargetHumanoid] = time()
		--	addCombatRemove(secondsInCombat,TargetHumanoid)
		--end
	end)
	
	if TargetHumanoid.Health - Damage <= 0 then
		headshotEffect(Tagger)
		-- push them
		local plrObj = game.Players:GetPlayerFromCharacter(hit.Parent)
		knockBack(plrObj,20,1000,0.2,Player)
		print("DED!")
	end
	
	if TargetHumanoid.Health - Damage <= 0 and not TargetHumanoid.Parent:FindFirstChild("gibbed") then
		if hit then
			--R6 ONLY!!!!!!11!!
			if hit.Name == "Left Arm" or hit.Name == "Right Arm" or hit.Name == "Head" or hit.Name == "Right Leg" or hit.Name == "Left Leg" then
				VisualizeGore:FireAllClients("}13,{\n\n}", hit, TargetHumanoid.Parent, GoreData)
			end
		end
	end
	--RAGDOLL SYSTEM
	
	if Tool.Name == "Taser" then
		print("TASED")
		if (Tagger.Team == game.Teams.Police or Tagger.Team == game.Teams.EMS) and TargetHumanoid.Health ~= 0 then
			print("sent tase request")
			local plrObj = game.Players:GetPlayerFromCharacter(hit.Parent)
			if not ragdolledPlayers[plrObj] then
				spawn(function() taser(plrObj) end)	
			end	
		end
	else
		if TargetHumanoid.Health ~= 0 then
			if hit.Parent and (string.find(hit.Name,"Leg") or string.find(hit.name,"Foot")) and game.Players:GetPlayerFromCharacter(hit.Parent) then
				local plrObj = game.Players:GetPlayerFromCharacter(hit.Parent)
				local chancing = math.random(1,100)

				if not ragdolledPlayers[plrObj] and chancing <= chance then
					spawn(function() knockDown(plrObj) end)	
				end	
			end
		end
	end
	
	if Tagger and TargetHumanoid and TargetHumanoid.Health ~= 0 and TargetTorso and DamageModule.CanDamage(TargetHumanoid.Parent, Tagger) then
		--headshot effect 
		if hit and hit.Name == "Head" then headshotEffect(Tagger) end
		while TargetHumanoid:FindFirstChild("creator") do
			TargetHumanoid.creator:Destroy()
		end
		playHitAnimation(TargetHumanoid)
		local creator = Instance.new("ObjectValue",TargetHumanoid)
		creator.Name = "creator"
		creator.Value = Tagger
		game.Debris:AddItem(creator,5)
		if Critical[1] then
			local CriticalChanceRandom = Random.new():NextInteger(0, 100)
		    if CriticalChanceRandom <= Critical[2] then
			    TargetHumanoid:TakeDamage(math.abs(Damage * Critical[3]))
		    else
			    TargetHumanoid:TakeDamage(math.abs(Damage))
		    end			
		else
			TargetHumanoid:TakeDamage(math.abs(Damage))
		end
		if Misc[1] > 0 then --knockback
			--[[
		    local shover = Tagger.Character.HumanoidRootPart or Tagger.Character.Head
		    local duration = 0.1
		    local speed = Misc[1]/duration
		    local velocity = (TargetTorso.Position - shover.Position).unit * speed
		    local shoveForce = Instance.new("BodyVelocity")
		    shoveForce.maxForce = Vector3.new(1e9, 1e9, 1e9)
		    shoveForce.velocity = velocity
		    shoveForce.Parent = TargetTorso
		    game:GetService("Debris"):AddItem(shoveForce, duration)
		    --]]
		end
		if Misc[2] > 0 and Tagger.Character.Humanoid and Tagger.Character.Humanoid.Health ~= 0 then --lifesteal
			--Tagger.Character.Humanoid.Health = Tagger.Character.Humanoid.Health + (Damage*Misc[2])
		end
		if Misc[3] then --flame		
			--[[
		    local igniteroll = math.random(1, 100)
		    if igniteroll <= Misc[7] then
			    local Debuff = TargetHumanoid.Parent:FindFirstChild("IgniteScript") or Misc[5]:Clone()
			    Debuff.creator.Value = Tagger
			    Debuff.Disabled = false
			    Debuff.Parent = TargetHumanoid.Parent
		    end
		    --]]
		end
		if Misc[4] then --freeze
			--[[
		    local icifyroll = math.random(1, 100)
		    if icifyroll <= Misc[8] then
			    local Debuff = TargetHumanoid.Parent:FindFirstChild("IcifyScript") or Misc[6]:Clone()
			    Debuff.Disabled = false
			    Debuff.Parent = TargetHumanoid.Parent
		    end
		    --]]
		end
	end
end