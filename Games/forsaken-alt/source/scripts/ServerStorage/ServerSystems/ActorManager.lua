-- <- Init -> --
local Module = {}
Module.__index = Module

-- <- Services -> --
local Client = game:GetService('ReplicatedStorage');

-- <- Private Variables -> --
-- <- Modules -> --
local Initializer = require(Client.Initializer);
local Network = Initializer.Modules.Network;
local Actors = Initializer.Modules.Actors;

-- <- Network -> --
Network:SetConnection('UseActorAbility', 'REMOTE_EVENT', function(Player: Player, Ability: {})
	local Config = Actors.CurrentActors[Player]
	local SecondConfig = Config.Config
	--
	if Config['AbilitiesDisabled'] == true and not workspace:GetAttribute("CooldownsDisabled") then
		return
	end
	--
	if Config['Cooldowns'][Ability] and not workspace:GetAttribute("CooldownsDisabled") then
		return
	end
	--
	local Behavior = Config.CustomBehavior or Config.Behavior
	local Abilities = Behavior.Abilities
	local AbilityFunction = Abilities[Ability]
	local Charges = AbilityFunction.Charges
	--
	local Time = tonumber(SecondConfig and typeof(SecondConfig) == "table" and SecondConfig.Cooldown or typeof(AbilityFunction.Cooldown) == "function" and AbilityFunction.Cooldown(Config, Ability) or AbilityFunction.Cooldown or SecondConfig[`{Ability}Cooldown`] or Config[("%*Cooldown"):format(Ability)]) or 45;
	if workspace:GetAttribute('CooldownsDisabled') then
		Time = 0
	end
	--
	if Charges then -- Just so it bypass if the Cooldowndisabled is on lol.
		if Charges == 0 then
			Network:FireClientConnection(Player, "UpdateAbilityCharges", "REMOTE_EVENT", Ability, Charges);
			return
		end
		--
		if workspace:GetAttribute('ChargesDisabled') == true then -- Panel bypass
			Network:FireClientConnection(Player, "UpdateAbilityCharges", "REMOTE_EVENT", Ability, Charges);
		else 
			Charges -= 1
			Network:FireClientConnection(Player, "UpdateAbilityCharges", "REMOTE_EVENT", Ability, Charges);
		end
	end
	--
	Config:SetCooldownOf(Ability, Time)
	--
	if AbilityFunction  then
		AbilityFunction.Callback(Config)
	end
	--
	Network:FireClientConnection(Player, 'UseActorAbility', 'REMOTE_EVENT', Ability, Config)
end)

-- <- Return -> --
return Module