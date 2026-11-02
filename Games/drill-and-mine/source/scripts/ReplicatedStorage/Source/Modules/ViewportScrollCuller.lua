--[[
	ViewportScrollCuller
	Perf-only helper: in a card ScrollingFrame (Drill shop, loot Index) every
	ViewportFrame re-renders its 3D model each frame -- including cards
	scrolled far outside the visible window (28 drill / 52 index models all
	live at once). Attach() keeps only the viewports on cards inside (or
	within half a window of) the visible scroll window Visible; the rest stop
	rendering. Purely a render gate: layout, scrolling and card looks are
	unchanged, and the half-window margin means a viewport is already back on
	before its card can scroll into view.
]]

local ViewportScrollCuller = {}

-- extra slack around the visible window (fraction of window size)
local MARGIN = 0.5

local attached = {} -- [scroll] = {refresh = fn, suspended = bool}

function ViewportScrollCuller.Attach(scroll)
	if attached[scroll] then
		return
	end
	local state = { suspended = false, resuming = false, resumeToken = 0 }
	attached[scroll] = state
	local viewportsByCard = {} -- [card] = {ViewportFrame, ...}
	local cacheDirty = true
	local pending = false

	local function rebuildCache()
		cacheDirty = false
		table.clear(viewportsByCard)
		for _, card in ipairs(scroll:GetChildren()) do
			if card:IsA("GuiObject") then
				local list
				for _, desc in ipairs(card:GetDescendants()) do
					if desc:IsA("ViewportFrame") then
						list = list or {}
						list[#list + 1] = desc
					end
				end
				if list then
					viewportsByCard[card] = list
				end
			end
		end
	end

	local function refresh()
		if cacheDirty then
			rebuildCache()
		end
		-- suspended (a frame open/close size tween is running): every
		-- AbsoluteSize change re-renders every visible viewport that frame,
		-- so they all stay off until the caller resumes
		if state.suspended then
			for _, list in pairs(viewportsByCard) do
				for _, viewport in ipairs(list) do
					if viewport.Visible then
						viewport.Visible = false
					end
				end
			end
			return
		end
		-- a staggered resume is revealing viewports one per frame; it owns
		-- visibility until it finishes and calls refresh() itself
		if state.resuming then
			return
		end
		local windowSize = scroll.AbsoluteWindowSize
		if windowSize.X <= 0 or windowSize.Y <= 0 then
			return
		end
		local windowPos = scroll.AbsolutePosition
		local minX = windowPos.X - windowSize.X * MARGIN
		local maxX = windowPos.X + windowSize.X * (1 + MARGIN)
		local minY = windowPos.Y - windowSize.Y * MARGIN
		local maxY = windowPos.Y + windowSize.Y * (1 + MARGIN)
		for card, list in pairs(viewportsByCard) do
			if card.Parent ~= scroll then
				viewportsByCard[card] = nil
			else
				local pos = card.AbsolutePosition
				local size = card.AbsoluteSize
				local inWindow = pos.X + size.X >= minX and pos.X <= maxX
					and pos.Y + size.Y >= minY and pos.Y <= maxY
				for _, viewport in ipairs(list) do
					if viewport.Visible ~= inWindow then
						viewport.Visible = inWindow
					end
				end
			end
		end
	end

	-- coalesce property spam (CanvasPosition fires every scrolled frame,
	-- AbsoluteWindowSize fires per frame of the open tween) into at most
	-- one refresh per frame
	local function schedule()
		if pending then
			return
		end
		pending = true
		task.defer(function()
			pending = false
			refresh()
		end)
	end

	local function markDirty()
		cacheDirty = true
		schedule()
	end

	-- in-window viewports only, for SetSuspended's staggered resume
	local function collectInWindow()
		if cacheDirty then
			rebuildCache()
		end
		local windowSize = scroll.AbsoluteWindowSize
		if windowSize.X <= 0 or windowSize.Y <= 0 then
			return nil
		end
		local windowPos = scroll.AbsolutePosition
		local minX = windowPos.X - windowSize.X * MARGIN
		local maxX = windowPos.X + windowSize.X * (1 + MARGIN)
		local minY = windowPos.Y - windowSize.Y * MARGIN
		local maxY = windowPos.Y + windowSize.Y * (1 + MARGIN)
		local result = {}
		for card, list in pairs(viewportsByCard) do
			if card.Parent == scroll then
				local pos = card.AbsolutePosition
				local size = card.AbsoluteSize
				local inWindow = pos.X + size.X >= minX and pos.X <= maxX
					and pos.Y + size.Y >= minY and pos.Y <= maxY
				if inWindow then
					for _, viewport in ipairs(list) do
						result[#result + 1] = viewport
					end
				end
			end
		end
		return result
	end
	state.collectInWindow = collectInWindow

	scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(schedule)
	scroll:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(schedule)
	scroll:GetPropertyChangedSignal("AbsolutePosition"):Connect(schedule)
	scroll.ChildAdded:Connect(markDirty)
	scroll.ChildRemoved:Connect(markDirty)
	state.refresh = refresh
	scroll.AncestryChanged:Connect(function(_, parent)
		if not parent then
			attached[scroll] = nil
		end
	end)
	schedule()
end

-- While a frame's open/close animation tweens sizes, every AbsoluteSize
-- change forces every visible ViewportFrame to re-render its 3D model that
-- frame (up to all 28/52 cards early in the open tween, when the tiny
-- window overlaps everything). Suspend hides all managed viewports; resume
-- restores exactly the in-window set. Static viewports are near-free, so
-- revealing once the frame has essentially settled removes the whole
-- per-frame 3D cost of the open/close animation.
function ViewportScrollCuller.SetSuspended(scroll, suspended)
	local state = attached[scroll]
	if not state or state.suspended == suspended then
		return
	end
	state.suspended = suspended
	state.resumeToken += 1
	if suspended then
		state.resuming = false
		if state.refresh then
			state.refresh()
		end
		return
	end
	-- resume: reveal the in-window set ONE viewport per frame. Un-hiding
	-- them all at once made every card model do its first 3D render in the
	-- same frame -- a visible hitch right as the open anim settles. ~8
	-- cards over ~8 frames is imperceptible.
	local token = state.resumeToken
	state.resuming = true
	task.spawn(function()
		local toShow = state.collectInWindow and state.collectInWindow() or nil
		if toShow then
			for _, viewport in ipairs(toShow) do
				if state.resumeToken ~= token then
					return
				end
				if viewport.Parent then
					viewport.Visible = true
				end
				task.wait()
			end
		end
		if state.resumeToken == token then
			state.resuming = false
			if state.refresh then
				state.refresh()
			end
		end
	end)
end

return ViewportScrollCuller
