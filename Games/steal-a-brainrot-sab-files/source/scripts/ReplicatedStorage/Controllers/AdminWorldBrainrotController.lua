-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local WorldBrainrotController = require(ReplicatedStorage.Controllers.WorldBrainrotController)

local POOL_ID = "Admin/Spawned"

local AdminWorldBrainrotController = {}

local renderTrove = nil

local function toSafeName(poolId)
	return poolId:gsub("[/\\%s]", "_")
end

local function getPoolFolder()
	local poolsRoot = Workspace:FindFirstChild("WBPools")
	if not poolsRoot then return nil end
	return poolsRoot:FindFirstChild(toSafeName(POOL_ID))
end

function AdminWorldBrainrotController:Start()
	local function startRendering()
		local poolFolder = getPoolFolder()
		if not poolFolder then
			local poolsRoot = Workspace:WaitForChild("WBPools", 10)
			if poolsRoot then
				poolFolder = poolsRoot:WaitForChild(toSafeName(POOL_ID), 10)
			end
		end

		local showTimer = true
		local showDropButton = true

		if poolFolder then
			local timerAttr = poolFolder:GetAttribute("ShowTimer")
			local dropBtnAttr = poolFolder:GetAttribute("ShowDropButton")

			if timerAttr ~= nil then
				showTimer = timerAttr
			end
			if dropBtnAttr ~= nil then
				showDropButton = dropBtnAttr
			end
		end

		renderTrove = WorldBrainrotController:RenderPool({
			PoolId = POOL_ID,
			ShowTimer = showTimer,
			ShowDropButton = showDropButton,
			GrabHoldDuration = 2,
			GrabMaxDistance = 10,
			RenderedBrainrots = {},
		})
	end

	task.spawn(startRendering)
end

function AdminWorldBrainrotController:Stop()
	if renderTrove then
		renderTrove:Destroy()
		renderTrove = nil
	end
end

return AdminWorldBrainrotController