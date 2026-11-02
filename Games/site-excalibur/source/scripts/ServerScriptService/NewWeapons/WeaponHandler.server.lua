local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WeaponModules = ReplicatedStorage.Assets.WeaponModules
local Footsteps = ReplicatedStorage.Assets.Footsteps

local WeaponEvent = ReplicatedStorage.WeaponEvent

WeaponEvent.OnServerEvent:Connect(function(Player, ...)
	local Arguments = {...}
	if Arguments[1] == "ActivateWeaponEffects" then
		local Weapon = Player.Character:FindFirstChildOfClass("Tool")
		for _, Client in next, Players:GetPlayers() do
			if Client ~= Player then
				if Weapon then
					WeaponEvent:FireClient(Client, "ActivateWeaponEffects", Weapon)	
				end
			end
		end
	elseif Arguments[1] == "ReplicateHit" then
		local Weapon = Player.Character:FindFirstChildOfClass("Tool")
		for _, Client in next, Players:GetPlayers() do
			if Client ~= Player then
				if Weapon then
					WeaponEvent:FireClient(Client, "ReplicateHit", Arguments[2], Arguments[3], Arguments[4])	
				end
			end
		end	
	elseif Arguments[1] == "Reload" then
		local Weapon = Player.Character:FindFirstChildOfClass("Tool")
		for _, Client in next, Players:GetPlayers() do
			if Client ~= Player then
				if Weapon then
					WeaponEvent:FireClient(Client, "Reload", Weapon, Arguments[2])	
				end	
			end
		end
	elseif Arguments[1] == "Footstep" then
		if Arguments[4].Parent.Parent == Footsteps then
			for _, Client in next, Players:GetPlayers() do
				if Client ~= Player then
					WeaponEvent:FireClient(Client, "Footstep", Arguments[2], Arguments[3], Arguments[4])	
				end
			end	
		end	
	elseif Arguments[1] == "CreateBullet" then
		local Weapon = Player.Character:FindFirstChildOfClass("Tool")
		for _, Client in next, Players:GetPlayers() do
			if Client ~= Player then
				if Weapon then
					WeaponEvent:FireClient(Client, "CreateBullet", Weapon, Arguments[2], Arguments[3])	
				end
			end
		end
	elseif Arguments[1] == "DamagePlayer" then
		local Weapon = Player.Character:FindFirstChildOfClass("Tool")
		if Weapon then
			local Config = require(WeaponModules:FindFirstChild(Weapon.Name))
			
			local HitPart = Arguments[2]
			local Humanoid = Arguments[3]
			for _, Client in next, Players:GetPlayers() do
			if Client ~= Player then
				if Weapon then
						WeaponEvent:FireClient(Client, "CreateBlood", HitPart)	
					end
				end
			end
			if HitPart.Name == "Head" then
				Humanoid:TakeDamage(Config.HeadshotDamage)
			else
				Humanoid:TakeDamage(Config.Damage)
			end
		end
	end
end)