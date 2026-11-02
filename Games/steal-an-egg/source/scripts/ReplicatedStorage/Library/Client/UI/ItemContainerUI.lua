-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local Library = ReplicatedStorage:WaitForChild("Library")
local Client = Library:WaitForChild("Client")
local Asserts = require(Library.Asserts)
local Functions = require(Library.Functions)
local ButtonFX = require(Client.GUIFX.ButtonFX)
local CircularSelection = require(Client.GUIFX.CircularSelection)
local AutoGridLayout = require(ReplicatedStorage.Library.Client.AutoGridLayout)
local ScreenResolution = require(Client.ScreenResolution)

require(Library.Items.AbstractItem)

local t = {}

t.__index = t

local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}

local function getPerContainerResolutionSettings(p1) --[[ getPerContainerResolutionSettings | Line: 196 ]]
	if p1[1].ResolutionThreshold == nil then
		return p1
	end

	return { p1 }
end

local function isGloballyHidden(p1) --[[ isGloballyHidden | Line: 203 | Upvalues: t4 (copy) ]]
	local v1 = t4[p1.Class.Name]

	if not v1 then
		return false
	end

	local v2 = p1:GetOptionalUID()

	if not v2 then
		return false
	end

	return v1[v2] == true
end

t2.SelectionMode = {
	DISABLED = 0,
	SINGULAR = 1,
	UNLIMITED = 2,
	CUSTOM = 3
}

local v1 = Functions.Values(t2.SelectionMode)

t2.QuantityMode = {
	NORMAL = 1,
	BINARY = 2
}

local v2 = Functions.Values(t2.QuantityMode)

t2.EventMode = {
	INSTANT = 1,
	ON_RELEASE = 2
}

local v3 = Functions.Values(t2.EventMode)

t2.Comparators = {
	Default = function(p1, p2) --[[ Default | Line: 241 ]]
		return p1:CompareTo(p2) < 0
	end,
	RaritySorted = function(p1, p2) --[[ RaritySorted | Line: 244 ]]
		local v1 = p1:GetRarity()
		local v2 = p2:GetRarity()

		if v1 == v2 then
			return p1:CompareTo(p2) < 0
		end

		return v2.RarityNumber < v1.RarityNumber
	end,
	IdNameSorted = function(p1, p2) --[[ IdNameSorted | Line: 252 ]]
		local v1, v2 = p1:GetId():match("(%D*)(%d*)")
		local v3 = tonumber(v2)
		local v4, v5 = p2:GetId():match("(%D*)(%d*)")
		local v6 = tonumber(v5)

		if v3 and v6 then
			if v3 == v6 then
				return v1 < v4
			end

			return v6 < v3
		end

		if v3 then
			return true
		end

		if v6 then
			return false
		end

		return p1:GetId() < p2:GetId()
	end
}

local function defaultSearchFilter(p1, p2) --[[ defaultSearchFilter | Line: 273 | Upvalues: Functions (copy) ]]
	if #p1 == 0 then
		return true
	end

	local v1 = Functions.RegexEscape(p1:lower())

	if p2:GetName():lower():find(v1) then
		return true
	end

	if p2:GetRarity().DisplayName:lower():find(v1) then
		return true
	end

	local v2 = p2:GetNickname()

	return v2 and v2:lower():find(v1) and true or false
end

t2.DefaultSearchFilter = defaultSearchFilter

local t6 = {
	SelectionIncrement = 1,
	RetainSearchOnClose = false,
	Navigator = nil,
	PageSize = 100,
	Comparator = function(p1, p2) --[[ Comparator | Line: 298 ]]
		return p1:GetUID() < p2:GetUID()
	end,
	Permitted = function(p1) --[[ Permitted | Line: 301 ]]
		return true
	end,
	SelectionPermitted = function(p1) --[[ SelectionPermitted | Line: 304 ]]
		return true
	end,
	ModifiedCount = function(p1) --[[ ModifiedCount | Line: 307 ]]
		return p1:GetAmount()
	end,
	ContainerSelect = function(p1) --[[ ContainerSelect | Line: 310 ]]
		return 1
	end,
	Creator = function(p1) --[[ Creator | Line: 313 ]]
		error("Unimplemented")
	end,
	ResolutionSettings = {
		{
			ResolutionThreshold = 0.65,
			PerRow = 3,
			Padding = UDim2.fromOffset(11, 11)
		},
		{
			ResolutionThreshold = 1.2,
			PerRow = 4,
			Padding = UDim2.fromOffset(14, 14)
		},
		{
			ResolutionThreshold = (1 / 0),
			PerRow = 4,
			Padding = UDim2.fromOffset(20, 20)
		}
	},
	SelectionMode = t2.SelectionMode.UNLIMITED,
	QuantityMode = t2.QuantityMode.NORMAL,
	EventMode = t2.EventMode.INSTANT,
	SearchFilter = defaultSearchFilter
}

