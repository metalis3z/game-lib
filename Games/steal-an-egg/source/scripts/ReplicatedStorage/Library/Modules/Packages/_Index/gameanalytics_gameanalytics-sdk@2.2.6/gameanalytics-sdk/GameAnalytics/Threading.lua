-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	_canSafelyClose = true,
	_endThread = false,
	_isRunning = false,
	_scheduledBlock = nil,
	_hasScheduledBlockRun = true,
	_blocks = {}
}
local Logger = require(script.Parent.Logger)
local RunService = game:GetService("RunService")

local function getScheduledBlock() --[[ getScheduledBlock | Line: 13 | Upvalues: t (copy) ]]
	if t._hasScheduledBlockRun or (t._scheduledBlock == nil or not (t._scheduledBlock.deadline <= tick())) then
		return nil
	end

	t._hasScheduledBlockRun = true

	return t._scheduledBlock
end

local function run() --[[ run | Line: 28 | Upvalues: Logger (copy), t (copy), RunService (copy) ]]
	task.spawn(function() --[[ Line: 29 | Upvalues: Logger (ref), t (ref) ]]
		Logger:d("Starting GA thread")

		while not t._endThread do
			local v1

			t._canSafelyClose = false

			if #t._blocks ~= 0 then
				for k, v in pairs(t._blocks) do
					local ok, result = pcall(v.block)

					if not ok then
						Logger:e(result)
					end
				end

				t._blocks = {}
			end

			if t._hasScheduledBlockRun or (t._scheduledBlock == nil or not (t._scheduledBlock.deadline <= tick())) then
				v1 = nil
			else
				t._hasScheduledBlockRun = true
				v1 = t._scheduledBlock
			end

			if v1 ~= nil then
				local ok, result = pcall(v1.block)

				if not ok then
					Logger:e(result)
				end
			end

			t._canSafelyClose = true
			task.wait(1)
		end

		Logger:d("GA thread stopped")
	end)
	game:BindToClose(function() --[[ Line: 62 | Upvalues: RunService (ref), t (ref) ]]
		if RunService:IsStudio() then
			return
		end

		task.wait(1)

		if not t._canSafelyClose then
			repeat
				task.wait()
			until t._canSafelyClose
		end

		task.wait(3)
	end)
end

function t.scheduleTimer(p1, p2, p3) --[[ scheduleTimer | Line: 82 | Upvalues: run (copy) ]]
	if p1._endThread then
		return
	end

	if not p1._isRunning then
		p1._isRunning = true
		run()
	end

	local t = {
		block = p3,
		deadline = tick() + p2
	}

	if not p1._hasScheduledBlockRun then
		return
	end

	p1._scheduledBlock = t
	p1._hasScheduledBlockRun = false
end
function t.performTaskOnGAThread(p1, p2) --[[ performTaskOnGAThread | Line: 103 | Upvalues: run (copy) ]]
	if p1._endThread then
		return
	end

	if not p1._isRunning then
		p1._isRunning = true
		run()
	end

	p1._blocks[#p1._blocks + 1] = {
		block = p2
	}
end
function t.stopThread(p1) --[[ stopThread | Line: 120 ]]
	p1._endThread = true
end

return t