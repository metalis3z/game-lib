-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ConsoleCmds = require(ReplicatedStorage.Library.Client.ConsoleCmds)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Signal = require(ReplicatedStorage.Library.Signal)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Variables = require(ReplicatedStorage.Library.Variables)
local v1 = table.freeze({ "Message", "BuyMultiple", "StealDnaMessage", "PetList", "GrowingEggList" })
local v2 = table.freeze({
	Message = true,
	BuyMultiple = true,
	StealDnaMessage = true
})
local v3 = table.freeze({
	BackpackGui = true,
	Treadmill = true,
	TreadmillScreenButtonSwapLeft = true,
	TreadmillScreenButtonSwapRight = true,
	TreadmillScreenComments = true,
	TreadmillUI = true
})
local v4 = table.freeze({
	BackpackGui = true,
	TopbarCentered = true,
	TopbarCenteredClipped = true,
	TopbarStandard = true,
	TopbarStandardClipped = true
})
local v5 = Log.new()
local v6 = GUI.PlayerGui()
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local v7 = nil
local v8 = false

local function isVisible(p1) --[[ isVisible | Line: 58 | Upvalues: ConsoleCmds (copy) ]]
	return ConsoleCmds.ElementIsVisibleOnScreen(p1)
end

local function priorityScreen() --[[ priorityScreen | Line: 62 | Upvalues: v1 (copy), GUI (copy), TabController (copy) ]]
	for v12, v2 in v1 do
		local v3 = GUI.Get(v2)
		local v4 = v3:IsA("ScreenGui")

		assert(v4, (("%* must be a ScreenGui"):format(v2)))

		if v3.Enabled then
			return v3
		end
	end

	local v6 = TabController.Get()

	if v6 == nil then
		return nil
	end

	local v7 = GUI.Get(v6)

	assert(v7:IsA("ScreenGui"), (("Tab %* must be a ScreenGui"):format(v6)))

	if v7.Enabled then
		return v7
	end

	return nil
end

local function restoreSelectableButtons() --[[ restoreSelectableButtons | Line: 80 | Upvalues: t2 (copy), t (copy) ]]
	for v1 in t2 do
		if v1.Parent ~= nil then
			v1.Selectable = t[v1]
		end

		t2[v1] = nil
	end
end

local function precedes(p1, p2) --[[ precedes | Line: 89 ]]
	local v1 = if p1:GetAttribute("InitialSelection") == true then true else false

	if v1 ~= (if p2:GetAttribute("InitialSelection") == true then true else false) then
		return v1
	end

	if p1.Name == "Close" or p2.Name == "Close" then
		return p2.Name == "Close"
	end

	if p1.LayoutOrder == p2.LayoutOrder then
		if p1.AbsolutePosition.Y == p2.AbsolutePosition.Y then
			return p1.AbsolutePosition.X < p2.AbsolutePosition.X
		end

		return p1.AbsolutePosition.Y < p2.AbsolutePosition.Y
	end

	return p1.LayoutOrder < p2.LayoutOrder
end

local function projectSelectableButtons(p1) --[[ projectSelectableButtons | Line: 107 | Upvalues: ConsoleCmds (copy), t (copy), t2 (copy), precedes (copy) ]]
	local v1 = nil

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("GuiButton") and (v3.Active and (ConsoleCmds.ElementIsVisibleOnScreen(v3) and v3:GetAttribute("ConsoleNavigationDisabled") ~= true)) then
			if t[v3] == nil then
				t[v3] = v3.Selectable
			end

			v3.Selectable = true
			t2[v3] = true

			if v1 == nil or precedes(v3, v1) then
				v1 = v3
			end
		end
	end

	return v1
end

local function isEligibleSelection(p1, p2) --[[ isEligibleSelection | Line: 129 | Upvalues: ConsoleCmds (copy) ]]
	return if p2 == nil then false else p2:IsDescendantOf(p1) and (p2:IsA("GuiButton") and (p2.Selectable and (p2.Active and ConsoleCmds.ElementIsVisibleOnScreen(p2))))
end

local function isExternalNavigationSelection(p1) --[[ isExternalNavigationSelection | Line: 138 | Upvalues: v4 (copy) ]]
	if p1 == nil then
		return false
	end

	local v1 = p1:FindFirstAncestorWhichIsA("LayerCollector")

	return if v1 == nil then false else v4[v1.Name] == true
end

