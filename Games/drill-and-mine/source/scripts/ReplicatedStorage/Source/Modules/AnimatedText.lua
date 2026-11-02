--[[
	AnimatedText (v8)
	Per-character text animation ported from devexfire.com's input mirror,
	driven by the site's EXACT CSS cubic-bezier curves:

	  charEnter: 0.22s cubic-bezier(.34,1.56,.64,1)
	             from { opacity 0; translateY(-0.45em); scale(0.55) }
	  charLeave: 0.18s cubic-bezier(.4,0,.6,1)
	             to   { opacity 0; translateY(+0.45em); scale(0.55) }
	  transform-origin: 50% 70%
	  wobble:    container scale 1.06 -> 1 (AnimatedText.Pop)

	Stroke paint order (v7): native Roblox text draws ALL glyph outlines
	behind ALL glyph fills, so an outline never overdraws its neighbor's
	fill. Stacked per-char layers broke that — each char's UIStroke bit
	into the previous char's fill (worse on big screens where
	UiStrokeScaler thickens strokes), reading as "overlapping squished
	text". Now every char on a stroked label is TWO CanvasGroups:
	  - stroke layer (glyph fill hidden, cloned UIStrokes) at ZIndex z
	  - fill layer   (glyph fill + gradient slice, no strokes) at z+1
	All stroke layers sit below all fill layers inside the overlay, exactly
	matching the native pass order. Both layers move/scale/fade in lockstep
	from the same animation closure. Unstroked labels keep a single layer.

	Font metrics (v8): measurements key on FontFace and go through
	GetTextBoundsAsync for fonts with no legacy Enum.Font equivalent
	(GetTextSize throws on Enum.Font.Unknown, so e.g. GothamSSm ExtraBold
	layouted on flat fallback widths -- on billboards TextScaled then
	crushed wide glyphs: the tiny "m" in "1m 21s"). Async metrics defer
	the flush until cached. Billboard char boxes get width headroom so
	TextScaled sizes purely by height -- every char renders the same size.
	Rendering (v4): CanvasGroups composite each layer once — animations
	write only Position + UIScale.Scale + GroupTransparency (no re-raster
	shimmer). Billboard labels use plain TextScaled chars.
	Coordination (v5): one step connection (RenderStepped on clients) is
	the flush dispatcher + geometry syncer + animation driver; sibling
	labels animate in lockstep; survivors slide on the enter bezier.
	Geometry sync (v6): AbsoluteSize changes trigger same-frame in-place
	resync of every char (cached measurements, no destruction), so text
	stays correct throughout FrameAnimator open/close/pulse tweens.
	Core (v2/v3): MaxVisibleGraphemes=0 hides the original text; index
	diff animates only changed chars; prefix-width kerning-accurate layout;
	horizontal gradients sliced per char; updates coalesce per 0.1s.

	Value pop (v9): any bound label whose FIRST number increases (commas
	stripped, K/M/B/T suffix honored: "$676.676m", "1.5K", "67/67") also
	does a whole-label scale pulse -- smooth ease up, spring back down --
	on top of the per-char animation. AnimatedText.Pop(gui, amount) is the
	shared pulse primitive (AnimatedTextController reuses it for growing
	progress-bar fills). The v6 geometry sync absorbs the AbsoluteSize
	churn the pulse causes on bound labels.

	Twin binding (v10): AT_Bind = true force-binds a label -- it beats an
	INHERITED AT_Ignore (flattened twin stacks keep AT_Ignore on their
	invisible BACK label; the visible front child opts back in with
	AT_Bind, e.g. UpgradeShop cards / HUD counters) as well as the
	shadow-twin rule. Shadow "Double" children of text labels also bind by
	default now, so front + shadow flush the same frame and animate in
	lockstep; only the shadow's own whole-label grow pulse is muted (the
	parent's _ATPop already scales it as a child -- an own pulse on top
	would hit scale^2 and pop the shadow out).

	Usage:
	  AnimatedText.Bind(label) / BindAll(root) / BindWorldGuis(workspace)
	  AnimatedText.Unbind(label) / AnimatedText.Pop(gui, amount?)
	Opt-out: attribute AT_Ignore = true on a label or any ancestor.
]]

local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")

local AnimatedText = {}

local ENTER_TIME = 0.22
local LEAVE_TIME = 0.18
local POP_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local GROW_POP = 1.12
local GROW_UP_INFO = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local GROW_DOWN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local SCALE_FROM = 0.55
local DROP_FACTOR = 0.45
local ANCHOR_Y = 0.7
local FLUSH_INTERVAL = 0.1
local RAPID_WINDOW = 0.35
local RAPID_ENTER_TIME = 0.12
-- Burst guard (v11): when MORE than this many idle labels flush in the same
-- step pass (rebirth reset cascade, payload storms rewriting a whole frame),
-- building + animating per-char overlays for all of them lands in ONE frame
-- and hitches. Those labels swap via plain native text instead; labels in
-- counter cadence (rapid) keep animating, and the next calm change animates
-- normally again.
local BURST_LIMIT = 4
local MAX_CHARS = 40
local MEASURE_SIZE = 50
local IGNORE_ATTR = "AT_Ignore"
local OVERLAY_NAME = "_AnimText"

local bindings = {}
local measureCache = {}
local measureCount = 0

-- ===== CSS cubic-bezier evaluator =====

local function cssBezier(x1, y1, x2, y2)
	local function sampleX(t)
		local mt = 1 - t
		return 3 * mt * mt * t * x1 + 3 * mt * t * t * x2 + t * t * t
	end
	local function sampleY(t)
		local mt = 1 - t
		return 3 * mt * mt * t * y1 + 3 * mt * t * t * y2 + t * t * t
	end
	local function dX(t)
		local mt = 1 - t
		return 3 * mt * mt * x1 + 6 * mt * t * (x2 - x1) + 3 * t * t * (1 - x2)
	end
	return function(x)
		if x <= 0 then return 0 end
		if x >= 1 then return 1 end
		local t = x
		for _ = 1, 6 do
			local err = sampleX(t) - x
			if math.abs(err) < 1e-4 then break end
			local d = dX(t)
			if math.abs(d) < 1e-6 then break end
			t = math.clamp(t - err / d, 0, 1)
		end
		return sampleY(t)
	end
