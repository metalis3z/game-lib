-- One-off and daily rewards the player claims from the lobby.
--
--   Data.ClaimLoginReward()          LoginRewardLibrary:GetLoginRewardInfoFromDay(LoginRewardsClaimed + 1),
--                                    once per day (ClaimedLoginRewardToday, reset by DailyService)
--   Data.ClaimLikeReward()           RIVALS wrap (universal) + 3 keys     } what Pages.Rewards shows
--   Data.ClaimFavoriteReward()       Shooting Star (universal)            } for each; Roblox has no
--   Data.ClaimNotificationsReward()  Bell (universal)                     } way to check a like or a
--   Data.ClaimGroupReward() -> bool  Nosniy Games (universal), if in CONSTANTS.GROUP_ID
--                                    favourite, so those two trust the client like the original did.
--   Data.ClaimBattlePassReward(tier, track)   SeasonLibrary.CurrentSeason.BattlePassRewards[tier][track]
--        once PassLevel >= tier and track <= MaxPassTrackNum; marks
--        BattlePass.RewardsClaimed[tostring(tier)][tostring(track)]
--   Data.RedeemCode(code) -> "Success" | reason       CODES below; RedeemedCodes[code] = true
--
-- The codes and what they gave lived on the original server. The patch-notes codes are the
-- ones the client still shows (Modules.PatchNotes.*.Code), and FREE199 is on the lobby's
-- billboard; the reward for each is this rebuild's choice, not the original's. Edit freely.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))
local LoginRewardLibrary = require(Modules:WaitForChild("LoginRewardLibrary"))
local SeasonLibrary = require(Modules:WaitForChild("SeasonLibrary"))

local PlayerDataService = require(script.Parent.PlayerDataService)
local DataTemplate = require(script.Parent.DataTemplate)
local RewardService = require(script.Parent.RewardService)

local Data = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Data")

local ONE_OFF = {
	ClaimedLikeReward = {
		{ Name = "RIVALS", Weapon = "IsUniversal", Quantity = 1 },
		{ Name = "Key", Quantity = 3 },
	},
	ClaimedFavoriteReward = { { Name = "Shooting Star", Weapon = "IsUniversal", Quantity = 1 } },
	ClaimedNotificationsReward = { { Name = "Bell", Weapon = "IsUniversal", Quantity = 1 } },
	ClaimedGroupReward = { { Name = "Nosniy Games", Weapon = "IsUniversal", Quantity = 1 } },
}

local GOODIE_BAG = { { Name = "Goodie Bag", Quantity = 1, Weapon = "IsRandom" } }

local CODES = {
	free199 = GOODIE_BAG,
	patchnotes_thehunt = GOODIE_BAG,
	patchnotes_cosmetics2 = GOODIE_BAG,
	patchnotes_gamemodes2 = GOODIE_BAG,
	patchnotes_contracts = GOODIE_BAG,
	patchnotes_season1 = GOODIE_BAG,
	patchnotes_halloween2025 = GOODIE_BAG,
	patchnotes_2025festive = GOODIE_BAG,
	patchnotes_laboroflove = GOODIE_BAG,
	patchnotes_luckyupdate = GOODIE_BAG,
	patchnotes_season3 = GOODIE_BAG,
	patchnotes_summer2026 = GOODIE_BAG,
	patchnotes_wildcatrelease = GOODIE_BAG,
	patchnotes_rias26 = GOODIE_BAG,
}

local ClaimService = {}

local function claimOnce(player: Player, flag: string): boolean
	local data = PlayerDataService.Get(player)
	if not data or data[flag] then
		return false
	end
	PlayerDataService.Set(player, flag, true)
	RewardService.GrantAll(player, ONE_OFF[flag], true)
	return true
end

local function claimLogin(player: Player)
	local data = PlayerDataService.Get(player)
	if not data or data.ClaimedLoginRewardToday then
		return
	end

	local day = (data.LoginRewardsClaimed or 0) + 1
	local info = LoginRewardLibrary:GetLoginRewardInfoFromDay(day)
	if not info then
		return
	end

	PlayerDataService.Set(player, "ClaimedLoginRewardToday", true)
	PlayerDataService.Set(player, "LoginRewardsClaimed", day)
	RewardService.GrantAll(player, info.Rewards, true)
end

local function claimBattlePass(player: Player, tier: any, track: any)
	local data = PlayerDataService.Get(player)
	tier, track = tonumber(tier), tonumber(track)
	if not data or not tier or not track then
		return
	end

	DataTemplate.EnsureSeason(data)
	local pass = data.Seasons[SeasonLibrary.CurrentSeason.Name].BattlePass
	local row = SeasonLibrary.CurrentSeason.BattlePassRewards[tier]
	local reward = row and row[track]
	if not reward or (pass.PassLevel or 0) < tier or track > (pass.MaxPassTrackNum or 1) then
		return
	end

	pass.RewardsClaimed = pass.RewardsClaimed or {}
	local claimedTier = pass.RewardsClaimed[tostring(tier)] or {}
	if claimedTier[tostring(track)] then
		return
	end
	claimedTier[tostring(track)] = true
	pass.RewardsClaimed[tostring(tier)] = claimedTier

	PlayerDataService.Replicate(player, "Seasons")
	RewardService.Grant(player, reward, true)
end

local function redeem(player: Player, code: any): string
	local data = PlayerDataService.Get(player)
	if not data or typeof(code) ~= "string" then
		return "Invalid code"
	end

	code = string.lower(code)
	local rewards = CODES[code]
	if not rewards then
		return "Invalid code"
	end
	if data.RedeemedCodes[code] then
		return "Already redeemed"
	end

	data.RedeemedCodes[code] = true
	PlayerDataService.Replicate(player, "RedeemedCodes")
	RewardService.GrantAll(player, rewards, true)
	return "Success"
end

function ClaimService.Start()
	Data.ClaimLoginReward.OnServerEvent:Connect(claimLogin)
	Data.ClaimBattlePassReward.OnServerEvent:Connect(claimBattlePass)
	Data.RedeemCode.OnServerInvoke = redeem

	Data.ClaimLikeReward.OnServerEvent:Connect(function(player: Player)
		claimOnce(player, "ClaimedLikeReward")
	end)
	Data.ClaimFavoriteReward.OnServerEvent:Connect(function(player: Player)
		claimOnce(player, "ClaimedFavoriteReward")
	end)
	Data.ClaimNotificationsReward.OnServerEvent:Connect(function(player: Player)
		claimOnce(player, "ClaimedNotificationsReward")
	end)

	Data.ClaimGroupReward.OnServerInvoke = function(player: Player)
		local ok, inGroup = pcall(player.IsInGroup, player, CONSTANTS.GROUP_ID)
		if not (ok and inGroup) then
			return false
		end
		claimOnce(player, "ClaimedGroupReward")
		return true
	end
end

ClaimService.Remotes = {
	Data.ClaimBattlePassReward,
	Data.RedeemCode,
	Data.ClaimLoginReward,
	Data.ClaimLikeReward,
	Data.ClaimFavoriteReward,
	Data.ClaimNotificationsReward,
	Data.ClaimGroupReward,
}

return ClaimService
