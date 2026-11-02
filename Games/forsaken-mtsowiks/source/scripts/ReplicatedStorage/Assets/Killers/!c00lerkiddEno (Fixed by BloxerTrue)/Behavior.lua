local module = {}
local RunService = game["Run Service"] or game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Util = require(ReplicatedStorage.Modules.Util)
local Hitboxes = require(ReplicatedStorage.Modules.Hitboxes)
local Statuses = require(ReplicatedStorage.Modules.Statuses)
local Maid = require(ReplicatedStorage.Modules.Misc.Maid)
local LightingSchematic = require(ReplicatedStorage.Modules.Schematics.Lighting)
local Ragdolls = require(ReplicatedStorage.Modules.Ragdolls)
local Network = require(ReplicatedStorage.Modules.Network)
local Actors = require(ReplicatedStorage.Modules.Actors)

local function playSound(actor, soundKey, opts)
	local params = {
		PlaybackSpeed = 0.975 + Random.new():NextNumber() * 0.05,
		Volume = 0.6,
	}
	if opts then
		for k,v in pairs(opts) do params[k] = v end
	end
	if not params.Parent then
		params.Parent = actor.Rig.PrimaryPart
	end
	return Sounds:Play(actor.Config.Sounds[soundKey], params)
end

module.Abilities = {
	Punch = {
		LayoutOrder = 1,
		Icon = "rbxassetid://93874368032471",
		KeybindType = "MainAbility",
		Cooldown = 2,
		Callback = function(self)
			if RunService:IsServer() then
				self.AbilitiesDisabled = true
				playSound(self, "Swing", {Volume = 0.25})
				task.delay(self.Config.Punch.Windup or 0.1, function()
					local hb = Hitboxes:CreateHitbox(self.Player, {
						Size = Vector3.new(4.5,6,5),
						CFrameOffset = CFrame.new(0,0,-1.5),
						Damage = self.Config.Punch.Damage,
						Time = self.Config.Punch.Linger or 0.3,
						Knockback = 2,
						HitMultiple = false,
						ExecuteOnKill = true,
						Connections = {
							Hit = function(hitActor)
								Util:CreateSpeedMultiplier(hitActor, 1.5, "HitSpeedBonus", 1.25)
								playSound(self, "Hit", {Volume = 0.35})
							end
						}
					})
					if hb then
						-- hitbox will auto-manage itself
					end
				end)
				task.delay(0.75, function()
					self.AbilitiesDisabled = false
				end)
				return
			elseif RunService:IsClient() then
				if self.Animations and self.Animations.Attack then
					self.Animations.Attack:Play(0.025)
				end
				return
			end
		end
	},
	WalkspeedOverride = {
		LayoutOrder = 3,
		Icon = "rbxassetid://101955457812737",
		KeybindType = "AltAbility2",
		Cooldown = 20,
		Callback = function(self)
			local timeout = self.Config.WalkspeedOverrideTimeout or 3
			if RunService:IsServer() then
				self.AbilitiesDisabled = true
				Util:SetSpeedCap(self.Rig, "C00lkiddWalkspeedOverride", self.Config.WalkspeedOverrideSpeed)
				task.delay(0.125, function()
					local lastHit = nil
					local ended = nil
					local hb = Hitboxes:CreateHitbox(self.Player, {
						Size = Vector3.new(7,5,6),
						Damage = self.Config.WalkspeedOverrideDamage,
						Time = timeout,
						Knockback = 4.5,
						HitMultiple = true,
						Connections = {
							Hit = function(v)
								lastHit = v
								Statuses:ApplyStatus(v, "Burning", {Level = 1, Duration = 8})
								if self.Rig:FindFirstChild("firebrand") then
									self.Rig.firebrand.Transparency = 0
									task.delay(1.5, function()
										TweenService:Create(self.Rig.firebrand, TweenInfo.new(0.5), {Transparency = 1}):Play()
									end)
								end
								if tostring(v.Parent) == "Survivors" then
									if v.Humanoid and v.Humanoid.Health <= 0 then
										Actors:IncrementActorStats(self.Player, {Action = "Killed a Survivor with Walkspeed Override", RewardType = "DifficultKillerAction"})
									else
										Actors:IncrementActorStats(self.Player, {Action = "Landed Walkspeed Override hit", RewardType = "RegularKillerAction"})
									end
								end
							end,
							Ended = function()
								ended = true
							end
						}
					})
					local velObj = Util:ApplyVelocity(self.Rig.PrimaryPart, self.Config.WalkspeedOverrideSpeed)
					Debris:AddItem(velObj, timeout + 3)
					TweenService:Create(velObj, TweenInfo.new(timeout * 1.5), {LineVelocity = self.Config.WalkspeedOverrideSpeed / 2}):Play()
					playSound(self, "WalkspeedOverrideLunge", {Parent = self.Rig.PrimaryPart})
					local collided = false
					local connName = ("%*C00lkiddCollision"):format(self.Player.Name)
					Network:SetConnection(connName, "REMOTE_EVENT", function(ply)
						if ply == self.Player then collided = true end
					end)
					repeat task.wait() until lastHit or ended or collided
					local result = "IDK"
					if lastHit then
						result = "Hit"
						self.Rig:SetAttribute("Invincible", true)
					elseif collided then
						result = "Collide"
					elseif ended then
						result = "Timeout"
					end
					local sv = Instance.new("StringValue")
					sv.Name = "Result"
					sv.Value = result
					sv.Parent = self.Rig
					Debris:AddItem(sv, 1.5)
					task.delay(1.5, function()
						self.AbilitiesDisabled = false
						self.Rig:SetAttribute("Invincible", nil)
					end)
					TweenService:Create(velObj, TweenInfo.new(result == "Collide" and 0.25 or 0.5), {LineVelocity = 0}):Play()
					Debris:AddItem(velObj, 1.5)
					Sounds:PlayVoiceline(self, ("WalkspeedOverride%*"):format(result), {Priority = 1.5})
					Sounds:Play(self.Config.Sounds[("WalkspeedOverride%*"):format(result)], {Parent = self.Rig.PrimaryPart})
					Util:SetSpeedCap(self.Rig, "C00lkiddWalkspeedOverride", nil)
					Network:RemoveConnection(connName, "REMOTE_EVENT")
					if hb then hb:Cancel() end
				end)
				return
			elseif RunService:IsClient() then
				if self.Animations then
					if self.Animations.WalkspeedOverrideStart then self.Animations.WalkspeedOverrideStart:Play() end
					if self.Animations.WalkspeedOverrideLoop then self.Animations.WalkspeedOverrideLoop:Play() end
				end
				self.Rig:SetAttribute("FootstepsMuted", true)
				local speedMul = Util:CreateSpeedMultiplier(self.Player, 0, "HinderedMovement")
				local resultVal = nil
				task.spawn(function()
					local t = 0
					local signaled = false
					while true do
						if not resultVal and self.Rig.PrimaryPart then
							if t >= 0.4 and self.Rig.PrimaryPart.AssemblyLinearVelocity.Magnitude <= 18 then
								if not signaled then
									Network:FireServerConnection(("%*C00lkiddCollision"):format(self.Player.Name), "REMOTE_EVENT")
									signaled = true
								end
								return
							else
								t = t + task.wait()
							end
						else
							return
						end
					end
				end)
				local resObj = self.Rig:WaitForChild("Result", 6)
				resultVal = resObj and resObj.Value or "IDK BRUH"
				self.Rig:SetAttribute("FootstepsMuted", nil)
				if self.Animations then
					if self.Animations.WalkspeedOverrideStart then self.Animations.WalkspeedOverrideStart:Stop() end
					if self.Animations.WalkspeedOverrideLoop then self.Animations.WalkspeedOverrideLoop:Stop() end
				end
				if resultVal == "Hit" then
					if self.Animations and self.Animations.WalkspeedOverrideHit then self.Animations.WalkspeedOverrideHit:Play(0) end
				elseif resultVal == "Timeout" and self.Animations and self.Animations.WalkspeedOverrideTimeout then
					self.Animations.WalkspeedOverrideTimeout:Play(0.05)
				elseif resultVal == "Collide" and self.Animations and self.Animations.WalkspeedOverrideCollide then
					self.Animations.WalkspeedOverrideCollide:Play(0.05)
				else
					if self.Animations and self.Animations.WalkspeedOverrideMiss then
						self.Animations.WalkspeedOverrideMiss:Play(0.05)
					end
				end
				if resObj then
					repeat task.wait() until not resObj.Parent
				end
				TweenService:Create(speedMul, TweenInfo.new(0.5), {Value = 1}):Play()
				Debris:AddItem(speedMul, 0.5)
				return
			end
		end
	}
}