end

local ENTER_EASE = cssBezier(0.34, 1.56, 0.64, 1)
local LEAVE_EASE = cssBezier(0.4, 0, 0.6, 1)

-- ===== unified frame step =====

local stepSignal = RunService:IsClient() and RunService.RenderStepped or RunService.Heartbeat
local activeAnims = {}
local dirty = {}
local needsSync = {}
local flushImpl, syncImpl
local stepConn = nil
local burstPass = false

-- "idle" = not in counter cadence: counters flush every FLUSH_INTERVAL and
-- must never trip (or be muted by) the burst guard -- while mining, the HUD
-- cash/strength/income labels alone can exceed BURST_LIMIT in one pass.
local function isIdleFlush(binding, now)
	return binding.lastApplyAt == nil or (now - binding.lastApplyAt) >= RAPID_WINDOW
end

local function step()
	local now = os.clock()
	-- syncImpl/flushImpl return true to request a retry (font metrics still
	-- being fetched async). Collect and re-add AFTER each loop: re-adding a
	-- removed key during pairs() iteration is undefined behavior.
	local resync = nil
	for binding in pairs(needsSync) do
		needsSync[binding] = nil
		if bindings[binding.label] == binding and binding.overlay then
			local ok, waiting = pcall(syncImpl, binding)
			if ok and waiting then
				resync = resync or {}
				resync[#resync + 1] = binding
			end
		end
	end
	if resync then
		for _, b in ipairs(resync) do
			needsSync[b] = true
		end
	end
	-- burst census BEFORE flushing: how many idle labels are about to flush
	-- together this pass (see BURST_LIMIT above)
	local freshFlushes = 0
	for binding in pairs(dirty) do
		if now - binding.lastFlush >= FLUSH_INTERVAL and isIdleFlush(binding, now) then
			freshFlushes += 1
		end
	end
	burstPass = freshFlushes > BURST_LIMIT

	local redirty = nil
	for binding in pairs(dirty) do
		if now - binding.lastFlush >= FLUSH_INTERVAL then
			dirty[binding] = nil
			if bindings[binding.label] == binding then
				local ok, retry = pcall(flushImpl, binding)
				if not ok then
					warn("[AnimatedText]", binding.label:GetFullName(), retry)
				elseif retry then
					redirty = redirty or {}
					redirty[#redirty + 1] = binding
				end
			end
		end
	end
	if redirty then
		for _, b in ipairs(redirty) do
			dirty[b] = true
		end
	end
	for i = #activeAnims, 1, -1 do
		local a = activeAnims[i]
		if a.cancelled then
			table.remove(activeAnims, i)
		else
			local p = math.clamp((now - a.t0) / a.dur, 0, 1)
			local ok = pcall(a.apply, a.ease(p), p)
			if not ok or p >= 1 then
				table.remove(activeAnims, i)
				if ok and a.onDone then task.spawn(a.onDone) end
			end
		end
	end
	if #activeAnims == 0 and next(dirty) == nil and next(needsSync) == nil and stepConn then
		stepConn:Disconnect()
		stepConn = nil
	end
end

local function ensureStep()
	if not stepConn then
		stepConn = stepSignal:Connect(step)
	end
end

local function animate(dur, ease, apply, onDone)
	local a = { t0 = os.clock(), dur = dur, ease = ease, apply = apply, onDone = onDone }
	apply(ease(0), 0)
	table.insert(activeAnims, a)
	ensureStep()
	return a
end

-- ===== measuring / layout =====

-- Cache keys on FontFace identity: tostring(label.Font) collapsed every
-- non-legacy font (e.g. GothamSSm ExtraBold) to "Enum.Font.Unknown", and
-- GetTextSize refuses Enum.Font.Unknown outright, so those labels laid out
-- on a flat fallback width.
local function fontInfoOf(label)
	local face = label.FontFace
	return {
		face = face,
		legacy = label.Font, -- Enum.Font.Unknown when no legacy equivalent
		key = face.Family .. "|" .. tostring(face.Weight) .. "|" .. tostring(face.Style),
	}
end

local measureQueue = {} -- cacheKey -> {face, text}
local measureWorkerRunning = false

local function cacheMeasure(key, v)
	measureCount += 1
	if measureCount > 8000 then
		measureCache = {}
		measureCount = 0
	end
	measureCache[key] = v
end

local function runMeasureWorker()
	if measureWorkerRunning then return end
	measureWorkerRunning = true
	task.spawn(function()
		local params = Instance.new("GetTextBoundsParams")
		params.Width = 100000
		params.Size = MEASURE_SIZE
		while true do
			local key, req = next(measureQueue)
			if not key then break end
			measureQueue[key] = nil
			if not measureCache[key] then
				params.Font = req.face
				params.Text = req.text
				local ok, result = pcall(TextService.GetTextBoundsAsync, TextService, params)
				cacheMeasure(key, ok and result or Vector2.new(#req.text * MEASURE_SIZE * 0.5, MEASURE_SIZE))
			end
		end
		measureWorkerRunning = false
	end)
end

-- Returns the measured size, or nil when the metrics are being fetched
-- async via GetTextBoundsAsync. There is deliberately NO wakeup from the
-- worker (it completes synchronously for warm fonts, racing any waiter
-- registration): deferred flushes/syncs stay in dirty/needsSync and the
-- step loop retries them until the cache is filled.
local function measure(fontInfo, text)
	local key = fontInfo.key .. "|" .. text
	local v = measureCache[key]
	if v then return v end
	if fontInfo.legacy ~= Enum.Font.Unknown then
		local ok, result = pcall(TextService.GetTextSize, TextService, text, MEASURE_SIZE, fontInfo.legacy, Vector2.new(100000, 100000))
		v = ok and result or Vector2.new(#text * MEASURE_SIZE * 0.5, MEASURE_SIZE)
		cacheMeasure(key, v)
		return v
	end
	measureQueue[key] = { face = fontInfo.face, text = text }
	runMeasureWorker()
	-- a warm font measures without yielding (always in edit, often in
	-- game), so the worker may have just filled the cache synchronously
	return measureCache[key]
end

local function splitGraphemes(s)
	local out = {}
	local ok = pcall(function()
		for first, last in utf8.graphemes(s) do
			out[#out + 1] = string.sub(s, first, last)
		end
	end)
	if not ok then
		table.clear(out)
		for i = 1, #s do out[i] = string.sub(s, i, i) end
	end
	return out
end

-- "value grew" detection: first number in the string, commas stripped,
-- abbreviation suffix applied when glued straight onto the digits (full
-- ladder matching FormatUtils.Abbreviate: K/M/B/T/Qd/Qn/Sx/Sp/Oc/No/Dc/...)
local SUFFIX_MULT = {
	k = 1e3, m = 1e6, b = 1e9, t = 1e12,
	qd = 1e15, qn = 1e18, sx = 1e21, sp = 1e24, oc = 1e27, no = 1e30,
	dc = 1e33, ud = 1e36, dd = 1e39, td = 1e42,
}
local function firstNumber(text)
	local num, suffix = text:gsub(",", ""):match("(%d+%.?%d*)(%a*)")
	if not num then return nil end
	local n = tonumber(num)
	if not n then return nil end
	local mult = SUFFIX_MULT[suffix:lower()]
	return mult and n * mult or n
end

local function isIgnored(inst)
	local cur = inst
	while cur do
		if cur:GetAttribute(IGNORE_ATTR) then return true end
		cur = cur.Parent
	end
	return false
end

-- Cumulative UIScale product affecting the label's rendered size: its own
-- UIScale children (_ATPop pulses) plus every ancestor GuiObject's (e.g. the
-- HoverController's HoverScale on buttons). Layout must work in PRE-scale
-- pixels: AbsoluteSize already includes these scales AND the renderer
-- multiplies pixel geometry by them again, so laying out from the scaled
-- size makes overlay chars track hover/pop tweens at scale^2 while native
-- text (the front "Double" twin) tracks at scale^1 -- the shadow copy
-- visibly detaches on every hovered button. Dividing the scales out keeps
-- both copies in lockstep, and pure-scale tweens now hit the syncImpl
-- early-out instead of re-layouting every frame.
local function cumulativeUIScale(label)
	local s = 1
	local cur = label
	while cur and not cur:IsA("LayerCollector") do
		if cur:IsA("GuiObject") then
			for _, c in ipairs(cur:GetChildren()) do
				if c:IsA("UIScale") then
					s *= c.Scale
				end
			end
		end
		cur = cur.Parent
	end
	return s
end

local function isOnScreen(label)
	if label.AbsoluteSize.X < 2 then return false end
	local cur = label
	while cur do
		if cur:IsA("LayerCollector") then
			return cur.Enabled
		elseif cur:IsA("GuiObject") then
			if not cur.Visible then return false end
		end
		cur = cur.Parent
	end
	return false
end

local function computeLayout(label, glyphs)
	local uiScale = cumulativeUIScale(label)
	if uiScale < 1e-3 then return nil end
	local absW, absH = label.AbsoluteSize.X / uiScale, label.AbsoluteSize.Y / uiScale
	if absW < 2 or absH < 2 then return nil end
	local fontInfo = fontInfoOf(label)
	local joined = table.concat(glyphs)

	-- gather every metric up front (one async batch for uncached fonts)
	local full = measure(fontInfo, joined)
	local lineRefSize = measure(fontInfo, "Ag")
	local prefixSizes = table.create(#glyphs)
	local waiting = not (full and lineRefSize)
	local prefixStr = ""
	for i, g in ipairs(glyphs) do
		prefixStr = prefixStr .. g
		prefixSizes[i] = measure(fontInfo, prefixStr)
		waiting = waiting or not prefixSizes[i]
	end
	if waiting then
		return nil, true
	end
	local lineRef = lineRefSize.Y

	local effSize
	if label.TextScaled then
		local s = MEASURE_SIZE * math.min(
			full.X > 0 and absW / full.X or 100,
			lineRef > 0 and absH / lineRef or 100
		)
		effSize = math.clamp(math.floor(s), 1, 100)
	else
		effSize = label.TextSize
	end
	local f = effSize / MEASURE_SIZE

	local widths = table.create(#glyphs)
	local prev = 0
	for i in ipairs(glyphs) do
		local w = prefixSizes[i].X
		widths[i] = math.max((w - prev) * f, 1)
		prev = w
	end
	local total = prev * f
	local lineH = lineRef * f

	if total > absW * 1.15 and (label.TextWrapped or label.TextTruncate ~= Enum.TextTruncate.None) then
		return nil
	end

	local startX
	if label.TextXAlignment == Enum.TextXAlignment.Left then
		startX = 0
	elseif label.TextXAlignment == Enum.TextXAlignment.Right then
		startX = absW - total
	else
		startX = (absW - total) / 2
	end
	local yPx
	if label.TextYAlignment == Enum.TextYAlignment.Top then
		yPx = lineH / 2
	elseif label.TextYAlignment == Enum.TextYAlignment.Bottom then
		yPx = absH - lineH / 2
	else
		yPx = absH / 2
	end

	local xScales = table.create(#glyphs)
	local x = startX
	for i in ipairs(glyphs) do
		xScales[i] = (x + widths[i] / 2) / absW
		x += widths[i]
	end
	return {
		effSize = effSize,
		widths = widths,
		lineH = lineH,
		xScales = xScales,
		yScale = yPx / absH,
		absW = absW,
		absH = absH,
	}
end

local function isSupported(label, text)
	if label.RichText and text:find("<") then return false end
	if text:find("\n") then return false end
	return true
end

-- ===== gradient slicing =====

local function evalColor(seq, t)
	local kps = seq.Keypoints
	if t <= kps[1].Time then return kps[1].Value end
	if t >= kps[#kps].Time then return kps[#kps].Value end
	for i = 1, #kps - 1 do
		local a, b = kps[i], kps[i + 1]
		if t >= a.Time and t <= b.Time then
			local fr = (t - a.Time) / math.max(b.Time - a.Time, 1e-6)
			return a.Value:Lerp(b.Value, fr)
		end
	end
	return kps[#kps].Value
end

local function evalNumber(seq, t)
	local kps = seq.Keypoints
	if t <= kps[1].Time then return kps[1].Value end
	if t >= kps[#kps].Time then return kps[#kps].Value end
	for i = 1, #kps - 1 do
		local a, b = kps[i], kps[i + 1]
		if t >= a.Time and t <= b.Time then
			local fr = (t - a.Time) / math.max(b.Time - a.Time, 1e-6)
			return a.Value + (b.Value - a.Value) * fr
		end
	end
	return kps[#kps].Value
end

local function sliceTimes(seq, t0, t1)
	local times = { t0 }
	for _, kp in ipairs(seq.Keypoints) do
		if kp.Time > t0 + 1e-4 and kp.Time < t1 - 1e-4 then
			times[#times + 1] = kp.Time
		end
	end
	times[#times + 1] = t1
	return times
end

local function cloneGradientFor(grad, inst, t0, t1)
	local r = grad.Rotation % 360
	if r < 0 then r += 360 end
	local axis = r % 180
	if axis > 45 and axis < 135 then
		grad:Clone().Parent = inst
		return
	end
	if r > 90 and r < 270 then
		t0, t1 = 1 - t1, 1 - t0
	end
	t0 = math.clamp(t0, 0, 1)
	t1 = math.clamp(t1, t0 + 1e-3, 1)
	local span = t1 - t0

	local g = Instance.new("UIGradient")
	g.Rotation = grad.Rotation
	g.Offset = grad.Offset
	g.Enabled = grad.Enabled

	local ckps = {}
	for _, t in ipairs(sliceTimes(grad.Color, t0, t1)) do
		ckps[#ckps + 1] = ColorSequenceKeypoint.new(math.clamp((t - t0) / span, 0, 1), evalColor(grad.Color, t))
	end
	local nkps = {}
	for _, t in ipairs(sliceTimes(grad.Transparency, t0, t1)) do
		nkps[#nkps + 1] = NumberSequenceKeypoint.new(math.clamp((t - t0) / span, 0, 1), evalNumber(grad.Transparency, t))
	end
	local okC = pcall(function() g.Color = ColorSequence.new(ckps) end)
	local okN = pcall(function() g.Transparency = NumberSequence.new(nkps) end)
	if not (okC and okN) then
		g:Destroy()
		grad:Clone().Parent = inst
		return
	end
	g.Parent = inst
end

-- ===== char helpers =====

local function charPosition(rec, dropK)
	if rec.scaleMode then
		return UDim2.new(rec.xScale, 0, rec.ys + rec.dropFrac * dropK, 0)
	end
	return UDim2.new(rec.xScale, 0, rec.ys, rec.yo + rec.dropPx * dropK)
end

local function eachLayer(rec, fn)
	fn(rec.fillC, rec.scaleF)
	if rec.strokeC then fn(rec.strokeC, rec.scaleS) end
end

local function setCharPosition(rec, pos)
	rec.fillC.Position = pos
	if rec.strokeC then rec.strokeC.Position = pos end
end

local function setCharScale(rec, s)
	rec.scaleF.Scale = s
	if rec.scaleS then rec.scaleS.Scale = s end
end

local function setCharGroupT(rec, t)
	rec.fillC.GroupTransparency = t
	if rec.strokeC then rec.strokeC.GroupTransparency = t end
end

local function destroyChar(rec)
	rec.fillC:Destroy()
	if rec.strokeC then rec.strokeC:Destroy() end
end

local function maxStrokeThickness(label)
	local m = 0
	for _, c in ipairs(label:GetChildren()) do
		if c:IsA("UIStroke") then m = math.max(m, c.Thickness) end
	end
	return m
end

local function setCharGeometry(rec, binding, layout, index)
	rec.xScale = layout.xScales[index]
	rec.dropPx = math.max(4, layout.effSize * DROP_FACTOR)
	rec.dropFrac = (layout.lineH * DROP_FACTOR) / layout.absH
	if rec.scaleMode then
		rec.ys = layout.yScale + (ANCHOR_Y - 0.5) * (layout.lineH / layout.absH)
		rec.yo = 0
		-- one lineH of width headroom so TextScaled is never width-bound:
		-- glyph size comes from box height alone, identical for every char
		-- (exact advance-width boxes let kerning/rounding shrink glyphs)
		rec.boxW = layout.widths[index] + layout.lineH
		rec.fillC.Size = UDim2.fromScale(rec.boxW / layout.absW, layout.lineH / layout.absH)
	else
		rec.ys = layout.yScale
		rec.yo = (ANCHOR_Y - 0.5) * layout.lineH
		local w = math.ceil(layout.widths[index]) + 2
		local h = math.ceil(layout.lineH)
		local pad = math.ceil(binding.strokePad + layout.lineH * 0.25)
		local sizeKey = w .. "x" .. h .. "x" .. pad
		if rec.sizeKey ~= sizeKey then
			rec.sizeKey = sizeKey
			local canvasSize = UDim2.fromOffset(w + 2 * pad, h + 2 * pad)
			local innerSize = UDim2.fromOffset(w, h)
			local anchor = Vector2.new(0.5, (pad + ANCHOR_Y * h) / (h + 2 * pad))
			rec.fillC.Size = canvasSize
			rec.fillC.AnchorPoint = anchor
			rec.inner.Size = innerSize
			rec.inner.TextSize = layout.effSize
			if rec.strokeC then
				rec.strokeC.Size = canvasSize
				rec.strokeC.AnchorPoint = anchor
				rec.strokeInner.Size = innerSize
				rec.strokeInner.TextSize = layout.effSize
			end
		end
	end
end

local function liveStrokeT(binding)
	local s = binding.srcStroke
	return (s and s.Parent) and s.Transparency or 0
end

-- Instantly restore a char to its settled visual state (scale 1, settled
-- position, live transparencies). Needed when an instant apply cancels a
-- mid-flight enter/slide: the cancelled anim otherwise leaves the char
-- frozen half-transparent with a washed-out stroke ("missing outline").
local function snapCharVisual(binding, rec)
	setCharScale(rec, 1)
	setCharPosition(rec, charPosition(rec, 0))
	if rec.scaleMode then
		rec.inner.TextTransparency = binding.label.TextTransparency
		local sT = liveStrokeT(binding)
		for _, s in ipairs(rec.strokes) do
			s.Transparency = sT
		end
	else
		setCharGroupT(rec, 0)
	end
end

local function cancelAnim(rec)
	if rec.anim then
		rec.anim.cancelled = true
		rec.anim = nil
	end
	if rec.moveAnim then
		rec.moveAnim.cancelled = true
		rec.moveAnim = nil
	end
end

local function moveChar(rec)
	if rec.moveAnim then rec.moveAnim.cancelled = true end
	local from = rec.fillC.Position
	local fxs, fxo = from.X.Scale, from.X.Offset
	local fys, fyo = from.Y.Scale, from.Y.Offset
	rec.moveAnim = animate(ENTER_TIME, ENTER_EASE, function(a)
		if not rec.fillC.Parent then return end
		local t = charPosition(rec, 0)
		setCharPosition(rec, UDim2.new(
			fxs + (t.X.Scale - fxs) * a,
			fxo + (t.X.Offset - fxo) * a,
			fys + (t.Y.Scale - fys) * a,
			fyo + (t.Y.Offset - fyo) * a
		))
	end, function()
		rec.moveAnim = nil
	end)
end

-- UI code across the game sets Text recursively on every descendant
-- TextLabel (shadow "Double" copies etc.), which also stomps the per-char
-- glyph labels inside the overlay -- every char slot then renders the FULL
-- string, stacked on its neighbors (garbled prices). Snap any outside
-- write back to the char's own glyph; the connection dies with the label.
local function guardGlyphText(l, glyph)
	l:GetPropertyChangedSignal("Text"):Connect(function()
		if l.Text ~= glyph then
			l.Text = glyph
		end
	end)
end

local function makeGlyphLabel(label, glyph)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.BorderSizePixel = 0
	l.AutoLocalize = false
	l.FontFace = label.FontFace
	l.TextWrapped = false
	l.TextScaled = false
	l.Text = glyph
	l.AnchorPoint = Vector2.new(0.5, 0.5)
	l.Position = UDim2.fromScale(0.5, 0.5)
	guardGlyphText(l, glyph)
	return l
end

local function createChar(binding, glyph, layout, index, animate_)
	local label = binding.label
	local rec = {
		glyph = glyph,
		strokes = {},
		scaleMode = binding.scaleMode,
	}

	if binding.scaleMode then
		-- billboard: single plain TextScaled label
		local inner = Instance.new("TextLabel")
		inner:SetAttribute(IGNORE_ATTR, true)
		inner.Name = "C"
		inner.BackgroundTransparency = 1
		inner.BorderSizePixel = 0
		inner.AutoLocalize = false
		inner.FontFace = label.FontFace
		inner.TextWrapped = false
		inner.TextScaled = true
		inner.Text = glyph
		guardGlyphText(inner, glyph)
		inner.TextColor3 = label.TextColor3
		inner.TextStrokeColor3 = label.TextStrokeColor3
		inner.TextStrokeTransparency = label.TextStrokeTransparency
		inner.TextTransparency = label.TextTransparency
		inner.ZIndex = binding.charZIndex
		inner.AnchorPoint = Vector2.new(0.5, ANCHOR_Y)
		rec.fillC = inner
		rec.inner = inner
		setCharGeometry(rec, binding, layout, index)
		-- gradient window spans the widened box (the gradient maps across
		-- the whole char label, not just the glyph's advance width)
		local halfW = rec.boxW / (2 * layout.absW)
		for _, child in ipairs(label:GetChildren()) do
			if child:IsA("UIGradient") then
				cloneGradientFor(child, inner, rec.xScale - halfW, rec.xScale + halfW)
			elseif child:IsA("UIStroke") then
				local c = child:Clone()
				c.Parent = inner
				rec.strokes[#rec.strokes + 1] = c
			end
		end
		local scale = Instance.new("UIScale")
		scale.Scale = 1
		scale.Parent = inner
		rec.scaleF = scale
	else
		local hasStroke = binding.srcStroke ~= nil
		local halfW -- gradient window, filled after geometry

		-- fill layer: glyph + gradient, NO strokes
		local fillC = Instance.new("CanvasGroup")
		fillC:SetAttribute(IGNORE_ATTR, true)
		fillC.Name = "C"
		fillC.BackgroundTransparency = 1
		fillC.BorderSizePixel = 0
		fillC.GroupTransparency = 0
		fillC.ZIndex = binding.charZIndex + 1
		local inner = makeGlyphLabel(label, glyph)
		inner.Name = "G"
		inner.TextColor3 = label.TextColor3
		inner.TextStrokeColor3 = label.TextStrokeColor3
		inner.TextStrokeTransparency = label.TextStrokeTransparency
		inner.TextTransparency = label.TextTransparency
		rec.fillC = fillC
		rec.inner = inner

		-- stroke layer: same glyph with hidden fill + the cloned strokes;
		-- ALL stroke layers render below ALL fill layers (native pass order)
		if hasStroke then
			local strokeC = Instance.new("CanvasGroup")
			strokeC:SetAttribute(IGNORE_ATTR, true)
			strokeC.Name = "CS"
			strokeC.BackgroundTransparency = 1
			strokeC.BorderSizePixel = 0
			strokeC.GroupTransparency = 0
			strokeC.ZIndex = binding.charZIndex
			local sInner = makeGlyphLabel(label, glyph)
			sInner.Name = "S"
			sInner.TextTransparency = 1 -- fill hidden; only the outline paints
			sInner.TextStrokeTransparency = 1
			rec.strokeC = strokeC
			rec.strokeInner = sInner
		end

		setCharGeometry(rec, binding, layout, index)
		halfW = layout.widths[index] / (2 * layout.absW)

		for _, child in ipairs(label:GetChildren()) do
			if child:IsA("UIGradient") then
				cloneGradientFor(child, inner, rec.xScale - halfW, rec.xScale + halfW)
				if rec.strokeInner then
					cloneGradientFor(child, rec.strokeInner, rec.xScale - halfW, rec.xScale + halfW)
				end
			elseif child:IsA("UIStroke") and rec.strokeInner then
				local c = child:Clone()
				c.Transparency = liveStrokeT(binding)
				c.Parent = rec.strokeInner
				rec.strokes[#rec.strokes + 1] = c
			end
		end

		local scaleF = Instance.new("UIScale")
		scaleF.Scale = 1
		scaleF.Parent = fillC
		rec.scaleF = scaleF
		inner.Parent = fillC
		if rec.strokeC then
			local scaleS = Instance.new("UIScale")
			scaleS.Scale = 1
			scaleS.Parent = rec.strokeC
			rec.scaleS = scaleS
			rec.strokeInner.Parent = rec.strokeC
		end
	end

	local pos = charPosition(rec, 0)
	setCharPosition(rec, pos)
	if rec.strokeC then rec.strokeC.Parent = binding.overlay end
	rec.fillC.Parent = binding.overlay

	if animate_ then
		-- "rapid" enters (counters rewriting every flush): same drop+pop
		-- motion but NO opacity channel -- restarting a fade at 10Hz kept
		-- chars half-transparent with washed-out strokes -- and a shorter
		-- duration so each pop lands between updates.
		local rapid = animate_ == "rapid"
		local dur = rapid and RAPID_ENTER_TIME or ENTER_TIME
		if not binding.scaleMode then
			rec.anim = animate(dur, ENTER_EASE, function(a)
				if not rec.fillC.Parent then return end
				setCharPosition(rec, charPosition(rec, -(1 - a)))
				setCharScale(rec, SCALE_FROM + (1 - SCALE_FROM) * a)
				if not rapid then
					setCharGroupT(rec, 1 - math.clamp(a, 0, 1))
				end
			end, function()
				rec.anim = nil
			end)
		else
			local inner = rec.inner
			rec.anim = animate(dur, ENTER_EASE, function(a)
				if not inner.Parent then return end
				setCharPosition(rec, charPosition(rec, -(1 - a)))
				setCharScale(rec, SCALE_FROM + (1 - SCALE_FROM) * a)
				if not rapid then
					local aC = math.clamp(a, 0, 1)
					inner.TextTransparency = math.clamp(1 + (binding.label.TextTransparency - 1) * aC, 0, 1)
					local sT = liveStrokeT(binding)
					for _, s in ipairs(rec.strokes) do
						s.Transparency = math.clamp(1 + (sT - 1) * aC, 0, 1)
					end
				end
			end, function()
				rec.anim = nil
			end)
		end
	end
	return rec
end

local function leaveChar(binding, rec, animate_)
	if not animate_ then
		cancelAnim(rec)
		destroyChar(rec)
		return
	end
	local startScale = rec.scaleF.Scale
	local startK = 0
	if rec.anim or rec.moveAnim then
		local pos = rec.fillC.Position
		if rec.scaleMode then
			startK = rec.dropFrac ~= 0 and (pos.Y.Scale - rec.ys) / rec.dropFrac or 0
		else
			startK = rec.dropPx ~= 0 and (pos.Y.Offset - rec.yo) / rec.dropPx or 0
		end
	end
	cancelAnim(rec)

	if not rec.scaleMode then
		local g0 = rec.fillC.GroupTransparency
		rec.anim = animate(LEAVE_TIME, LEAVE_EASE, function(a)
			if not rec.fillC.Parent then return end
			setCharPosition(rec, charPosition(rec, startK + (1 - startK) * a))
			setCharScale(rec, startScale + (SCALE_FROM - startScale) * a)
			local aC = math.clamp(a, 0, 1)
			setCharGroupT(rec, math.clamp(g0 + (1 - g0) * aC, 0, 1))
		end, function()
			rec.anim = nil
			destroyChar(rec)
		end)
	else
		local inner = rec.inner
		local startT = inner.TextTransparency
		local startStrokeT = {}
		for i, s in ipairs(rec.strokes) do startStrokeT[i] = s.Transparency end
		rec.anim = animate(LEAVE_TIME, LEAVE_EASE, function(a)
			if not inner.Parent then return end
			setCharPosition(rec, charPosition(rec, startK + (1 - startK) * a))
			setCharScale(rec, startScale + (SCALE_FROM - startScale) * a)
			local aC = math.clamp(a, 0, 1)
			inner.TextTransparency = math.clamp(startT + (1 - startT) * aC, 0, 1)
			for i, s in ipairs(rec.strokes) do
				local st = startStrokeT[i] or 0
				s.Transparency = math.clamp(st + (1 - st) * aC, 0, 1)
			end
		end, function()
			rec.anim = nil
			destroyChar(rec)
		end)
	end
	task.delay(LEAVE_TIME + 0.1, function()
		destroyChar(rec)
	end)
end

local function destroyOverlay(binding, restore)
	for _, c in ipairs(binding.overlayConns) do c:Disconnect() end
	table.clear(binding.overlayConns)
	for _, rec in ipairs(binding.chars) do cancelAnim(rec) end
	if binding.overlay then
		binding.overlay:Destroy()
		binding.overlay = nil
	end
	binding.chars = {}
	needsSync[binding] = nil
	if restore and binding.origMaxVisible ~= nil then
		binding.label.MaxVisibleGraphemes = binding.origMaxVisible
		binding.origMaxVisible = nil
	end
end

syncImpl = function(binding)
	local label = binding.label
	local uiScale = cumulativeUIScale(label)
	if uiScale < 1e-3 then return end
	local sz = label.AbsoluteSize / uiScale
	if math.abs(sz.X - (binding.builtW or 0)) < 0.75 and math.abs(sz.Y - (binding.builtH or 0)) < 0.75 then
		return
	end
	if sz.X < 2 or sz.Y < 2 then return end
	local layout, waitingMeasure
	if #binding.glyphs <= MAX_CHARS then
		layout, waitingMeasure = computeLayout(label, binding.glyphs)
	end
	if not layout then
		return waitingMeasure -- true => step re-queues this sync
	end
	if #binding.chars ~= #binding.glyphs then return end
	for i, rec in ipairs(binding.chars) do
		setCharGeometry(rec, binding, layout, i)
		if not rec.anim and not rec.moveAnim then
			setCharPosition(rec, charPosition(rec, 0))
		end
	end
	binding.effSize = layout.effSize
	binding.yScale = layout.yScale
	binding.builtW, binding.builtH = layout.absW, layout.absH
end

local function buildOverlay(binding)
	local label = binding.label
	local old = label:FindFirstChild(OVERLAY_NAME)
	if old then old:Destroy() end

	local collector = label:FindFirstAncestorWhichIsA("LayerCollector")
	binding.scaleMode = collector ~= nil and collector:IsA("BillboardGui")
	binding.strokePad = maxStrokeThickness(label)
	binding.srcStroke = label:FindFirstChildOfClass("UIStroke")

	local overlay = Instance.new("Frame")
	overlay.Name = OVERLAY_NAME
	overlay:SetAttribute(IGNORE_ATTR, true)
	overlay.BackgroundTransparency = 1
	overlay.BorderSizePixel = 0
	overlay.Size = UDim2.fromScale(1, 1)
	overlay.Active = false

	if collector and collector.ZIndexBehavior == Enum.ZIndexBehavior.Global then
		overlay.ZIndex = label.ZIndex
		binding.charZIndex = label.ZIndex
	else
		overlay.ZIndex = -10000
		binding.charZIndex = 1
	end

	binding.overlay = overlay
	binding.origMaxVisible = label.MaxVisibleGraphemes
	label.MaxVisibleGraphemes = 0
	overlay.Parent = label

	local oldLayout = #binding.glyphs > 0 and #binding.glyphs <= MAX_CHARS
		and computeLayout(label, binding.glyphs) or nil
	binding.chars = {}
	local preScale = label.AbsoluteSize / math.max(cumulativeUIScale(label), 1e-3)
	binding.builtW, binding.builtH = preScale.X, preScale.Y
	if oldLayout then
		binding.effSize = oldLayout.effSize
		binding.yScale = oldLayout.yScale
		for i, g in ipairs(binding.glyphs) do
			binding.chars[i] = createChar(binding, g, oldLayout, i, false)
		end
	else
		binding.glyphs = {}
	end

	table.insert(binding.overlayConns, label:GetPropertyChangedSignal("TextTransparency"):Connect(function()
		for _, rec in ipairs(binding.chars) do
			if not (rec.scaleMode and rec.anim) then
				rec.inner.TextTransparency = label.TextTransparency
			end
		end
	end))
	table.insert(binding.overlayConns, label:GetPropertyChangedSignal("TextColor3"):Connect(function()
		for _, rec in ipairs(binding.chars) do
			rec.inner.TextColor3 = label.TextColor3
		end
	end))
	if binding.srcStroke then
		table.insert(binding.overlayConns, binding.srcStroke:GetPropertyChangedSignal("Transparency"):Connect(function()
			local v = binding.srcStroke.Transparency
			for _, rec in ipairs(binding.chars) do
				if not (rec.scaleMode and rec.anim) then
					for _, s in ipairs(rec.strokes) do
						s.Transparency = v
					end
				end
			end
		end))
		-- BillboardStrokeScaler thins the source stroke with camera distance
		-- (overhead strength tag, ported 2026-07-21); mirror Thickness onto
		-- the per-char clones so animated digits don't keep fat outlines
		-- while zoomed out. Thickness is never tween-animated, so no guard.
		table.insert(binding.overlayConns, binding.srcStroke:GetPropertyChangedSignal("Thickness"):Connect(function()
			local v = binding.srcStroke.Thickness
			for _, rec in ipairs(binding.chars) do
				for _, s in ipairs(rec.strokes) do
					s.Thickness = v
				end
			end
		end))
	end
	if not binding.scaleMode then
		table.insert(binding.overlayConns, label:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			needsSync[binding] = true
			ensureStep()
		end))
	end
end

local function applyText(binding, newGlyphs, layout, animate_)
	local old = binding.glyphs
	local chars = binding.chars
	local newChars = table.create(#newGlyphs)
	local effChanged = binding.effSize ~= layout.effSize
	local n = math.max(#old, #newGlyphs)
	for i = 1, n do
		local og, ng = old[i], newGlyphs[i]
		local rec = chars[i]
		if og and ng and og == ng and rec then
			local moved = rec.xScale ~= layout.xScales[i] or effChanged or binding.yScale ~= layout.yScale
			setCharGeometry(rec, binding, layout, i)
			if moved then
				if rec.anim then
					-- enter/leave reads live geometry; nothing else to do
				elseif animate_ then
					moveChar(rec)
				else
					cancelAnim(rec)
					snapCharVisual(binding, rec)
				end
			end
			newChars[i] = rec
		elseif animate_ == "rapid" then
			-- counter cadence: no leave ghost (stacked ghosts read as digits
			-- smeared into each other) but ALWAYS play the enter pop -- it
			-- has no opacity channel so restarts can't strand a faded char
			if rec then leaveChar(binding, rec, false) end
			if ng then
				newChars[i] = createChar(binding, ng, layout, i, "rapid")
			end
		else
			-- Updates faster than ENTER_TIME (but slower than RAPID_WINDOW)
			-- used to re-trigger the pop while the previous one was
			-- mid-flight, so 1-char numbers never reached full size. If the
			-- outgoing char is still animating, swap instantly; the next
			-- change after a pause animates normally.
			local midSwap = rec ~= nil and (rec.anim ~= nil or rec.moveAnim ~= nil)
			if rec then leaveChar(binding, rec, animate_ and not midSwap) end
			if ng then
				newChars[i] = createChar(binding, ng, layout, i, animate_ and not midSwap)
			end
		end
	end
	binding.chars = newChars
	binding.glyphs = newGlyphs
	binding.effSize = layout.effSize
	binding.yScale = layout.yScale
	binding.builtW, binding.builtH = layout.absW, layout.absH
end

flushImpl = function(binding)
	local label = binding.label
	if not label.Parent then return end
	local newText = binding.pending
	binding.pending = nil
	local oldText = table.concat(binding.glyphs)
	if newText == nil or newText == oldText then return end
	binding.lastFlush = os.clock()

	-- growing value -> whole-label pulse (in addition to the char anims)
	local oldValue = firstNumber(oldText)
	local newValue = firstNumber(newText)
	local grew = oldValue ~= nil and newValue ~= nil and newValue > oldValue + 1e-9

	local glyphs = splitGraphemes(newText)
	local onScreen = isOnScreen(label)

	if not binding.overlay and not onScreen then
		binding.glyphs = glyphs
		return
	end

	-- Burst guard: instant native swap, no overlay, no pulse. lastApplyAt is
	-- deliberately NOT touched -- a follow-up wave 0.1s later (attr change
	-- then payload push) must still count as idle so it burst-guards too
	-- instead of overlay-building in rapid mode.
	if burstPass and isIdleFlush(binding, os.clock()) then
		destroyOverlay(binding, true)
		binding.glyphs = glyphs
		return
	end

	local layout, waitingMeasure
	if isSupported(label, newText) and #glyphs <= MAX_CHARS then
		layout, waitingMeasure = computeLayout(label, glyphs)
	end

	if waitingMeasure then
		-- async font metrics on the way; stay dirty so step retries this
		-- flush on the normal cadence until the cache fills
		binding.pending = newText
		return true
	end

	if not layout then
		destroyOverlay(binding, true)
		binding.glyphs = glyphs
		-- AT_NoPulse: char anims stay, the whole-label grow pulse is muted --
		-- for labels whose CONTAINER is pulsed externally (level readout),
		-- where a per-label pop on top reads as the bar scaling apart.
		if onScreen then
			AnimatedText.Pop(label, (grew and not binding.mutePulse and not label:GetAttribute("AT_NoPulse")) and GROW_POP or nil)
		end
		return
	end

	if not binding.overlay then
		buildOverlay(binding)
	end
	-- Counter labels (cash lerps etc) rewrite their text every flush; the
	-- FULL animation at that cadence stacks leave-ghosts on entering chars
	-- and keeps strokes stuck mid-fade (digits smear into each other).
	-- Changes arriving faster than RAPID_WINDOW use "rapid" mode: the
	-- drop+pop still plays on every change, but with no leave ghosts and
	-- no opacity fade, so fast counting stays crisp and outlined.
	local now = os.clock()
	local rapid = binding.lastApplyAt ~= nil and (now - binding.lastApplyAt) < RAPID_WINDOW
	binding.lastApplyAt = now
	local mode
	if not onScreen then
		mode = false
	elseif rapid then
		mode = "rapid"
	else
		mode = true
	end
	applyText(binding, glyphs, layout, mode)
	if onScreen and grew and not binding.mutePulse and not label:GetAttribute("AT_NoPulse") then
		AnimatedText.Pop(label, GROW_POP)
	end
end

function AnimatedText.Pop(gui, amount)
	local scale = gui:FindFirstChild("_ATPop")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "_ATPop"
		scale.Parent = gui
	end
	if amount then
		-- growing-value pulse: smooth ease up, spring back down. Retriggers
		-- while counting keep the label gently inflated until the last
		-- update's up-tween completes, then it springs home.
		local up = TweenService:Create(scale, GROW_UP_INFO, { Scale = amount })
		up.Completed:Once(function(state)
			if state == Enum.PlaybackState.Completed then
				TweenService:Create(scale, GROW_DOWN_INFO, { Scale = 1 }):Play()
			end
		end)
		up:Play()
	else
		scale.Scale = 1.06
		TweenService:Create(scale, POP_INFO, { Scale = 1 }):Play()
	end
end

function AnimatedText.Bind(label)
	if bindings[label] then return end
	if not (label:IsA("TextLabel") or label:IsA("TextButton")) then return end
	-- AT_Bind = true force-binds: it beats an inherited AT_Ignore. Flattened
	-- twin stacks (UpgradeShop cards, HUD Cash/Storage/Extra) keep AT_Ignore
	-- on the invisible BACK label; without this override that ignore cascades
	-- onto the visible front child and the whole frame silently stops
	-- animating. It also bypasses the shadow-twin handling below (level-bar
	-- Doubles are FRONT texts and keep their normal pulse semantics).
	local forceBind = label:GetAttribute("AT_Bind") == true
	if not forceBind and isIgnored(label) then return end
	-- Shadow-twin: a label named "Double" parented directly under another text
	-- label is a drop-shadow duplicate (its text is mirrored by the UI text
	-- setters). It used to stay UNBOUND (static native text riding the
	-- parent's pulse), but a static shadow snaps to the new string the moment
	-- it's mirrored while the front chars are still mid enter/leave -- for
	-- ~0.2s the two copies show DIFFERENT text. Now it binds like any label so
	-- front + shadow flush the same frame (v5 lockstep), with its OWN grow
	-- pulse muted: the parent's _ATPop already scales the shadow (it's a
	-- child), so an own pulse on top would stack to scale^2 and visibly pop
	-- the shadow out of the front text.
	local mutePulse = false
	if not forceBind and label.Name == "Double" then
		local parent = label.Parent
		if parent and (parent:IsA("TextLabel") or parent:IsA("TextButton")) then
			mutePulse = true
		end
	end
	local binding = {
		label = label,
		glyphs = splitGraphemes(label.Text),
		chars = {},
		overlay = nil,
		overlayConns = {},
		conns = {},
		pending = nil,
		lastFlush = 0,
		mutePulse = mutePulse,
	}
	bindings[label] = binding
	table.insert(binding.conns, label:GetPropertyChangedSignal("Text"):Connect(function()
		binding.pending = label.Text
		dirty[binding] = true
		ensureStep()
	end))
	table.insert(binding.conns, label.Destroying:Connect(function()
		AnimatedText.Unbind(label)
	end))
	table.insert(binding.conns, label.AncestryChanged:Connect(function()
		if not label:IsDescendantOf(game) then
			AnimatedText.Unbind(label)
		end
	end))
end

function AnimatedText.Unbind(label)
	local binding = bindings[label]
	if not binding then return end
	bindings[label] = nil
	dirty[binding] = nil
	needsSync[binding] = nil
	for _, c in ipairs(binding.conns) do c:Disconnect() end
	destroyOverlay(binding, label.Parent ~= nil)
end

function AnimatedText.BindAll(root)
	local function try(inst)
		if inst:IsA("TextLabel") or inst:IsA("TextButton") then
			AnimatedText.Bind(inst)
		end
	end
	for _, d in ipairs(root:GetDescendants()) do
		try(d)
	end
	root.DescendantAdded:Connect(try)
end

function AnimatedText.BindWorldGuis(container)
	local function try(inst)
		if (inst:IsA("TextLabel") or inst:IsA("TextButton"))
			and inst:FindFirstAncestorWhichIsA("LayerCollector") then
			AnimatedText.Bind(inst)
		end
	end
	for _, d in ipairs(container:GetDescendants()) do
		try(d)
	end
	container.DescendantAdded:Connect(try)
end

return AnimatedText
