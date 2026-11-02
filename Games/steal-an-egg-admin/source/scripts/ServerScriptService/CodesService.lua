--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Remotes = require(ReplicatedStorage.Shared.Remotes)
local DataService = require(ServerScriptService.DataService)

local CODES: {[string]: {Reward: {Money: number?, SpeedPower: number?}}} = {
	["WELCOME"] = { Reward = { Money = 999999999999 } },
	["RELEASE"] = { Reward = { SpeedPower = 1000000 } },
	["FREEPETS"] = { Reward = { Money = 250 } },
}

local CodesService = {}

function CodesService.Init()
	Remotes.Codes.AskRedeem.OnServerEvent:Connect(function(player, code)
		print("[CodesService] Redeem request from", player.Name, "code:", tostring(code))
		if typeof(code) ~= "string" then
			print("[CodesService] Invalid code type:", typeof(code))
			Remotes.Codes.Verdict:FireClient(player, false, "Invalid code.")
			return
		end

		local normalized = string.upper((string.gsub(code, "^%s+", "")):gsub("%s+$", ""))
		if normalized == "" then
			Remotes.Codes.Verdict:FireClient(player, false, "Please enter a code.")
			return
		end

		local codeData = CODES[normalized]
		if not codeData then
			print("[CodesService] Code not found:", normalized)
			Remotes.Codes.Verdict:FireClient(player, false, "Invalid code.")
			return
		end

		-- Ensure player data is loaded
		local data = DataService.Get(player)
		if not data then
			Remotes.Codes.Verdict:FireClient(player, false, "Data still loading, try again.")
			return
		end

		local claimedCodes = DataService.GetField(player, "ClaimedCodes", {})
		for _, claimed in ipairs(claimedCodes) do
			if claimed == normalized then
				print("[CodesService] Code already claimed by", player.Name, ":", normalized)
				Remotes.Codes.Verdict:FireClient(player, false, "Code already redeemed.")
				return
			end
		end

		-- Apply rewards
		local reward = codeData.Reward
		local rewardTexts = {}
		if reward.Money then
			DataService.AddMoney(player, reward.Money)
			table.insert(rewardTexts, `{reward.Money} Money`)
		end
		if reward.SpeedPower then
			DataService.AddSpeedPower(player, reward.SpeedPower)
			table.insert(rewardTexts, `{reward.SpeedPower} SpeedPower`)
		end

		-- Track claimed code
		table.insert(claimedCodes, normalized)
		DataService.SetField(player, "ClaimedCodes", claimedCodes)

		local rewardSummary = table.concat(rewardTexts, ", ")
		Remotes.Codes.Verdict:FireClient(player, true, `Code redeemed! +{rewardSummary}`)
	end)
end

function CodesService.Start()
	-- No startup logic needed
end

return CodesService