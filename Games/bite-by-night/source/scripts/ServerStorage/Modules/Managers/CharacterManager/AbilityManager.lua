local AbilityManager = {}
AbilityManager.__index = AbilityManager

-- <- Types -> --
type Ability = {
	Name: string,
	Icon: string,
	Desc: string,
}

-- <- Services -> --
local ServerStorage = game:GetService('ServerStorage');

-- <- Modules -> --
local UniversalAbilities = require('@game/ServerStorage/Modules/Abilities/Universal');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');
local InfoCard = require('@game/ReplicatedStorage/Modules/InfoCards');

-- <- Public Variables -> --
local ServerAsset = ServerStorage.Assets
local AbilitiesAssets = ServerAsset.AbilitiesStuff
local Abilities = ServerStorage.Modules.Abilities

-- <- Private Functions -> --
local function GetAbilityInformation(CharacterName: string, AbilityName: string)
	local CharacterAbilityModule = Abilities:FindFirstChild(CharacterName);
	if not CharacterAbilityModule then
		return
	end

	local CharacterAbilityInformation = ServerUtil.SafeRequire(CharacterAbilityModule);
	if not CharacterAbilityInformation then
		return
	end

	local CharacterAbilities = CharacterAbilityInformation.Abilities
	if not CharacterAbilities then
		return
	end

	return CharacterAbilities[AbilityName]
end

local function DetermineVariants(Character, AbilityVariants): string
	local CurrentVariantSelected = ''
	local HighestMatchCount = -1

	for VariantName, VariantInformation in AbilityVariants do
		local RequiredAttributes = VariantInformation.Attributes or {}
		local MatchingAttributes = 0
		for _, AttributeName in RequiredAttributes do
			if Character:GetAttribute(AttributeName) then
				MatchingAttributes += 1
			end
		end

		if #RequiredAttributes == MatchingAttributes and MatchingAttributes > HighestMatchCount then
			HighestMatchCount = MatchingAttributes
			CurrentVariantSelected = VariantName
		end
	end

	return CurrentVariantSelected
end

local function GetMovesInfoByName(MoveTable: {Name: string}, MoveName: string)
	for _, MoveInformation in MoveTable do
		if MoveInformation.Name == MoveName then
			return MoveInformation
		end
	end

	return nil
end

local function GetUsesInformation(Information, Character, AbilityMeta)
	local Uses = Information and (Information.Uses or Information.USES)
	local CurrentUses = Information and (Information.CurrentUses or 0) or 0
	if typeof(Uses) == 'function' then
		Uses = Uses(Character, AbilityMeta);
	end
	if typeof(CurrentUses) == 'function' then
		CurrentUses = CurrentUses(Character, AbilityMeta);
	end

	return Uses, CurrentUses
end

local function DetermineCallback(AbilityInformation, Character: Model)
	if not AbilityInformation then
		return nil
	end

	local AbilityVariants = AbilityInformation.Variants
	if AbilityVariants and Character then
		local Variant = DetermineVariants(Character, AbilityVariants);
		if Variant ~= '' then
			local VariantInformation = AbilityVariants[Variant]
			if VariantInformation then
				return VariantInformation.Callback
			end
		end
	end

	return AbilityInformation.Callback
end

local function ResolveResult(AbilityInformation, Result)
	if typeof(Result) == 'table' then
		local Success = Result.Success
		if Success == nil then
			Success = true
		end

		local Cooldown = Result.Cooldown
		if Success and Cooldown == nil and Result.UseCooldown ~= false then
			Cooldown = AbilityInformation and AbilityInformation.Cooldown
		end

		return Success, Cooldown
	elseif typeof(Result) == 'number' then
		return true, Result
	elseif typeof(Result) == 'boolean' then
		return Result, Result and AbilityInformation and AbilityInformation.Cooldown or nil
	end

	return false, nil
end

local function GetCooldownText(Remaining)
	if Remaining >= 10 then
		return tostring(math.ceil(Remaining));
	end

	local Rounded = math.ceil(Remaining * 10) / 10
	if Rounded <= 0 then
		Rounded = 0.1
	end

	return string.format('%.1f', Rounded);
end

-- <- Public Functions -> --
function AbilityManager:GetCurrentInformation(Character: Model?)
	local AbilityInformation = self.AbilityInformation
	if not AbilityInformation then
		return nil, '', self.ClientAbilityInformation
	end

	local AbilityVariants = AbilityInformation.Variants
	if AbilityVariants and Character then
		local CurrentVariant = DetermineVariants(Character, AbilityVariants);
		if CurrentVariant ~= '' then
			local VariantInformation = AbilityVariants[CurrentVariant]
			if VariantInformation then
				return VariantInformation, CurrentVariant, VariantInformation.ClientInformation or self.ClientAbilityInformation
			end
		end
	end

	return AbilityInformation, '', self.ClientAbilityInformation
