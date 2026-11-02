-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local FlowGame = require(script.FlowGame)

require(script.FlowGame.Settings)

local LocalPlayer = Players.LocalPlayer
local t = {}

t.__index = t

local function resetGrid(p1) --[[ resetGrid | Line: 50 ]]
	for i, v in ipairs(p1.Container.GridHolder.Grid:GetChildren()) do
		if not v:IsA("UIGridLayout") then
			v:Destroy()
		end
	end
end

local function resetProgress(p1) --[[ resetProgress | Line: 59 ]]
	p1.Container.Progress.CanvasGroup.Frame.Size = UDim2.fromScale(1, 0)
end

local function getPuzzleUI(p1) --[[ getPuzzleUI | Line: 63 | Upvalues: LocalPlayer (copy) ]]
	local puzzleUI = p1.puzzleUI

	if puzzleUI and puzzleUI.Parent == LocalPlayer.PlayerGui then
		return puzzleUI
	end

	local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

	PuzzleUI.Enabled = false
	PuzzleUI.Container.Visible = false
	p1.puzzleUI = PuzzleUI

	return PuzzleUI
end

local function ensurePuzzleUITabOpen(p1) --[[ ensurePuzzleUITabOpen | Line: 77 | Upvalues: LocalPlayer (copy), TabController (copy) ]]
	local puzzleUI = p1.puzzleUI
	local v1

	if puzzleUI and puzzleUI.Parent == LocalPlayer.PlayerGui then
		v1 = puzzleUI
	else
		local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

		PuzzleUI.Enabled = false
		PuzzleUI.Container.Visible = false
		p1.puzzleUI = PuzzleUI
		v1 = PuzzleUI
	end

	if TabController.IsOpen("PuzzleUI") then
		v1.Enabled = true
	else
		TabController.OpenTab("PuzzleUI")
	end

	return v1
end

local function resetPuzzleUI(p1) --[[ resetPuzzleUI | Line: 88 | Upvalues: LocalPlayer (copy), resetGrid (copy) ]]
	local puzzleUI = p1.puzzleUI
	local v1

	if puzzleUI and puzzleUI.Parent == LocalPlayer.PlayerGui then
		v1 = puzzleUI
	else
		local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

		PuzzleUI.Enabled = false
		PuzzleUI.Container.Visible = false
		p1.puzzleUI = PuzzleUI
		v1 = PuzzleUI
	end

	resetGrid(v1)
	v1.Container.Progress.CanvasGroup.Frame.Size = UDim2.fromScale(1, 0)
	v1.Container.Visible = false
	v1.Container.Size = UDim2.fromScale(0, 0)
	v1.Container.Tutorial.Visible = false
end

local function clearActiveGame(p1, p2) --[[ clearActiveGame | Line: 97 ]]
	local activeGame = p1.activeGame

	if not activeGame then
		return
	end

	if not p2 or activeGame.id == p2 then
		p1.activeGame = nil
	end
end

function t.new() --[[ new | Line: 111 | Upvalues: t (copy), TabController (copy), LocalPlayer (copy), resetGrid (copy) ]]
	local v2 = setmetatable({}, t)

	v2.activeGame = nil
	v2.completedBindable = Instance.new("BindableEvent")
	v2.Completed = v2.completedBindable.Event
	v2.puzzleUI = nil
	v2.manualCloseGameId = nil
	TabController.AddCloseListener(function(p1) --[[ Line: 119 | Upvalues: v2 (copy), LocalPlayer (ref), resetGrid (ref) ]]
		if p1 ~= "PuzzleUI" then
			return
		end

		local activeGame = v2.activeGame

		if activeGame then
			local id = activeGame.id

			v2.manualCloseGameId = id
			activeGame:EndGame(false)

			local v1 = v2
			local activeGame2 = v1.activeGame

			if activeGame2 and (not id or activeGame2.id == id) then
				v1.activeGame = nil
			end

			local v22 = v2
			local puzzleUI = v22.puzzleUI
			local v3

			if puzzleUI and puzzleUI.Parent == LocalPlayer.PlayerGui then
				v3 = puzzleUI
			else
				local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

				PuzzleUI.Enabled = false
				PuzzleUI.Container.Visible = false
				v22.puzzleUI = PuzzleUI
				v3 = PuzzleUI
			end

			resetGrid(v3)
			v3.Container.Progress.CanvasGroup.Frame.Size = UDim2.fromScale(1, 0)
			v3.Container.Visible = false
			v3.Container.Size = UDim2.fromScale(0, 0)
			v3.Container.Tutorial.Visible = false
		else
			local v4 = v2
			local puzzleUI = v4.puzzleUI
			local v5

			if puzzleUI and puzzleUI.Parent == LocalPlayer.PlayerGui then
				v5 = puzzleUI
			else
				local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

				PuzzleUI.Enabled = false
				PuzzleUI.Container.Visible = false
				v4.puzzleUI = PuzzleUI
				v5 = PuzzleUI
			end

			resetGrid(v5)
			v5.Container.Progress.CanvasGroup.Frame.Size = UDim2.fromScale(1, 0)
			v5.Container.Visible = false
			v5.Container.Size = UDim2.fromScale(0, 0)
			v5.Container.Tutorial.Visible = false
		end
	end)

	return v2
