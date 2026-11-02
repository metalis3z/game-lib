-- CustomAdminPanel Server Script v2
-- Whitelist: 9095034954,10270273034,8570623120,8220421537

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)

local WHITELIST = {  }

local Execute    = Net:RemoteEvent("CustomAdmin/Execute")
local OpenUI     = Net:RemoteEvent("CustomAdmin/OpenUI")
local GetEvents  = Net:RemoteFunction("CustomAdmin/GetEvents")
local GetAnimals = Net:RemoteFunction("CustomAdmin/GetAnimals")
local GetMuts    = Net:RemoteFunction("CustomAdmin/GetMutations")
local GetItems   = Net:RemoteFunction("CuzstomAdmin/GetItems")
local GetPlayers = Net:RemoteFunction("CustomAdmin/GetPlayers")

local function isAdmin(p)
	for _, id in ipairs(WHITELIST) do
		if tostring(p.UserId) == tostring(id) then return true end
	end
	return false
end

local function getSync(player)
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	return Synchronizer:Get(player)
end

local function findPlayer(name)
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower() == tostring(name):lower() or tostring(p.UserId) == tostring(name) then
			return p
		end
	end
end

local function findAnimal(name)
	local Animals = require(ReplicatedStorage.Datas.Animals)
	for k, d in pairs(Animals) do
		if d.DisplayName == name or k == name then return d, k end
	end
end

-- Listes
GetEvents.OnServerInvoke = function(p)
	if not isAdmin(p) then return nil end
	local svc = require(ServerScriptService.Services.EventService)
	local list = {}
	for name in pairs(svc.EventConfigs) do table.insert(list, name) end
	table.sort(list)
	return list
end

GetAnimals.OnServerInvoke = function(p)
	if not isAdmin(p) then return nil end
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local list = {}
	for k, d in pairs(Animals) do
		if not d.LuckyBlock then table.insert(list, { key = k, name = d.DisplayName or k, rarity = d.Rarity or "" }) end
	end
	table.sort(list, function(a,b) return a.name < b.name end)
	return list
end

GetMuts.OnServerInvoke = function(p)
	if not isAdmin(p) then return nil end
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local list = { "Normal" }
	for name in pairs(Mutations) do table.insert(list, name) end
	table.sort(list)
	return list
end

GetItems.OnServerInvoke = function(p)
	if not isAdmin(p) then return nil end
	local list = {}
	for _, item in ipairs(ReplicatedStorage.Items:GetChildren()) do
		if item:IsA("Tool") then table.insert(list, item.Name) end
	end
	table.sort(list)
	return list
end

GetPlayers.OnServerInvoke = function(p)
	if not isAdmin(p) then return nil end
	local list = {}
	for _, pl in ipairs(Players:GetPlayers()) do
		table.insert(list, { name = pl.Name, userId = pl.UserId })
	end
	return list
end