end

function AbilityManager:GetRemainingCooldown(): number
	if not self.CooldownEndAt or self.CooldownEndAt <= 0 then
		return 0
	end

	return math.max(0, self.CooldownEndAt - os.clock());
end

function AbilityManager:IsOnCooldown(): boolean
	return self:GetRemainingCooldown() > 0
end

function AbilityManager:UpdateCooldownVisual(): ()
	local AbilityCard = self.AbilityCard
	if not AbilityCard then
		return
	end

	local CooldownFrame = AbilityCard:FindFirstChild('CD');
	local CooldownLabel = AbilityCard:FindFirstChild('COOLDOWN');
	if not CooldownFrame or not CooldownLabel or not AbilityCard.Visible then
		return
	end

	local Remaining = self:GetRemainingCooldown();
	if Remaining <= 0 then
		CooldownFrame.Visible = false
		CooldownFrame.Size = UDim2.fromScale(0.6, 0.6);
		CooldownLabel.Visible = false
		CooldownLabel.Text = '0'
		return
	end

	local Duration = math.max(self.CooldownDuration or Remaining, 0.1);
	local Scale = math.clamp(Remaining / Duration, 0.15, 1);
	CooldownFrame.Visible = true
	CooldownFrame.Size = UDim2.fromScale(0.6 * Scale, 0.6 * Scale);
	CooldownLabel.Visible = true
	CooldownLabel.Text = GetCooldownText(Remaining);
end

function AbilityManager:SetCooldown(Duration: number?): ()
	self.CooldownToken = (self.CooldownToken or 0) + 1
	local Token = self.CooldownToken

	if not Duration or Duration <= 0 then
		self.CooldownDuration = 0
		self.CooldownEndAt = 0
		self:UpdateCooldownVisual();
		return
	end

	self.CooldownDuration = Duration
	self.CooldownEndAt = os.clock() + Duration
	self:UpdateCooldownVisual();

	task.spawn(function()
		while self.AbilityCard and self.CooldownToken == Token do
			if self:GetRemainingCooldown() <= 0 then
				break
			end

			self:UpdateCooldownVisual();
			task.wait(0.1);
		end

		if self.CooldownToken == Token then
			self.CooldownDuration = 0
			self.CooldownEndAt = 0
			self:UpdateCooldownVisual();
		end
	end);
end

function AbilityManager:RefreshCard(Character: Model?): ()
	local AbilityCard = self.AbilityCard
	if not AbilityCard then
		return
	end

	Character = Character or (self.Player and self.Player.Character)
	local CurrentInformation, CurrentVariant, ClientInformation = self:GetCurrentInformation(Character);
	self.ActiveInformation = CurrentInformation
	self.ActiveVariant = CurrentVariant

	if not CurrentInformation then
		AbilityCard.Visible = false
		self:UpdateCooldownVisual();
		return
	end

	if CurrentInformation.TurnInvisible then
		AbilityCard.Visible = false
		self:UpdateCooldownVisual();
		return
	end

	AbilityCard.Visible = true

	local Uses, CurrentUses = GetUsesInformation(CurrentInformation, Character, self);
	AbilityCard.Clip.Render.Image = ClientInformation and ClientInformation.Icon or self.AbilityIcon

	local UsesFrame = AbilityCard:FindFirstChild('USES');
	local UsesLabel = UsesFrame and UsesFrame:FindFirstChild('Status');
	if UsesFrame and UsesLabel then
		UsesFrame.Visible = false
		if Uses then
			UsesFrame.Visible = true
			UsesLabel.Text = `{CurrentUses}/{Uses}`
		elseif CurrentVariant ~= '' then
			UsesFrame.Visible = true
			UsesLabel.Text = CurrentVariant
		end
	end

	self:UpdateCooldownVisual();
end

function AbilityManager:DisplayCard(): ()
	if not self.Player or not self.Player:IsA('Player') then
		return
	end

	local AbilityCardClone = AbilitiesAssets.Template:Clone();
	AbilityCardClone.Name = self.AbilityIndex
	AbilityCardClone.Keybind.Key.Text = self.AbilityInformation.KeybindDisplay or self.ClientAbilityInformation.KeybindDisplay or '?'
	AbilityCardClone.Clip.Render.Image = self.AbilityIcon
	AbilityCardClone.Parent = self.Player.PlayerGui.UI.UI.GameUIContainer.Abilities.List

	self.AbilityCard = AbilityCardClone
	self:RefreshCard(self.Player.Character);
end

function AbilityManager:SwitchCardToNormal(): ()
	self:RefreshCard(self.Player and self.Player.Character);
end

