--[[
	AnimatedTextController
	Applies the devexfire.com per-character text animation game-wide:
	- every current and future TextLabel / TextButton in PlayerGui
	  (cash, income, bars, names, notifications, shop prices...)
	- every label on world-space guis in workspace (drill layer HP bars,
	  podium overheads, storage billboards...)
	Also watches PlayerGui progress-bar FILLS (frames named ProgressFrame /
	ProgressBar / Fill): when a fill's Size scale grows, the bar container
	does the same smooth pulse growing numbers get (AnimatedText.Pop).

	Opt a label (or a whole frame) out by setting attribute AT_Ignore = true.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimatedText = require(ReplicatedStorage.Source.Modules.AnimatedText)

local AnimatedTextController = {}

-- ===== growing progress bars -> container pulse =====
local BAR_FILL_NAMES = { progressframe = true, progressbar = true, fill = true }
local BAR_POP = 1.08
local BAR_POP_DEBOUNCE = 0.4 -- fill tweens fire Size per frame; pop at most this often

local barBound = setmetatable({}, { __mode = "k" })

local function bindBarFill(f)
	if barBound[f] then return end
	if f:GetAttribute("AT_Ignore") then return end
	barBound[f] = true
	local lastX, lastY = f.Size.X.Scale, f.Size.Y.Scale
	local lastPop = 0
	f:GetPropertyChangedSignal("Size"):Connect(function()
		local x, y = f.Size.X.Scale, f.Size.Y.Scale
		local grewNow = x > lastX + 1e-4 or y > lastY + 1e-4
		lastX, lastY = x, y
		if grewNow and f.Parent then
			local now = os.clock()
			if now - lastPop >= BAR_POP_DEBOUNCE then
				lastPop = now
				AnimatedText.Pop(f.Parent, BAR_POP)
			end
		end
	end)
end

local function tryBarFill(inst)
	if inst:IsA("Frame") and BAR_FILL_NAMES[inst.Name:lower()] then
		bindBarFill(inst)
	end
end

function AnimatedTextController.Init()
	local player = Players.LocalPlayer
	if not player then return end
	local playerGui = player:WaitForChild("PlayerGui")
	AnimatedText.BindAll(playerGui)
	AnimatedText.BindWorldGuis(workspace)
	for _, d in ipairs(playerGui:GetDescendants()) do
		tryBarFill(d)
	end
	playerGui.DescendantAdded:Connect(tryBarFill)
end

return AnimatedTextController
