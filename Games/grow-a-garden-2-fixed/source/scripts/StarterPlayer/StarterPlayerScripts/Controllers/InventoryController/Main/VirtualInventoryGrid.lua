--credit to quartz games studio
local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 4 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.ScrollingFrame = p1.ScrollingFrame
	v2.UIGridFrame = p1.UIGridFrame
	v2.HiddenParent = p1.HiddenParent
	v2.Slots = p1.Slots
	v2.GetNumberOfHotbarSlots = p1.GetNumberOfHotbarSlots
	v2.GetCurrentFilter = p1.GetCurrentFilter
	v2.ToolMatchesFilter = p1.ToolMatchesFilter
	v2.CellSize = p1.CellSize
	v2.CellPadding = p1.CellPadding
	v2.BufferRows = p1.BufferRows or 2
	v2.IsFrozen = p1.IsFrozen
	v2.OnShowSlot = p1.OnShowSlot
	v2._dirtyList = true
	v2._dirtyLayout = true
	v2._scheduled = false
	v2._visibleSlots = {}
	v2._rendered = {}
	v2._columns = 1
	v2._rowHeight = v2.CellSize + v2.CellPadding

	return v2
end
function t.MarkListDirty(p1) --[[ MarkListDirty | Line: 30 ]]
	p1._dirtyList = true
	p1:RequestRender()
end
function t.MarkLayoutDirty(p1) --[[ MarkLayoutDirty | Line: 35 ]]
	p1._dirtyLayout = true
	p1:RequestRender()
end
function t.SetSearchQuery(p1, p2) --[[ SetSearchQuery | Line: 40 ]]
	local t = {}

	if type(p2) == "string" then
		for v1 in p2:gmatch("%S+") do
			t[v1:lower()] = true
		end
	end

	p1._searchTerms = if next(t) and t then t else nil
	p1._dirtyList = true
	p1:RequestRender()
end

local function getSearchText(p1) --[[ getSearchText | Line: 52 ]]
	local t = {}

	table.insert(t, p1.Name or "")

	local ToolTip = p1.ToolTip

	if type(ToolTip) == "string" then
		table.insert(t, ToolTip)
	end

	for k, v in pairs((p1:GetAttributes())) do
		if type(v) == "string" or type(v) == "number" then
			table.insert(t, (tostring(v)))
		end
	end

	return table.concat(t, " "):lower()
end

local function countHits(p1, p2) --[[ countHits | Line: 68 ]]
	local sum = 0

	for k in pairs(p2) do
		local _, v1 = p1:gsub(k, "")

		sum = sum + v1
	end

	return sum
end

local function getFruitSortKey(p1) --[[ getFruitSortKey | Line: 77 ]]
	if p1:GetAttribute("Fruit") == nil then
		return 2, 0
	end

	return if p1:GetAttribute("Mutation") ~= nil then 0 else 1, p1:GetAttribute("SizeMultiplier") or 1
end

function t.RebuildVisibleSlots(p1) --[[ RebuildVisibleSlots | Line: 87 | Upvalues: getSearchText (copy), countHits (copy) ]]
	local _searchTerms = p1._searchTerms
	local v1 = p1.GetNumberOfHotbarSlots() + 1
	local v2 = p1.GetCurrentFilter()
	local t = {}

	for i = v1, #p1.Slots do
		local v3, v4
		local v5 = p1.Slots[i]

		if v5 and (v5.Tool and p1.ToolMatchesFilter(v5.Tool, v2)) then
			if _searchTerms then
				local v6 = countHits(getSearchText(v5.Tool), _searchTerms)

				if v6 > 0 then
					table.insert(t, {
						slot = v5,
						hits = v6,
						order = i
					})
				end

				continue
			end

			local Tool = v5.Tool

			if Tool:GetAttribute("Fruit") ~= nil then
				local v8 = Tool:GetAttribute("Mutation") ~= nil

				v3 = if v8 then 0 else 1
				v4 = Tool:GetAttribute("SizeMultiplier") or 1
			else
				v3 = 2
				v4 = 0
			end

			table.insert(t, {
				slot = v5,
				group = v3,
				size = v4,
				order = i
			})
		end
	end

	if _searchTerms then
		table.sort(t, function(p1, p2) --[[ Line: 110 ]]
			if p1.hits == p2.hits then
				return p1.order < p2.order
			end

			return p1.hits > p2.hits
		end)
	else
		table.sort(t, function(p1, p2) --[[ Line: 117 ]]
			if p1.group == p2.group then
				if p1.size == p2.size then
					return p1.order < p2.order
				end

				return p1.size > p2.size
			end

			return p1.group < p2.group
		end)
	end

	local t2 = {}

	for v10, v11 in t do
		table.insert(t2, v11.slot)
	end

	p1._visibleSlots = t2
