-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local CollectionService = game:GetService("CollectionService")
local Client = Library:WaitForChild("Client")
local v1 = require(ReplicatedStorage.Library.Modules.SpatialTable).new(150)
local Functions = require(Library.Functions)
local Player = require(Library.Player)
local Save = require(Client.Save)
local TabController = require(Client.TabController)
local Interact = require(Client.Interact)
local Pads = require(Client.WorldFX.Pads)
local v2 = require(ReplicatedStorage.Library.Modules.Event)
local LocalPlayer = Players.LocalPlayer
local v3 = false
local CurrentCamera = workspace.CurrentCamera
local t2 = {
	SpinnyWheel = true
}

t.InstanceMachineCreated = v2.new()
t.InstanceMachineDestroyed = v2.new()
t.MachineLoaded = v2.new()
t.MachineRemoved = v2.new()
t.Approached = v2.new()
t.Left = v2.new()

local t3 = {}
local t4 = {}
local t5 = {}

function t.All() --[[ All | Line: 59 | Upvalues: t3 (copy) ]]
	return t3
end
function t.AllModels() --[[ AllModels | Line: 63 | Upvalues: t (copy) ]]
	local t2 = {}

	for k in pairs(t.All()) do
		for k2, v in pairs(t.GetModels(k)) do
			table.insert(t2, v)
		end
	end

	return t2
