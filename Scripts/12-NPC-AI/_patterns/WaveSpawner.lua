-- WaveSpawner (pattern module, written for this library)
-- What it does: runs enemy waves on the server. Each wave has a total enemy budget, spawns in
-- batches at random spawn points up to a cap of enemies alive at once, and is "cleared" when every
-- enemy it spawned has died or been removed. Fires signals so a round script / UI can react.
--
-- Credit / ideas taken from:
--   zombie-outbreak-survival  Game Round + ZombieManager (count = base * wave * multiplier, spawn loop
--                             over tagged Spawner parts, alive registry cleaned on AncestryChanged)
--   smash-egg-for-animals     BossArenaServer           (boss every N waves via the Build hook)
--
-- Note: the original game let any client fire a "SetCustomMaxWave" remote. Keep wave control on the
-- server only (or check admin permissions) - never trust a client-sent wave number.
--
-- Usage (server Script):
--   local WaveSpawner = require(path.to.WaveSpawner)
--   local spawner = WaveSpawner.new({
--       Template = game.ServerStorage.Enemies.Zombie,      -- or Build = function(wave, index) return model end
--       SpawnTag = "EnemySpawn",                           -- CollectionService tag on spawn BaseParts
--       Parent = workspace.Enemies,
--       CountForWave = function(wave) return 6 + wave * 4 end,
--       MaxAlive = 20,
--   })
--   spawner.WaveStarted.Event:Connect(function(wave, total) print("Wave", wave, total) end)
--   spawner.WaveCleared.Event:Connect(function(wave) print("Cleared", wave) end)
--   for wave = 1, 10 do
--       if not spawner:RunWave(wave) then break end      -- yields until cleared (false if stopped)
--       task.wait(8)                                      -- intermission
--   end

local CollectionService = game:GetService("CollectionService")

local WaveSpawner = {}
WaveSpawner.__index = WaveSpawner

local DEFAULTS = {
	Template = nil :: Model?,
	Build = nil :: ((number, number) -> Model)?, -- (wave, index) -> new model, overrides Template
	SpawnTag = "EnemySpawn",
	Parent = workspace,
	CountForWave = function(wave: number): number
		return 10 * wave
	end,
	MaxAlive = 25,        -- never more than this many alive at once
	BatchSize = 2,        -- enemies per spawn point per tick
	SpawnInterval = 3,    -- seconds between spawn ticks
	SpawnOffset = Vector3.new(0, 3, 0),
	Configure = nil :: ((Model, number) -> ())?, -- e.g. scale health with the wave number
}

function WaveSpawner.new(config: { [string]: any })
	local self = setmetatable({}, WaveSpawner)
	self.Config = table.clone(DEFAULTS)
	for k, v in pairs(config) do
		self.Config[k] = v
	end
	assert(self.Config.Template or self.Config.Build, "WaveSpawner needs Template or Build")

	self.Wave = 0
	self.Alive = {} :: { [Model]: boolean }
	self.AliveCount = 0
	self._stopped = false

	self.WaveStarted = Instance.new("BindableEvent") -- (wave, total)
	self.EnemySpawned = Instance.new("BindableEvent") -- (model, wave)
	self.EnemyDied = Instance.new("BindableEvent") -- (model, remainingInWave)
	self.WaveCleared = Instance.new("BindableEvent") -- (wave)
	return self
end

function WaveSpawner:_spawnPoints(): { BasePart }
	local points = {}
	for _, inst in ipairs(CollectionService:GetTagged(self.Config.SpawnTag)) do
		if inst:IsA("BasePart") and inst:IsDescendantOf(workspace) then
			table.insert(points, inst)
		end
	end
	return points
end

function WaveSpawner:_track(model: Model, onGone: () -> ())
	self.Alive[model] = true
	self.AliveCount += 1
	local done = false
	local conns = {}
	local function gone()
		if done then
			return
		end
		done = true
		for _, c in ipairs(conns) do
			c:Disconnect()
		end
		self.Alive[model] = nil
		self.AliveCount -= 1
		onGone()
	end
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if humanoid then
		table.insert(conns, humanoid.Died:Connect(gone))
	end
	table.insert(conns, model.AncestryChanged:Connect(function(_, parent)
		if parent == nil then
			gone()
		end
	end))
end

function WaveSpawner:_make(wave: number, index: number): Model
	local cfg = self.Config
	if cfg.Build then
		return cfg.Build(wave, index)
	end
	return (cfg.Template :: Model):Clone()
end

-- Runs one wave and yields until every enemy of the wave is gone.
-- Returns true when cleared, false if Stop() was called.
function WaveSpawner:RunWave(wave: number): boolean
	local cfg = self.Config
	self.Wave = wave
	local total = math.max(1, math.floor(cfg.CountForWave(wave)))
	local spawned, remaining = 0, total
	local cleared = Instance.new("BindableEvent")

	self.WaveStarted:Fire(wave, total)

	local function onGone(model: Model)
		remaining -= 1
		self.EnemyDied:Fire(model, remaining)
		if remaining <= 0 and not self._stopped then
			cleared:Fire(true)
		end
	end

	local spawnThread = task.spawn(function()
		while spawned < total and not self._stopped do
			local points = self:_spawnPoints()
			if #points == 0 then
				warn("[WaveSpawner] no spawn points tagged " .. cfg.SpawnTag)
			end
			for _, point in ipairs(points) do
				for _ = 1, cfg.BatchSize do
					if spawned >= total or self.AliveCount >= cfg.MaxAlive or self._stopped then
						break
					end
					spawned += 1
					local model = self:_make(wave, spawned)
					model:PivotTo(point.CFrame + cfg.SpawnOffset)
					if cfg.Configure then
						cfg.Configure(model, wave)
					end
					model.Parent = cfg.Parent
					self:_track(model, function()
						onGone(model)
					end)
					self.EnemySpawned:Fire(model, wave)
				end
			end
			task.wait(cfg.SpawnInterval)
		end
	end)

	self._cancelWave = function()
		cleared:Fire(false)
	end
	local ok = cleared.Event:Wait()
	self._cancelWave = nil
	if coroutine.status(spawnThread) ~= "dead" then
		task.cancel(spawnThread)
	end
	cleared:Destroy()
	if ok then
		self.WaveCleared:Fire(wave)
	end
	return ok
end

-- Removes every alive enemy (e.g. when all players died) and makes RunWave return false.
function WaveSpawner:Stop()
	self._stopped = true
	if self._cancelWave then
		self._cancelWave()
	end
	for model in pairs(self.Alive) do
		model:Destroy()
	end
end

function WaveSpawner:Reset()
	self:Stop()
	self._stopped = false
	self.Wave = 0
end

function WaveSpawner:Destroy()
	self:Stop()
	self.WaveStarted:Destroy()
	self.EnemySpawned:Destroy()
	self.EnemyDied:Destroy()
	self.WaveCleared:Destroy()
end

return WaveSpawner