end
function t._updateLayout(p1) --[[ _updateLayout | Line: 135 ]]
	local v2 = math.floor(p1.ScrollingFrame.AbsoluteSize.X / (p1.CellSize + p1.CellPadding))

	if v2 < 1 then
		v2 = 1
	end

	p1._columns = v2
	p1._rowHeight = p1.CellSize + p1.CellPadding
end
function t._updateCanvas(p1) --[[ _updateCanvas | Line: 144 ]]
	p1.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#p1._visibleSlots / p1._columns) * p1._rowHeight + p1.CellPadding)
end
function t._desiredRange(p1) --[[ _desiredRange | Line: 151 ]]
	local v1 = #p1._visibleSlots

	if v1 <= 0 then
		return 1, 0
	end

	local Y = p1.ScrollingFrame.CanvasPosition.Y
	local v3 = math.floor(Y / p1._rowHeight)
	local v5 = math.floor((Y + p1.ScrollingFrame.AbsoluteWindowSize.Y) / p1._rowHeight)
	local v9 = math.max(0, v3 - p1.BufferRows) * p1._columns + 1
	local v10 = (v5 + p1.BufferRows + 1) * p1._columns

	if v9 < 1 then
		v9 = 1
	end

	if v1 < v10 then
		v10 = v1
	end

	return v9, v10
end
function t._hideSlot(p1, p2) --[[ _hideSlot | Line: 174 ]]
	local v1 = if p2 then p2.Frame else p2

	if not v1 then
		return
	end

	v1.Visible = false
end
function t._showSlot(p1, p2, p3) --[[ _showSlot | Line: 181 ]]
	local v1 = if p2 then p2.Frame else p2

	if v1 then
		local v2 = p3 - 1
		local v5 = math.floor(v2 / p1._columns)

		v1.Visible = true
		v1.Position = UDim2.new(0, v2 % p1._columns * p1._rowHeight, 0, v5 * p1._rowHeight)
		v1.Size = UDim2.new(0, p1.CellSize, 0, p1.CellSize)
		v1.LayoutOrder = p3
	end
end
function t.RenderNow(p1) --[[ RenderNow | Line: 197 ]]
	if p1.IsFrozen and p1.IsFrozen() then
		p1._scheduled = false

		return
	end

	if p1._dirtyList then
		p1._dirtyList = false
		p1:RebuildVisibleSlots()
	end

	if p1._dirtyLayout then
		p1._dirtyLayout = false
		p1:_updateLayout()
	end

	p1:_updateCanvas()

	local v1, v2 = p1:_desiredRange()
	local t = {}

	for i = v1, v2 do
		local v3 = p1._visibleSlots[i]

		if v3 then
			t[v3] = i
		end
	end

	for v4 in p1._rendered do
		if not t[v4] then
			p1:_hideSlot(v4)
			p1._rendered[v4] = nil
		end
	end

	for v5, v6 in t do
		local v7 = p1._rendered[v5]

		p1:_showSlot(v5, v6)
		p1._rendered[v5] = true

		if not v7 and p1.OnShowSlot then
			p1.OnShowSlot(v5)
		end
	end

	p1._scheduled = false
end
function t.RequestRender(p1) --[[ RequestRender | Line: 242 ]]
	if not p1._scheduled then
		p1._scheduled = true
		task.defer(function() --[[ Line: 247 | Upvalues: p1 (copy) ]]
			p1:RenderNow()
		end)
	end
end
function t.ClearAll(p1) --[[ ClearAll | Line: 252 ]]
	for v1 in p1._rendered do
		p1:_hideSlot(v1)
		p1._rendered[v1] = nil
	end
end

return t