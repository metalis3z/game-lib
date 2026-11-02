local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local AdminCommands = require(ReplicatedStorage.Datas.AdminCommands)
local DataService = require(ServerScriptService.Services.DataService)

local AdminPanelService = {}
AdminPanelService.__index = AdminPanelService

local playerCooldowns = {}

local ADMINS = {
	[10270273034] = true,
	[5676913539] = false
}

function AdminPanelService.new()
	local self = setmetatable({}, AdminPanelService)

	self._placeCooldownEvent = Net:RemoteEvent("AdminPanelService/PlaceCooldownFromChat")
	self._executeCommandEvent = Net:RemoteEvent("AdminPanelService/ExecuteCommand")
	self._dealWithThisEvent = Net:RemoteEvent("AdminPanelService/DealWithThis")
	self._openUIEvent = Net:RemoteEvent("AdminPanelService/OpenUI")

	self._commandModules = {
		jail = require(script.CommandModules.JailCommand),
		morph = require(script.CommandModules.MorphCommand),
		ragdoll = require(script.CommandModules.RagdollCommand),
		rocket = require(script.CommandModules.RocketCommand),
		tiny = require(script.CommandModules.TinyCommand),
		control = require(script.CommandModules.ControlCommand),
		balloon = require(script.CommandModules.BalloonCommand),
	}

	self:_setupEventHandlers()
	self:_setupPlayerHandlers()
	self:_setupPlayerCleanup()

	return self
end

-- 🔐 ПРОВЕРКА АДМИНА
function AdminPanelService:_hasAdminAccess(player: Player): boolean
	return ADMINS[player.UserId] == true
end

function AdminPanelService:_setAdminAttribute(player: Player)
	player:SetAttribute("AdminCommands", self:_hasAdminAccess(player))
end

-- ⏱️ COOLDOWN
function AdminPanelService:_isOnCooldown(player: Player, commandName: string): boolean
	local data = playerCooldowns[player.UserId]
	if not data then return false end

	local expireTime = data[commandName]
	if not expireTime then return false end

	return os.clock() < expireTime
end

function AdminPanelService:_setCooldown(player: Player, commandName: string, duration: number)
	playerCooldowns[player.UserId] = playerCooldowns[player.UserId] or {}
	playerCooldowns[player.UserId][commandName] = os.clock() + duration
end

-- 🎮 КОМАНДЫ
function AdminPanelService:_setupEventHandlers()
	self._executeCommandEvent.OnServerEvent:Connect(function(executor: Player, targetPlayer: Player, commandName: string)
		if not self:_hasAdminAccess(executor) then
			warn("[AdminPanelService] Non-admin tried command:", executor.Name)
			return
		end

		if not targetPlayer or not Players:FindFirstChild(targetPlayer.Name) then
			warn("[AdminPanelService] Invalid target")
			return
		end

		local command = AdminCommands[commandName]
		if not command then
			warn("[AdminPanelService] Unknown command:", commandName)
			return
		end

		if self:_isOnCooldown(executor, commandName) then
			return
		end

		if commandName == "control" and executor == targetPlayer then
			Net:RemoteEvent("NotificationService/Notify")
				:FireClient(executor, '<font color="#FA0103">You can\'t use this on yourself!</font>', 5)
			return
		end

		self:_setCooldown(executor, commandName, command.cooldown or 0)
		self._placeCooldownEvent:FireClient(executor, commandName)

		local notify = Net:RemoteEvent("NotificationService/Notify")
		notify:FireClient(
			executor,
			string.format('<font color="#92FF67">"%s" executed on %s</font>', commandName, targetPlayer.Name),
			5
		)

		notify:FireClient(
			targetPlayer,
			string.format('%s used "%s" on you! %s', executor.Name, commandName, command.description or ""),
			5
		)

		if self._commandModules[commandName] then
			self._commandModules[commandName]:Execute(executor, targetPlayer)
		end

		if command.effects then
			if command.effects.Victim then
				self._dealWithThisEvent:FireClient(targetPlayer, commandName, "Victim", targetPlayer)
			end
			if command.effects.Executor then
				self._dealWithThisEvent:FireClient(executor, commandName, "Executor", targetPlayer)
			end
		end
	end)
end

-- 👤 ИГРОКИ
function AdminPanelService:_setupPlayerHandlers()
	local function handlePlayer(player: Player)
		task.wait(1) -- данные тут не нужны, просто даём серверу прогрузиться
		if player.Parent then
			self:_setAdminAttribute(player)
		end
	end

	Players.PlayerAdded:Connect(handlePlayer)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(handlePlayer, player)
	end
end

-- 🧹 CLEANUP
function AdminPanelService:_setupPlayerCleanup()
	Players.PlayerRemoving:Connect(function(player)
		playerCooldowns[player.UserId] = nil
	end)
end

-- 🖥️ ОТКРЫТИЕ АДМИНКИ
function AdminPanelService:OpenAdminPanel(player: Player)
	if not self:_hasAdminAccess(player) then return end
	self._openUIEvent:FireClient(player)
end

-- 🌍 PUBLIC API
function AdminPanelService:HasAdminAccess(player: Player): boolean
	return self:_hasAdminAccess(player)
end

function AdminPanelService:RefreshAdminStatus(player: Player)
	self:_setAdminAttribute(player)
end

local adminPanelService = AdminPanelService.new()

_G.OpenAdminPanel = function(player: Player)
	adminPanelService:OpenAdminPanel(player)
end

return adminPanelService