local function reconcile() --[[ reconcile | Line: 146 | Upvalues: v8 (ref), t2 (copy), t (copy), Variables (copy), v7 (ref), ConsoleCmds (copy), GuiService (copy), priorityScreen (copy), v4 (copy), v2 (copy), projectSelectableButtons (copy), t3 (copy) ]]
	if v8 then
		return
	end

	v8 = true

	for v1 in t2 do
		if v1.Parent ~= nil then
			v1.Selectable = t[v1]
		end

		t2[v1] = nil
	end

	if not Variables.Console then
		v7 = nil
		ConsoleCmds.SetActiveInterface(nil)
		GuiService.SelectedObject = nil
		GuiService.GuiNavigationEnabled = false
		v8 = false

		return
	end

	local v22 = priorityScreen()

	v7 = v22
	ConsoleCmds.SetActiveInterface(v22)

	if v22 == nil then
		local SelectedObject = GuiService.SelectedObject
		local v3

		if SelectedObject == nil then
			v3 = false
		else
			local v42 = SelectedObject:FindFirstAncestorWhichIsA("LayerCollector")

			v3 = if v42 == nil then false else v4[v42.Name] == true
		end

		if v3 then
			GuiService.GuiNavigationEnabled = true
		else
			GuiService.SelectedObject = nil
			GuiService.GuiNavigationEnabled = false
		end
	else
		if v2[v22.Name] then
			GuiService.SelectedObject = nil
			GuiService.GuiNavigationEnabled = false
			v8 = false

			return
		end

		local v5 = projectSelectableButtons(v22)
		local SelectedObject = GuiService.SelectedObject
		local v6

		if SelectedObject == nil then
			v6 = false
		else
			local v72 = SelectedObject:IsDescendantOf(v22)

			if v72 then
				local v82 = SelectedObject:IsA("GuiButton")

				if v82 then
					v6 = SelectedObject.Selectable

					if v6 then
						v6 = SelectedObject.Active

						if v6 then
							v6 = ConsoleCmds.ElementIsVisibleOnScreen(SelectedObject)
						end
					end
				else
					v6 = v82
				end
			else
				v6 = v72
			end
		end

		if not v6 then
			local v10 = t3[v22]

			SelectedObject = if if v10 == nil then false else v10:IsDescendantOf(v22) and (v10:IsA("GuiButton") and (v10.Selectable and (v10.Active and ConsoleCmds.ElementIsVisibleOnScreen(v10)))) then v10 else v5
		end

		GuiService.SelectedObject = SelectedObject
		GuiService.GuiNavigationEnabled = SelectedObject ~= nil
	end

	v8 = false
end

local function requestReconcile() --[[ requestReconcile | Line: 194 | Upvalues: reconcile (copy) ]]
	task.defer(reconcile)
end

local function observe(p1) --[[ observe | Line: 198 | Upvalues: t4 (copy), v3 (copy), ConsoleCmds (copy), requestReconcile (copy), t3 (copy), t (copy), t2 (copy), reconcile (copy) ]]
	if t4[p1] then
		return
	end

	t4[p1] = true

	local v1 = if p1:IsA("ScreenGui") then p1 else p1:FindFirstAncestorOfClass("ScreenGui")

	if v1 == nil or not v3[v1.Name] then
		ConsoleCmds.ObserveInstance(p1)
	end

	if p1:IsA("ScreenGui") then
		p1:GetPropertyChangedSignal("Enabled"):Connect(requestReconcile)
	elseif p1:IsA("GuiObject") then
		p1:GetPropertyChangedSignal("Visible"):Connect(requestReconcile)

		if p1:IsA("GuiButton") then
			p1:GetPropertyChangedSignal("Active"):Connect(requestReconcile)
		end
	end

	p1.Destroying:Once(function() --[[ Line: 215 | Upvalues: t4 (ref), p1 (copy), t3 (ref), t (ref), t2 (ref), reconcile (ref) ]]
		t4[p1] = nil

		if p1:IsA("ScreenGui") then
			t3[p1] = nil
		elseif p1:IsA("GuiButton") then
			t[p1] = nil
			t2[p1] = nil
		end

		if not p1:IsA("GuiObject") then
			task.defer(reconcile)

			return
		end

		for v1, v2 in t3 do
			if v2 == p1 then
				t3[v1] = nil
			end
		end

		task.defer(reconcile)
	end)
end

for v9, v10 in v6:GetDescendants() do
	observe(v10)
end

for v11, v12 in v6:GetChildren() do
	observe(v12)
end

v6.DescendantAdded:Connect(function(p1) --[[ Line: 245 | Upvalues: observe (copy), reconcile (copy) ]]
	observe(p1)
	task.defer(reconcile)
end)
v6.DescendantRemoving:Connect(requestReconcile)
GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function() --[[ Line: 250 | Upvalues: v7 (ref), GuiService (copy), ConsoleCmds (copy), t3 (copy), Variables (copy), v4 (copy) ]]
	local v1 = v7
	local SelectedObject = GuiService.SelectedObject

	if v1 ~= nil and (if SelectedObject == nil then false else SelectedObject:IsDescendantOf(v1) and (SelectedObject:IsA("GuiButton") and (SelectedObject.Selectable and (SelectedObject.Active and ConsoleCmds.ElementIsVisibleOnScreen(SelectedObject))))) then
		t3[v1] = SelectedObject

		return
	end

	if not Variables.Console or v1 ~= nil then
		return
	end

	local v42

	if SelectedObject == nil then
		v42 = false
	else
		local v5 = SelectedObject:FindFirstAncestorWhichIsA("LayerCollector")

		v42 = if v5 == nil then false else v4[v5.Name] == true
	end

	GuiService.GuiNavigationEnabled = v42
end)
Signal.Fired("Changed Platform"):Connect(requestReconcile)
TabController.Opened:Connect(requestReconcile)
TabController.Closed:Connect(requestReconcile)
ConsoleCmds.UpdateInterface(Variables.Platform)
reconcile()
v5:AtInfo():Log("Console navigation initialized")