function AbilityManager:MakeCardInvisible(): ()
	if not self.AbilityCard then
		return
	end

	self.AbilityCard.Visible = false
	self:UpdateCooldownVisual();
end

function AbilityManager:SwitchVariant(_VariantName: string): ()
	self:RefreshCard(self.Player and self.Player.Character);
end

function AbilityManager:Cleanup(): ()
	self.CooldownToken = (self.CooldownToken or 0) + 1
	if self.AbilityCard then
		self.AbilityCard:Destroy();
		self.AbilityCard = nil
	end
end

function AbilityManager.AttributesChanged(PlayerCharacter: Model, Abilities): ()
	for _, AbilityMeta in Abilities do
		AbilityMeta:RefreshCard(PlayerCharacter);
	end
end

function AbilityManager.RegisterAbility(Player: Player, AbilityIndex: number, ClientAbilityInformation: Ability)
	local Character = Player.Character
	if not Character then
		return
	end

	local CharacterName = string.gsub(Character:GetAttribute('Character'), 'Survivor%-', '');
	if not CharacterName then
		return
	end

	local AbilityServerInformation = GetAbilityInformation(CharacterName, ClientAbilityInformation.Name);
	if not AbilityServerInformation then
		return
	end

	local CharacterInfo = InfoCard[CharacterName] or InfoCard.Survivor[CharacterName]
	if not CharacterInfo then
		return
	end

	local AbilityVariants = AbilityServerInformation.Variants
	if AbilityVariants then
		for VariantName, VariantInformation in AbilityVariants do
			local VariantClientInformation = GetMovesInfoByName(CharacterInfo.Moves, VariantName);
			if VariantClientInformation then
				VariantInformation.ClientInformation = VariantClientInformation
			end
		end
	end

	local self = setmetatable({}, AbilityManager);
	self.Player = Player
	self.AbilityIndex = AbilityIndex
	self.AbilityName = ClientAbilityInformation.Name
	self.AbilityIcon = ClientAbilityInformation.Icon
	self.ClientAbilityInformation = ClientAbilityInformation
	self.AbilityInformation = AbilityServerInformation
	self.CooldownDuration = 0
	self.CooldownEndAt = 0
	self.CooldownToken = 0
	return self
end

function AbilityManager.GetAbilities(Player: Player, CurrentCharacter: string)
	CurrentCharacter = string.gsub(CurrentCharacter, 'Survivor%-', '');

	local CharacterInformation = InfoCard[CurrentCharacter] or InfoCard.Survivor[CurrentCharacter]
	if not CharacterInformation then
		return
	end

	local CharacterAbilities = CharacterInformation.Moves
	if not CharacterAbilities then
		return
	end

	local ReturnTable = {}
	for Index, Ability in CharacterAbilities do
		local NewAbilityMeta = AbilityManager.RegisterAbility(Player, Index, Ability);
		if NewAbilityMeta then
			table.insert(ReturnTable, NewAbilityMeta);
		end
	end

	return ReturnTable
end

function AbilityManager.TryToUseAbility(Player: Player, PlayerAbilities, CharacterMeta, AbilityTable): ()
	local Character = Player.Character
	if not Character or typeof(AbilityTable) ~= 'table' then
		return
	end

	local AbilityType = AbilityTable[1]
	if not AbilityType and typeof(AbilityType) ~= 'boolean' then
		return
	end

	if typeof(AbilityType) == 'boolean' and AbilityTable[2] == 304 then
		return UniversalAbilities.Running(Player, AbilityType);
	end

	local UniversalCallBack = UniversalAbilities[AbilityType]
	if UniversalCallBack and typeof(UniversalCallBack) == 'function' then
		return UniversalCallBack(Player);
	end

	if Character:GetAttribute('Silenced') then
		return
	end

	local AbilityMeta = PlayerAbilities[AbilityTable[2]]
	if not AbilityMeta or AbilityMeta:IsOnCooldown() then
		return
	end

	local CurrentInformation = AbilityMeta:GetCurrentInformation(Character);
	if not CurrentInformation then
		return
	end

	local AbilityCallBack = DetermineCallback(CurrentInformation, Character);
	if not AbilityCallBack then
		return
	end

	local AdditionalArguments = {}
	for Index = 3, #AbilityTable do
		AdditionalArguments[#AdditionalArguments + 1] = AbilityTable[Index]
	end

	local Result = AbilityCallBack(Player, AbilityMeta, CharacterMeta, table.unpack(AdditionalArguments));
	local Success, Cooldown = ResolveResult(CurrentInformation, Result);
	if Success and Cooldown and Cooldown > 0 then
		AbilityMeta:SetCooldown(Cooldown);
	end

	AbilityMeta:RefreshCard(Character);
end

-- <- Return -> --
return AbilityManager