-- Execution commandes
Execute.OnServerEvent:Connect(function(player, cmd, args)
	if not isAdmin(player) then
		warn("[CustomAdmin] UNAUTHORIZED:", player.Name)
		return
	end

	local RS  = ReplicatedStorage
	local SSS = ServerScriptService

	local ok, err = pcall(function()
		-- Services (lazy load)
		local function AnimalSvc() return require(SSS.Services.AnimalService) end
		local function MoneySvc()  return require(SSS.Services.MoneyService) end
		local function EventSvc()  return require(SSS.Services.EventService) end
		local function LuckSvc()   return require(SSS.Services.LuckService) end
		local function NotifSvc()  return require(SSS.Services.NotificationService) end
		local function PollSvc()   return require(SSS.Services.PollService) end
		local function Net2()      return require(RS.Packages.Net) end

		-- ============================================================
		-- EVENTS
		-- ============================================================
		if cmd == "executeevent" then
			EventSvc():ExecuteEvent(args[1], tonumber(args[2]) or nil)

		elseif cmd == "cancelevent" then
			EventSvc():CancelEvent(args[1])

		elseif cmd == "executeglobalevent" then
			if _G.MessagingHub then
				_G.MessagingHub.Publish("GlobalEvent", { Event = args[1], Duration = tonumber(args[2]) })
			end
			EventSvc():ExecuteEvent(args[1], tonumber(args[2]) or nil)

		elseif cmd == "cancelglobalevent" then
			if _G.MessagingHub then
				_G.MessagingHub.Publish("GlobalEvent", { Cancel = true, Event = args[1] })
			end
			EventSvc():CancelEvent(args[1])

		-- ============================================================
		-- SPAWN
		-- ============================================================
		elseif cmd == "spawnbrainrot" then
			local data = findAnimal(args[1])
			if not data then return end
			local mut = (args[2] == "Normal" or args[2] == "") and nil or args[2]
			for i = 1, math.clamp(tonumber(args[3]) or 1, 1, 100) do
				AnimalSvc().spawnAnimalCustom(data, mut, {}, nil, nil, nil)
				task.wait(0.05)
			end

		elseif cmd == "spawnglobalbrainrot" then
			local data, key = findAnimal(args[1])
			if not data then return end
			local mut = (args[2] == "Normal" or args[2] == "") and nil or args[2]
			local amt = math.clamp(tonumber(args[3]) or 1, 1, 100)
			for i = 1, amt do
				AnimalSvc().spawnAnimalCustom(data, mut, {}, nil, nil, nil)
				task.wait(0.05)
			end
			if _G.MessagingHub then
				_G.MessagingHub.Publish("GlobalBrainrotSpawn", {
					brainrot = key, amount = amt, mutation = mut,
					senderJobId = game.JobId
				})
			end

		elseif cmd == "addbrainrot" then
			local target = findPlayer(args[1])
			if not target then return end
			local data, key = findAnimal(args[2])
			if not data then return end
			local mut = (args[3] == "Normal" or args[3] == "") and nil or args[3]
			for i = 1, math.clamp(tonumber(args[4]) or 1, 1, 100) do
				AnimalSvc().spawnAnimalInBase(target, key, mut, {})
			end

		elseif cmd == "spawnluckyblock" then
			local Animals = require(RS.Datas.Animals)
			local data = Animals[args[1]]
			if not data then return end
			local mut = (args[2] == "Normal" or args[2] == "") and nil or args[2]
			for i = 1, math.clamp(tonumber(args[3]) or 1, 1, 20) do
				AnimalSvc().spawnAnimalCustom(data, mut, {}, nil, nil, nil)
				task.wait(0.05)
			end

		elseif cmd == "clearroad" then
			local folder = workspace:FindFirstChild("MovingAnimals")
			if folder then
				for _, m in ipairs(folder:GetChildren()) do m:Destroy() end
			end

		-- ============================================================
		-- JOUEURS
		-- ============================================================
		elseif cmd == "setmoney" then
			local target = findPlayer(args[1])
			if not target then return end
			MoneySvc():Set(target, tonumber(args[2]) or 0)

		elseif cmd == "givemoney" then
			local target = findPlayer(args[1])
			if not target then return end
			MoneySvc():Add(target, tonumber(args[2]) or 0)

		elseif cmd == "setrebirth" then
			local target = findPlayer(args[1])
			if not target then return end
			local ch = getSync(target)
			if ch then ch:Set("Rebirth", tonumber(args[2]) or 0) end

		elseif cmd == "addspins" then
			local target = findPlayer(args[1])
			if not target then return end
			local ch = getSync(target)
			if ch then ch:Increase("DivineSpinWheel.Spins", tonumber(args[2]) or 1) end

		elseif cmd == "setgoldcoins" then
			local target = findPlayer(args[1])
			if not target then return end
			local ch = getSync(target)
			if ch then ch:Set("StPatricksEvent.GoldCoins", tonumber(args[2]) or 0) end

		elseif cmd == "giveitem" then
			local target = findPlayer(args[1])
			if not target then return end
			local tool = RS.Items:FindFirstChild(args[2])
			if tool and tool:IsA("Tool") then
				tool:Clone().Parent = target:FindFirstChild("Backpack")
			end

		elseif cmd == "morph" then
			local target = findPlayer(args[1])
			if not target or not target.Character then return end
			local uid = pcall(function()
				return Players:GetUserIdFromNameAsync(args[2])
			end)
			local ok2, userId = pcall(function() return Players:GetUserIdFromNameAsync(args[2]) end)
			if ok2 and userId then
				local desc = Players:GetHumanoidDescriptionFromUserId(userId)
				target:LoadCharacter()
				task.wait(1)
				if target.Character then
					local hum = target.Character:FindFirstChildOfClass("Humanoid")
					if hum then hum:ApplyDescription(desc) end
				end
			end

		elseif cmd == "nukebase" then
			local target = findPlayer(args[1])
			if not target then return end
			local ch = getSync(target)
			if ch then
				local pods = ch:Get("AnimalPodiums") or {}
				for k in pairs(pods) do pods[k] = "Empty" end
				ch:Set("AnimalPodiums", pods)
				ch:Set("AnimalAddedOrRemoved", true)
			end

		elseif cmd == "kick" then
			local target = findPlayer(args[1])
			if target then target:Kick(args[2] or "Kicked by admin") end

		elseif cmd == "kickall" then
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= player then p:Kick(args[1] or "Server closed") end
			end

		elseif cmd == "freeze" then
			local target = findPlayer(args[1])
			if target and target.Character then
				for _, p in ipairs(target.Character:GetDescendants()) do
					if p:IsA("BasePart") then p.Anchored = true end
				end
			end

		elseif cmd == "unfreeze" then
			local target = findPlayer(args[1])
			if target and target.Character then
				for _, p in ipairs(target.Character:GetDescendants()) do
					if p:IsA("BasePart") then p.Anchored = false end
				end
			end

		-- ============================================================
		-- SERVEUR
		-- ============================================================
		elseif cmd == "addluck" then
			local luckSvc = LuckSvc()
			local Index = tonumber(args[1]) or 1
			local EndTime = luckSvc:GetEndTime()
			if EndTime ~= 0 then EndTime += 900
			else EndTime = workspace:GetServerTimeNow() + 900 end
			luckSvc:StartLuck(Index, EndTime)
			local notif = require(RS.Packages.Net):RemoteEvent("NotificationService/Notify")
			for _, pl in ipairs(Players:GetPlayers()) do
				notif:FireClient(pl, "Admin activated <font color='#79DD2F'>"..Index.."x Luck</font>!", 5, nil, "Top")
			end

		elseif cmd == "endluck" then
			LuckSvc():SetLuck(1)

		elseif cmd == "setspeed" then
			AnimalSvc().SetSpeed(tonumber(args[1]) or nil)

		elseif cmd == "settime" then
			game:GetService("Lighting").ClockTime = tonumber(args[1]) or 12

		-- ============================================================
		-- ANNONCES
		-- ============================================================
		elseif cmd == "announce" then
			local notif = require(RS.Packages.Net):RemoteEvent("NotificationService/Notify")
			for _, pl in ipairs(Players:GetPlayers()) do
				notif:FireClient(pl, args[1] or "", 5, nil, "Top")
			end

		elseif cmd == "globalannounce" then
			local notif = require(RS.Packages.Net):RemoteEvent("NotificationService/Notify")
			for _, pl in ipairs(Players:GetPlayers()) do
				notif:FireClient(pl, args[1] or "", 5, nil, "Top")
			end
			if _G.MessagingHub then
				_G.MessagingHub.Publish("GlobalAnnounce", { Text = args[1] })
			end

		elseif cmd == "rainbowannounce" then
			local text = "<rainbow>" .. (args[1] or "") .. "</rainbow>"
			local notif = require(RS.Packages.Net):RemoteEvent("NotificationService/Notify")
			for _, pl in ipairs(Players:GetPlayers()) do
				notif:FireClient(pl, text, 5, nil, "Top")
			end
			if _G.MessagingHub then
				_G.MessagingHub.Publish("RainbowAnnounce", { Text = args[1] })
			end

		elseif cmd == "zebraannounce" then
			local text = "<zebra>" .. (args[1] or "") .. "</zebra>"
			local notif = require(RS.Packages.Net):RemoteEvent("NotificationService/Notify")
			for _, pl in ipairs(Players:GetPlayers()) do
				notif:FireClient(pl, text, 5, nil, "Top")
			end

		elseif cmd == "goldannounce" then
			local text = '<font color="#FFD700">' .. (args[1] or "") .. "</font>"
			local notif = require(RS.Packages.Net):RemoteEvent("NotificationService/Notify")
			for _, pl in ipairs(Players:GetPlayers()) do
				notif:FireClient(pl, text, 5, nil, "Top")
			end

		elseif cmd == "ogannounce" then
			local text = '<font color="#FF4500">' .. (args[1] or "") .. "</font>"
			local notif = require(RS.Packages.Net):RemoteEvent("NotificationService/Notify")
			for _, pl in ipairs(Players:GetPlayers()) do
				notif:FireClient(pl, text, 5, nil, "Top")
			end

		elseif cmd == "playerannounce" then
			local target = findPlayer(args[1])
			if not target then return end
			local notif = require(RS.Packages.Net):RemoteEvent("NotificationService/Notify")
			notif:FireClient(target, args[2] or "", 5, nil, "Top")

		-- ============================================================
		-- POLLS
		-- ============================================================
		elseif cmd == "startpoll" then
			PollSvc().startPoll({
				question = args[1], option1 = args[2], option2 = args[3],
				option1colorHex = "2197ff", option2colorHex = "da261a",
				duration = tonumber(args[4]) or 30, allowSwitch = true
			})

		elseif cmd == "endpoll" then
			PollSvc().endActivePoll()

		elseif cmd == "startglobalpoll" then
			PollSvc().startGlobalPoll({
				question = args[1], option1 = args[2], option2 = args[3],
				option1colorHex = "2197ff", option2colorHex = "da261a",
				duration = tonumber(args[4]) or 30, allowSwitch = true
			})

		elseif cmd == "endglobalpoll" then
			PollSvc().endGlobalPoll()
		end
	end)

	if not ok then
		warn("[CustomAdmin] Error cmd '", cmd, "':", err)
	end
end)

Players.PlayerAdded:Connect(function(p)
	if isAdmin(p) then
		task.wait(3)
		if p and p.Parent then OpenUI:FireClient(p) end
	end
end)
