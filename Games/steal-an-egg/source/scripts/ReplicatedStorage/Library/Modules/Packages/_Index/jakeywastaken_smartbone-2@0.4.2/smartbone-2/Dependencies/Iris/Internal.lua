-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types)

return function(p1) --[[ Line: 3 ]]
	local t = {
		_started = false,
		_cycleTick = 0,
		_globalRefreshRequested = false,
		_localRefreshActive = false,
		_widgets = {},
		_widgetCount = 0,
		_stackIndex = 1,
		_rootInstance = nil
	}

	t._rootWidget = {
		ID = "R",
		type = "Root",
		ZIndex = 0,
		Instance = t._rootInstance
	}
	t._lastWidget = t._rootWidget
	t._rootConfig = {}
	t._config = t._rootConfig
	t._IDStack = { "R" }
	t._usedIDs = {}
	t._pushedId = nil
	t._nextWidgetId = nil
	t._states = {}
	t._postCycleCallbacks = {}
	t._connectedFunctions = {}
	t._cycleCoroutine = coroutine.create(function() --[[ Line: 49 | Upvalues: t (copy) ]]
		while true do
			for v1, v2 in t._connectedFunctions do
				local ok, result = pcall(v2)

				if not ok then
					t._stackIndex = 1
					coroutine.yield(false, result)
				end

				if t._stackIndex ~= 1 then
					t._stackIndex = 1
					error("Callback has too few calls to Iris.End()", 0)
				end
			end

			coroutine.yield(true)
		end
	end)

	local t2 = {}

	t2.__index = t2
	function t2.get(p1) --[[ get | Line: 82 ]]
		return p1.value
	end
	function t2.set(p1, p2) --[[ set | Line: 86 | Upvalues: t (copy) ]]
		if p2 == p1.value then
			return p1.value
		end

		p1.value = p2

		for v1, v2 in p1.ConnectedWidgets do
			t._widgets[v2.type].UpdateState(v2)
		end

		for v3, v4 in p1.ConnectedFunctions do
			v4(p2)
		end

		return p1.value
	end
	function t2.onChange(p1, p2) --[[ onChange | Line: 101 ]]
		table.insert(p1.ConnectedFunctions, p2)
	end
	t.StateClass = t2
	function t._cycle() --[[ _cycle | Line: 113 | Upvalues: p1 (copy), t (copy) ]]
		if p1.Disabled then
			return
		end

		t._rootWidget.lastCycleTick = t._cycleTick

		if t._rootInstance == nil or t._rootInstance.Parent == nil then
			p1.ForceRefresh()
		end

		for v1, v2 in t._lastVDOM do
			if v2.lastCycleTick ~= t._cycleTick then
				t._DiscardWidget(v2)
			end
		end

		t._lastVDOM = t._VDOM
		t._VDOM = t._generateEmptyVDOM()
		task.spawn(function() --[[ Line: 137 | Upvalues: t (ref) ]]
			for v1, v2 in t._postCycleCallbacks do
				v2()
			end
		end)

		if t._globalRefreshRequested then
			t._generateSelectionImageObject()
			t._globalRefreshRequested = false

			for v3, v4 in t._lastVDOM do
				t._DiscardWidget(v4)
			end

			t._generateRootInstance()
			t._lastVDOM = t._generateEmptyVDOM()
		end

		local v5 = t

		v5._cycleTick = v5._cycleTick + 1
		t._widgetCount = 0
		table.clear(t._usedIDs)

		if t.parentInstance:IsA("GuiBase2d") and math.min(t.parentInstance.AbsoluteSize.X, t.parentInstance.AbsoluteSize.Y) < 100 then
			error("Iris Parent Instance is too small")
		end

		local v6 = t.parentInstance:IsA("GuiBase2d") or (t.parentInstance:IsA("CoreGui") or (t.parentInstance:IsA("PluginGui") or t.parentInstance:IsA("PlayerGui")))

		if v6 == false then
			error("Iris Parent Instance cant contain GUI")
		end

		if game:GetService("RunService"):IsStudio() then
			for v7, v8 in t._connectedFunctions do
				v8()
			end
		else
			local v9 = coroutine.status(t._cycleCoroutine)

			if v9 == "suspended" then
				local _, v10, v11 = coroutine.resume(t._cycleCoroutine)

				if v10 == false then
					error(v11, 0)
				end
			else
				if v9 == "running" then
					error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.")
				end

				error("unrecoverable state")
			end
		end
	end
	function t._NoOp() --[[ _NoOp | Line: 208 ]] end
	function t.WidgetConstructor(p12, p2) --[[ WidgetConstructor | Line: 212 | Upvalues: t (copy), p1 (copy) ]]
		local t2 = {
			All = {
				Required = { "Generate", "Discard", "Update", "Args", "Events", "hasChildren", "hasState" },
				Optional = {}
			},
			IfState = {
				Required = { "GenerateState", "UpdateState" },
				Optional = {}
			},
			IfChildren = {
				Required = { "ChildAdded" },
				Optional = { "ChildDiscarded" }
			}
		}
		local t3 = {}

		for v1, v2 in t2.All.Required do
			local v3 = if p2[v2] == nil then false else true

			assert(v3, (("field %* is missing from widget %*, it is required for all widgets"):format(v2, p12)))
			t3[v2] = p2[v2]
		end

		for v5, v6 in t2.All.Optional do
			if p2[v6] == nil then
				t3[v6] = t._NoOp

				continue
			end

			t3[v6] = p2[v6]
		end

		if p2.hasState then
			for v7, v8 in t2.IfState.Required do
				local v9 = if p2[v8] == nil then false else true

				assert(v9, (("field %* is missing from widget %*, it is required for all widgets with state"):format(v8, p12)))
				t3[v8] = p2[v8]
			end

			for v11, v12 in t2.IfState.Optional do
				if p2[v12] == nil then
					t3[v12] = t._NoOp

					continue
				end

				t3[v12] = p2[v12]
			end
		end

		if p2.hasChildren then
			for v13, v14 in t2.IfChildren.Required do
				local v15 = if p2[v14] == nil then false else true

				assert(v15, (("field %* is missing from widget %*, it is required for all widgets with children"):format(v14, p12)))
				t3[v14] = p2[v14]
			end

			for v17, v18 in t2.IfChildren.Optional do
				if p2[v18] == nil then
					t3[v18] = t._NoOp

					continue
				end

				t3[v18] = p2[v18]
			end
		end

		t._widgets[p12] = t3
		p1.Args[p12] = t3.Args

		local t4 = {}

		for v19, v20 in t3.Args do
			t4[v20] = v19
		end

		t3.ArgNames = t4

		for v21, v22 in t3.Events do
			if p1.Events[v21] == nil then
				p1.Events[v21] = function() --[[ Line: 312 | Upvalues: t (ref), v21 (copy) ]]
					return t._EventCall(t._lastWidget, v21)
				end
			end
		end
	end
	function t._Insert(p1, p2, p3) --[[ _Insert | Line: 319 | Upvalues: t (copy) ]]
		local v1 = nil
		local v2 = t._getID(3)
		local v3 = t._widgets[p1]
		local v4 = t

		v4._widgetCount = v4._widgetCount + 1

		if t._VDOM[v2] then
			return t._ContinueWidget(v2, p1)
		end

		local t2 = {}

		if p2 ~= nil then
			if type(p2) ~= "table" then
				p2 = { p2 }
			end

			for v5, v6 in p2 do
				t2[v3.ArgNames[v5]] = v6
			end
		end

		table.freeze(t2)

		if t._lastVDOM[v2] and p1 == t._lastVDOM[v2].type then
			if t._localRefreshActive then
				t._DiscardWidget(t._lastVDOM[v2])
			else
				v1 = t._lastVDOM[v2]
			end
		end

		if v1 == nil then
			v1 = t._GenNewWidget(p1, t2, p3, v2)
		end

		if t._deepCompare(v1.providedArguments, t2) == false then
			v1.arguments = t._deepCopy(t2)
			v1.providedArguments = t2
			v3.Update(v1)
		end

		v1.lastCycleTick = t._cycleTick

		if v3.hasChildren then
			local v8 = t

			v8._stackIndex = v8._stackIndex + 1
			t._IDStack[t._stackIndex] = v1.ID
		end

		t._VDOM[v2] = v1
		t._lastWidget = v1

		return v1
	end
	function t._GenNewWidget(p1, p2, p3, p4) --[[ _GenNewWidget | Line: 386 | Upvalues: t (copy) ]]
		local v1 = t._IDStack[t._stackIndex]
		local v2 = t._widgets[p1]
		local t2 = {}

		setmetatable(t2, t2)
		t2.ID = p4
		t2.type = p1
		t2.parentWidget = t._VDOM[v1]
		t2.trackedEvents = {}
		t2.ZIndex = t2.parentWidget.ZIndex + t._widgetCount * 64 + t._config.ZIndexOffset
		t2.Instance = v2.Generate(t2)
		t2.Instance.Parent = if t._config.Parent then t._config.Parent else t._widgets[t2.parentWidget.type].ChildAdded(t2.parentWidget, t2)
		t2.providedArguments = p2
		t2.arguments = t._deepCopy(p2)
		v2.Update(t2)

		local v5

		if v2.hasState then
			if p3 then
				for v6, v7 in p3 do
					if type(v7) ~= "table" or getmetatable(v7) ~= t.StateClass then
						p3[v6] = t._widgetState(t2, v6, v7)
					end
				end

				t2.state = p3

				for v8, v9 in p3 do
					v9.ConnectedWidgets[t2.ID] = t2
				end
			else
				t2.state = {}
			end

			v2.GenerateState(t2)
			v2.UpdateState(t2)
			t2.stateMT = {}
			setmetatable(t2.state, t2.stateMT)
			t2.__index = t2.state
			v5 = t2.stateMT
		else
			v5 = t2
		end

		function v5.__index(p1, p2) --[[ Line: 450 | Upvalues: t (ref), t2 (copy) ]]
			return function() --[[ Line: 451 | Upvalues: t (ref), t2 (ref), p2 (copy) ]]
				return t._EventCall(t2, p2)
			end
		end

		return t2
	end
	function t._ContinueWidget(p1, p2) --[[ _ContinueWidget | Line: 458 | Upvalues: t (copy) ]]
		local v2 = t._VDOM[p1]

		if t._widgets[p2].hasChildren then
			local v3 = t

			v3._stackIndex = v3._stackIndex + 1
			t._IDStack[t._stackIndex] = v2.ID
		end

		t._lastWidget = v2

		return v2
	end
	function t._DiscardWidget(p1) --[[ _DiscardWidget | Line: 472 | Upvalues: t (copy) ]]
		local parentWidget = p1.parentWidget

		if parentWidget then
			t._widgets[parentWidget.type].ChildDiscarded(parentWidget, p1)
		end

		t._widgets[p1.type].Discard(p1)
	end
	function t._widgetState(p1, p2, p3) --[[ _widgetState | Line: 483 | Upvalues: t (copy) ]]
		local v1 = p1.ID .. p2

		if t._states[v1] then
			t._states[v1].ConnectedWidgets[p1.ID] = p1
		else
			t._states[v1] = {
				value = p3,
				ConnectedWidgets = {
					[p1.ID] = p1
				},
				ConnectedFunctions = {}
			}
			setmetatable(t._states[v1], t.StateClass)
		end

		return t._states[v1]
	end
	function t._EventCall(p1, p2) --[[ _EventCall | Line: 499 | Upvalues: t (copy) ]]
		local v1 = t._widgets[p1.type].Events[p2]

		assert(v1 ~= nil, (("widget %* has no event of name %*"):format(p1.type, p2)))

		if p1.trackedEvents[p2] == nil then
			v1.Init(p1)
			p1.trackedEvents[p2] = true
		end

		return v1.Get(p1)
	end
	function t._GetParentWidget() --[[ _GetParentWidget | Line: 511 | Upvalues: t (copy) ]]
		return t._VDOM[t._IDStack[t._stackIndex]]
	end
	function t._generateEmptyVDOM() --[[ _generateEmptyVDOM | Line: 517 | Upvalues: t (copy) ]]
		return {
			R = t._rootWidget
		}
	end
	function t._generateRootInstance() --[[ _generateRootInstance | Line: 523 | Upvalues: t (copy) ]]
		t._rootInstance = t._widgets.Root.Generate(t._widgets.Root)
		t._rootInstance.Parent = t.parentInstance
		t._rootWidget.Instance = t._rootInstance
	end
	function t._generateSelectionImageObject() --[[ _generateSelectionImageObject | Line: 530 | Upvalues: t (copy) ]]
		local v1, v2, v3

		if t.SelectionImageObject then
			t.SelectionImageObject:Destroy()
		end

		v1 = Instance.new("Frame")
		v1.Position = UDim2.fromOffset(-1, -1)
		v1.Size = UDim2.new(1, 2, 1, 2)
		v1.BackgroundColor3 = t._config.SelectionImageObjectColor
		v1.BackgroundTransparency = t._config.SelectionImageObjectTransparency
		v1.BorderSizePixel = 0
		v2 = Instance.new("UIStroke")
		v2.Thickness = 1
		v2.Color = t._config.SelectionImageObjectBorderColor
		v2.Transparency = t._config.SelectionImageObjectBorderTransparency
		v2.LineJoinMode = Enum.LineJoinMode.Round
		v2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		v2.Parent = v1
		v3 = Instance.new("UICorner")
		v3.CornerRadius = UDim.new(0, 2)
		v3.Parent = v1
		t.SelectionImageObject = v1
	end
	function t._getID(p1) --[[ _getID | Line: 561 | Upvalues: t (copy) ]]
		if t._nextWidgetId then
			local _nextWidgetId = t._nextWidgetId

			t._nextWidgetId = nil

			return _nextWidgetId
		end

		local count = 1 + (p1 or 1)
		local v1 = debug.info(count, "l")
		local v2 = ""

		while v1 ~= -1 and v1 ~= nil do
			count = count + 1
			v1, v2 = debug.info(count, "l"), v2 .. "+" .. v1
		end

		if t._usedIDs[v2] then
			local _usedIDs = t._usedIDs

			_usedIDs[v2] = _usedIDs[v2] + 1
		else
			t._usedIDs[v2] = 1
		end

		return v2 .. ":" .. (if t._pushedId then t._pushedId else t._usedIDs[v2])
	end
	function t._deepCompare(p1, p2) --[[ _deepCompare | Line: 588 | Upvalues: t (copy) ]]
		for v1, v2 in p1 do
			local v3 = p2[v1]

			if type(v2) == "table" then
				if not v3 or type(v3) ~= "table" then
					return false
				end

				if t._deepCompare(v2, v3) == false then
					return false
				end

				continue
			end

			if type(v2) ~= type(v3) or v2 ~= v3 then
				return false
			end
		end

		return true
	end
	function t._deepCopy(p1) --[[ _deepCopy | Line: 610 | Upvalues: t (copy) ]]
		local t2 = {}

		for k, v in pairs(p1) do
			if type(v) == "table" then
				v = t._deepCopy(v)
			end

			t2[k] = v
		end

		return t2
	end
	t._lastVDOM = t._generateEmptyVDOM()
	t._VDOM = t._generateEmptyVDOM()
	p1.Internal = t
	p1._config = t._config

	return t
end