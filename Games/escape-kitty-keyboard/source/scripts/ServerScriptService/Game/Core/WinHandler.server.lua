local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataHandler = require(game.ServerScriptService.DataService.DataHandler)
local Config = require(ReplicatedStorage:WaitForChild("Config"))
local WinsMultiplierManager = require(game.ServerScriptService:WaitForChild("WinsMultiplierManager"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")
local ShowWin = Remotes:WaitForChild("ShowWin")

local winDebounces = {}

local function giveWin(player, winBlockName)
	local data = DataHandler.Get(player)
	if not data then return end
	
	local lastWin = winDebounces[player] or 0
	if os.time() - lastWin < (Config.WIN_DEBOUNCE_DELAY or 3) then
		return
	end
	
	local amount = Config.WIN_AMOUNTS[winBlockName] or 150000
	local winsMult = data.WinsMultiplier or 1
	local globalWinsMult = WinsMultiplierManager.Get()
	local totalMult = winsMult * globalWinsMult
	
	local finalAmount = amount * totalMult
	data.Wins = data.Wins + finalAmount
	data.LastWinAmount = finalAmount
	winDebounces[player] = os.time()

	-- Auto-upgrade to best award based on wins
	local newStepBonus = Config.GetBestStepBonus(data.Wins)
	if newStepBonus ~= data.StepBonus then
		data.StepBonus = newStepBonus
	end

	UpdateUI:FireClient(player, {Wins = data.Wins, StepBonus = data.StepBonus})
	ShowWin:FireClient(player, amount * totalMult)
	
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats and leaderstats:FindFirstChild("Wins") then
		leaderstats.Wins.Value = data.Wins
	end
	
	if player.Character then
		local spawnPos = workspace:FindFirstChild("SpawnLocation") and workspace.SpawnLocation.Position or Vector3.new(0, 10, 0)
		player.Character:MoveTo(spawnPos + (Config.SPAWN_OFFSET or Vector3.new(0, 5, 0)))
	end
end

local function setupWinBlocks()
	task.spawn(function()
		local descendants = workspace:GetDescendants()
		for i = 1, #descendants, 500 do
			local endIndex = math.min(i + 499, #descendants)
			for j = i, endIndex do
				local v = descendants[j]
				if v:IsA("BasePart") and string.find(v.Name, "WinBlock") then
					v.Touched:Connect(function(hit)
						local player = Players:GetPlayerFromCharacter(hit.Parent)
						if player then
							giveWin(player, v.Name)
						end
					end)
				end
			end
			task.wait() -- Yield to prevent startup freeze
		end
	end)
end

setupWinBlocks()

workspace.DescendantAdded:Connect(function(v)
	if v:IsA("BasePart") and string.find(v.Name, "WinBlock") then
		v.Touched:Connect(function(hit)
			local player = Players:GetPlayerFromCharacter(hit.Parent)
			if player then
				giveWin(player, v.Name)
			end
		end)
	end
end)