function module.Created(self, player)
	self.Maid = Maid.new()
	self.Meta = {}
	self.Instances = {}
	self.State = {}
	self.NetworkConnections = {}
	self.ConnectionDictionary = {}
	self.State.WalkspeedActive = false
	self.Meta.Tags = {}
	self.Meta.Tags.Minion = ("%s_C00LKIDD_MINION"):format(player.Name)
	self.Player = player
	if RunService:IsClient() then
		if Players.LocalPlayer ~= player then
			-- nothing
		end
	end
end

function module.OnIntroduction(_, actorRig, actorInstance, duration)
	task.spawn(function()
		local fb = actorInstance:WaitForChild("firebrand", 20)
		if fb then fb.Transparency = 0 end
	end)
	local originalClock = nil
	task.delay(0.5, function()
		originalClock = game.Lighting.ClockTime
		TweenService:Create(game.Lighting, TweenInfo.new(0.75), {ClockTime = 0}):Play()
	end)
	task.delay(1.5, function()
		local clone = actorRig.Config.IntroSky:Clone()
		clone.Parent = game.Lighting
		TweenService:Create(game.Lighting, TweenInfo.new(1.5), {ClockTime = originalClock or 12}):Play()
		Debris:AddItem(clone, duration - 1.5)
	end)