function t.SetMaximumSelectedStacks(p1, p2) --[[ SetMaximumSelectedStacks | Line: 344 ]]
	p1.setting.MaxSelectedStacks = p2
end
function t.initCircularSelection(p1, p2, p3, p4, p5, p6, p7, p8) --[[ initCircularSelection | Line: 348 | Upvalues: CircularSelection (copy), t2 (copy) ]]
	local v1, v2, v3, v4, v5 = CircularSelection.Add(p2, p3, math.min(p3, p4), function(p12) --[[ Line: 362 | Upvalues: p1 (copy), t2 (ref), p5 (copy) ]]
		if p12.selected then
			if p1.setting.SelectionMode == t2.SelectionMode.UNLIMITED then
				if p1.setting.MaxSelectedStacks then
					local count = 0

					for k, v in pairs(p1.selectionState) do
						if v > 0 then
							count = count + 1
						end
					end

					if p1.setting.MaxSelectedStacks <= count then
						p1.circularSelections[p5].stop()

						return
					end
				end
			elseif p1.setting.SelectionMode == t2.SelectionMode.SINGULAR then
				for k, v in pairs(p1.circularSelections) do
					if k ~= p5 then
						v.stop()
					end
				end

				p1.selectionState = {}
			end
		else
			for k, v in pairs(p1.circularSelections) do
				if k ~= p5 then
					v.enable(true)
				end
			end
		end

		local v1 = p1.selectionState[p5] or 0

		p1.selectionState[p5] = p12.quantity

		for i, v in ipairs(p1.selectionListeners) do
			task.spawn(function() --[[ Line: 397 | Upvalues: v (copy), p1 (ref) ]]
				v(p1.selectionState, p1)
			end)
		end

		for i, v in ipairs(p1.itemListeners) do
			task.spawn(function() --[[ Line: 403 | Upvalues: v (copy), p5 (ref), p12 (copy), v1 (copy) ]]
				v(p5, p12.quantity, v1)
			end)
		end
	end, p6, p7)

	p1.circularSelections[p5] = {
		kill = v1,
		stop = v2,
		enable = v3,
		lock = v4,
		force = v5
	}

	if not p8 then
		return
	end

	task.spawn(function() --[[ Line: 421 | Upvalues: v5 (copy), p8 (copy) ]]
		v5(p8, true)
	end)
