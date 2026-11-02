--> Variables
local _L = _G._L

local Services
local Maid
local Network
local Audio
local TableUtils
local Character
local Shared
local RandomUtility
local Timer
local Create
local NumberUtility
local TableUtility
local Tags
local DictionaryUtility
local cancellableDelay
local Tracker
local Powers
local PowerComponents
local PowerUtility
local AttributeUtility
local WheelRewards
local DailyGiftUtility
local FreeGiftUtility
local WheelRewardUtility
local PetUtility
local PowerComponentUtility
local TrainingAreaUtility
local AuraUtility
local RankUtility
local Codes
local CodesUtility
local EggUtility
local BoostUtility
local FreePetPackUtility
local Trade
local TradeRequest
local TradeUtility
local SettingUtility
local TableTracker
local SeasonUtility
local UpgradeUtility
local Clan
local RobuxMultiplierUtility
local ClanShopItemUtility
local QuestUtility
local HackerEventUtility
local TutorialQuestUtility
local ClanEmblems

local CLANS_DATA_STORE
local MESSAGES_SORTED_MAP
local JOIN_CODES_DATA_STORE

--> Constants

------------->
local Player = {_objects = {}}
Player.__index = Player

function Player._init()
	Services = _L.Get {"Common", "Library", "Services"}
	Maid = _L.Get {"Common", "Library", "Classes", "Maid"} 
	Network = _L.Get {"Common", "Library", "Network"}
	Audio = _L.Get {"Common", "Library", "Audio"}
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	Character = _L.Get {"Server", "Modules", "Controllers", "Character"}
	Trade = _L.Get {"Server", "Modules", "Controllers", "Trade"}
	Clan = _L.Get {"Server", "Modules", "Controllers", "Clan"}
	TradeRequest = _L.Get {"Server", "Modules", "Controllers", "TradeRequest"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	TableTracker = _L.Get {"Common", "Library", "Classes", "Tracker", "TableTracker"}
	Shared = _L.Get {"Common", "Modules", "Shared"}
	Orb = _L.Get {"Server", "Modules", "Controllers", "Orb"}
	Constants = _L.Get {"Common", "Modules", "Constants"}
	RandomUtility = _L.Get {"Common", "Library", "Utilities", "RandomUtility"}
	Timer = _L.Get {"Common", "Library", "Classes", "Timer"}
	Create = _L.Get {"Common", "Library", "Functions", "Create"}
	NumberUtility = _L.Get {"Common", "Library", "Utilities", "NumberUtility"}
	cancellableDelay = _L.Get {"Common", "Library", "Functions", "cancellableDelay"}
	Tags = _L.Get {"Server", "Modules", "Tags"}
	DictionaryUtility = _L.Get {"Common", "Library", "Utilities", "DictionaryUtility"}
	Powers = _L.Get {"Common", "Modules", "Databases", "Powers", "Powers"}
	PowerComponents = _L.Get {"Common", "Modules", "Databases", "Powers", "Components"}
	_Stats = _L.Get {"Common", "Modules", "Databases", "Stats"}
	AttributeUtility = _L.Get {"Common", "Library", "Utilities", "AttributeUtility"}
	WheelRewards = _L.Get {"Common", "Modules", "Databases", "WheelRewards"}
	DailyGiftUtility = _L.Get {"Common", "Modules", "Utilities", "DailyGiftUtility"}
	FreeGiftUtility = _L.Get {"Common", "Modules", "Utilities", "FreeGiftUtility"}
	PlayerRewardUtility = _L.Get {"Common", "Modules", "Utilities", "PlayerRewardUtility"}
	WheelRewardUtility = _L.Get {"Common", "Modules", "Utilities", "WheelRewardUtility"}
	PetUtility = _L.Get {"Common", "Modules", "Utilities", "PetUtility"}
	PowerComponentUtility = _L.Get {"Common", "Modules", "Utilities", "PowerComponentUtility"}
	PowerUtility = _L.Get {"Common", "Modules", "Utilities", "PowerUtility"}
	TrainingAreaUtility = _L.Get {"Common", "Modules", "Utilities", "TrainingAreaUtility"} 
	RobuxMultiplierUtility = _L.Get {"Common", "Modules", "Utilities", "RobuxMultiplierUtility"} 
	RankUtility = _L.Get {"Common", "Modules", "Utilities", "RankUtility"}
	AuraUtility = _L.Get {"Common", "Modules", "Utilities", "AuraUtility"} 
	CodesUtility = _L.Get {"Server", "Modules", "Utilities", "CodesUtility"} 
	Codes = _L.Get {"Server", "Modules", "Databases", "Codes"}
	EggUtility = _L.Get {"Common", "Modules", "Utilities", "EggUtility"}
	BoostUtility = _L.Get {"Common", "Modules", "Utilities", "BoostUtility"}
	FreePetPackUtility = _L.Get {"Common", "Modules", "Utilities", "FreePetPackUtility"}
	FreeHugeEventUtility = _L.Get {"Common", "Modules", "Utilities", "FreeHugeEventUtility"}
	HackerEventUtility = _L.Get {"Common", "Modules", "Utilities", "HackerEventUtility"}
	TradeUtility = _L.Get {"Common", "Modules", "Utilities", "TradeUtility"}
	SettingUtility = _L.Get {"Common", "Modules", "Utilities", "SettingUtility"}
	SeasonUtility = _L.Get {"Common", "Modules", "Utilities", "SeasonUtility"}
	TitleUtility = _L.Get {"Common", "Modules", "Utilities", "TitleUtility"}
	CaseUtility = _L.Get {"Common", "Modules", "Utilities", "CaseUtility"}
	UpgradeUtility = _L.Get {"Common", "Modules", "Utilities", "UpgradeUtility"}
	ClanQuestUtility = _L.Get {"Common", "Modules", "Utilities", "ClanQuestUtility"}
	ClanShopItemUtility = _L.Get {"Common", "Modules", "Utilities", "ClanShopItemUtility"}
	DailyQuestUtility = _L.Get {"Common", "Modules", "Utilities", "DailyQuestUtility"}
	WeeklyQuestUtility = _L.Get {"Common", "Modules", "Utilities", "WeeklyQuestUtility"}
	QuestUtility = _L.Get {"Common", "Modules", "Utilities", "QuestUtility"}
	TutorialQuestUtility = _L.Get {"Common", "Modules", "Utilities", "TutorialQuestUtility"}
	ClanEmblems = _L.Get {"Common", "Modules", "Databases", "ClanEmblems"}
	InviteRewardUtility = _L.Get {"Common", "Modules", "Utilities", "InviteRewardUtility"}
end

function Player._start()
	task.spawn(function()
		CLANS_DATA_STORE = Services.DataStoreService:GetDataStore("Clans_001")
		_G.CLANS_DATA_STORE = CLANS_DATA_STORE
	end)
	
	task.spawn(function()
		JOIN_CODES_DATA_STORE = Services.DataStoreService:GetDataStore("Join_Codes_001")
		_G.JOIN_CODES_DATA_STORE = JOIN_CODES_DATA_STORE
	end)
	
	task.spawn(function()
		MESSAGES_SORTED_MAP = Services.MemoryStoreService:GetSortedMap("Messages_001")
		_G.MESSAGES_SORTED_MAP = MESSAGES_SORTED_MAP
	end)
end

function Player.new(props)
	local self = setmetatable({}, Player)
	
	self._client = props.client
	
	self._data = self._client.data
	self._purchases = self._client.purchases
	
	self._instance = self._client.player
	self._character_controller = nil
	self._is_dead = Tracker.new(true)

	self._toolbar_data = Tracker.new({})
	self._main_power = Tracker.new(nil)
	self._current_power = {
		tracker = Tracker.new(nil),
		maid = Maid.new()
	}
	
	self._trade = Tracker.new(nil)
	self._trade_requests = {}
	
	self._flags = TableTracker.new({})
	
	self._last_cooldown = 0
	
	self._training_area = Tracker.new(nil)
	self._safezone = Tracker.new(nil)
	
	self._last_animation = 1
	self._active_wheel_spins = {}
	self._active_case_spins = {}
	self._last_clan_action = Tracker.new(tick())
	
	self._maid = Maid.new()
	
	self._maid:GiveTask(self._flags)

	self:_construct()

	return self
end

function Player:_construct()
	Player._objects[self._instance] = self

	self._maid:GiveTask(function()
		Player._objects[self._instance] = nil
	end)

	task.spawn(function()
		self:_setup()
	end)
end

function Player:_setup()
	self:_add_character(self._instance.Character or self._instance.CharacterAdded:Wait())

	self._instance.CharacterAdded:Connect(function(...)
		self:_add_character(...)
	end)

	local leaderstats = Create("Folder", {
		Name = "leaderstats",
		Parent = self._instance
	})

	for _, statInfo in pairs(_Stats) do
		if not statInfo.leaderstats then
			continue
		end
		
		local statInstance = Create("StringValue", {
			Name = statInfo.display_name,
			Parent = leaderstats,
			Value = "..."
		})

		self._data:Bind({"stats", statInfo.name}, function(value)
			statInstance.Value = NumberUtility.short(value)
		end)
	end
	
	AttributeUtility.set(self._instance, "visited_best_training_area", true)
	
	local total = Tracker.new(TrainingAreaUtility.getTotalCount(self._data))

	self._maid:GiveTask(total:Bind(function(value)
		local oldValue = total:GetLast()

		if oldValue and value and value > oldValue then
			AttributeUtility.set(self._instance, "visited_best_training_area", false)
		end
	end))
	
	self._maid:GiveTask(self._data:Bind({"stats", "Strength"}, function(value)
		if value >= 10 and self._data:Get("tutorial_marker") == 2 then
			--self._data:Set("tutorial_marker", 3)
		end
		
		total:Set(TrainingAreaUtility.getTotalCount(self._data))
		self:_update_toolbar_data()
	end))
	
	self._maid:GiveTask(self._flags:Bind({}, function(value)
		AttributeUtility.set(self._instance, "flags", value)
	end))
	
	self._maid:GiveTask(self._last_clan_action:Bind(function(value)
		AttributeUtility.set(self._instance, "last_clan_action", value)
	end))
	
	self._maid:GiveTask(self._toolbar_data:Bind(function(value)
		AttributeUtility.set(self._instance, "toolbar_data", value)
	end))
	
	self._maid:GiveTask(self._trade:Bind(function(value)
		AttributeUtility.set(self._instance, "trade", value)
	end))
	
	self._maid:GiveTask(self._data:Bind("clan", function(value)
		local newValue = value
		
		for _, clan in pairs(Clan._objects) do
			if (clan._uid ~= value and clan._data) or (clan._data and clan._data:Get("deleted")) then
				local success = clan:_kick(self._instance.UserId)
			end
		end

		for _, clan in pairs(Clan._objects) do
			task.spawn(function()
				if clan._uid == value and clan._data then
					local _, playerPacket = TableUtility.match(clan._data:Get("players"), function(i, v)
						return v[1] == self._instance.UserId
					end)

					if not playerPacket or clan._data:Get("deleted") then
						newValue = nil
						self._data:Set("clan", newValue)
					end
				end

				clan:_should_destroy()
			end)
		end
		
		if not newValue then
			return
		end
		
		local clan = Clan._objects[value]
		
		if not clan then
			Clan.new({uid = value})
		end
	end))
	
	self._maid:GiveTask(Tracker.Subscribe({self._safezone, self._data:Track({"boosts", "Protection_Potion"})}, function()
		local safeZoneValue = self._safezone:Get()
		local protectionPotionTime = self._data:Get({"boosts", "Protection_Potion", "time_left"})
		
		if protectionPotionTime > 0 or safeZoneValue then
			self:add_flag("protection")
		else
			self:remove_flag("protection")
		end
	end))
	
	self._maid:GiveTask(Tracker.Subscribe({self._current_power.tracker, self._is_dead}, function()
		self._last_animation = 1
		
		local value = self._current_power.tracker:Get()
		local isDead = self._is_dead:Get()

		self._current_power.maid:DoCleaning()

		for _, oldPowerComponentInfo in pairs(PowerComponents) do
			if not oldPowerComponentInfo.idle_animation then
				continue
			end
			
			self._character_controller:stop_animation({
				name = oldPowerComponentInfo.idle_animation
			})
		end
		
		if value ~= "Punch" and self._data:Get("tutorial_marker") == 2 then
			self._data:Set("tutorial_marker", 1)
		end
		
		if value and not isDead then
			if value == "Punch" and self._data:Get("tutorial_marker") == 1 then
				self._data:Set("tutorial_marker", 2)
			end
			
			local _, powerInfo = TableUtility.match(Powers, function(i, v)
				return v.name == value
			end)

			if powerInfo then
				local _, powerComponentInfo = TableUtility.match(PowerComponents, function(i, v)
					return v.name == powerInfo.component
				end)

				local powerName = powerInfo.name

				if self._character_controller then
					if powerComponentInfo.idle_animation then
						self._character_controller:play_animation({
							name = powerComponentInfo.idle_animation,
							fade_time = 0.2
						})
					end

					self._current_power.maid:GiveTask(cancellableDelay(0.2, function()
						local powerInstance = _L.Assets.Models.Powers:FindFirstChild(powerName)
						if powerInstance then
							local newPowerInstance = powerInstance:Clone()

							self._current_power.maid:GiveTask(newPowerInstance)

							newPowerInstance.Parent = self._character_controller._instance
						end
					end))
				end
			end
		end

		self._instance:SetAttribute("current_power", value)
	end))
	
	self._instance:SetAttribute("last_wheel_time", os.time())
	self._instance:SetAttribute("join_time", os.time())
	AttributeUtility.set(self._instance, "free_gifts", {})
	
	self._maid:GiveTask(Timer.Simple(0.5, function()
		self._data:Set({"stats", "Total_Time"}, self._data:Get({"stats", "Total_Time"}) + 0.5)
		
		if self._data:Get("auto_punch") then
			self._current_power.tracker:Set("Punch")
			self:_power_click()
		end
		
		if self._data:Get({"settings", "Auto_Rebirth"}) then
			self:_rebirth()
		end
		
		if WheelRewardUtility.canClaim(self._instance) then
			self._instance:SetAttribute("last_wheel_time", os.time())
			
			PlayerRewardUtility.give(self._client, {{name = "Stat", props = {
				name = "Wheel_Spin",
				value = 1
			}}}, false)
		end
		
		local currentDailyRound = DailyQuestUtility.getCurrentRound()
		local dataDailyRound = self._data:Get({"quests", "daily", "t"})
		
		if dataDailyRound ~= currentDailyRound then
			self._data:Set({"quests", "daily"}, {
				t = currentDailyRound,
				v = DailyQuestUtility.generateList(self._client)
			})
		end
		
		local currentWeeklyRound = WeeklyQuestUtility.getCurrentRound()
		local dataWeeklyRound = self._data:Get({"quests", "weekly", "t"})

		if dataWeeklyRound ~= currentWeeklyRound then
			self._data:Set({"quests", "weekly"}, {
				t = currentWeeklyRound,
				v = WeeklyQuestUtility.generateList(self._client)
			})
		end
		
		if not self._data:Get({"quests", "tutorial", "c"}) and TableUtility.length(self._data:Get({"quests", "tutorial", "v"})) == 0 then
			self._data:Set({"quests", "tutorial"}, {
				c = false,
				v = TutorialQuestUtility.getList(self._client)
			})
		end
	end))
	
	self._maid:GiveTask(Tracker.Subscribe({self._data:Track({"upgrades", "3"}), self._data:Track({"gamepasses"})}, function()
		local v1 = self._purchases:OwnsGamepass("5_Pets_Equipped")
		local v2 = self._purchases:OwnsGamepass("8_Pets_Equipped")
		local v3 = self._data:Get({"upgrades", "3"})
		self._data:Set({"stats", "Pet_Equip_Space"}, 3 + (v3 - 1) + (if v1 then 5 else 0) + (if v2 then 8 else 0))
	end))
end

function Player:_add_character(character)
	repeat Services.RunService.Heartbeat:Wait() until workspace:IsAncestorOf(character)

	if self._character_controller then
		self._character_controller:Destroy()
	end

	self._character_controller = Character.new({
		instance = self._instance.Character or self._instance.CharacterAdded:Wait(),
		player_controller = self
	})

	self._is_dead:Set(false)
end

function Player:add_flag(flagName)
	self._flags:Set({flagName}, true)
end

function Player:remove_flag(flagName)
	self._flags:Set({flagName}, nil)
end

function Player:has_flag(flagName)
	return self._flags:Get({})[flagName] ~= nil
end

function Player:_filter_text(text)
	local function get_text_object(message, fromPlayerId)
		local textObject
		local success, errorMessage = pcall(function()
			textObject = Services.TextService:FilterStringAsync(message, self._instance.UserId)
		end)
		if success then
			return true, textObject
		elseif errorMessage then
			print("Error generating TextFilterResult:", errorMessage)
		end
		return false
	end

	local function get_filtered_message(textObject)
		local filteredMessage
		local success, errorMessage = pcall(function()
			filteredMessage = textObject:GetNonChatStringForBroadcastAsync()
		end)
		if success then
			return true, filteredMessage
		elseif errorMessage then
			print("Error filtering message:", errorMessage)
		end
		return false
	end

	local success, messageObject = get_text_object(text, self._instance.UserId)
	
	if success then
		local filteredText = ""
		local success, filteredText = get_filtered_message(messageObject)
		
		if success then
			return true, filteredText
		else
			return false
		end
	end
	
	return false
end

function Player:_clans_create(props)
	if self._data:Get("clan") then
		return false
	end
	
	if (self._data:Get({"stats", "Gems"}) - Constants.CLAN_CREATION_GEMS_COST) < 0 then
		return false, "enough"
	end
	
	if tick() - self._last_clan_action:Get() < Constants.CLAN_ACTION_DELAY then
		return false, "delay", tick()
	end

	self._last_clan_action:Set(tick())
	
	local clanUid = Services.HttpService:GenerateGUID(false)
	local clanNameSuccess, clanName = self:_filter_text(props.name)

	if clanNameSuccess then
	--	local clanDescriptionSuccess, clanDescription = self:_filter_text(props.description)
		
		--if clanDescriptionSuccess then
			self._data:Set({"stats", "Gems"}, self._data:Get({"stats", "Gems"}) - Constants.CLAN_CREATION_GEMS_COST)

			local clanEmblem = props.emblem

			if not CLANS_DATA_STORE then
				repeat task.wait() until CLANS_DATA_STORE
			end

			local success, result = pcall(function()
				return CLANS_DATA_STORE:SetAsync(clanUid, {
					name = {clanName, tick()},
					emblem = {clanEmblem, tick()},
					uid = clanUid,
					players = {{self._instance.UserId, tick(), "Owner"}},
					kills = 0,
					deaths = 0,
					eggs_opened = 0,
					max_players = Constants.DEFAULT_CLAN_MAX_PLAYERS,
					quests = {},
					join_code = nil,
					--description = {clanDescription, tick()}
				})
			end)

			if success then
				self._data:Set("clan", clanUid)
				return true
			else
				return false
			end
		--end
	end
	
	return false
end

function Player:get_clan()
	local clanUid = self._data:Get("clan")
	if not clanUid then
		return
	end
	return Clan._objects[clanUid]
end

function Player:_discord_verification_submit(code)
	if self._data:Get("discord_verified") then
		return false
	end

	code = string.lower(code)

	if code == "hotsimulators" then
		self._data:Set("discord_verified", true)

		task.spawn(function()
			Services.BadgeService:AwardBadge(self._instance.UserId, 2150108502)
		end)

		PlayerRewardUtility.give(self._client, {
			{
				name = "Pet",
				props = {
					name = "Community Beast",
					value = 1
				}
			}
		}, true)

		return true
	end

	return false, "invalid"
end

function Player:_clans_leave()
	if tick() - self._last_clan_action:Get() < Constants.CLAN_ACTION_DELAY then
		return false, "delay", tick()
	end

	self._last_clan_action:Set(tick())
	
	local clan = self:get_clan()
	
	if not clan then
		return false
	end
	
	local success = false
	
	if clan and clan._data then
		local owner = clan:get_owner()
		
		if owner and owner[1] == self._instance.UserId then
			clan._data:Set("deleted", true)
			
			success = clan:_kick(TableUtility.map(clan._data:Get("players"), function(i, v)
				return i, v[1]
			end), true)
		else
			success = clan:_kick(self._instance.UserId, true)
		end
	end
	
	if success then
		self._data:Set("clan", nil)
	end
	
	return true
end

function Player:_clans_kick(userId)
	if tick() - self._last_clan_action:Get() < Constants.CLAN_ACTION_DELAY then
		return false, "delay", tick()
	end

	self._last_clan_action:Set(tick())

	local clan = self:get_clan()

	if not clan then
		return false
	end

	local success = false

	if clan and clan._data then
		local owner = clan:get_owner()
		
		if owner and owner[1] == self._instance.UserId then
			success = clan:_kick(userId, true)
		end
	end

	return true
end

function Player:_clans_direct_join(clan)
	local success, err = false, nil

	if clan then
		success, err = clan:_join(self._instance.UserId, true)
	end

	if success then
		task.spawn(function()
			Services.BadgeService:AwardBadge(self._instance.UserId, 2149922634)
		end)
		self._data:Set("clan", clan._uid)
		return true
	end
	
	return false, err
end

function Player:_clans_join(clanKey, withCode)
	if tick() - self._last_clan_action:Get() < Constants.CLAN_ACTION_DELAY then
		return false, "delay", tick()
	end
	
	self._last_clan_action:Set(tick())
	
	local otherClanUid = self._data:Get("clan")
	
	if otherClanUid then
		return false, "error"
	end
	
	if not clanKey then
		return false, "invalid"
	end
	
	if withCode then
		if not tonumber(clanKey) then
			return false, "invalid"
		end
		
		local clan = TableUtility.match(Clan._objects, function(i, v)
			return v._data and v._data:Get("join_code") == clanKey
		end)
		
		if clan then
			return self:_clans_direct_join(clan)
		else
			local success, clanUid = pcall(function()
				return JOIN_CODES_DATA_STORE:GetAsync(clanKey)
			end)
			
			if success and clanUid then
				local clan = Clan._objects[clanUid]
				if not clan then
					clan = Clan.new({uid = clanUid})
				end
				local success, err = self:_clans_direct_join(clan)
				if not success or clan._data:Get("deleted") then
					clan:Destroy()
				end
				return success, err
			elseif success then
				return false, "invalid"
			else
				return false, "error"
			end
		end
	else
		local clan = Clan._objects[clanKey]
		
		if clan then
			return self:_clans_direct_join(clan)
		else
			return false, "error"
		end
	end
end

function Player:_is_available()
	if self._instance and self._instance.Parent == Services.Players then
		return true
	else
		return false
	end
end

function Player:_invite_rewards_claim(inviteRewardId)
	if self._claiming_invite_reward then
		return false
	end
	
	self._claiming_invite_reward = true
	
	if InviteRewardUtility.canClaim(self._data, inviteRewardId) then
		local inviteRewardInfo = InviteRewardUtility.getInfo(inviteRewardId)
		if inviteRewardId == "5" then
			task.spawn(function()
				Services.BadgeService:AwardBadge(self._instance.UserId, 2150491191)
			end)
		end
		self._data:Set({"invite_rewards", inviteRewardId}, true)
		PlayerRewardUtility.give(self._client, inviteRewardInfo.reward, true)
		self._claiming_invite_reward = false
		return true
	end
	
	self._claiming_invite_reward = false
	
	return false
end

function Player:_season_claim(tierType, tierId)
	if self._claiming_season then
		return
	end
	
	self._claiming_season = true
	
	local currentSeasonInfo = SeasonUtility.getCurrentInfo()
	local tierInfo = currentSeasonInfo.tiers[tierId]
	
	if tierInfo.required > self._data:Get({"seasons", currentSeasonInfo.id, "total_strength_gained"}) and not table.find(self._data:Get({"seasons", currentSeasonInfo.id, "skipped"}), tierInfo.id) then
		self._claiming_season = false
		return
	end
	
	if tierType == "Premium" then
		if self._data:Get({"seasons", currentSeasonInfo.id, "owns_premium"}) then
			local newTiers = self._data:Get({"seasons", currentSeasonInfo.id, "premium"})
			
			if not table.find(newTiers, tierId) then
				table.insert(newTiers, tierId)
			end
			
			PlayerRewardUtility.give(self._client, tierInfo.premium, true)

			self._data:Set({"seasons", currentSeasonInfo.id, "premium"}, newTiers)
		end
	elseif tierType == "Free" then
		local newTiers = self._data:Get({"seasons", currentSeasonInfo.id, "free"})
		
		if not table.find(newTiers, tierId) then
			table.insert(newTiers, tierId)
		end
		
		PlayerRewardUtility.give(self._client, tierInfo.free, true)
		
		self._data:Set({"seasons", currentSeasonInfo.id, "free"}, newTiers)
	end
	
	task.spawn(function()
		if tierId == TableUtility.length(currentSeasonInfo.tiers) then
			Services.BadgeService:AwardBadge(self._instance.UserId, 2149635466)
		end
	end)
	
	self._claiming_season = false
end

function Player:_clans_quests_claim(clanQuestId)
	local clanUid = self._data:Get("clan")

	if not clanUid then
		return false
	end
	
	local clan = Clan._objects[clanUid]
	
	if not clan then
		return false
	end
	
	local canClaim = ClanQuestUtility.canClaimServer(clanQuestId, clan, self._client)
	
	if canClaim then
		local clanQuestInfo = ClanQuestUtility.getInfo(clanQuestId)

		if not clanQuestInfo then
			return false
		end
		
		self._data:Set({"clan_quests", clanQuestId}, true)
		PlayerRewardUtility.give(self._client, clanQuestInfo.reward, true)

		if TableUtility.length(self._data:Get("clan_quests")) >= 1 then
			task.spawn(function()
				Services.BadgeService:AwardBadge(self._instance.UserId, 2149974978)
			end)
		end

		return true
	end
	
	return false
end

function Player:_notify(...)
	Network.Remote.Fire("C_Notifications_Add", self._instance, ...)
end

function Player:_upgrade_request(upgradeId, wasSkipped)
	local currentUpgradeStage = self._data:Get({"upgrades", upgradeId})
	
	if currentUpgradeStage then
		local upgradeInfo = UpgradeUtility.getInfo(upgradeId)

		if currentUpgradeStage < upgradeInfo.max_stages and upgradeInfo.predicate(self._client, wasSkipped) then
			local upgradeCost = UpgradeUtility.getCost(upgradeId, currentUpgradeStage)
			
			if upgradeCost > self._data:Get({"stats", "Gems"}) then
				return false, "afford"
			end
			
			self._data:Set({"stats", "Gems"}, self._data:Get({"stats", "Gems"}) - upgradeCost)
			
			local success = upgradeInfo.callback(self._client, wasSkipped)

			if success then
				self._data:Set({"upgrades", upgradeId}, currentUpgradeStage + 1)
				return true
			else
				return false
			end
		end
	end
	
	return false
end

function Player:_power_click(position)
	if not self._character_controller or not self._character_controller._root then
		return false
	end

	local currentPowerInfo = self:_get_current_power_info()
	local isDead = self._is_dead:Get()
	
	if currentPowerInfo and not isDead then
		local currentPowerName = currentPowerInfo.name
		local currentPowerComponentInfo = PowerComponentUtility.getInfo(currentPowerInfo.component)
		
		if tick() - self._last_cooldown < currentPowerComponentInfo.cooldown then
			return false
		end
		
		self._last_cooldown = tick()
		
		if currentPowerComponentInfo then
			self._character_controller:play_animation({
				name = currentPowerComponentInfo.click_animation[self._last_animation]
			})

			if self._last_animation >= #currentPowerComponentInfo.click_animation then
				self._last_animation = 1
			else
				self._last_animation += 1
			end
			
			local audioToPlay
			local strengthGiven

			strengthGiven = if typeof(currentPowerInfo.strength) == "function" then currentPowerInfo.strength(self) else currentPowerInfo.strength
			audioToPlay = currentPowerComponentInfo.click_audio
			
			local new = TableUtility.clone(audioToPlay)

			audioToPlay.position = self._character_controller._root.Position

			Audio.Play(audioToPlay)
			
			local powerStrengthGiven
			
			if currentPowerName == "Punch" then
				local trainingAreaId = TrainingAreaUtility.find(self)
				local trainingAreaInfo
				local friendBoost = 1
				
				if trainingAreaId then
					trainingAreaInfo = TrainingAreaUtility.getInfo(trainingAreaId)
				end
				
				if self._instance:GetAttribute("friends_in_game") then
					friendBoost += self._instance:GetAttribute("friends_in_game") * 0.5
				end
				
				local petsBoost = PetUtility.getTotalBoost(self._data)
				
				local i = self._data:Get("robux_multiplier")
				local vvvv
				
				if i then
					vvvv = RobuxMultiplierUtility.getInfo(i)
				end
				
				powerStrengthGiven = math.round(workspace.GlobalStrengthMultiplier.Value * (if self._purchases:OwnsGamepass("x2_Strength") then 2 else 1) * (if vvvv then vvvv.value else 1) * self._data:Get({"upgrades", "4"}) * (if self._purchases:OwnsGamepass("VIP") then 3 else 1) * strengthGiven * (if BoostUtility.has(self._data, "x2_Strength") then 2 else 1) * petsBoost * friendBoost * (1 + self._data:Get({"stats", "Rebirths"}) / 10) * (if trainingAreaInfo then trainingAreaInfo.multiplier elseif self._instance:GetAttribute("is_king") then 5 else 1))
				
				self._data:Set({"seasons", Constants.CURRENT_SEASON_ID, "total_strength_gained"}, self._data:Get({"seasons", Constants.CURRENT_SEASON_ID, "total_strength_gained"}) + powerStrengthGiven)
				self._data:Set({"stats", "Strength"}, self._data:Get({"stats", "Strength"}) + powerStrengthGiven)
				self._data:Set({"stats", "Total_Strength"}, self._data:Get({"stats", "Total_Strength"}) + powerStrengthGiven)
				
				local clan = self:get_clan()

				if clan then
					clan:increment("strength", powerStrengthGiven)
				end
				
				self:_quests_progress("7", powerStrengthGiven)
				self:_tutorial_quests_progress("3", powerStrengthGiven)
			end
			
			Network.Remote.FireAll("C_Power_Play", {
				player = self._client.player,
				strength_given = powerStrengthGiven,
				name = currentPowerInfo.name,
				position = position
			})

			return true
		end
	end

	return false
end

function Player:_clans_shop_buy(clanShopItemId)
	local clanShopItemInfo = ClanShopItemUtility.getInfo(clanShopItemId)
	local clanShopItemPrice = clanShopItemInfo.price
	
	if self._data:Get({"stats", "Crowns"}) >= clanShopItemPrice then
		self._data:Set({"stats", "Crowns"}, self._data:Get({"stats", "Crowns"}) - clanShopItemPrice)
		PlayerRewardUtility.give(self._client, clanShopItemInfo.reward, true)
		task.spawn(function()
			Services.BadgeService:AwardBadge(self._instance.UserId, 2149933943)
		end)
		return true
	end
	
	return false
end

function Player:_get_toolbar_data()
	return self._toolbar_data:Get()
end

function Player:_update_toolbar_data()
	local currentStrength = self._data:Get({"stats", "Strength"})

	local currentPowerInfo = Shared.GetCurrentPowerInfoFromStrength(currentStrength)
	local currentPowerName = currentPowerInfo.name
	
	self._main_power:Set(currentPowerInfo.name)
	
	local toolbarData = {"Punch", currentPowerName}
	
	for _, ownedPowerName in pairs(self._data:Get({"owned_powers"})) do
		table.insert(toolbarData, ownedPowerName)
	end
	
	local oldPowerName = self._current_power.tracker:Get()

	local _, oldPowerInfo = TableUtility.match(Powers, function(i, v)
		return if oldPowerName then v.name == oldPowerName else false
	end)
	
	if not table.find(toolbarData, oldPowerName) then
		self._current_power.tracker:Set(nil)
	end
	
	if oldPowerInfo and oldPowerInfo.required then
		self._current_power.tracker:Set(currentPowerName)
	end
	
	self._toolbar_data:Set(toolbarData)
end

function Player:_trade_toggle_add(petUid)
	local _, petData = TableUtility.match(self._data:Get("pets"), function(xi, v)
		return v.uid == petUid
	end)
	
	if not petData then
		return
	end
	
	local tradeUid = self._trade:Get()

	if tradeUid then
		local trade = Trade._objects[tradeUid]

		if trade then
			local traderIndex = TradeUtility.getTraderIndex(trade, self._instance)

			if traderIndex and trade._state.tracker:Get() == "Default" then
				trade:_unready_all()
				
				local trader = trade._traders[traderIndex]
				local petIndex = table.find(trader.pets, petUid)
				
				if petIndex then
					table.remove(trader.pets, petIndex)
				else
					table.insert(trader.pets, petUid)
				end
				
				trade:_update_traders()
			end
		end
	end
end

function Player:_tutorial_complete()
	self._data:Set("tutorial_marker", 4)
	PlayerRewardUtility.give(self._client, {{
		name = "Stat",
		props = {
			name = "Gems",
			value = 500
		}
	}}, true)
	task.spawn(function()
		Services.BadgeService:AwardBadge(self._instance.UserId, 2150108471)
	end)
end

function Player:_quests_claim(questType, questIndex)
	local sub = if questType == "Daily" then "daily" elseif questType == "Weekly" then "weekly" else "tutorial"
	local questData = self._data:Get({"quests", sub, "v", questIndex})
	
	if not questData then
		return false
	end
	
	local progress = questData.progress
	local canClaim = progress >= questData.required and not questData.completed

	if canClaim then
		local questInfo = (if questType == "Tutorial" then TutorialQuestUtility else QuestUtility).getInfo(questData.id)

		if not questInfo then
			return false
		end

		self._data:Set({"quests", sub, "v", questIndex, "completed"}, true)
		PlayerRewardUtility.give(self._client, questInfo.reward(questData.reward), true)
		
		task.spawn(function()
			if questType ~= "Tutorial" then
				Services.BadgeService:AwardBadge(self._instance.UserId, 2150030018)
			end
		end)
		
		return true
	end

	return false
end

function Player:_quests_progress(questId, questProgressValue)
	local new = TableUtility.deep.clone(self._data:Get("quests"))
	
	for k, v in pairs(new) do
		if k == "tutorial" then
			continue
		end
		for _, vv in pairs(v.v) do
			vv.progress = vv.progress + if questId == vv.id then questProgressValue else 0
		end
	end
	
	self._data:Set("quests", new)
end

function Player:_tutorial_quests_progress(questId, questProgressValue)
	local new = TableUtility.deep.clone(self._data:Get("quests"))

	for k, v in pairs(new) do
		if k == "tutorial" then
			for _, vv in pairs(v.v) do
				vv.progress = vv.progress + if questId == vv.id then questProgressValue else 0
			end
		end
	end

	self._data:Set("quests", new)
end

function Player:_titles_toggle_equip(titleId)
	local titleInfo = TitleUtility.getInfo(titleId)
	local _, titleData = TableUtility.match(self._data:Get("titles"), function(i, v)
		return v.id == titleId
	end)

	if not titleData then
		return
	end

	local wasEquipped = titleData.equipped

	self._data:Set("titles", TableUtility.map(self._data:Get("titles"), function(i, v)
		return i, {id = v.id, equipped = not wasEquipped and titleId == v.id}
	end))
end

function Player:_trade_cancel()
	local tradeUid = self._trade:Get()
	
	if tradeUid then
		local trade = Trade._objects[tradeUid]
		
		if trade._state.tracker:Get() == "Default" then
			trade._state.tracker:Set("Cancelled")
		end
	end
end
function Player:_toggle_power(powerName)
	local toolbarData = self:_get_toolbar_data()

	if table.find(toolbarData, powerName) then
		if self._current_power.tracker:Get() == powerName then
			self._current_power.tracker:Set(nil)
		else
			self._current_power.tracker:Set(powerName)
		end
	end
end

function Player:_clans_settings_type(value)
	local clan = self:get_clan()

	if clan and clan._data and value == "Public" or value == "Private" then
		clan._data:Set("_type", {value, tick()})
	end
end

function Player:_clans_settings_emblem(value)
	local clan = self:get_clan()

	if clan and clan._data and value >= 1 and value <= #ClanEmblems then
		clan._data:Set("emblem", {value, tick()})
	end
end

function Player:_rebirth(skipped)
	local currentRebirths = self._data:Get({"stats", "Rebirths"})
	local currentStrength = self._data:Get({"stats", "Strength"})
	local currentGems = self._data:Get({"stats", "Gems"})
	local nextRebirths = currentRebirths + if self._purchases:OwnsGamepass("x2_Rebirths") then 2 else 1
	
	local gemsGiven = Shared.GetGemsGivenForRebirth(nextRebirths) * self._data:Get({"upgrades", "2"})
	
	local strengthRequired = if currentRebirths then Shared.GetStrengthRequiredForRebirth(nextRebirths) else nil
	
	if not skipped then
		if not strengthRequired or strengthRequired > currentStrength then
			return false, 1
		end

		self._data:Set({"stats", "Strength"}, 0)
	end
	
	self._data:Set({"stats", "Gems"}, currentGems + gemsGiven)
	local rebirthsGiven = if self._purchases:OwnsGamepass("x2_Rebirths") then 2 else 1
	self._data:Set({"stats", "Rebirths"}, self._data:Get({"stats", "Rebirths"}) + rebirthsGiven)
	
	local clan = self:get_clan()

	if clan then
		clan:increment("rebirths", rebirthsGiven)
	end
	
	self:_quests_progress("4", rebirthsGiven)
	self:_tutorial_quests_progress("2", rebirthsGiven)
	
	task.spawn(function()
		Services.BadgeService:AwardBadge(self._instance.UserId, 2149635621)
	end)

	Network.Remote.FireAll("C_Character_Rebirth", self._instance)

	return true
end

function Player:_trade_ready_toggle()
	local tradeUid = self._trade:Get()

	if tradeUid then
		local trade = Trade._objects[tradeUid]

		if trade then
			local traderIndex = TradeUtility.getTraderIndex(trade, self._instance)
			
			if traderIndex and trade._state.tracker:Get() ~= "Completed" then
				local trader = trade._traders[traderIndex]
				trader.ready:Set(not trader.ready:Get())
			end
		end
	end
end

function Player:_rank_reward_claim()
	if self._rank_reward_claiming or self._data:Get({"stats", "Total_Time"}) < (30 * 60) then
		return
	end
	
	self._rank_reward_claiming = true
	
	local canClaim = RankUtility.canClaim(self._data)
	
	if canClaim then
		self._data:Set("rank_reward", os.time())
		
		local currentRankInfo, i = RankUtility.getInfoFromKills(self._data:Get({"stats", "Kills"}))
		
		local rew = {{name = "Stat", props = {
			name = "Gems",
			value = math.round(10000^(1+(i-1)*0.2))
		}},{name = "Boost", props = {
			name = "x2_Damage",
			value = math.random(i, i + 2)
		}},{name = "Boost", props = {
			name = "Protection_Potion",
			value = math.random(i, i + 2)
		}},{name = "Boost", props = {
			name = "x2_Strength",
			value = math.random(i, i + 2)
		}},{name = "Boost", props = {
			name = "Lucky_Potion",
			value = math.random(i, i + 2)
		}}}
		
		if math.random(1, 100) == 1 and i >= 2 then
			table.insert(rew, {
				name = "Pet",
				props = {
					name = "Emerald Monkey",
					value = 1
				}
			})
		end
		
		PlayerRewardUtility.give(self._client, rew, true)
		
		self._rank_reward_claiming = false
		
		return true
	end
	
	self._rank_reward_claiming = false
end

function Player:_get_current_power_info()
	local currentPowerName = self._current_power.tracker:Get() 

	local currentPowerInfo = PowerUtility.getInfo(currentPowerName)

	return currentPowerInfo
end

function Player:_cases_open(caseId)
	local caseInfo = CaseUtility.getInfo(caseId)
	
	if caseInfo and caseInfo.predicate(self._client) then
		local success = caseInfo.callback(self._client)
		
		if success then
			if caseInfo.id == 1 then
				self._data:Set("last_daily_case", os.time())
			elseif caseInfo.id == 2 then
				self._data:Set("last_premium_case", os.time())
			end
			
			local randomRewardId = RandomUtility.chance(TableUtility.map(caseInfo.rewards, function(i, v)
				return i, v[2]
			end))
			
			local caseSpinId = Services.HttpService:GenerateGUID(false)
			local randomReward = caseInfo.rewards[randomRewardId]
			
			self._active_case_spins[caseSpinId] = randomReward[1]
			
			task.spawn(function()
				Services.BadgeService:AwardBadge(self._instance.UserId, 2149769642)
			end)
						
			return true, randomRewardId, caseSpinId
		end
	end
	
	return false
end

function Player:_spin_request()
	local currentWheelSpins = self._data:Get({"stats", "Wheel_Spin"})
	
	if currentWheelSpins <= 0 then
		return false, "notenough"
	end
	
	self._data:Set({"stats", "Wheel_Spin"}, currentWheelSpins - 1)
	
	local wheelRewardId = RandomUtility.chance(TableUtility.map(WheelRewards, function(i, v)
		return i, v.chance
	end))
	
	local wheelSpinId = Services.HttpService:GenerateGUID(false)
	
	self._active_wheel_spins[wheelSpinId] = wheelRewardId
	
	return true, nil, {id = wheelRewardId}, wheelSpinId
end

function Player:_trade_request(targetPlayer)
	local players = {self._instance, targetPlayer}
	local success, err = TradeUtility.canOccur(players)
	
	if not success then
		return false, err
	end
	
	if self._trade_requests[targetPlayer] then
		return false, "already"
	end
	
	table.clear(self._trade_requests)
	
	local newTradeRequest = TradeRequest.new({players = players})
	
	self._trade_requests[targetPlayer] = newTradeRequest

	return true
end

function Player:_spin_confirm(wheelSpinId)
	if self._active_wheel_spins[wheelSpinId] then
		local a = self._active_wheel_spins[wheelSpinId]
		self._active_wheel_spins[wheelSpinId] = nil
		
		local wheelRewardInfo = WheelRewardUtility.getInfo(a)
		
		if wheelRewardInfo then
			PlayerRewardUtility.give(self._client, {{
				name = wheelRewardInfo.reward_name,
				props = {
					name =wheelRewardInfo.name,
					value = wheelRewardInfo.value
				}
			}})
		end
		
		return true
	end
	
	return false
end

function Player:_cases_confirm(caseSpinId)
	local a = self._active_case_spins[caseSpinId]
	
	if a then
		self._active_case_spins[caseSpinId] = nil
		
		PlayerRewardUtility.give(self._client, a)

		return true
	end

	return false
end

function Player:_daily_gifts_claim(dailyGiftId)
	if not dailyGiftId then
		return false
	end
	
	local canClaim = DailyGiftUtility.canClaim(self._data, dailyGiftId)
	local nextDailyGiftId = DailyGiftUtility.getNextId(self._data)
	
	if canClaim then
		self._data:Set("last_daily_gift", {i = if nextDailyGiftId == 7 then 0 else nextDailyGiftId, t = os.time()})
		
		local dailyGiftInfo = DailyGiftUtility.getInfo(nextDailyGiftId)
		
		PlayerRewardUtility.give(self._client, {{
			name = dailyGiftInfo.reward_name,
			props = {
				name = dailyGiftInfo.name,
				value = dailyGiftInfo.value
			}
		}})
		
		return true, {{
			reward_name = dailyGiftInfo.reward_name,
			name = dailyGiftInfo.name,
			value = dailyGiftInfo.value
		}}
	end
end

function Player:_free_gifts_claim(freeGiftId)
	local currentFreeGifts = TableUtility.deep.clone(AttributeUtility.get(self._instance, "free_gifts"))
	
	if not freeGiftId or not currentFreeGifts then
		return false
	end

	local canClaim = FreeGiftUtility.canClaim(self._instance, freeGiftId)

	if canClaim then
		currentFreeGifts[freeGiftId] = true
		
		AttributeUtility.set(self._instance, "free_gifts", currentFreeGifts)

		local freeGiftInfo = FreeGiftUtility.getInfo(freeGiftId)
		
		PlayerRewardUtility.give(self._client, {{
			name = freeGiftInfo.reward_name,
			props = {
				name = freeGiftInfo.name,
				value = freeGiftInfo.value
			}
		}})

		return true, {{
			reward_name = freeGiftInfo.reward_name,
			name = freeGiftInfo.name,
			value = freeGiftInfo.value
		}}
	end
end

function Player:_egg_auto_delete_toggle(petName)
	self._data:Set({"auto_delete", petName}, if self._data:Get({"auto_delete", petName}) then nil else true)
end

function Player:_pets_toggle_equip(petUid)
	local petData = PetUtility.getData(self._data, petUid)
	
	if not petData then
		return false
	end
	
	local equipState = PetUtility.isEquipped(self._data, petUid)
	local newState = not equipState
	
	PetUtility.setEquipped(self._data, petUid, newState)
	
	return true, newState
end

function Player:_pets_equip_best()
	local petsData = self._data:Get("pets")
	local petEquipSpace = self._data:Get({"stats", "Pet_Equip_Space"})
	
	local petUids = TableUtility.filter(TableUtility.map(TableUtility.sort(petsData, function(a, b)
		local aPetInfo = PetUtility.getInfo(a.name)
		local bPetInfo = PetUtility.getInfo(b.name)
		return (PetUtility.getBoost(self._data, a.uid) or 0) > (PetUtility.getBoost(self._data, b.uid) or 0)
	end), function(i, v)
		return i, v.uid
	end), function(i, v)
		return i <= petEquipSpace
	end)
	
	self._data:Set("pets", TableUtility.map(TableUtility.deep.clone(petsData), function(i, v)
		v.equipped = false
		return i, v
	end))
	
	self._data:Set("pets", TableUtility.map(TableUtility.deep.clone(petsData), function(i, v)
		v.equipped = if table.find(petUids, v.uid) then true else false
		return i, v
	end))
	
	return true, petUids
end

function Player:_pets_delete(petUids)
	PetUtility.remove(self._data, petUids)
	return true
end

function Player:_auras_toggle_equip(auraName)
	if self._data:Get("equipped_aura") == auraName then
		self._data:Set("equipped_aura", nil)
		return true
	end
	
	local auraInfo = AuraUtility.getInfo(auraName)
	local rankInfo = RankUtility.getInfoFromAuraName(auraName)
	local rankName = rankInfo.name
	
	local hasRank = RankUtility.has(self._data, rankName, true)
	
	if hasRank then
		self._data:Set("equipped_aura", auraInfo.name)
		return true
	else
		return false
	end
end

function Player:_settings_toggle(settingName)
	local settingInfo = SettingUtility.getInfo(settingName)
	
	if settingInfo then
		local success, err = settingInfo.callback(self._client)
		
		if success then
			local newSettingsData = TableUtility.deep.clone(self._data:Get("settings"))

			newSettingsData[settingName] = not newSettingsData[settingName]

			self._data:Set("settings", newSettingsData)
			
			return true
		else
			return false, err
		end
	end
	
	return false
end

function Player:_submit_code(code)
	if table.find(self._data:Get("used_codes"), code) then
		return false, "used"
	end
	
	local codeInfo = CodesUtility.getInfo(code)
	
	if codeInfo then
		local new = TableUtility.deep.clone(self._client.data:Get("used_codes"))
		
		table.insert(new, code)
		
		self._client.data:Set("used_codes", new)
		
		return codeInfo.callback(self._client)
	else
		return false, "invalid"
	end
end

function Player:_free_pet_pack_claim()
	if self._client.data:Get("claimed_free_pet_pack") then
		return false, "claimed"
	end
	
	local canClaim = FreePetPackUtility.canClaim(self._instance)
	
	if canClaim then
		self._client.data:Set("claimed_free_pet_pack", true)
		
		local success = PlayerRewardUtility.give(self._client, {{
			name = "Pet",
			props = {
				name = "Blue Angel",
				value = 1
			}
		},{
			name = "Pet",
			props = {
				name = "Green Angel",
				value = 1
			}
		},{
			name = "Pet",
			props = {
				name = "Pink Angel",
				value = 1
			}
		}}, true)
		
		task.spawn(function()
			Services.BadgeService:AwardBadge(self._instance.UserId, 2149635205)
		end)
		
		return success
	end

	return false
end

function Player:_huge_event_reward_claim(bypass)
	if not bypass and self._client.data:Get("claimed_huge_event_reward") then
		return false, "claimed"
	end

	local canClaim = FreeHugeEventUtility.canClaim(self._client)

	if bypass or canClaim then
		self._client.data:Set("claimed_huge_event_reward", true)

		local success = PlayerRewardUtility.give(self._client, {{
			name = "Pet",
			props = {
				name = "Huge Cthulhu",
				value = 1
			}
		}}, true)
		
		task.spawn(function()
			Services.BadgeService:AwardBadge(self._instance.UserId, 2149635402)
		end)

		return success
	end

	return false
end

function Player:_pets_craft(petUid)
	local craftable = PetUtility.getCraftable(self._data, petUid)
	
	local petName = TableUtility.once(craftable, function(i, v)
		return v.name
	end)
	
	if TableUtility.length(craftable) < Constants.PETS_NEEDED_FOR_CRAFT then
		return false
	end
	
	local n = 0
	
	local new = TableUtility.deep.clone(self._data:Get("pets"))
	
	for _, a in pairs(craftable) do
		local i, v = TableUtility.match(new, function(i, v)
			return a.uid == v.uid
		end)
		
		if v and n < Constants.PETS_NEEDED_FOR_CRAFT then
			n += 1
			table.remove(new, i)
		end
	end
	
	self._data:Set("pets", new)
	
	PetUtility.give(self._client, {
		name = petName,
		tier = "Rainbow",
		value = 1
	}, true)
	
	return true
end

function Player:_hacker_event_reward_claim(bypass)
	if not bypass and self._client.data:Get("claimed_hacker_event_reward") then
		return false, "claimed"
	end

	local canClaim = HackerEventUtility.canClaim(self._client)

	if bypass or canClaim then
		self._client.data:Set("claimed_hacker_event_reward", true)

		local success = PlayerRewardUtility.give(self._client, {{
			name = "Pet",
			props = {
				name = "Hacker Dominus",
				value = 1
			}
		}}, true)

		task.spawn(function()
			Services.BadgeService:AwardBadge(self._instance.UserId, 2150032952)
		end)

		return success
	end

	return false
end

function Player:_auto_punch_toggle()
	self._data:Set("auto_punch", not self._data:Get("auto_punch"))
	return true
end

function Player:_egg_open(eggName, n, s)
	local eggInfo = EggUtility.getInfo(eggName)
	
	if not eggInfo then
		return false
	end
	
	if not self._client.purchases:OwnsGamepass("Triple_Eggs") and n >= 3 and not eggInfo.is_exclusive then
		if s then
			self._client.purchases:PromptGamepass("Triple_Eggs")
		end
		return false
	end
	
	if self._data:Get({"stats", "Gems"}) - eggInfo.price * n >= 0 then
		if not PetUtility.hasInventorySpace(self._data, n) then
			return false, "space"
		end
		
		self._data:Set({"stats", "Gems"}, self._data:Get({"stats", "Gems"}) - eggInfo.price * n)
		
		if eggName == "250K_Event_Egg" then
			self._data:Set({"stats", "Event_Eggs_1_Opened"}, self._data:Get({"stats", "Event_Eggs_1_Opened"}) + n)
		end
		
		local success, rewardData = PlayerRewardUtility.give(self._client, {{name = "Egg", props = {
			name = eggInfo.name,
			value = n
		}}})
		
		Network.Remote.Fire("C_Eggs_Open", self._instance, {
			name = eggName,
			reward_data = rewardData
		})
		
		return success
	else
		return false, "afford"
	end
end

function Player:_boosts_use(boostName, boostValue)
	local boostInfo = BoostUtility.getInfo(boostName)
	
	if boostInfo.active then
		return BoostUtility.use(self._client, {
			name = boostName,
			value = boostValue
		})
	end
end

function Player:_damage_register(p2, n)
	local pcc2 = Network.Bindable.Invoke("S_Client_Get", p2)

	if not pcc2 then
		return false
	end

	local pc2 = pcc2.player_controller

	if pc2 and not self._safezone:Get() then
		return pc2:_damage(self, n)
	end
end

function Player:_damage(pc2, n)
	n = if self._client.purchases:OwnsGamepass("x2_Damage") or BoostUtility.has(pc2._data, "x2_Damage") then n * 2 else n
	
	if not self:has_flag("protection") then
		local characterController = self._character_controller

		if characterController then
			local c = characterController:get_health()

			if c-n <= 0 then
				if self._instance:GetAttribute("is_king") and Network.Bindable.Invoke("check", pc2._instance) then
					Network.Bindable.Fire("setKing", pc2._instance)
				end
				local clan1 = pc2:get_clan()
				if clan1 then
					clan1:increment("kills", 1)
				end
				pc2:_quests_progress("1", 1)
				pc2._data:Set({"stats", "Kills"}, pc2._data:Get({"stats", "Kills"}) + 1)
				pc2._data:Set({"stats", "Huge_Event_Kills"}, pc2._data:Get({"stats", "Huge_Event_Kills"}) + 1)
				pc2._data:Set({"stats", "Hacker_Event_Kills"}, pc2._data:Get({"stats", "Hacker_Event_Kills"}) + 1)
				local clan2 = self:get_clan()
				if clan2 then
					clan2:increment("deaths", 1)
				end
				self:_quests_progress("2", 1)
				self._data:Set({"stats", "Deaths"}, self._data:Get({"stats", "Deaths"}) + 1)
				
				Network.Remote.Fire("C_Kill", pc2._instance, self._instance)
				
				if workspace:GetAttribute("special_event") == "deathmatch" then
					local n = math.random(50, 100)
					local total = math.max(math.ceil(pc2._data:Get({"stats", "Gems"}) * 0.005), n)

					local orbs = {}

					for i = 1, n do
						table.insert(orbs, Orb.new({
							client = pc2._client,
							position = characterController._root.Position,
							image = PlayerRewardUtility.getInfo("Stat").getInfo("Gems").image,
							callback = function()
								PlayerRewardUtility.give(pc2._client, {{
									name = "Stat",
									props = {
										name = "Gems",
										value = math.ceil(total / n)
									}
								}})
							end,
						}))
					end

					Network.Remote.Fire("C_Orb_Bulk", pc2._instance, TableUtility.map(orbs, function(i, v)
						return i, v:package()
					end))

					if self._data:Get({"stats", "Gems"}) >= 1000 then
						local after = self._data:Get({"stats", "Gems"}) - self._data:Get({"stats", "Gems"}) * 0.001
						self._data:Set({"stats", "Gems"}, after)
					end
				end
			end
			
			self:_quests_progress("6", n)

			if c then
				Network.Remote.Fire("hit", self._instance)
				characterController:set_health(c - n)
				return true
			end
		end
	end
	
	return false
end

function Player:Destroy()
	self._maid:Destroy()
end

return Player