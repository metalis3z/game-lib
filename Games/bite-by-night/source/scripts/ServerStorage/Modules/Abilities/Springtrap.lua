-- <- Modules -> --
local AbilityUtil = require('@game/ServerStorage/Modules/Abilities/AbilityUtil');
local SwingModule = require('@self/Swing');
local AxeThrowModule = require('@self/AxeThrow');
local BeartrapModule = require('@self/Beartrap');
local ScreamModule = require('@self/Scream');
local ChargeModule = require('@self/Charge');

-- <- Private Functions -> --
local function GetAssetMeta(Player: Player, CharacterMeta)
	local AssetMeta = AbilityUtil.GetAssetMeta(Player);
	if not AssetMeta or not CharacterMeta then
		return
	end

	return AssetMeta, CharacterMeta
end

-- <- Return -> --
return {
	Abilities = {
		['Swing'] = {
			KeybindDisplay = 'M1',
			Callback = function(Player: Player, _, CharacterMeta)
				local AssetMeta = GetAssetMeta(Player, CharacterMeta);
				if not AssetMeta then
					return
				end

				SwingModule.Swing(Player, CharacterMeta, AssetMeta);
			end,
		},
		['Remnant Cleaver'] = {
			KeybindDisplay = 'Q',
			Callback = function(Player: Player, _, CharacterMeta)
				local AssetMeta = GetAssetMeta(Player, CharacterMeta);
				if not AssetMeta then
					return
				end

				local Existing = AxeThrowModule.AxeThrowPlayers[Player]
				if Existing then
					Existing:Use();
				else
					local ThrowMeta = AxeThrowModule.new(Player, AssetMeta, CharacterMeta);
					ThrowMeta:Use();
				end
			end,
		},
		['Beartrap'] = {
			KeybindDisplay = 'E',
			Uses = 3,
			CurrentUses = BeartrapModule.GetCurrentTraps,
			Variants = {
				['Scream'] = {
					Attributes = {
						'Axeless',
					},
					Callback = function(Player: Player)
						local AssetMeta = AbilityUtil.GetAssetMeta(Player);
						if not AssetMeta then
							return
						end

						ScreamModule.Scream(Player, AssetMeta);
					end,
				},
				['Charge'] = {
					Attributes = {
						'Axeless',
						'Screamed',
					},
					Callback = function(Player: Player, _, CharacterMeta)
						local AssetMeta = GetAssetMeta(Player, CharacterMeta);
						if not AssetMeta then
							return
						end

						ChargeModule.Charge(Player, CharacterMeta, AssetMeta);
					end,
				},
			},
			Callback = function(Player: Player, AbilityMeta, CharacterMeta)
				local AssetMeta = GetAssetMeta(Player, CharacterMeta);
				if not AssetMeta then
					return
				end

				BeartrapModule.Beartrap(Player, CharacterMeta, AssetMeta, AbilityMeta);
			end,
		},
	},
}