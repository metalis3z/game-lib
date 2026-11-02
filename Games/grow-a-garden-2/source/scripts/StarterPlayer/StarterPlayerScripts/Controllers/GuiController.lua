--credit to leon games studio
({}).StartOrder = 3

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local FieldOfViewController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Signal = require(ReplicatedStorage.ClientModules.Signal)
local t = {}
local t2 = { "TeleportButtons", "GrowingList", "PetList", "BackpackGui", "HUD", "MushroomUI" }
local Blur = Lighting.Blur
local CurrentCamera = workspace.CurrentCamera
local v1 = Signal.new()
local v2 = Signal.new()
local v3 = Signal.new()
local t3 = {
	_Locked = false,
	Gui = nil,
	GuiFocusedSignal = v2,
	GuiUnfocusedSignal = v1,
	GuiHiddenSignal = v3
}

local function SetHudGuisEnabled(p1, p2) --[[ SetHudGuisEnabled | Line: 78 | Upvalues: t2 (copy), PlayerGui (copy) ]]
	for v1, v2 in t2 do
		if p1 or not (p2 and table.find(p2, v2)) then
			local v3 = PlayerGui:FindFirstChild(v2)

			if v3 and v3.Name ~= "TouchGui" then
				v3.Enabled = p1
			end
		end
	end
end

function t3.Unlock(p1) --[[ Unlock | Line: 99 ]]
	p1._Locked = false
end
function t3.Lock(p1) --[[ Lock | Line: 106 ]]
	p1._Locked = true
end
function t3.IsOpen(p1, p2) --[[ IsOpen | Line: 113 | Upvalues: PlayerGui (copy) ]]
	local v1 = PlayerGui:FindFirstChild(p2)

	if not v1 then
		return false
	end

	if p1.Gui == v1 then
		return true
	end

	return v1.Enabled
end
function t3.Close(p1, p2) --[[ Close | Line: 130 | Upvalues: t2 (copy), PlayerGui (copy), v1 (copy), TweenService (copy), Blur (copy), FieldOfViewController (copy) ]]
	if p2 then
		p1._Locked = false
	elseif p1._Locked then
		return
	end

	local Gui = p1.Gui

	if not Gui then
		return
	end

	Gui.Enabled = false
	p1.Gui = nil

	for v12, v2 in t2 do
		local v3 = PlayerGui:FindFirstChild(v2)

		if v3 and v3.Name ~= "TouchGui" then
			v3.Enabled = true
		end
	end

	v1:Fire(Gui)
	TweenService:Create(Blur, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = 0
	}):Play()
	FieldOfViewController:SetBaseFOV(70)
end
function t3.Open(p1, p2, p3, p4) --[[ Open | Line: 153 | Upvalues: PlayerGui (copy), t2 (copy), v2 (copy), TweenService (copy), Blur (copy), FieldOfViewController (copy) ]]
	if p3 then
		p1._Locked = false
	elseif p1._Locked then
		return
	end

	local v1 = PlayerGui:FindFirstChild(p2)

	if not v1 then
		return
	end

	if not v1:IsA("ScreenGui") then
		return
	end

	if p1.Gui then
		p1:Close(p3)
	end

	p1.Gui = v1

	if p1.Gui then
		p1.Gui.Enabled = true
	end

	local v22 = p4 or nil

	for v3, v4 in t2 do
		if not (v22 and table.find(v22, v4)) then
			local v5 = PlayerGui:FindFirstChild(v4)

			if v5 and v5.Name ~= "TouchGui" then
				v5.Enabled = false
			end
		end
	end

	v2:Fire(v1)
	TweenService:Create(Blur, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = 20
	}):Play()
	FieldOfViewController:SetBaseFOV(60)
end
function t3.Hook(p1, p2, ...) --[[ Hook | Line: 191 | Upvalues: t (copy) ]]
	local v1 = t[p2]

	if v1 then
		return v1.new(...)
	end
end
function t3.SetHUDVisibility(p1, p2) --[[ SetHUDVisibility | Line: 203 | Upvalues: v3 (copy) ]]
	v3:Fire(p2)
end
function t3.SnapshotHudStates(p1) --[[ SnapshotHudStates | Line: 210 | Upvalues: t2 (copy), PlayerGui (copy) ]]
	local t = {}

	for v1, v2 in t2 do
		local v3 = PlayerGui:FindFirstChild(v2)

		if v3 then
			t[v2] = v3.Enabled
		end
	end

	return t
end
function t3.RestoreHudStates(p1, p2) --[[ RestoreHudStates | Line: 224 | Upvalues: PlayerGui (copy) ]]
	if not p2 then
		return
	end

	for v1, v2 in p2 do
		local v3 = PlayerGui:FindFirstChild(v1)

		if v3 and v3.Name ~= "TouchGui" then
			v3.Enabled = v2
		end
	end
end
function t3.Init(p1) --[[ Init | Line: 237 ]] end
function t3.Start(p1) --[[ Start | Line: 241 | Upvalues: t (copy) ]]
	for v1, v2 in script:WaitForChild("Components"):GetChildren() do
		if v2:IsA("ModuleScript") then
			local ok, _ = pcall(function() --[[ Line: 247 | Upvalues: v2 (copy) ]]
				return require(v2)
			end)

			if ok then
				t[v2.Name] = require(v2)
			end
		end
	end
end

return t3