end
function t.startGame(p1, p2, p3) --[[ startGame | Line: 140 | Upvalues: LocalPlayer (copy), resetGrid (copy), TabController (copy), FlowGame (copy) ]]
	if p1.activeGame then
		p1.activeGame:EndGame(false)
		p1.activeGame = nil
	end

	local puzzleUI = p1.puzzleUI
	local v1

	if puzzleUI and puzzleUI.Parent == LocalPlayer.PlayerGui then
		v1 = puzzleUI
	else
		local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

		PuzzleUI.Enabled = false
		PuzzleUI.Container.Visible = false
		p1.puzzleUI = PuzzleUI
		v1 = PuzzleUI
	end

	resetGrid(v1)
	v1.Container.Progress.CanvasGroup.Frame.Size = UDim2.fromScale(1, 0)
	v1.Container.Visible = false
	v1.Container.Size = UDim2.fromScale(0, 0)
	v1.Container.Tutorial.Visible = false

	local puzzleUI2 = p1.puzzleUI
	local v2

	if puzzleUI2 and puzzleUI2.Parent == LocalPlayer.PlayerGui then
		v2 = puzzleUI2
	else
		local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

		PuzzleUI.Enabled = false
		PuzzleUI.Container.Visible = false
		p1.puzzleUI = PuzzleUI
		v2 = PuzzleUI
	end

	if TabController.IsOpen("PuzzleUI") then
		v2.Enabled = true
	else
		TabController.OpenTab("PuzzleUI")
	end

	if LocalPlayer:GetAttribute("CompletedGenPuzzle") then
		v2.Container.Tutorial.Visible = false
		v2.Container.Position = UDim2.fromScale(0.5, 0.5)
	else
		v2.Container.Tutorial.Visible = true
		v2.Container.Position = UDim2.fromScale(0.5, 0.55)
	end

	local v4 = FlowGame.new(v2, p2, p3)

	v4.completedEvent = Instance.new("BindableEvent")

	local completedEvent = v4.completedEvent

	assert(completedEvent, "Expected completed event after FlowGame start")
	completedEvent.Event:Once(function(p12) --[[ Line: 163 | Upvalues: p1 (copy), v4 (copy) ]]
		local v1 = if p12 == "leaveGenerator" and p1.manualCloseGameId == v4.id then "manualClose" else p12

		if p1.manualCloseGameId == v4.id then
			p1.manualCloseGameId = nil
		end

		local v2 = p1
		local id = v4.id
		local activeGame = v2.activeGame

		if activeGame and (not id or activeGame.id == id) then
			v2.activeGame = nil
		end

		p1.completedBindable:Fire(v1)
	end)
	p1.activeGame = v4
end
function t.endGame(p1, p2) --[[ endGame | Line: 180 | Upvalues: TabController (copy), LocalPlayer (copy), resetGrid (copy) ]]
	local activeGame = p1.activeGame

	if activeGame then
		if p2 and activeGame.id ~= p2 then
			return
		end

		activeGame:EndGame(false)
		p1.activeGame = nil
		TabController.CloseTab()

		local puzzleUI = p1.puzzleUI
		local v1

		if puzzleUI and puzzleUI.Parent == LocalPlayer.PlayerGui then
			v1 = puzzleUI
		else
			local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

			PuzzleUI.Enabled = false
			PuzzleUI.Container.Visible = false
			p1.puzzleUI = PuzzleUI
			v1 = PuzzleUI
		end

		resetGrid(v1)
		v1.Container.Progress.CanvasGroup.Frame.Size = UDim2.fromScale(1, 0)
		v1.Container.Visible = false
		v1.Container.Size = UDim2.fromScale(0, 0)
		v1.Container.Tutorial.Visible = false
	else
		TabController.CloseTab()

		local puzzleUI = p1.puzzleUI
		local v2

		if puzzleUI and puzzleUI.Parent == LocalPlayer.PlayerGui then
			v2 = puzzleUI
		else
			local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

			PuzzleUI.Enabled = false
			PuzzleUI.Container.Visible = false
			p1.puzzleUI = PuzzleUI
			v2 = PuzzleUI
		end

		resetGrid(v2)
		v2.Container.Progress.CanvasGroup.Frame.Size = UDim2.fromScale(1, 0)
		v2.Container.Visible = false
		v2.Container.Size = UDim2.fromScale(0, 0)
		v2.Container.Tutorial.Visible = false
	end
end
function t.SetProgress(p1, p2, p3) --[[ SetProgress | Line: 198 | Upvalues: LocalPlayer (copy) ]]
	local puzzleUI = p1.puzzleUI
	local v1

	if puzzleUI and puzzleUI.Parent == LocalPlayer.PlayerGui then
		v1 = puzzleUI
	else
		local PuzzleUI = LocalPlayer.PlayerGui:WaitForChild("PuzzleUI")

		PuzzleUI.Enabled = false
		PuzzleUI.Container.Visible = false
		p1.puzzleUI = PuzzleUI
		v1 = PuzzleUI
	end

	v1.Container.Progress.CanvasGroup.Frame.Size = UDim2.fromScale(1, (math.clamp(p2 / math.max(p3, 1), 0, 1)))
end

return t.new()