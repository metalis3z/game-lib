-- Reference copy for study. Game: Aura Ascension (UPD 3) (aura-ascension)
-- Original: ServerScriptService/GameServer/Services/AdminService.lua  (147 lines)
-- What it does: Admin check by UserIds or group rank (from a config module), per-admin rate limit, an AllowedCommands whitelist, structured payloads, and an audit log of who ran what.

local Players = game:GetService("Players")

local AdminConfig = require(script.Parent.Parent.Config.AdminConfig)
local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local RateLimiter = require(script.Parent.Parent.Core.RateLimiter)
local TableUtil = require(script.Parent.Parent.Core.TableUtil)

local AdminService = {}
AdminService.__index = AdminService

function AdminService.new()
	return setmetatable({
		RateLimiter = RateLimiter.new(),
		AuditLog = {},
	}, AdminService)
end

function AdminService:Init(registry)
	self.Registry = registry
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.RemoteBinder:BindFunction("AdminService", "GetAdminState", function(player)
		return self:GetAdminState(player)
	end)
	self.RemoteBinder:BindFunction("AdminService", "RunCommand", function(player, payload)
		return self:RunCommand(player, payload)
	end)
end

function AdminService:_isAdmin(player)
	if AdminConfig.UserIds[player.UserId] == true then
		return true
	end
	if AdminConfig.GroupId and AdminConfig.MinimumGroupRank then
		local success, rank = pcall(function()
			return player:GetRankInGroup(AdminConfig.GroupId)
		end)
		if success and rank >= AdminConfig.MinimumGroupRank then
			return true
		end
	end
	return false
end

function AdminService:_pushAudit(entry)
	table.insert(self.AuditLog, 1, entry)
	while #self.AuditLog > AdminConfig.MaxAuditEntries do
		table.remove(self.AuditLog)
	end
	self.RemoteBinder:FireAll("AdminService", "AuditLogUpdated", TableUtil.DeepCopy(self.AuditLog))
end

function AdminService:GetAdminState(player)
	return {
		IsAdmin = self:_isAdmin(player),
		AuditLog = self:_isAdmin(player) and TableUtil.DeepCopy(self.AuditLog) or {},
	}
end

function AdminService:_resolveTarget(targetValue)
	if typeof(targetValue) == "Instance" and targetValue:IsA("Player") then
		return targetValue
	end
	if type(targetValue) == "number" then
		return Players:GetPlayerByUserId(targetValue)
	end
	if type(targetValue) == "string" then
		local lowered = string.lower(targetValue)
		for _, player in ipairs(Players:GetPlayers()) do
			if string.lower(player.Name) == lowered or string.lower(player.DisplayName) == lowered then
				return player
			end
		end
	end
	return nil
end

function AdminService:RunCommand(player, payload)
	if not self:_isAdmin(player) then
		return { ok = false, reason = "UNAUTHORIZED" }
	end
	local allowed = self.RateLimiter:Allow(player, "RunCommand", GameConfig.RateLimits.AdminCommand)
	if not allowed then
		return { ok = false, reason = "RATE_LIMITED" }
	end
	if type(payload) ~= "table" then
		return { ok = false, reason = "INVALID_PAYLOAD" }
	end
	local command = tostring(payload.Command or "")
	if AdminConfig.AllowedCommands[command] ~= true then
		return { ok = false, reason = "COMMAND_BLOCKED" }
	end
	local target = self:_resolveTarget(payload.Target)
	local result
	if command == "grant_aura" then
		if not target then
			return { ok = false, reason = "TARGET_NOT_FOUND" }
		end
		local amount = math.max(0, math.floor(tonumber(payload.Amount) or 0))
		local awarded = self.Registry:Get("PlayerService"):AddAura(target, amount, "Admin")
		result = { ok = awarded > 0, awarded = awarded }
	elseif command == "grant_rebirths" then
		if not target then
			return { ok = false, reason = "TARGET_NOT_FOUND" }
		end
		local amount = math.max(0, math.floor(tonumber(payload.Amount) or 0))
		self.Registry:Get("DataService"):Mutate(target, function(data)
			data.Stats.Rebirths += amount
		end)
		self.Registry:Get("PlayerService"):SyncReplicatedState(target)
		result = { ok = true, granted = amount }
	elseif command == "grant_pose" then
		if not target then
			return { ok = false, reason = "TARGET_NOT_FOUND" }
		end
		local success, reason = self.Registry:Get("PoseService"):GrantPoseById(target, tostring(payload.PoseId or ""))
		if success then
			self.Registry:Get("PoseService"):PushPoseData(target)
		end
		result = { ok = success, reason = reason }
	elseif command == "grant_pack" then
		if not target then
			return { ok = false, reason = "TARGET_NOT_FOUND" }
		end
		local success, reason = self.Registry:Get("PackService"):GrantPackById(target, tostring(payload.PackId or ""))
		result = { ok = success, reason = reason }
	elseif command == "broadcast" then
		local message = tostring(payload.Message or "SERVER NOTICE")
		self.Registry:Get("TrainingAreasService"):BroadcastCursedZone(message, payload.NotificationType or "SuccessNotification")
		result = { ok = true }
	elseif command == "force_cursed_zone" then
		self.Registry:Get("CursedZoneService"):ForceActive(payload.Active ~= false)
		result = { ok = true, active = payload.Active ~= false }
	else
		result = { ok = false, reason = "UNKNOWN_COMMAND" }
	end
	self:_pushAudit({
		IssuedBy = player.Name,
		Command = command,
		Target = target and target.Name or tostring(payload.Target),
		At = os.time(),
		Success = result and result.ok == true,
	})
	self.RemoteBinder:FireClient("AdminService", "CommandResult", player, result)
	return result
end

return AdminService