end
function t.GetDisplayName(p1) --[[ GetDisplayName | Line: 73 | Upvalues: t (copy) ]]
	local v1 = t.GetAll(p1)

	assert(#v1 > 0, "No machines found for " .. p1)

	return v1[1].DisplayName
end
function t.GetAll(p1) --[[ GetAll | Line: 79 | Upvalues: v3 (ref), t3 (copy) ]]
	while not v3 do
		task.wait()
	end

	return t3[p1] or {}
end
function t.GetModels(p1) --[[ GetModels | Line: 90 | Upvalues: t (copy) ]]
	local t2 = {}

	for k, v in pairs(t.GetAll(p1)) do
		table.insert(t2, v.Model)
	end

	return t2
end
function t.GetUI(p1) --[[ GetUI | Line: 99 | Upvalues: t (copy) ]]
	local v1 = t.GetAll(p1)

	assert(if #v1 > 0 then v1[1].UI or nil else nil, "No UI found for machine: " .. p1)

	return v1[1].UI
end
function t.AddApproachListenerForModel(p1, p2, p3) --[[ AddApproachListenerForModel | Line: 111 | Upvalues: t (copy) ]]
	for k, v in pairs(t.GetAll(p1)) do
		if v.Pad and v.Model == p2 then
			local Pad = v.Pad

			assert(Pad, "Pad object is nil for machine: " .. p1)
			Pad:AddEnterListener(function() --[[ Line: 120 | Upvalues: p3 (copy), v (copy) ]]
				p3(v.Model)
			end)
		end
	end
end
function t.AddApproachListener(p1, p2) --[[ AddApproachListener | Line: 127 | Upvalues: t5 (copy) ]]
	if not t5[p1] then
		t5[p1] = {}
	end

	table.insert(t5[p1], p2)
end
function t.AddLeaveListener(p1, p2) --[[ AddLeaveListener | Line: 134 | Upvalues: t5 (copy) ]]
	if not t5[p1] then
		t5[p1] = {}
	end

	table.insert(t5[p1], p2)
end
function t.AddInteractListener(p1, p2) --[[ AddInteractListener | Line: 141 | Upvalues: t (copy) ]]
	for k, v in pairs(t.GetAll(p1)) do
		if v.InteractPart then
			assert(v.InteractPart, "InteractPart is nil for machine: " .. p1)
			table.insert(v.InteractListeners, function() --[[ Line: 147 | Upvalues: p2 (copy), v (copy) ]]
				p2(v.Model)
			end)
		end
	end
end
function t.CanUse(p1) --[[ CanUse | Line: 154 | Upvalues: Save (copy), t (copy), Player (copy) ]]
	if not Save.Get() then
		return false, "Something went wrong!"
	end

	if not t.Owns(p1) then
		return false, "Something went wrong!"
	end

	local v1 = Player.Optional.PrimaryPart(Player.Get())

	if not v1 then
		return false, "Something went wrong!"
	end

	for k, v in pairs(t.GetAll(p1)) do
		if (v1.Position - (v.InteractPart and v.InteractPart.Position or v.Pad.pad:GetPivot().Position)).Magnitude <= 80 then
			return true
		end
	end

	return false, "Something went wrong!"
end
function t.IsStandingOn(p1) --[[ IsStandingOn | Line: 188 | Upvalues: t (copy) ]]
	for k, v in pairs(t.GetAll(p1)) do
		if v.Pad then
			local Pad = v.Pad

			assert(Pad, "Pad object is nil for machine: " .. p1)

			if Pad:IsStandingOn() then
				return true
			end
		end
	end

	return false
end
function t.Owns(p1) --[[ Owns | Line: 201 ]]
	return true
end
function t.PreventOpen(p1) --[[ PreventOpen | Line: 205 | Upvalues: t4 (copy) ]]
	t4[p1] = true
end
function t.AllowOpen(p1) --[[ AllowOpen | Line: 209 | Upvalues: t4 (copy) ]]
	t4[p1] = nil
end
function t.IsAllowedToOpen(p1) --[[ IsAllowedToOpen | Line: 213 | Upvalues: t4 (copy) ]]
	return t4[p1] == nil
end
function t.GetClosestMachine(p1, p2, p3) --[[ GetClosestMachine | Line: 217 | Upvalues: Player (copy), t3 (copy), Functions (copy) ]]
	local v1 = if p2 then p2 else Player.Get()
	local v2 = nil

	for k, v in pairs(t3) do
		for i, v3 in ipairs(v) do
			if v3.MachineName == p1 then
				local v32 = Functions.Distance(v1, v3.Model:GetPivot().Position)

				if v2 then
					if (p3 == nil or v32 <= p3) and v32 < (1 / 0) then
						v2 = v3
						p3 = (1 / 0)
					end

					continue
				end

				if p3 == nil or v32 <= p3 then
					if v32 then
						v2 = v3
						p3 = v32

						continue
					end

					v2 = v3
				end
			end
		end
	end

	return v2
end

local function AddMachine(p1) --[[ AddMachine | Line: 247 | Upvalues: Pads (copy), LocalPlayer (copy), t3 (copy), t5 (copy), t (copy), t4 (copy), t2 (copy), TabController (copy), Interact (copy), v1 (copy) ]]
	local Pad = p1:FindFirstChild("Pad")
	local v12

	if p1:FindFirstChild("Interact") then
		v12 = p1:FindFirstChild("Interact")
	else
		local Part = Instance.new("Part")

		Part.Anchored = true
		Part.CanCollide = true

		if p1.PrimaryPart then
			Part.Position = p1.PrimaryPart.Position
		else
			Part.Position = p1:GetPivot().Position
		end

		v12 = Part
	end

	local v2 = nil

	if Pad then
		if Pad then
			v2 = Pads.new(Pad)
		end
	else
		v2 = nil
	end

	local v4 = LocalPlayer.PlayerGui:WaitForChild("_MACHINES"):FindFirstChild(p1.Name)
	local t6 = {
		Highlight = nil,
		Model = p1,
		MachineName = p1.Name
	}

	t6.DisplayName = p1:GetAttribute("DisplayName") or p1.Name
	t6.Pad = v2
	t6.Position = p1:GetPivot().Position
	t6.PrimaryPart = p1.PrimaryPart
	t6.InteractPart = v12
	t6.UI = v4
	t6.ApproachListeners = {}
	t6.LeaveListeners = {}
	t6.InteractListeners = {}
	t6.DontAddMachineHighlight = p1:GetAttribute("DontAddMachineHighlight") or false

	if not t3[p1.Name] then
		t3[p1.Name] = {}
	end

	table.insert(t3[p1.Name], t6)

	if t6.Pad then
		t6.Pad:AddEnterListener(function() --[[ Line: 298 | Upvalues: t5 (ref), p1 (copy), t (ref), t6 (copy) ]]
			local v1 = t5[p1.Name]

			if v1 then
				for i, v in ipairs(v1) do
					task.spawn(v, p1)
				end
			end

			t.Approached:FireAsync(t6)
		end)
		t6.Pad:AddLeaveListener(function() --[[ Line: 307 | Upvalues: t5 (ref), p1 (copy), t (ref), t6 (copy) ]]
			local v1 = t5[p1.Name]

			if v1 then
				for i, v in ipairs(v1) do
					task.spawn(v, p1)
				end
			end

			t.Left:FireAsync(t6)
		end)
	end

	if t6.Pad and t6.UI then
		t6.Pad:AddEnterListener(function() --[[ Line: 319 | Upvalues: t4 (ref), t6 (copy), t2 (ref), TabController (ref) ]]
			if t4[t6.MachineName] then
				return
			end

			if t2[t6.MachineName] then
				return
			end

			if TabController.Get() ~= nil then
				return
			end

			if not TabController.IsOpen(t6.UI.Name) then
				TabController.OpenTab(t6.UI.Name)
			end
		end)

		local v7 = false

		TabController.AddCloseListener(function(p1) --[[ Line: 334 | Upvalues: v7 (ref), t6 (copy), TabController (ref) ]]
			if v7 or p1 ~= t6.UI.Name and (p1 ~= "Message" and t6.UI.Name ~= "SuperMachine") then
				return
			end

			v7 = true
			task.delay(1, function() --[[ Line: 342 | Upvalues: TabController (ref), t6 (ref), v7 (ref) ]]
				task.wait(0.15)

				if not TabController.IsOpen() and t6.Pad:IsStandingOn() then
					TabController.OpenTab(t6.UI.Name)
					t6.Pad:FireEnterListeners()
				end

				v7 = false
			end)
		end)
	end

	if v4 then
		local Close = v4:FindFirstChild("Close", true)

		if Close and not Close:GetAttribute("MachineInitialized") then
			Close:SetAttribute("MachineInitialized", true)
			Close.Activated:Connect(function() --[[ Line: 359 | Upvalues: TabController (ref), p1 (copy) ]]
				if not TabController.IsOpen(p1.Name) then
					return
				end

				TabController.CloseTab()
			end)
		end
	end

	if v12 then
		Interact.Add(v12):Connect(function() --[[ Line: 368 | Upvalues: t6 (copy) ]]
			for i, v in ipairs(t6.InteractListeners) do
				task.spawn(v)
			end
		end)
	end

	t.InstanceMachineCreated:FireAsync(t6)
	v1:Insert(t6.Position, t6)
	t.MachineLoaded:FireAsync(t6)
end

local function GetModel(p1) --[[ GetModel | Line: 380 | Upvalues: t3 (copy), t (copy), v1 (copy) ]]
	if not t3[p1.Name] then
		warn(("Machine: %* not found in MachinesByName, bad model:"):format(p1.Name), p1)

		return
	end

	local v12 = t3[p1.Name]

	for i = #v12, 1, -1 do
		local v2 = v12[i]

		if v2.Model == p1 then
			table.remove(v12, i)
			t.MachineRemoved:FireAsync(v2)
			v1:Remove(v2.Position, v2)
		end
	end
end

CollectionService:GetInstanceAddedSignal("Machine"):Connect(AddMachine)
CollectionService:GetInstanceRemovedSignal("Machine"):Connect(GetModel)
task.spawn(function() --[[ Line: 399 | Upvalues: CollectionService (copy), AddMachine (copy), v3 (ref) ]]
	for i, v in ipairs(CollectionService:GetTagged("Machine")) do
		AddMachine(v)
	end

	v3 = true
end)
RunService.RenderStepped:Connect(function() --[[ Line: 406 | Upvalues: Player (copy), CurrentCamera (copy), v1 (copy), TabController (copy) ]]
	local v12 = Player.Optional.Position()

	if not v12 then
		return
	end

	local Position = CurrentCamera.CFrame.Position
	local v2 = v1:Collect(v12)
	local v3 = TabController.Get() ~= nil

	for i, v in ipairs(v2) do
		if not v.DontAddMachineHighlight then
			local v4 = not v3

			if v.Highlight and not v4 then
				v.Highlight:Destroy()
				v.Highlight = nil
			end

			if v4 then
				local Magnitude = (v.Position - Position).Magnitude

				if Magnitude < 150 then
					if not v.Highlight then
						local Highlight = Instance.new("Highlight")

						Highlight.FillTransparency = 1
						Highlight.OutlineColor = Color3.new()
						Highlight.OutlineTransparency = 1
						Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
						Highlight.Parent = v.Model
						v.Highlight = Highlight
					end

					assert(v.Highlight, "luau")
					v.Highlight.OutlineTransparency = 0.8

					continue
				end

				local v5 = math.min(Magnitude - 150, 35) / 35 * 0.2 + 0.8

				if v5 >= 1 and v.Highlight then
					v.Highlight:Destroy()
					v.Highlight = nil

					continue
				end

				if v5 < 1 then
					if not v.Highlight then
						local Highlight = Instance.new("Highlight")

						Highlight.FillTransparency = 1
						Highlight.OutlineColor = Color3.new()
						Highlight.OutlineTransparency = 1
						Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
						Highlight.Parent = v.Model
						v.Highlight = Highlight
					end

					assert(v.Highlight, "luau")
					v.Highlight.OutlineTransparency = v5
				end
			end
		end
	end
end)

return t