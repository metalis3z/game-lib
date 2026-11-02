local Players = game:GetService("Players")
local SSS = game:GetService("ServerScriptService")
local Rep = game.ReplicatedStorage
local Remotes = Rep.Remotes
local Modules = Rep.Modules
local Data = require(script.Parent.Data)
local Items = require(Modules.Items)
local GetStatsModule = require(SSS.Functions.GetRealStats)

local BoostsHandler = {} do
	Remotes.Boost.Event:Connect(function(Player: Player, Boost: string, Amount: number?)
		local PlayerData = Data:Get(Player)
		local BoostData = game.ReplicatedStorage.Boosts:FindFirstChild(Boost)
		if not BoostData then
			return
		end
		BoostData = require(BoostData)
		
		if not Amount then
			Amount = 1
		end
		local Time = os.time() + BoostData.Time
		local Amount = PlayerData.Boosts[Boost] ~= nil and math.min(PlayerData.Boosts[Boost].Amount + Amount, BoostData.MaxStack) or math.min(Amount, BoostData.MaxStack)
		local AlreadyHave = PlayerData.Boosts[Boost] ~= nil and true or false
		PlayerData.Boosts[Boost] = {
			Time = Time,
			Amount = Amount,
			BoostType = Boost,
		}
		--Remotes.DataUpdated:FireClient(Player, {"Boosts", PlayerData.Boosts})
		Remotes.DataUpdated:FireClient(Player, {"Boosts", Boost, PlayerData.Boosts[Boost]})
	end)
	--Remotes.Boost.Event:Connect(function(Player, BoostType, BoostAmount)
	--	if BoostType ~= nil and BoostType ~= "" then
	--		if game.Players:FindFirstChild(Player.Name) and Rep.Boosts:FindFirstChild(BoostType) then
	--			local PData = Data:Get(Player)
	--			local Boost = require(Rep.Boosts:FindFirstChild(BoostType))
	--			if not PData.Boosts[BoostType] then
	--				PData.Boosts[BoostType] = {Time = os.time() + Boost.Time, Amount = math.round(BoostAmount), BoostType = BoostType}
	--			else
	--				PData.Boosts[BoostType].Time = os.time() + Boost.Time
	--				if PData.Boosts[BoostType].Amount < Boost.MaxStack then
	--					PData.Boosts[BoostType].Amount += math.round(BoostAmount)
	--				end
	--			end
	--			GetStatsModule.GetRealStats(Player, PData)
	--			Remotes.DataUpdated:FireClient(Player, {"Boosts", BoostType, PData.Boosts[BoostType]})
	--		else
	--			warn("Error BJ_X_301. Can't find Player or Boost")
	--		end
	--	end
	--end)
end

return BoostsHandler