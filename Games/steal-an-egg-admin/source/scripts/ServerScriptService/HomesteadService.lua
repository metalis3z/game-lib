--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Bases = require(ReplicatedStorage.Data.Bases)
local DataService = require(ServerScriptService.DataService)

local HomesteadService = {}

local bridge_name = "_HomesteadBaseTierBridge"

function HomesteadService.RaiseBaseTier(player: Player, requestedTier: number?, skipPayment: boolean?): (boolean, string?)
	local profile = DataService.WaitForProfile(player, 15)
	if not profile then
		return false, "Data still loading"
	end

	local currentLevel = math.max(0, math.floor(tonumber(profile.BaseUpgradeLevel) or 0))

	if skipPayment and type(requestedTier) == "number" then
		if currentLevel >= (requestedTier :: number) then
			return true
		end
		if (requestedTier :: number) ~= currentLevel + 1 then
			return false, "This is not your next plot upgrade"
		end
	end

	local nextConfig = Bases.BASES[currentLevel + 1]
	if nextConfig == nil then
		return false, "Max plot upgrade reached"
	end

	local cost = (nextConfig :: any).Cost or 0
	if not skipPayment and cost > 0 then
		local money = tonumber(profile.Money) or 0
		if money < cost then
			return false, "Not enough money"
		end
		DataService.AddMoney(player, -cost)
	end

	profile.BaseUpgradeLevel = currentLevel + 1
	DataService.SyncChange(player, "BaseUpgradeLevel", profile.BaseUpgradeLevel)

	print(("[HomesteadService] %s upgraded plot to level %d"):format(player.Name, currentLevel + 1))
	return true
end

local initialized = false

function HomesteadService.Init()
	if initialized then
		return
	end
	initialized = true

	Remotes.Homestead.AskBaseTierRaise.OnServerEvent:Connect(function(player)
		local ok, err = pcall(HomesteadService.RaiseBaseTier, player, nil, false)
		if not ok then
			warn(("[HomesteadService] AskBaseTierRaise failed for %s: %s"):format(player.Name, tostring(err)))
		end
	end)

	local found = ServerScriptService:FindFirstChild(bridge_name)
	local bridge: BindableFunction
	if found ~= nil and found:IsA("BindableFunction") then
		bridge = found :: BindableFunction
	else
		if found ~= nil then
			found:Destroy()
		end
		bridge = Instance.new("BindableFunction")
		bridge.Name = bridge_name
		bridge.Parent = ServerScriptService
	end

	bridge:SetAttribute("Ready", true)
	bridge.OnInvoke = function(player, tier)
		if typeof(player) ~= "Instance" or not player:IsA("Player") then
			return false, "Invalid bridge caller"
		end
		local ok, granted, err = pcall(HomesteadService.RaiseBaseTier, player, tonumber(tier), true)
		if not ok then
			return false, tostring(granted)
		end
		return granted, err
	end

	print(("[HomesteadService] AskBaseTierRaise wired and %s ready"):format(bridge_name))
end

function HomesteadService.Start()
end

return HomesteadService