end

function module.OnVictory(_, state, actor, outroLighting, timeLength)
	if state == "Start" then
		LightingSchematic:SetCustomLighting(actor.Config.OutroLighting)
		if Players.LocalPlayer then
			Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true)
		end
		local conn = RunService.RenderStepped:Connect(function()
			if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = 25 end
		end)
		task.delay(timeLength, function() conn:Disconnect() end)
		task.spawn(function()
			local clone = actor.Config.IntroSky:Clone()
			clone.Parent = game.Lighting
			Debris:AddItem(clone, timeLength - 1.5)
			local bg = workspace.Misc:FindFirstChild("KillerCutsceneBackground")
			if bg and bg:FindFirstChild("People") then
				local rsConn
				rsConn = RunService.RenderStepped:Connect(function(dt)
					if not bg or not bg.Parent or not bg:FindFirstChild("People") then
						rsConn:Disconnect()
						return
					end
					for i,v in pairs(bg.People:GetChildren()) do
						local pp = v.PrimaryPart
						if pp then
							local rot = (i % 2 == 0) and 2.25 or -2.25
							pp.CFrame = pp.CFrame * CFrame.Angles(0, dt * rot, rot)
						end
					end
				end)
				task.delay(timeLength, function() rsConn:Disconnect() end)
			end
		end)
	elseif state == "End" then
		if Players.LocalPlayer then
			Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", false)
			Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil)
		end
		LightingSchematic:SetAsCurrentLighting()
	end
end

function module.OnExecution(self, actor, target)
	local offsetCFrame = nil
	if target.Name == "007n7" then
		offsetCFrame = actor.Rig.PrimaryPart.CFrame * CFrame.new(3, -2.75, 2.25) * CFrame.Angles(math.pi/2, 0, -0.3490658503988659)
	end
	local velocityVec = (target.Name == "007n7") and Vector3.new() or (actor.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200
	local serverTime = workspace:GetServerTimeNow() + (target.Name == "007n7" and 3.6 or 3.5)
	Network:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", target, serverTime, ("%*|%*|%*"):format(velocityVec.X, velocityVec.Y, velocityVec.Z), offsetCFrame)
	task.delay(2.1, function()
		local hum = target:FindFirstChild("Humanoid")
		if hum then
			hum.BreakJointsOnDeath = false
			hum.Health = 0
		end
	end)
	task.delay(3.5, function()
		if target and target.PrimaryPart then
			target.PrimaryPart.Anchored = false
		end
	end)
end

return module