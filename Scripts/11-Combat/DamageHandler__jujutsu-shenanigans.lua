-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: ServerStorage/Modules/DamageHandler.lua  (ModuleScript, 167 lines)
-- What it does: TakeDamage(attacker, humanoid, damage, stun, anim, blockable, counterable...): front-only blocking (CheckBehind), counters, finisher detection, hit-glow highlight, stun, hit animation, kill credit / streaks.

--// Services \\--

local Players = game:GetService('Players')
local RS = game:GetService('ReplicatedStorage')



--// Modules Required \\--

local RPModules = RS.Modules
local SvModules = script.Parent


local PlayerClasses = require(SvModules.PlayerClass)
local StunHandler = require(SvModules.StunHandler)
local CombatLogger = require(script.CombatLogger)
local Utility = require(RPModules.Utility)


local AnimationService = require(SvModules.AnimationService)


local CheckBehind = Utility('CheckBehind')



--// Module \\--

local DummyCounter = .08 / 100
local module = {}



--// Local Functions \\--

local function RNG()
	return math.random() <= DummyCounter
end



--// Module Functions \\--

function module:TakeDamage(Damager: Model, Hum: Humanoid, Damage: number, StunTime: number, Animation: Animation, Blockable: boolean, Counterable: boolean, bypassStunImmunity: boolean, addAwkProgress: boolean, doFinisher: boolean, Type: string, FinisherRequirement: number)
	if not Damager or not Hum.Parent then return end
	if doFinisher == nil then
		doFinisher = true
	end
	
	local returnValue = { CouldHit = false; Blocked = false; Countered = false; Finisher = Hum.Health <= (FinisherRequirement or Damage); }
	
	local WasDead = Hum.Health <= 0
	
	local DamagerPlayer = Players:GetPlayerFromCharacter(Damager)
	local Damaged: Model = Hum.Parent
	
	if Blockable == true and Damaged:HasTag('Blocking') and CheckBehind(Damager.HumanoidRootPart, Damaged.HumanoidRootPart) == false then
		returnValue.Blocked = true
	else
		local specialCountered = Damaged:FindFirstChild('Dummy') and ((RNG() == true and (Type == 'M1' or Type == 'Dropkick')) or Damaged:HasTag('SpecialCounter'))
		
		if (Damaged:HasTag('Countering') and Counterable == true) or specialCountered then
			if specialCountered then
				Damaged:AddTag('SpecialCounter')
			end
			
			returnValue.Countered = true
		else
			if Damage >= Hum.MaxHealth then
				local HealthScript: Script = Damager:FindFirstChild('Health')
				if HealthScript then
					HealthScript.Enabled = false
				end
			end

			returnValue.CouldHit = true
			if returnValue.Finisher == true then
				if doFinisher == true then
					Hum:TakeDamage(Damage)
				end
			else
				Hum:TakeDamage(Damage)
			end

			if StunTime then
				local hitglove = script.HitGlow:Clone()
				hitglove.Parent = workspace.Effects
				
				local f = Damaged["Right Leg"]
				local l = Damaged["Left Arm"]
				local r = Damaged["Right Arm"]
				local g = Damaged["Left Leg"]
				local h = Damaged.Head
				local t = Damaged.Torso
				
				local f1 = hitglove.Torso.WeldF
				local l1 = hitglove.Torso.WeldL
				local r1 = hitglove.Torso.WeldR
				local g1 = hitglove.Torso.WeldG
				local h1 = hitglove.Torso.WeldH
				local t1 = hitglove.Torso.WeldT
				
				f1.Part1 = f
				l1.Part1 = l
				r1.Part1 = r
				g1.Part1 = g
				h1.Part1 = h
				t1.Part1 = t
				
			    task.delay(0.15, function()
					hitglove:Destroy()
				end)
				
				StunHandler:Stun(Damaged, StunTime, bypassStunImmunity)
			end

			if Animation then
				AnimationService:stopAll(Damaged)
				AnimationService:playAnimation(Damaged, Animation)
			end

			if DamagerPlayer then
				local DamagerClass = PlayerClasses:GetClass(DamagerPlayer.UserId)
				
				if not WasDead and returnValue.Finisher == true and not Damaged:FindFirstChild('Dummy') and RS.PS_Owner.Value == 0 then
					DamagerPlayer.leaderstats.Kills.Value += 1
					DamagerPlayer.leaderstats.Hidden.Money.Value += 5
					DamagerPlayer.leaderstats.Hidden['Total Kills'].Value += 1
					
					Damager:SetAttribute('Streak', (Damager:GetAttribute('Streak') or 0) + 1)
					if Damager:GetAttribute('Streak') >= 10 and not Damager:HasTag('HighestStreak') then
						require(script.Parent.KillstreakModule):AddKillstreak(Damager)
					end
					
					if #DamagerClass.OwnedEmotes < #RS.Assets.Emotes:GetChildren() then
						if DamagerClass.KillsForEmote > 0 then
							DamagerClass.KillsForEmote -= 1

							if DamagerClass.KillsForEmote == 0 then
								RS.Remotes.Comunicator.Set:FireClient(DamagerPlayer, 'CanSpinEmote')
							else
								RS.Remotes.Comunicator.Set:FireClient(DamagerPlayer, 'ChangeKillForEmote', DamagerClass.KillsForEmote)
							end
						end
					end
				end

				if addAwkProgress == true or addAwkProgress == nil then
					if not Damager:HasTag('Awakened') then
						DamagerPlayer.AwakeningProgress.Value += Damage/2
					end

					if DamagerPlayer.AwakeningProgress.Value > 100 then
						DamagerPlayer.AwakeningProgress.Value = 100
					end
				end
			end
		end
	end
	
	CombatLogger:DamagedLog(Damager, Damaged, Counterable, Type)
	CombatLogger:DamagerLog(Damager, Damaged)
	
	return returnValue
end

return module
