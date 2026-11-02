-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:25
-- Luau version 6, Types version 3
-- Time taken: 0.017845 seconds

local HttpService_upvr = game:GetService("HttpService")
return function(arg1) -- Line 5
	--[[ Upvalues[1]:
		[1]: HttpService_upvr (readonly)
	]]
	local module_upvr = {
		_version = " 2.3.1 ";
		_started = false;
		_shutdown = false;
		_cycleTick = 0;
		_globalRefreshRequested = false;
		_localRefreshActive = false;
		_widgets = {};
		_stackIndex = 1;
		_rootInstance = nil;
		_rootWidget = {
			ID = 'R';
			type = "Root";
			Instance = module_upvr._rootInstance;
			ZIndex = 0;
			ZOffset = 0;
		};
		_lastWidget = module_upvr._rootWidget;
		_rootConfig = {};
		_config = module_upvr._rootConfig;
		_IDStack = {'R'};
		_usedIDs = {};
		_pushedId = nil;
		_nextWidgetId = nil;
		_states = {};
		_postCycleCallbacks = {};
		_connectedFunctions = {};
		_connections = {};
		_initFunctions = {};
		_fullErrorTracebacks = game:GetService("RunService"):IsStudio();
		_cycleCoroutine = coroutine.create(function() -- Line 71
			--[[ Upvalues[1]:
				[1]: module_upvr (readonly)
			]]
			while module_upvr._started do
				for _, v in module_upvr._connectedFunctions do
					debug.profilebegin("Iris/Connection")
					local pcall_result1, pcall_result2 = pcall(v)
					debug.profileend()
					if not pcall_result1 then
						module_upvr._stackIndex = 1
						coroutine.yield(false, pcall_result2)
					end
				end
				coroutine.yield(true)
			end
		end);
	}
	local tbl_6 = {}
	tbl_6.__index = tbl_6
	function tbl_6.get(arg1_2) -- Line 130
		return arg1_2.value
	end
	function tbl_6.set(arg1_3, arg2) -- Line 140
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if arg2 == arg1_3.value then
			return arg1_3.value
		end
		arg1_3.value = arg2
		for _, v_2 in arg1_3.ConnectedWidgets do
			module_upvr._widgets[v_2.type].UpdateState(v_2)
		end
		for _, v_3 in arg1_3.ConnectedFunctions do
			v_3(arg2)
		end
		return arg1_3.value
	end
	function tbl_6.onChange(arg1_4, arg2) -- Line 161
		local var16_upvr = #arg1_4.ConnectedFunctions + 1
		arg1_4.ConnectedFunctions[var16_upvr] = arg2
		return function() -- Line 164
			--[[ Upvalues[2]:
				[1]: arg1_4 (readonly)
				[2]: var16_upvr (readonly)
			]]
			arg1_4.ConnectedFunctions[var16_upvr] = nil
		end
	end
	module_upvr.StateClass = tbl_6
	function module_upvr._cycle() -- Line 183
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: module_upvr (readonly)
		]]
		if arg1.Disabled then
		else
			module_upvr._rootWidget.lastCycleTick = module_upvr._cycleTick
			if module_upvr._rootInstance == nil or module_upvr._rootInstance.Parent == nil then
				arg1.ForceRefresh()
			end
			for _, v_16 in module_upvr._lastVDOM do
				if v_16.lastCycleTick ~= module_upvr._cycleTick and v_16.lastCycleTick ~= -1 then
					module_upvr._DiscardWidget(v_16)
				end
			end
			setmetatable(module_upvr._lastVDOM, {
				__mode = "kv";
			})
			module_upvr._lastVDOM = module_upvr._VDOM
			module_upvr._VDOM = module_upvr._generateEmptyVDOM()
			task.spawn(function() -- Line 209
				--[[ Upvalues[1]:
					[1]: module_upvr (copied, readonly)
				]]
				for _, v_17 in module_upvr._postCycleCallbacks do
					v_17()
				end
			end)
			if module_upvr._globalRefreshRequested then
				module_upvr._generateSelectionImageObject()
				module_upvr._globalRefreshRequested = false
				for _, v_18 in module_upvr._lastVDOM do
					module_upvr._DiscardWidget(v_18)
				end
				module_upvr._generateRootInstance()
				module_upvr._lastVDOM = module_upvr._generateEmptyVDOM()
			end
			local var78 = module_upvr
			var78._cycleTick += 1
			table.clear(module_upvr._usedIDs)
			local children_2 = module_upvr.parentInstance:IsA("GuiBase2d")
			if not children_2 then
				children_2 = module_upvr.parentInstance:IsA("CoreGui")
				if not children_2 then
					children_2 = module_upvr.parentInstance:IsA("PluginGui")
					if not children_2 then
						children_2 = module_upvr.parentInstance:IsA("PlayerGui")
					end
				end
			end
			if children_2 == false then
				error("Iris Parent Instance cant contain GUI")
			end
			if module_upvr._fullErrorTracebacks then
				for _, v_19 in module_upvr._connectedFunctions do
					v_19()
				end
				-- KONSTANTWARNING: GOTO [216] #154
			end
			local coroutine_status_result1_3 = coroutine.status(module_upvr._cycleCoroutine)
			if coroutine_status_result1_3 == "suspended" then
				local _, coroutine_resume_result2_2, coroutine_resume_result3_2 = coroutine.resume(module_upvr._cycleCoroutine)
				if coroutine_resume_result2_2 == false then
					error(coroutine_resume_result3_2, 0)
					-- KONSTANTWARNING: GOTO [216] #154
				end
			elseif coroutine_status_result1_3 == "running" then
				error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.")
			else
				error("unrecoverable state")
			end
			if module_upvr._stackIndex ~= 1 then
				module_upvr._stackIndex = 1
				error("Callback has too few calls to Iris.End()", 0)
			end
		end
	end
	function module_upvr._NoOp() -- Line 286
	end
	function module_upvr.WidgetConstructor(arg1_5, arg2) -- Line 300
		--[[ Upvalues[2]:
			[1]: module_upvr (readonly)
			[2]: arg1 (readonly)
		]]
		local tbl_2 = {
			All = {
				Required = {"Generate", "Discard", "Update", "Args", "Events", "hasChildren", "hasState"};
				Optional = {};
			};
			IfState = {
				Required = {"GenerateState", "UpdateState"};
				Optional = {};
			};
			IfChildren = {
				Required = {"ChildAdded"};
				Optional = {"ChildDiscarded"};
			};
		}
		local tbl = {}
		for _, v_4 in tbl_2.All.Required do
			local var125
			if arg2[v_4] == nil then
				var125 = false
			else
				var125 = true
			end
			assert(var125, `field {v_4} is missing from widget {arg1_5}, it is required for all widgets`)
			tbl[v_4] = arg2[v_4]
		end
		for i_5, v_5 in tbl_2.All.Optional do
			if arg2[v_5] == nil then
				var125 = module_upvr
				tbl[v_5] = var125._NoOp
			else
				tbl[v_5] = arg2[v_5]
			end
		end
		if arg2.hasState then
			i_5 = tbl_2.IfState
			for _, v_6 in i_5.Required do
				if arg2[v_6] == nil then
					var125 = false
				else
					var125 = true
				end
				assert(var125, `field {v_6} is missing from widget {arg1_5}, it is required for all widgets with state`)
				tbl[v_6] = arg2[v_6]
			end
			for _, v_7 in tbl_2.IfState.Optional do
				if arg2[v_7] == nil then
					var125 = module_upvr
					tbl[v_7] = var125._NoOp
				else
					tbl[v_7] = arg2[v_7]
				end
			end
		end
		if arg2.hasChildren then
			for _, v_8 in tbl_2.IfChildren.Required do
				if arg2[v_8] == nil then
					var125 = false
				else
					var125 = true
				end
				assert(var125, `field {v_8} is missing from widget {arg1_5}, it is required for all widgets with children`)
				tbl[v_8] = arg2[v_8]
			end
			for _, v_9 in tbl_2.IfChildren.Optional do
				if arg2[v_9] == nil then
					var125 = module_upvr
					tbl[v_9] = var125._NoOp
				else
					tbl[v_9] = arg2[v_9]
				end
			end
		end
		module_upvr._widgets[arg1_5] = tbl
		arg1.Args[arg1_5] = tbl.Args
		for i_10, v_10 in tbl.Args do
			({})[v_10] = i_10
			local var127
		end
		tbl.ArgNames = var127
		for i_11_upvr, _ in tbl.Events do
			if arg1.Events[i_11_upvr] == nil then
				arg1.Events[i_11_upvr] = function() -- Line 391
					--[[ Upvalues[2]:
						[1]: module_upvr (copied, readonly)
						[2]: i_11_upvr (readonly)
					]]
					return module_upvr._EventCall(module_upvr._lastWidget, i_11_upvr)
				end
			end
		end
	end
	function module_upvr._Insert(arg1_6, arg2, arg3) -- Line 409
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local any__getID_result1 = module_upvr._getID(3)
		local var155 = module_upvr._widgets[arg1_6]
		if module_upvr._VDOM[any__getID_result1] then
			return module_upvr._ContinueWidget(any__getID_result1, arg1_6)
		end
		local var157
		if var157 ~= nil then
			if type(var157) ~= "table" then
				var157 = {var157}
			end
			for i_12, v_12 in var157 do
				({})[var155.ArgNames[i_12]] = v_12
				local var159
			end
		end
		table.freeze(var159)
		local var160 = module_upvr._lastVDOM[any__getID_result1]
		if var160 and arg1_6 == var160.type and module_upvr._localRefreshActive then
			module_upvr._DiscardWidget(var160)
			var160 = nil
		end
		if var160 == nil then
			i_12 = var159
			v_12 = arg3
			local _ = module_upvr._GenNewWidget(arg1_6, i_12, v_12, any__getID_result1)
		else
		end
		local parentWidget_3 = var160.parentWidget
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		i_12 = var160.type
		if i_12 ~= "Window" then
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			i_12 = var160.type
			if i_12 ~= "Tooltip" then
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				i_12 = var160.ZIndex
				v_12 = parentWidget_3.ZOffset
				if i_12 ~= v_12 then
					i_12 = true
					parentWidget_3.ZUpdate = i_12
				end
				i_12 = parentWidget_3.ZUpdate
				if i_12 then
					i_12 = parentWidget_3.ZOffset
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var160.ZIndex = i_12
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					i_12 = var160.Instance
					if i_12 then
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						i_12 = var160.Instance
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						v_12 = var160.ZIndex
						i_12.ZIndex = v_12
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						i_12 = var160.Instance
						-- KONSTANTERROR: Expression was reused, decompilation is incorrect
						v_12 = var160.ZIndex
						i_12.LayoutOrder = v_12
					end
				end
			end
		end
		v_12 = module_upvr
		i_12 = v_12._deepCompare
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		v_12 = var160.providedArguments
		i_12 = i_12(v_12, var159)
		if i_12 == false then
			v_12 = module_upvr
			i_12 = v_12._deepCopy
			v_12 = var159
			i_12 = i_12(v_12)
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			var160.arguments = i_12
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			var160.providedArguments = var159
			i_12 = var155.Update
			v_12 = var160
			i_12(v_12)
		end
		v_12 = module_upvr
		i_12 = v_12._cycleTick
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		var160.lastCycleTick = i_12
		i_12 = parentWidget_3.ZOffset
		i_12 += 1
		parentWidget_3.ZOffset = i_12
		i_12 = var155.hasChildren
		if i_12 then
			i_12 = 0
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			var160.ZOffset = i_12
			i_12 = false
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			var160.ZUpdate = i_12
			i_12 = module_upvr
			v_12 = i_12._stackIndex
			v_12 += 1
			i_12._stackIndex = v_12
			v_12 = module_upvr
			i_12 = v_12._IDStack
			v_12 = module_upvr._stackIndex
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			i_12[v_12] = var160.ID
		end
		v_12 = module_upvr
		i_12 = v_12._VDOM
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		i_12[any__getID_result1] = var160
		i_12 = module_upvr
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		i_12._lastWidget = var160
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		return var160
	end
	function module_upvr._GenNewWidget(arg1_7, arg2, arg3, arg4) -- Line 502
		--[[ Upvalues[2]:
			[1]: module_upvr (readonly)
			[2]: HttpService_upvr (copied, readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var179 = module_upvr._VDOM[module_upvr._IDStack[module_upvr._stackIndex]]
		local var180 = module_upvr._widgets[arg1_7]
		local module_upvr_2 = {}
		setmetatable(module_upvr_2, module_upvr_2)
		module_upvr_2.ID = arg4
		module_upvr_2.type = arg1_7
		module_upvr_2.parentWidget = var179
		module_upvr_2.trackedEvents = {}
		module_upvr_2.UID = HttpService_upvr:GenerateGUID(false):sub(0, 8)
		module_upvr_2.ZIndex = var179.ZOffset
		module_upvr_2.Instance = var180.Generate(module_upvr_2)
		local parentWidget_4 = module_upvr_2.parentWidget
		local var183
		if var183 then
			var183 = module_upvr_2.Instance
			var183.Parent = module_upvr._config.Parent
		else
			var183 = module_upvr_2.Instance
			var183.Parent = module_upvr._widgets[parentWidget_4.type].ChildAdded(parentWidget_4, module_upvr_2)
		end
		module_upvr_2.providedArguments = arg2
		var183 = module_upvr._deepCopy(arg2)
		module_upvr_2.arguments = var183
		var183 = var180.Update
		var183(module_upvr_2)
		var183 = nil
		if var180.hasState then
			if arg3 then
				for i_13, v_13 in arg3 do
					if type(v_13) ~= "table" or getmetatable(v_13) ~= module_upvr.StateClass then
						arg3[i_13] = module_upvr._widgetState(module_upvr_2, i_13, v_13)
					end
				end
				module_upvr_2.state = arg3
				for _, v_14 in arg3 do
					v_14.ConnectedWidgets[module_upvr_2.ID] = module_upvr_2
				end
			else
				module_upvr_2.state = {}
			end
			var180.GenerateState(module_upvr_2)
			var180.UpdateState(module_upvr_2)
			module_upvr_2.stateMT = {}
			setmetatable(module_upvr_2.state, module_upvr_2.stateMT)
			module_upvr_2.__index = module_upvr_2.state
			var183 = module_upvr_2.stateMT
		else
			var183 = module_upvr_2
		end
		function var183.__index(arg1_8, arg2_2) -- Line 566
			--[[ Upvalues[2]:
				[1]: module_upvr (copied, readonly)
				[2]: module_upvr_2 (readonly)
			]]
			return function() -- Line 567
				--[[ Upvalues[3]:
					[1]: module_upvr (copied, readonly)
					[2]: module_upvr_2 (copied, readonly)
					[3]: arg2_2 (readonly)
				]]
				return module_upvr._EventCall(module_upvr_2, arg2_2)
			end
		end
		return module_upvr_2
	end
	function module_upvr._ContinueWidget(arg1_9, arg2) -- Line 585
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		local var186 = module_upvr._VDOM[arg1_9]
		if module_upvr._widgets[arg2].hasChildren then
			local var187 = module_upvr
			var187._stackIndex += 1
			module_upvr._IDStack[module_upvr._stackIndex] = var186.ID
		end
		module_upvr._lastWidget = var186
		return var186
	end
	function module_upvr._DiscardWidget(arg1_10) -- Line 608
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		local parentWidget = arg1_10.parentWidget
		if parentWidget then
			module_upvr._widgets[parentWidget.type].ChildDiscarded(parentWidget, arg1_10)
		end
		module_upvr._widgets[arg1_10.type].Discard(arg1_10)
		arg1_10.lastCycleTick = -1
	end
	function module_upvr._widgetState(arg1_11, arg2, arg3) -- Line 633
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		local var189 = arg1_11.ID..arg2
		if module_upvr._states[var189] then
			module_upvr._states[var189].ConnectedWidgets[arg1_11.ID] = arg1_11
			return module_upvr._states[var189]
		end
		local tbl_5 = {}
		tbl_5.value = arg3
		local tbl_3 = {}
		tbl_3[arg1_11.ID] = arg1_11
		tbl_5.ConnectedWidgets = tbl_3
		tbl_5.ConnectedFunctions = {}
		module_upvr._states[var189] = tbl_5
		setmetatable(module_upvr._states[var189], module_upvr.StateClass)
		return module_upvr._states[var189]
	end
	function module_upvr._EventCall(arg1_12, arg2) -- Line 659
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		local type = arg1_12.type
		local var193 = module_upvr._widgets[type].Events[arg2]
		if var193 == nil then
			type = false
		else
			type = true
		end
		assert(type, `widget {arg1_12.type} has no event of name {arg2}`)
		if arg1_12.trackedEvents[arg2] == nil then
			var193.Init(arg1_12)
			arg1_12.trackedEvents[arg2] = true
		end
		return var193.Get(arg1_12)
	end
	function module_upvr._GetParentWidget() -- Line 678
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		return module_upvr._VDOM[module_upvr._IDStack[module_upvr._stackIndex]]
	end
	function module_upvr._generateEmptyVDOM() -- Line 691
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		return {
			R = module_upvr._rootWidget;
		}
	end
	function module_upvr._generateRootInstance() -- Line 704
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		module_upvr._rootInstance = module_upvr._widgets.Root.Generate(module_upvr._widgets.Root)
		module_upvr._rootInstance.Parent = module_upvr.parentInstance
		module_upvr._rootWidget.Instance = module_upvr._rootInstance
	end
	function module_upvr._generateSelectionImageObject() -- Line 718
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if module_upvr.SelectionImageObject then
			module_upvr.SelectionImageObject:Destroy()
		end
		local Frame = Instance.new("Frame")
		Frame.Position = UDim2.fromOffset(-1, -1)
		Frame.Size = UDim2.new(1, 2, 1, 2)
		Frame.BackgroundColor3 = module_upvr._config.SelectionImageObjectColor
		Frame.BackgroundTransparency = module_upvr._config.SelectionImageObjectTransparency
		Frame.BorderSizePixel = 0
		local UIStroke = Instance.new("UIStroke")
		UIStroke.Thickness = 1
		UIStroke.Color = module_upvr._config.SelectionImageObjectBorderColor
		UIStroke.Transparency = module_upvr._config.SelectionImageObjectBorderTransparency
		UIStroke.LineJoinMode = Enum.LineJoinMode.Round
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Parent = Frame
		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0, 2)
		UICorner.Parent = Frame
		module_upvr.SelectionImageObject = Frame
	end
	function module_upvr._getID(arg1_13) -- Line 758
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var198
		if module_upvr._nextWidgetId then
			var198 = module_upvr
			var198 = module_upvr
			var198._nextWidgetId = nil
			return var198._nextWidgetId
		end
		var198 = 1
		var198 = ""
		local line_defined = debug.info(var198 + (arg1_13 or 1), 'l')
		while line_defined ~= -1 and line_defined ~= nil do
			var198 = var198..'+'..line_defined
		end
		if module_upvr._usedIDs[var198] then
			local _usedIDs = module_upvr._usedIDs
			_usedIDs[var198] += 1
			-- KONSTANTWARNING: GOTO [54] #45
		end
		module_upvr._usedIDs[var198] = 1
		if module_upvr._pushedId then
		else
		end
		return var198..':'..module_upvr._usedIDs[var198]
	end
	function module_upvr._deepCompare(arg1_14, arg2) -- Line 796
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [50] 41. Error Block 14 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [50] 41. Error Block 14 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [4] 5. Error Block 24 start (CF ANALYSIS FAILED)
		-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [50.8]
		if nil == "table" then
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [50.7]
			if nil then
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				if nil == "table" then
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					if nil == false then
						-- KONSTANTWARNING: GOTO [50] #41
					end
					-- KONSTANTWARNING: GOTO [50] #41
				end
			end
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [50.9]
			local function INLINED_2() -- Internal function, doesn't exist in bytecode
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [50.6]
				return nil ~= nil
			end
			if nil ~= nil or INLINED_2() then
			end
		end
		-- KONSTANTERROR: [4] 5. Error Block 24 end (CF ANALYSIS FAILED)
	end
	function module_upvr._deepCopy(arg1_15) -- Line 826
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		for i_15, v_15 in pairs(arg1_15) do
			if type(v_15) == "table" then
				table.clone(arg1_15)[i_15] = module_upvr._deepCopy(v_15)
			end
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		return table.clone(arg1_15)
	end
	module_upvr._lastVDOM = module_upvr._generateEmptyVDOM()
	module_upvr._VDOM = module_upvr._generateEmptyVDOM()
	arg1.Internal = module_upvr
	arg1._config = module_upvr._config
	return module_upvr
end