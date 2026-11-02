--!strict
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local EventService = require(script.Parent.EventService)

export type LuckData = {
	Index: number?,
	EndTime: number?,
}

local LuckService = {}
local luck: any
local Running = false
local Initialized = false

local function ensureLuck()
	if not luck then
		luck = Synchronizer:Get("ServerLuck") or Synchronizer:Create("ServerLuck", {Index = nil, EndTime = nil})
	end
	return luck
end

function LuckService:SetLuck(index: number)
	local l = ensureLuck()
	l:Set("Index", index)
end

function LuckService:GetLuck(): number?
	local l = ensureLuck()
	return l:Get("Index")
end

function LuckService:GetEndTime(): number?
	local l = ensureLuck()
	return l:Get("EndTime")
end

function LuckService:AddTime(seconds: number)
	local l = ensureLuck()
	local current = Workspace:GetServerTimeNow()
	local endTime = l:Get("EndTime") or 0
	local new = math.max(endTime + seconds, current)
	l:Set("EndTime", new)
end

function LuckService:ReduceTime(seconds: number)
	local l = ensureLuck()
	local current = Workspace:GetServerTimeNow()
	local endTime = l:Get("EndTime") or 0
	local new = math.max(endTime - seconds, current)
	l:Set("EndTime", new)
end

function LuckService:ResetLuck()
	local l = ensureLuck()
	l:Set("Index", nil)
	l:Set("EndTime", nil)
end

function LuckService:StartLuck(index: number, duration: number)
	local l = ensureLuck()
	local now = Workspace:GetServerTimeNow()
	local endTime = now + duration
	l:Set("Index", index)
	l:Set("EndTime", endTime)


	if not Running then
		Running = true
		RunService.Heartbeat:Connect(function()
			local current = Workspace:GetServerTimeNow()
			local stored = l:Get("EndTime") or 0
			if stored > 0 and current >= stored then
				l:Set("Index", nil)
				l:Set("EndTime", nil)
				Running = false
			end
		end)
	end
end


function LuckService:IsActive(): boolean
	if not Initialized then return false end
	local l = ensureLuck()
	local now = Workspace:GetServerTimeNow()
	local endTime = l:Get("EndTime") or 0
	return endTime > now and (l:Get("Index") or 0) > 0
end

function LuckService:GetRemainingTime(): number
	local l = ensureLuck()
	local now = Workspace:GetServerTimeNow()
	return math.max((l:Get("EndTime") or 0) - now, 0)
end

function LuckService:GetFormattedTime(): string
	local remaining = LuckService:GetRemainingTime()
	local minutes = math.floor(remaining / 60)
	local seconds = math.floor(remaining % 60)
	return string.format("%02d:%02d", minutes, seconds)
end

function LuckService:BroadcastStatus()
	local l = ensureLuck()
	for _, player in ipairs(Players:GetPlayers()) do
		l:AddListener(player)
	end
end

Players.PlayerAdded:Connect(function(player)
	local l = ensureLuck()
	l:AddListener(player)
end)

function LuckService:Start()
	if Initialized then return end
	ensureLuck()
	Initialized = true
	RunService.Heartbeat:Connect(function()
		if LuckService:IsActive() then
			LuckService:BroadcastStatus()
		end
	end)
end

return LuckService
