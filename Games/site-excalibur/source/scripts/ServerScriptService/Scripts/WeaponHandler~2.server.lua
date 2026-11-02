local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GunHandler = ReplicatedStorage.Remotes.GunHandler
local WeaponModules = ReplicatedStorage.Assets.WeaponModules

function ReturnWeapon(Player)
	for _, Object in next, Player.Character:GetChildren() do
		if Object:IsA("Tool") then
			return Object
		end
	end
	return nil
end

function CalculateDamage(Humanoid, Damage)
	local HP = Humanoid.Health
	local FinalDamage
	if Damage >= HP then
		return ((HP + Damage) - Damage - 0)
	else
		return Damage
	end
end


function ReplicateElement(Type)
	if Type:IsA("ParticleEmitter") then
		Type:Emit(Type.Rate)
	elseif Type:IsA("Light") then
		spawn(function()
			Type.Enabled = true
			wait()
			Type.Enabled = false
		end)
	elseif Type:IsA("Sound") then
		local Parent = Type.Parent
		Type = Type:Clone()
		Type.Parent = Parent
		Type.PlayOnRemove = true
		Type:Destroy()
	end
end

function ReplicateMuzzle(Muzzle)
	if Muzzle then
		for _, Object in next, Muzzle:GetChildren() do
			ReplicateElement(Object)
		end
	end
end

GunHandler.OnServerEvent:Connect(function(Plr, Target, HitType, Hit)
	if HitType == "Replicate" then
		GunHandler:FireAllClients(ReturnWeapon(Plr):FindFirstChild("Muzzle"), Plr, Hit)
		return
	end
	if HitType == "Melee1" or HitType == "Melee2" then
		ReplicateElement(ReturnWeapon(Plr).Handle[HitType])
		return
	end
	local Distance
	local weapon = ReturnWeapon(Plr)
	if not weapon then
		return
	end
	local Module = WeaponModules:FindFirstChild(ReturnWeapon(Plr).Name)
	if Module then
		local Enemy = Players:GetPlayerFromCharacter(Target.Parent)
		local Data = require(Module)
		if HitType == "Head" then
			Target:TakeDamage(Data.HeadshotDamage)
		elseif HitType == "Torso" then
			if Target.Health > 0 then
				Target:TakeDamage(CalculateDamage(Target, Data.Damage))
			end
			if Enemy.Character.Unconscious then
				if Target.Health < 6 and Enemy.Character.Unconscious.Value == false then
					Enemy.Character.Unconscious.Value = true
				end
				if Enemy.Character.Unconscious.Value == true and Target.Health < 6 then
					Target.Health = Target.Health - 1.34
				elseif Enemy.Character.Unconscious.Value == true and Target.Health > 6 then
					Target:TakeDamage(CalculateDamage(Target, Data.Damage))
				end
			else
				Target:TakeDamage(Data.Damage)
			end
		elseif Data.CombatType == "Melee" then
			if Target.Health > 5 then
				Target:TakeDamage(CalculateDamage(Target, Data.Damage))
			end
			if Enemy.Character.Unconscious then
				if Target.Health < 6 and Enemy.Character.Unconscious.Value == false then
					Enemy.Character.Unconscious.Value = true
				end
				if Enemy.Character.Unconscious.Value == true and Target.Health < 6 then
					Target.Health = Target.Health - 1.34
				elseif Enemy.Character.Unconscious.Value == true and Target.Health > 6 then
					Target:TakeDamage(CalculateDamage(Target, Data.Damage))
				end
			else
				Target:TakeDamage(Data.Damage)
			end
		end
	end
end)