end
function t.getRenderContainer(p1, p2) --[[ getRenderContainer | Line: 427 | Upvalues: Asserts (copy) ]]
	local ContainerSelect = p1.setting.ContainerSelect

	assert(ContainerSelect, "ContainerSelect is not provided in settings")

	local v1 = ContainerSelect(p2)

	Asserts.positiveInteger(v1)
	assert(v1 <= #p1.containers, "ContainerSelect returned an index out of bounds")

	local v3 = p1.containers[v1]

	assert(v3, "Render container does not exist")

	return v3
end
function t.getScrollingFrame(p1) --[[ getScrollingFrame | Line: 440 ]]
	local v1 = p1.containers[1]

	assert(v1, "No container found to retrieve ScrollingFrame")

	if v1:IsA("ScrollingFrame") then
		return v1
	end

	return v1:FindFirstAncestorOfClass("ScrollingFrame")
end
function t.getScreenGui(p1) --[[ getScreenGui | Line: 449 ]]
	local v1 = p1.containers[1]

	assert(v1, "No container found to retrieve ScreenGui")

	return v1:FindFirstAncestorOfClass("ScreenGui")
end
function t.upsertRender(p1, p2, p3, p4) --[[ upsertRender | Line: 455 | Upvalues: t2 (copy), GuiService (copy), RunService (copy) ]]
	local SelectionIncrement = p1.setting.SelectionIncrement

	assert(SelectionIncrement, "SelectionIncrement is not provided in settings")

	local ModifiedCount = p1.setting.ModifiedCount

	assert(ModifiedCount, "ModifiedCount is not provided in settings")

	local SelectionPermitted = p1.setting.SelectionPermitted

	assert(SelectionPermitted, "SelectionPermitted is not provided in settings")

	local v1 = p2:GetUID()

	if p1.renders[v1] then
		return false
	end

	local v2 = ModifiedCount(p2)

	if v2 <= 0 then
		return false
	end

	p1.items[v1] = p2

	local v3 = p1.setting.Creator(p2)
	local Quantity = v3:FindFirstChild("Quantity")

	if Quantity and Quantity:IsA("TextLabel") then
		Quantity.Text = ("x%*"):format(v2)

		local HideQuantity = p1.setting.HideQuantity

		if type(HideQuantity) == "boolean" then
			Quantity.Visible = not HideQuantity
		elseif type(HideQuantity) == "function" then
			Quantity.Visible = not HideQuantity(p2, v2)
		end
	end

	if p3 then
		v3.LayoutOrder = p3
	end

	v3.Visible = if p1.setting.SearchBar and p1.setting.SearchFilter then if p4 == nil then p1.setting.SearchFilter(p1.setting.SearchBar.Text, p2) else p4 else true
	v3.Parent = p1:getRenderContainer(p2)
	p1.renders[v1] = {
		render = v3,
		quantity = v2
	}

	local v6 = if p2:IsA("Pet") then p2:IsTitanic() or p2:IsHuge() else false
	local v8 = if p1.setting.QuantityMode == t2.QuantityMode.BINARY then 1 elseif p1.setting.ModifiedCount == nil then p2:GetAmount() else p1.setting.ModifiedCount(p2)
	local v11 = if p1.setting.EventMode == t2.EventMode.INSTANT then true else false

	if p1.setting.SelectionMode ~= t2.SelectionMode.DISABLED then
		local v12 = if typeof(SelectionIncrement) == "function" then SelectionIncrement(p2) else SelectionIncrement

		if v12 <= v8 and SelectionPermitted(p2) then
			p1:initCircularSelection(v3, v8, v12, v1, v11, v6, if p1.selectionState[v1] and p1.selectionState[v1] > 0 then p1.selectionState[v1] else nil)
		end
	end

	if not (p1.lastDeletedConsoleUID and p1.lastDeletedConsoleTimestamp) then
		return true
	end

	if not (if p1.lastDeletedConsoleUID == v1 then if tick() - p1.lastDeletedConsoleTimestamp < 0.1 then true else false else false) then
		return true
	end

	GuiService.SelectedObject = v3

	if not (p1.lastDeletedConsoleCanvasPosition and p1:getScrollingFrame()) then
		return true
	end

	task.spawn(function() --[[ Line: 555 | Upvalues: RunService (ref) ]]
		RunService.RenderStepped:Wait()
		RunService.RenderStepped:Wait()
		RunService.RenderStepped:Wait()
		RunService.RenderStepped:Wait()
		RunService.RenderStepped:Wait()
	end)

	return true
end
function t.resort(p1, p2) --[[ resort | Line: 569 ]]
	local Comparator = p1.setting.Comparator

	assert(Comparator, "Comparator is not provided in settings")

	if p2 == nil then
		p2 = false
	end

	local list = {}

	for k, v in pairs(p1.renders) do
		table.insert(list, {
			uid = k,
			activeRender = v
		})
	end

	if p2 then
		table.sort(list, function(p12, p2) --[[ Line: 586 | Upvalues: p1 (copy), Comparator (copy) ]]
			local v1 = if (p1.selectionState[p12.uid] or 0) > 0 then true else false

			if v1 == (if (p1.selectionState[p2.uid] or 0) > 0 then true else false) then
				return Comparator(p1.items[p12.uid], p1.items[p2.uid])
			end

			return v1
		end)
	else
		table.sort(list, function(p12, p2) --[[ Line: 595 | Upvalues: Comparator (copy), p1 (copy) ]]
			return Comparator(p1.items[p12.uid], p1.items[p2.uid])
		end)
	end

	for i, v in ipairs(list) do
		local v1 = list[i - 1]
		local v2 = list[i + 1]
		local activeRender = v.activeRender

		if activeRender.render.LayoutOrder ~= i then
			activeRender.render.LayoutOrder = i
		end

		activeRender.nextUID = v2 and v2.uid or nil
		activeRender.prevUID = v1 and v1.uid or nil
	end
end
function t.deleteRender(p1, p2) --[[ deleteRender | Line: 612 | Upvalues: GuiService (copy) ]]
	local v1 = p1.renders[p2]

	if not v1 then
		return
	end

	if p1.circularSelections[p2] then
		p1.circularSelections[p2].kill()
		p1.circularSelections[p2] = nil
	end

	if GuiService.SelectedObject and (GuiService.SelectedObject == v1.render or GuiService.SelectedObject:IsDescendantOf(v1.render)) then
		p1.lastDeletedConsoleUID = p2
		p1.lastDeletedConsoleTimestamp = tick()

		local v2 = p1:getScrollingFrame()

		if v2 then
			p1.lastDeletedConsoleCanvasPosition = v2.CanvasPosition
		else
			p1.lastDeletedConsoleCanvasPosition = nil
		end

		local v3 = v1.nextUID and p1.renders[v1.nextUID] or nil
		local v4 = v1.prevUID and p1.renders[v1.prevUID] or nil

		if v3 then
			GuiService.SelectedObject = v3.render
		elseif v4 then
			GuiService.SelectedObject = v4.render
		end
	end

	local v5 = v1.prevUID and p1.renders[v1.prevUID] or nil
	local v6 = v1.nextUID and p1.renders[v1.nextUID] or nil

	if v5 and v6 then
		v5.nextUID = v1.nextUID
		v6.prevUID = v1.prevUID
	elseif v5 and not v6 then
		v5.nextUID = nil
	elseif v6 and not v5 then
		v6.prevUID = nil
	end

	v1.render:Destroy()
	p1.renders[p2] = nil
	p1.items[p2] = nil
end
function t.hideRender(p1, p2) --[[ hideRender | Line: 665 ]]
	local v1 = p1.renders[p2]

	if not v1 then
		return
	end

	if p1.circularSelections[p2] then
		p1.circularSelections[p2].stop()
		p1.circularSelections[p2].enable(false)
	end

	v1.render.Visible = false
end
function t.showRender(p1, p2) --[[ showRender | Line: 679 ]]
	local v1 = p1.renders[p2]

	if not v1 then
		return
	end

	if p1.circularSelections[p2] then
		p1.circularSelections[p2].enable(true)
	end

	v1.render.Visible = true
end
function t.SetSelectionAmount(p1, p2, p3) --[[ SetSelectionAmount | Line: 692 ]]
	local v1 = p1.circularSelections[p2]

	if not v1 then
		return
	end

	v1.force(p3)
end
function t.SetSelectionEnabled(p1, p2) --[[ SetSelectionEnabled | Line: 699 ]]
	for k, v in pairs(p1.circularSelections) do
		v.lock(not p2)
	end
end
function t.ClearSelection(p1) --[[ ClearSelection | Line: 705 ]]
	for k, v in pairs(p1.circularSelections) do
		v.stop()
	end

	p1.selectionState = {}
end
function t.ClearUID(p1, p2) --[[ ClearUID | Line: 712 ]]
	local v1 = p1.circularSelections[p2]

	if v1 then
		v1.stop()
	end

	p1.selectionState[p2] = nil
end
function t.ReapplyResolution(p1) --[[ ReapplyResolution | Line: 720 ]]
	if not p1.autoResolution then
		return
	end

	p1.autoResolution()
end
function t.ChangeResolutionSettings(p1, p2) --[[ ChangeResolutionSettings | Line: 726 | Upvalues: AutoGridLayout (copy) ]]
	local t = {}
	local v1 = if p2[1].ResolutionThreshold == nil then p2 else { p2 }

	for i, v in ipairs(p1.containers) do
		local v2 = v1[i]

		assert(v2, "Resolution setting missing for container " .. i)
		table.insert(t, AutoGridLayout(v, v2))
	end

	function p1.autoResolution() --[[ autoResolution | Line: 736 | Upvalues: p1 (copy), t (copy) ]]
		for i, v in ipairs(p1.containers) do
			local v1 = t[i]

			assert(v1, "Auto resolution function missing for container " .. i)
			v1()
		end
	end
	p1.autoResolution()
end
function t.Destroy(p1) --[[ Destroy | Line: 747 | Upvalues: t3 (copy) ]]
	p1:Clear()

	for v1, v2 in p1.searchBarEvents do
		v2:Disconnect()
	end

	p1.searchBarEvents = {}

	for i, v in ipairs(p1.paginationEvents) do
		v:Disconnect()
	end

	p1.paginationEvents = {}
	t3[p1.uid] = nil
end
function t.Clear(p1) --[[ Clear | Line: 760 ]]
	p1.renderThreadUID = p1.renderThreadUID + 1

	for v1 in p1.renders do
		p1:deleteRender(v1)
	end

	p1.cachedPopulation = {}
end
function t.Refresh(p1, p2) --[[ Refresh | Line: 768 ]]
	local v1 = false
	local v2 = pairs

	for v4, v5 in v2(if p2 then p2 else p1.dirty) do
		local v6 = v5:Clone():SetUID(v4)

		if not p1.renders[v4] then
			return
		end

		p1:deleteRender(v4)
		p1:upsertRender(v6)
		v1 = true
	end

	if v1 then
		p1:resort()
		p1.autoResolution()
	end

	p1.dirty = {}
end
function t.GetFront(p1) --[[ GetFront | Line: 786 ]]
	local v1 = nil
	local v2 = (1 / 0)

	for k, v in pairs(p1.renders) do
		if not v1 or v.render.LayoutOrder < v2 then
			v1 = v.render
			v2 = v.render.LayoutOrder
		end
	end

	return v1
end
function t.GetBack(p1) --[[ GetBack | Line: 798 ]]
	local v1 = nil
	local v2 = (-1 / 0)

	for k, v in pairs(p1.renders) do
		if not v1 or v2 < v.render.LayoutOrder then
			v1 = v.render
			v2 = v.render.LayoutOrder
		end
	end

	return v1
end
function t.GetContainers(p1) --[[ GetContainers | Line: 810 ]]
	return p1.containers
end
function t.IsEmpty(p1) --[[ IsEmpty | Line: 814 ]]
	return next(p1.renders) == nil
end
function t.Populate(p1, p2) --[[ Populate | Line: 818 | Upvalues: t4 (copy), RunService (copy) ]]
	local Permitted = p1.setting.Permitted

	assert(Permitted, "Permitted is not provided in settings")

	local ModifiedCount = p1.setting.ModifiedCount

	assert(ModifiedCount, "ModifiedCount is not provided in settings")

	local Comparator = p1.setting.Comparator

	assert(Comparator, "Comparator is not provided in settings")
	p1.renderThreadUID = p1.renderThreadUID + 1

	local renderThreadUID = p1.renderThreadUID
	local t = {}
	local v1 = false

	for v3, v4 in p1.renders do
		local v2
		local v5 = p2[v3]

		if v5 and not p1.dirty[v3] then
			if ModifiedCount(v5) <= 0 or not Permitted(v5) then
				p1:deleteRender(v3)
			else
				local v6 = t4[v5.Class.Name]

				if v6 then
					local v7 = v5:GetOptionalUID()

					v2 = if v7 then if v6[v7] == true then true else false else false
				else
					v2 = false
				end

				if v2 or v4.quantity ~= ModifiedCount(v5) then
					p1:deleteRender(v3)

					continue
				end

				t[v3] = true
			end

			continue
		end

		p1:deleteRender(v3)
	end

	p1.cachedPopulation = p2

	local t2 = {}

	for v9, v10 in p2 do
		local v8

		if Permitted(v10) and (not p1.setting.SearchBar or (not p1.setting.SearchFilter or p1.setting.SearchFilter(p1.setting.SearchBar.Text, v10))) then
			local v11 = t4[v10.Class.Name]

			if v11 then
				local v12 = v10:GetOptionalUID()

				v8 = if v12 then if v11[v12] == true then true else false else false
			else
				v8 = false
			end

			if not v8 then
				table.insert(t2, {
					item = v10,
					uid = v9
				})
			end
		end
	end

	if p1.setting.LoadSpeed then
		table.sort(t2, function(p1, p2) --[[ Line: 869 | Upvalues: Comparator (copy) ]]
			return Comparator(p1.item, p2.item)
		end)
	end

	p1.renderCount = #t2

	local v13, v14

	if p1.hasPages then
		local pageNumber = p1.pageNumber

		assert(pageNumber, "Page number is not defined for pagination")

		local PageSize = p1.setting.PageSize

		assert(PageSize, "PageSize is not defined in settings")

		local v15 = pageNumber
		local Navigator = p1.setting.Navigator

		assert(Navigator, "Navigator is required for pagination")

		local v18 = math.max(1, (math.ceil(p1.renderCount / PageSize)))

		if v18 < v15 then
			p1.pageNumber = v18
			v15 = v18
			v13 = PageSize * v18 - 1
			v14 = PageSize * (v18 - 1)
		else
			v13 = PageSize * v15 - 1
			v14 = PageSize * (v15 - 1)
		end

		Navigator.Left.ImageLabel.ImageTransparency = if if v15 > 1 then true else false then 0 else 0.65
		Navigator.Right.ImageLabel.ImageTransparency = if if v15 < v18 then true else false then 0 else 0.65
		Navigator.Visible = if v18 > 1 then true else false
		Navigator.PageNumber.Text = tostring(v15)
	else
		v14 = nil
		v13 = nil
	end

	local v24 = 0
	local v25 = false

	task.spawn(function() --[[ Line: 910 | Upvalues: t2 (copy), Permitted (copy), ModifiedCount (copy), t4 (ref), renderThreadUID (copy), p1 (copy), v24 (ref), v14 (ref), v13 (ref), t (copy), v1 (ref), v25 (ref), RunService (ref) ]]
		for i, v in ipairs(t2) do
			local v12
			local item = v.item
			local uid = v.uid

			if Permitted(item) and ModifiedCount(item) > 0 then
				local v2 = t4[item.Class.Name]

				if v2 then
					local v3 = item:GetOptionalUID()

					v12 = if v3 then if v2[v3] == true then true else false else false
				else
					v12 = false
				end

				if not v12 then
					if renderThreadUID ~= p1.renderThreadUID then
						return
					end

					v24 = v24 + 1

					if v14 and v13 then
						local v4 = v24 - 1

						if v14 <= v4 and v4 <= v13 then
							t[uid] = nil

							local v5 = p1:upsertRender(item, i, true)

							if v5 then
								v1 = true
							end

							if not v25 then
								v25 = true

								if not p1.hasPages then
									p1.autoResolution()
								end
							end

							if v5 and (p1.setting.LoadSpeed and (v24 % p1.setting.LoadSpeed == 0 and not p1.hasPages)) then
								RunService.RenderStepped:Wait()
							end

							continue
						end

						if v13 < v4 then
							break
						end

						continue
					end

					t[uid] = nil

					local v6 = p1:upsertRender(item, i, true)

					if v6 then
						v1 = true
					end

					if not v25 then
						v25 = true

						if not p1.hasPages then
							p1.autoResolution()
						end
					end

					if v6 and (p1.setting.LoadSpeed and (v24 % p1.setting.LoadSpeed == 0 and not p1.hasPages)) then
						RunService.RenderStepped:Wait()
					end
				end
			end
		end

		if renderThreadUID ~= p1.renderThreadUID then
			return
		end

		for k in pairs(t) do
			p1:deleteRender(k)
		end

		if v1 then
			p1:resort()
		end

		if v1 then
			if p1.dirtyScreenResolution then
				task.delay(0.1, function() --[[ Line: 978 | Upvalues: p1 (ref) ]]
					p1.autoResolution()
				end)
			else
				p1.autoResolution()
			end

			p1.dirtyScreenResolution = false
		end

		p1.dirty = {}
	end)
end
function t.GetStackCount(p1) --[[ GetStackCount | Line: 991 ]]
	local count = 0

	for v1, v2 in p1.selectionState do
		if v2 > 0 then
			count = count + 1
		end
	end

	return count
end
function t.GetSelection(p1) --[[ GetSelection | Line: 1001 ]]
	return p1.selectionState
end
function t.GetSelectionCount(p1) --[[ GetSelectionCount | Line: 1005 ]]
	local sum = 0

	for v1, v2 in p1.selectionState do
		sum = sum + v2
	end

	return sum
end
function t.HasSelection(p1) --[[ HasSelection | Line: 1013 ]]
	for v1, v2 in p1.selectionState do
		if v2 > 0 then
			return true
		end
	end

	return false
end
function t.Filter(p1, p2) --[[ Filter | Line: 1022 ]]
	local v1 = if p2 then p2 else function(p1) --[[ Line: 1027 ]]
	return true
end

	for k, v in pairs(p1.renders) do
		local v2 = if (p1.selectionState[k] or 0) > 0 then true else false
		local v3 = p1.items[k]

		assert(v3, "Item not found for uid: " .. tostring(k))

		if v1(v3) or v2 then
			p1:showRender(k)

			continue
		end

		p1:hideRender(k)
	end
end
function t.AddSelectionListener(p1, p2) --[[ AddSelectionListener | Line: 1044 ]]
	table.insert(p1.selectionListeners, p2)
end
function t.AddItemListener(p1, p2) --[[ AddItemListener | Line: 1051 ]]
	table.insert(p1.itemListeners, p2)
end
function t.initSearchBar(p1) --[[ initSearchBar | Line: 1058 ]]
	local SearchBar = p1.setting.SearchBar

	assert(SearchBar, "SearchBar is not provided in settings")
	assert(p1.setting.SearchFilter, "SearchFilter is not provided in settings")

	local v1 = p1:getScrollingFrame()

	table.insert(p1.searchBarEvents, SearchBar.Changed:Connect(function(p12) --[[ Line: 1066 | Upvalues: SearchBar (copy), p1 (copy), v1 (copy) ]]
		if p12 ~= "Text" then
			return
		end

		local Text = SearchBar.Text

		if p1.hasPages and p1.cachedPopulation then
			p1:Clear()
			p1:Populate(p1.cachedPopulation)
		elseif Text == "" then
			p1:Filter(function(p1) --[[ Line: 1074 ]]
				return true
			end)
			p1:resort()
		else
			p1:Filter(function(p12) --[[ Line: 1079 | Upvalues: p1 (ref), Text (copy) ]]
				return p1.setting.SearchFilter(Text, p12)
			end)
			p1:resort(true)
		end

		task.delay(0.1, function() --[[ Line: 1084 | Upvalues: v1 (ref), p1 (ref) ]]
			if not v1 then
				return
			end

			p1.autoResolution()
			v1.CanvasPosition = Vector2.new()
		end)
	end))

	local v2 = p1:getScreenGui()

	if not v2 or p1.setting.RetainSearchOnClose then
		return
	end

	table.insert(p1.searchBarEvents, v2.Changed:Connect(function(p12) --[[ Line: 1098 | Upvalues: v2 (copy), SearchBar (copy), v1 (copy), p1 (copy) ]]
		if p12 ~= "Enabled" or (not v2.Enabled or SearchBar.Text == "") then
			return
		end

		SearchBar.Text = ""
		task.delay(0.1, function() --[[ Line: 1101 | Upvalues: v1 (ref), p1 (ref) ]]
			if not v1 then
				return
			end

			p1.autoResolution()
			v1.CanvasPosition = Vector2.new()
		end)
	end))
end
function t.requestPageTurn(p1, p2) --[[ requestPageTurn | Line: 1113 ]]
	assert(p1.hasPages and (p1.pageNumber and (p1.setting.PageSize and p1.setting.Navigator)), "Pagination requires a valid Navigator, pageNumber, and PageSize")

	local v2 = p1.pageNumber + math.sign(p2)

	if v2 < 1 or math.ceil(p1.renderCount / p1.setting.PageSize) < v2 then
		return
	end

	if not (p1.cachedPopulation and next(p1.cachedPopulation)) then
		return
	end

	p1.setting.Navigator.PageNumber.Text = tostring(v2)

	local v4 = p1:getScrollingFrame()
	local v5, v6

	if v4 then
		local CanvasPosition = v4.CanvasPosition
		local AbsoluteCanvasSize = v4.AbsoluteCanvasSize

		v5, v6 = if CanvasPosition.Y >= AbsoluteCanvasSize.Y - v4.AbsoluteSize.Y - 10 then true else AbsoluteCanvasSize.Y <= 0, CanvasPosition
	else
		v5 = false
		v6 = nil
	end

	p1.pageNumber = v2
	p1:Clear()
	p1:Populate(p1.cachedPopulation)

	if v4 then
		task.spawn(function() --[[ Line: 1146 | Upvalues: v5 (ref), v4 (copy), v6 (ref) ]]
			if v5 then
				v4.CanvasPosition = Vector2.new(0, 10000)

				return
			end

			v4.CanvasPosition = v6 or Vector2.new()
		end)
	else
		return
	end
end
function t.initPagination(p1) --[[ initPagination | Line: 1157 | Upvalues: t5 (copy), ButtonFX (copy) ]]
	local Navigator = p1.setting.Navigator

	assert(Navigator, "Navigator is not provided in settings for pagination")
	table.insert(p1.paginationEvents, Navigator.Left.Activated:Connect(function() --[[ Line: 1163 | Upvalues: p1 (copy) ]]
		p1:requestPageTurn(-1)
	end))
	table.insert(p1.paginationEvents, Navigator.Right.Activated:Connect(function() --[[ Line: 1169 | Upvalues: p1 (copy) ]]
		p1:requestPageTurn(1)
	end))

	if t5[Navigator] then
		return
	end

	t5[Navigator] = true
	ButtonFX(Navigator.Left)
	ButtonFX(Navigator.Right)
end
function t2.new(p1, p2) --[[ new | Line: 1181 | Upvalues: Functions (copy), t6 (copy), v1 (copy), v2 (copy), v3 (copy), AutoGridLayout (copy), t (copy), t3 (copy) ]]
	local v12 = Functions.DeepCopy(t6)

	if p2 then
		for k, v in pairs(p2) do
			v12[k] = v
		end
	end

	assert(if type(v12.RetainSearchOnClose) == "boolean" then true else false, "RetainSearchOnClose must be a boolean")
	assert(v12.Comparator, "Comparator is not provided in settings")
	assert(v12.Permitted, "Permitted is not provided in settings")
	assert(v12.Creator, "Creator is not provided in settings")
	assert(v12.SelectionMode, "SelectionMode is not provided in settings")
	assert(v12.ResolutionSettings, "ResolutionSettings is not provided in settings")
	assert(v12.SearchFilter, "SearchFilter is not provided in settings")
	assert(if table.find(v1, v12.SelectionMode) == nil then false else true, "Invalid SelectionMode")
	assert(if table.find(v2, v12.QuantityMode) == nil then false else true, "Invalid QuantityMode")
	assert(if table.find(v3, v12.EventMode) == nil then false else true, "Invalid EventMode")

	local v6 = if v12.Navigator == nil then false else true
	local v7 = if type(p1) == "table" then p1 else { p1 }
	local t2 = {}
	local ResolutionSettings2 = v12.ResolutionSettings
	local v8 = if ResolutionSettings2[1].ResolutionThreshold == nil then ResolutionSettings2 else { ResolutionSettings2 }

	for i, v in ipairs(v7) do
		local v9 = v8[i]

		assert(v9, "Resolution setting missing for container " .. i)
		table.insert(t2, AutoGridLayout(v, v9))
	end

	local function autoResolution() --[[ autoResolution | Line: 1219 | Upvalues: v7 (ref), t2 (copy) ]]
		for i, v in ipairs(v7) do
			local v1 = t2[i]

			assert(v1, "Auto resolution function missing for container " .. i)
			v1()
		end
	end

	local t4 = {
		renderThreadUID = 0,
		dirtyScreenResolution = false,
		renderCount = 0,
		containers = v7,
		setting = v12,
		renders = {},
		items = {},
		dirty = {},
		uid = Functions.GenerateUID(),
		autoResolution = autoResolution,
		selectionListeners = {},
		selectionState = {},
		circularSelections = {},
		itemListeners = {},
		searchBarEvents = {},
		paginationEvents = {},
		hasPages = v6
	}

	t4.pageNumber = if v6 then 1 else nil
	t4.cachedPopulation = {}

	local v13 = setmetatable(t4, t)

	t3[v13.uid] = v13

	if v13.setting.SearchBar then
		v13:initSearchBar()
	end

	if v13.setting.Navigator then
		v13:initPagination()
	end

	task.defer(v13.autoResolution)

	return v13
end
t2.IsGloballyHidden = isGloballyHidden
function t2.SetGloballyHidden(p1, p2) --[[ SetGloballyHidden | Line: 1267 | Upvalues: t4 (copy) ]]
	local v1 = t4[p1.Class.Name]

	if not v1 then
		v1 = {}
		t4[p1.Class.Name] = v1
	end

	local v2 = p1:GetUID()
	local v3 = if p2 then true else nil

	if v1[v2] == v3 then
		return
	end

	v1[v2] = v3
end

local v4 = nil

ScreenResolution.Changed:Connect(function() --[[ Line: 1283 | Upvalues: t3 (copy), v4 (ref) ]]
	for v1, v2 in t3 do
		v2.dirtyScreenResolution = true
	end

	if v4 then
		task.cancel(v4)
	end

	v4 = task.delay(0.15, function() --[[ Line: 1292 | Upvalues: v4 (ref), t3 (ref) ]]
		v4 = nil

		for v1, v2 in t3 do
			v2.autoResolution()
		end
	end)
end)

return t2