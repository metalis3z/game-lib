-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types)

return function(p1) --[[ Line: 3 ]]
	local v1 = p1.State(true)
	local v2 = p1.State(false)
	local v3 = p1.State(false)
	local v4 = p1.State(false)
	local v5 = p1.State(false)
	local v6 = p1.State(false)

	local function helpMarker(p12) --[[ helpMarker | Line: 12 | Upvalues: p1 (copy) ]]
		p1.PushConfig({
			TextColor = p1._config.TextDisabledColor
		})

		local v1 = p1.Text({ "(?)" })

		p1.PopConfig()
		p1.PushConfig({
			ContentWidth = UDim.new(0, 350)
		})

		if v1.hovered() then
			p1.Tooltip({ p12 })
		end

		p1.PopConfig()
	end

	local t = {
		Basic = function() --[[ Basic | Line: 26 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Basic" })
			p1.SeparatorText({ "Basic" })

			local v1 = p1.State(1)

			p1.Button({ "Button" })
			p1.SmallButton({ "SmallButton" })
			p1.Text({ "Text" })
			p1.TextWrapped({ string.rep("Text Wrapped ", 5) })
			p1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) })
			p1.Text({ "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>", true, nil, true })
			p1.SameLine()
			p1.RadioButton({ "Index \'1\'", 1 }, {
				index = v1
			})
			p1.RadioButton({ "Index \'two\'", "two" }, {
				index = v1
			})

			if p1.RadioButton({ "Index \'false\'", false }, {
				index = v1
			}).active() == false and p1.SmallButton({ "Select last" }).clicked() then
				v1:set(false)
			end

			p1.End()

			local t = {}

			t[1] = "The Index is: " .. tostring(v1.value)
			p1.Text(t)
			p1.SeparatorText({ "Inputs" })
			p1.InputNum({})
			p1.DragNum({})
			p1.SliderNum({})
			p1.End()
		end,
		Tree = function() --[[ Tree | Line: 57 | Upvalues: p1 (copy), helpMarker (copy) ]]
			p1.Tree({ "Trees" })
			p1.Tree({
				"Tree using SpanAvailWidth",
				[p1.Args.Tree.SpanAvailWidth] = true
			})
			helpMarker("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area")
			p1.End()

			local v1 = p1.Tree({ "Tree with Children" })

			p1.Text({ "Im inside the first tree!" })
			p1.Button({ "Im a button inside the first tree!" })
			p1.Tree({ "Im a tree inside the first tree!" })
			p1.Text({ "I am the innermost text!" })
			p1.End()
			p1.End()
			p1.Checkbox({ "Toggle above tree" }, {
				isChecked = v1.state.isUncollapsed
			})
			p1.End()
		end,
		CollapsingHeader = function() --[[ CollapsingHeader | Line: 76 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Collapsing Headers" })
			p1.CollapsingHeader({ "A header" })
			p1.Text({ "This is under the first header!" })
			p1.End()

			local v1 = p1.State(true)

			p1.CollapsingHeader({ "Another header" }, {
				isUncollapsed = v1
			})

			if not p1.Button({ "Shhh... secret button!" }).clicked() then
				p1.End()
				p1.End()

				return
			end

			v1:set(true)
			p1.End()
			p1.End()
		end,
		Group = function() --[[ Group | Line: 91 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Groups" })
			p1.SameLine()
			p1.Group()
			p1.Text({ "I am in group A" })
			p1.Button({ "Im also in A" })
			p1.End()
			p1.Separator()
			p1.Group()
			p1.Text({ "I am in group B" })
			p1.Button({ "Im also in B" })
			p1.Button({ "Also group B" })
			p1.End()
			p1.End()
			p1.End()
		end,
		Indent = function() --[[ Indent | Line: 110 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Indents" })
			p1.Text({ "Not Indented" })
			p1.Indent()
			p1.Text({ "Indented" })
			p1.Indent({ 7 })
			p1.Text({ "Indented by 7 more pixels" })
			p1.End()
			p1.Indent({ -7 })
			p1.Text({ "Indented by 7 less pixels" })
			p1.End()
			p1.End()
			p1.End()
		end,
		Input = function() --[[ Input | Line: 126 | Upvalues: p1 (copy), helpMarker (copy) ]]
			p1.Tree({ "Input" })

			local v1 = p1.State(false)
			local v2 = p1.State(false)
			local v3 = p1.State(0)
			local v4 = p1.State(100)
			local v5 = p1.State(1)
			local v6 = p1.State("%d")

			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})

			local v7 = p1.InputNum({
				"Input Number",
				[p1.Args.InputNum.NoButtons] = v2.value,
				[p1.Args.InputNum.Min] = v3.value,
				[p1.Args.InputNum.Max] = v4.value,
				[p1.Args.InputNum.Increment] = v5.value,
				[p1.Args.InputNum.Format] = { v6.value }
			})

			p1.PopConfig()
			p1.Text({ "The Value is: " .. v7.number.value })

			if p1.Button({ "Randomize Number" }).clicked() then
				v7.number:set(math.random(1, 99))
			end

			local v8 = p1.Checkbox({ "NoField" }, {
				isChecked = v1
			})
			local v9 = p1.Checkbox({ "NoButtons" }, {
				isChecked = v2
			})

			if v8.checked() and v9.isChecked.value == true then
				v9.isChecked:set(false)
			end

			local v10, v11, v12, v13

			if not v9.checked() or v8.isChecked.value ~= true then
				p1.PushConfig({
					ContentWidth = UDim.new(1, -120)
				})
				p1.InputVector2({ "InputVector2" })
				p1.InputVector3({ "InputVector3" })
				p1.InputUDim({ "InputUDim" })
				p1.InputUDim2({ "InputUDim2" })
				v10 = p1.State(false)
				v11 = p1.State(false)
				v12 = p1.State(Color3.new())
				v13 = p1.State(0)
				p1.SliderNum({ "Transparency", 0.01, 0, 1 }, {
					number = v13
				})
				p1.InputColor3({ "InputColor3", v10:get(), v11:get() }, {
					color = v12
				})
				p1.InputColor4({ "InputColor4", v10:get(), v11:get() }, {
					color = v12,
					transparency = v13
				})
				p1.SameLine()
				p1.Text({ v12:get():ToHex() })
				p1.Checkbox({ "Use Floats" }, {
					isChecked = v10
				})
				p1.Checkbox({ "Use HSV" }, {
					isChecked = v11
				})
				p1.End()
				p1.PopConfig()
				p1.Separator()
				p1.SameLine()
				p1.Text({ "Slider Numbers" })
				helpMarker("ctrl + click slider number widgets to input a number")
				p1.End()
				p1.PushConfig({
					ContentWidth = UDim.new(1, -120)
				})
				p1.SliderNum({ "Slide Int", 1, 1, 8 })
				p1.SliderNum({ "Slide Float", 0.01, 0, 100 })
				p1.SliderNum({ "Small Numbers", 0.001, -2, 1, "%f radians" })
				p1.SliderNum({ "Odd Ranges", 0.001, -3.141592653589793, math.pi, "%f radians" })
				p1.SliderNum({ "Big Numbers", 10000, 100000, 10000000 })
				p1.SliderNum({ "Few Numbers", 1, 0, 3 })
				p1.PopConfig()
				p1.Separator()
				p1.SameLine()
				p1.Text({ "Drag Numbers" })
				helpMarker("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed")
				p1.End()
				p1.PushConfig({
					ContentWidth = UDim.new(1, -120)
				})
				p1.DragNum({ "Drag Int" })
				p1.DragNum({ "Slide Float", 0.001, -10, 10 })
				p1.DragNum({ "Percentage", 1, 0, 100, "%d %%" })
				p1.PopConfig()
				p1.End()

				return
			end

			v8.isChecked:set(false)
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			p1.InputVector2({ "InputVector2" })
			p1.InputVector3({ "InputVector3" })
			p1.InputUDim({ "InputUDim" })
			p1.InputUDim2({ "InputUDim2" })
			v10 = p1.State(false)
			v11 = p1.State(false)
			v12 = p1.State(Color3.new())
			v13 = p1.State(0)
			p1.SliderNum({ "Transparency", 0.01, 0, 1 }, {
				number = v13
			})
			p1.InputColor3({ "InputColor3", v10:get(), v11:get() }, {
				color = v12
			})
			p1.InputColor4({ "InputColor4", v10:get(), v11:get() }, {
				color = v12,
				transparency = v13
			})
			p1.SameLine()
			p1.Text({ v12:get():ToHex() })
			p1.Checkbox({ "Use Floats" }, {
				isChecked = v10
			})
			p1.Checkbox({ "Use HSV" }, {
				isChecked = v11
			})
			p1.End()
			p1.PopConfig()
			p1.Separator()
			p1.SameLine()
			p1.Text({ "Slider Numbers" })
			helpMarker("ctrl + click slider number widgets to input a number")
			p1.End()
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			p1.SliderNum({ "Slide Int", 1, 1, 8 })
			p1.SliderNum({ "Slide Float", 0.01, 0, 100 })
			p1.SliderNum({ "Small Numbers", 0.001, -2, 1, "%f radians" })
			p1.SliderNum({ "Odd Ranges", 0.001, -3.141592653589793, math.pi, "%f radians" })
			p1.SliderNum({ "Big Numbers", 10000, 100000, 10000000 })
			p1.SliderNum({ "Few Numbers", 1, 0, 3 })
			p1.PopConfig()
			p1.Separator()
			p1.SameLine()
			p1.Text({ "Drag Numbers" })
			helpMarker("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed")
			p1.End()
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})
			p1.DragNum({ "Drag Int" })
			p1.DragNum({ "Slide Float", 0.001, -10, 10 })
			p1.DragNum({ "Percentage", 1, 0, 100, "%d %%" })
			p1.PopConfig()
			p1.End()
		end,
		InputText = function() --[[ InputText | Line: 203 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Input Text" })
			p1.PushConfig({
				ContentWidth = UDim.new(0, 250)
			})

			local v1 = p1.InputText({
				"Input Text Test",
				[p1.Args.InputText.TextHint] = "Input Text here"
			})

			p1.PopConfig()
			p1.Text({ "The text is: " .. v1.text.value })
			p1.End()
		end,
		MultiInput = function() --[[ MultiInput | Line: 212 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Multi-Component Input" })

			local v1 = p1.State(Vector2.new())
			local v2 = p1.State((Vector3.new()))
			local v3 = p1.State(UDim.new())
			local v4 = p1.State(UDim2.new())
			local v5 = p1.State(Color3.new())
			local v6 = p1.State(Rect.new(0, 0))

			p1.SeparatorText({ "Input" })
			p1.InputVector2({}, {
				number = v1
			})
			p1.InputVector3({}, {
				number = v2
			})
			p1.InputUDim({}, {
				number = v3
			})
			p1.InputUDim2({}, {
				number = v4
			})
			p1.InputRect({}, {
				number = v6
			})
			p1.SeparatorText({ "Drag" })
			p1.DragVector2({}, {
				number = v1
			})
			p1.DragVector3({}, {
				number = v2
			})
			p1.DragUDim({}, {
				number = v3
			})
			p1.DragUDim2({}, {
				number = v4
			})
			p1.DragRect({}, {
				number = v6
			})
			p1.SeparatorText({ "Slider" })
			p1.SliderVector2({}, {
				number = v1
			})
			p1.SliderVector3({}, {
				number = v2
			})
			p1.SliderUDim({}, {
				number = v3
			})
			p1.SliderUDim2({}, {
				number = v4
			})
			p1.SliderRect({}, {
				number = v6
			})
			p1.SeparatorText({ "Color" })
			p1.InputColor3({}, {
				color = v5
			})
			p1.InputColor4({}, {
				color = v5
			})
			p1.End()
		end,
		Tooltip = function() --[[ Tooltip | Line: 254 | Upvalues: p1 (copy) ]]
			p1.PushConfig({
				ContentWidth = UDim.new(0, 250)
			})
			p1.Tree({ "Tooltip" })

			if p1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
				p1.Tooltip({ "I am some helpful tooltip text" })
			end

			local v1 = p1.State("Hello ")
			local v2 = p1.State(1)

			if p1.InputNum({ "# of repeat", 1, 1, 50 }, {
				number = v2
			}).numberChanged() then
				v1:set(string.rep("Hello ", v2:get()))
			end

			if not p1.Checkbox({ "Show dynamic text tooltip" }).isChecked.value then
				p1.End()
				p1.PopConfig()

				return
			end

			p1.Tooltip({ v1:get() })
			p1.End()
			p1.PopConfig()
		end,
		Selectable = function() --[[ Selectable | Line: 272 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Selectable" })

			local v1 = p1.State(2)

			p1.Selectable({ "Selectable #1", 1 }, {
				index = v1
			})
			p1.Selectable({ "Selectable #2", 2 }, {
				index = v1
			})

			if p1.Selectable({ "Double click Selectable", 3, true }, {
				index = v1
			}).doubleClicked() then
				v1:set(3)
			end

			p1.Selectable({ "Impossible to select", 4, true }, {
				index = v1
			})

			if p1.Button({ "Select last" }).clicked() then
				v1:set(4)
			end

			p1.Selectable({ "Independent Selectable" })
			p1.End()
		end,
		Combo = function() --[[ Combo | Line: 288 | Upvalues: p1 (copy) ]]
			p1.Tree({ "Combo" })
			p1.PushConfig({
				ContentWidth = UDim.new(1, -120)
			})

			local v1 = p1.State("No Selection")

			p1.SameLine()

			local v2 = p1.Checkbox({ "No Preview" })
			local v3 = p1.Checkbox({ "No Button" })

			if v2.checked() and v3.isChecked.value == true then
				v3.isChecked:set(false)
			end

			if v3.checked() and v2.isChecked.value == true then
				v2.isChecked:set(false)
			end

			p1.End()
			p1.Combo({ "Basic Usage", v3.isChecked:get(), v2.isChecked:get() }, {
				index = v1
			})
			p1.Selectable({ "Select 1", "One" }, {
				index = v1
			})
			p1.Selectable({ "Select 2", "Two" }, {
				index = v1
			})
			p1.Selectable({ "Select 3", "Three" }, {
				index = v1
			})
			p1.End()
			p1.ComboArray({ "Using ComboArray" }, {
				index = "No Selection"
			}, { "Red", "Green", "Blue" })

			local v4 = p1.State("7 AM")

			p1.Combo({ "Combo with Inner widgets" }, {
				index = v4
			})
			p1.Tree({ "Morning Shifts" })
			p1.Selectable({ "Shift at 7 AM", "7 AM" }, {
				index = v4
			})
			p1.Selectable({ "Shift at 11 AM", "11 AM" }, {
				index = v4
			})
			p1.Selectable({ "Shist at 3 PM", "3 PM" }, {
				index = v4
			})
			p1.End()
			p1.Tree({ "Night Shifts" })
			p1.Selectable({ "Shift at 6 PM", "6 PM" }, {
				index = v4
			})
			p1.Selectable({ "Shift at 9 PM", "9 PM" }, {
				index = v4
			})
			p1.End()
			p1.End()
			p1.Text({ "Selected: " .. p1.ComboEnum({ "Using ComboEnum" }, {
					index = Enum.UserInputState.Begin
				}, Enum.UserInputState).index:get().Name })
			p1.PopConfig()
			p1.End()
		end
	}
	local t2 = {
		"Basic",
		"Tree",
		"CollapsingHeader",
		"Group",
		"Indent",
		"Input",
		"MultiInput",
		"InputText",
		"Tooltip",
		"Selectable",
		"Combo"
	}

	local function v7() --[[ recursiveTree | Line: 331 | Upvalues: p1 (copy), v7 (copy) ]]
		if not p1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
			p1.End()

			return
		end

		v7()
		p1.End()
	end

	local function v8(p12) --[[ recursiveWindow | Line: 339 | Upvalues: p1 (copy), v8 (copy) ]]
		p1.Window({ "Recursive Window" }, {
			size = p1.State(Vector2.new(175, 100)),
			isOpened = p12
		})

		local v1 = p1.Checkbox({ "Recurse Again" })

		p1.End()

		if not v1.isChecked.value then
			return
		end

		v8(v1.isChecked)
	end

	local function runtimeInfo() --[[ runtimeInfo | Line: 349 | Upvalues: p1 (copy), v3 (copy), helpMarker (copy) ]]
		local v1 = p1.Window({ "Runtime Info" }, {
			isOpened = v3
		})
		local _lastVDOM = p1.Internal._lastVDOM
		local _states = p1.Internal._states
		local v2 = p1.State(3)
		local v32 = p1.State(0)
		local v4 = p1.State(os.clock())

		p1.SameLine()
		p1.InputNum({
			"",
			[p1.Args.InputNum.Format] = "%d Seconds",
			[p1.Args.InputNum.Max] = 10
		}, {
			number = v2
		})

		if p1.Button({ "Disable" }).clicked() then
			p1.Disabled = true
			task.delay(v2:get(), function() --[[ Line: 362 | Upvalues: p1 (ref) ]]
				p1.Disabled = false
			end)
		end

		p1.End()

		local v5 = os.clock()

		v32.value = v32.value + (v5 - v4.value - v32.value) * 0.2
		v4.value = v5
		p1.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", v32.value * 1000, 1 / v32.value) })
		p1.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", v1.position.value.X, v1.position.value.Y, v1.size.value.X, v1.size.value.Y) })
		p1.SameLine()
		p1.Text({ "Enter an ID to learn more about it." })
		helpMarker("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs")
		p1.End()
		p1.PushConfig({
			ItemWidth = UDim.new(1, -150)
		})

		local value = p1.InputText({ "ID field" }, {
			text = p1.State(v1.ID)
		}).text.value

		p1.PopConfig()
		p1.Indent()

		local v7 = _lastVDOM[value]
		local v8 = _states[value]

		if v7 then
			p1.Table({
				1,
				[p1.Args.Table.RowBg] = false
			})
			p1.Text({ string.format("The ID, \"%s\", is a widget", value) })
			p1.NextRow()
			p1.Text({ string.format("Widget is type: %s", v7.type) })
			p1.NextRow()
			p1.Tree({ "Widget has Args:" }, {
				isUncollapsed = p1.State(true)
			})

			for v9, v10 in v7.arguments do
				p1.Text({ v9 .. " - " .. tostring(v10) })
			end

			p1.End()
			p1.NextRow()

			if v7.state then
				p1.Tree({ "Widget has State:" }, {
					isUncollapsed = p1.State(true)
				})

				for v11, v12 in v7.state do
					local t = {}

					t[1] = v11 .. " - " .. tostring(v12.value)
					p1.Text(t)
				end

				p1.End()
			end

			p1.End()
		elseif v8 then
			p1.Table({
				1,
				[p1.Args.Table.RowBg] = false
			})
			p1.Text({ string.format("The ID, \"%s\", is a state", value) })
			p1.NextRow()

			local t = {}

			t[1] = string.format("Value is type: %s, Value = %s", typeof(v8.value), (tostring(v8.value)))
			p1.Text(t)
			p1.NextRow()
			p1.Tree({ "state has connected widgets:" }, {
				isUncollapsed = p1.State(true)
			})

			for v14, v15 in v8.ConnectedWidgets do
				p1.Text({ v14 .. " - " .. v15.type })
			end

			p1.End()
			p1.NextRow()
			p1.Text({ string.format("state has: %d connected functions", #v8.ConnectedFunctions) })
			p1.End()
		else
			p1.Text({ string.format("The ID, \"%s\", is not a state or widget", value) })
		end

		p1.End()

		if p1.Tree({ "Widgets" }).isUncollapsed.value then
			local count = 0
			local v16 = ""

			for v17, v18 in _lastVDOM do
				v16 = v16 .. "\n" .. v18.ID .. " - " .. v18.type
				count = count + 1
			end

			p1.Text({ "Number of Widgets: " .. count })
			p1.Text({ v16 })
		end

		p1.End()

		if not p1.Tree({ "States" }).isUncollapsed.value then
			p1.End()
			p1.End()

			return
		end

		local count = 0
		local v19 = ""

		for v20, v21 in _states do
			v19 = v19 .. "\n" .. v20 .. " - " .. tostring(v21.value)
			count = count + 1
		end

		p1.Text({ "Number of States: " .. count })
		p1.Text({ v19 })
		p1.End()
		p1.End()
	end

	local function v9() --[[ recursiveMenu | Line: 463 | Upvalues: p1 (copy), v9 (copy) ]]
		if p1.Menu({ "Recursive" }).state.isOpened.value then
			p1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
			p1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
			p1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
			p1.Separator()
			p1.MenuToggle({ "Autosave" })
			p1.MenuToggle({ "Checked" })
			p1.Separator()
			p1.Menu({ "Options" })
			p1.MenuItem({ "Red" })
			p1.MenuItem({ "Yellow" })
			p1.MenuItem({ "Green" })
			p1.MenuItem({ "Blue" })
			p1.Separator()
			v9()
			p1.End()
		end

		p1.End()
	end

	local function mainMenuBar() --[[ mainMenuBar | Line: 487 | Upvalues: p1 (copy), v9 (copy), v2 (copy), v5 (copy), v6 (copy), v3 (copy), v4 (copy) ]]
		p1.MenuBar()
		p1.Menu({ "File" })
		p1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
		p1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
		p1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
		v9()
		p1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt })
		p1.End()
		p1.Menu({ "Examples" })
		p1.MenuToggle({ "Recursive Window" }, {
			isChecked = v2
		})
		p1.MenuToggle({ "Windowless" }, {
			isChecked = v5
		})
		p1.MenuToggle({ "Main Menu Bar" }, {
			isChecked = v6
		})
		p1.End()
		p1.Menu({ "Tools" })
		p1.MenuToggle({ "Runtime Info" }, {
			isChecked = v3
		})
		p1.MenuToggle({ "Style Editor" }, {
			isChecked = v4
		})
		p1.End()
		p1.End()
	end

	local function mainMenuBarExample() --[[ mainMenuBarExample | Line: 510 | Upvalues: p1 (copy), mainMenuBar (copy) ]]
		local AbsoluteSize = p1.Internal._rootWidget.Instance.PseudoWindowScreenGui.AbsoluteSize

		mainMenuBar()
	end

	local function f10() --[[ Line: 525 | Upvalues: p1 (copy), v4 (copy) ]]
		local v1 = p1.State(1)
		local list = {
			{ "Sizing", function() --[[ Line: 531 | Upvalues: p1 (ref) ]]
					local v1 = p1.State({})

					if p1.Button({ "Update Config" }).clicked() then
						p1.UpdateGlobalConfig(v1:get())
						v1:set({})
					end

					for v2, v3 in {
						{
							"ItemWidth",
							nil,
							UDim.new(),
							UDim.new(1, 200)
						},
						{
							"ContentWidth",
							nil,
							UDim.new(),
							UDim.new(1, 200)
						}
					} do
						local v4 = p1.SliderUDim({ table.unpack(v3) }, {
							number = p1.WeakState(p1._config[v3[1]])
						})

						if v4.numberChanged() then
							v1:get()[v3[1]] = v4.number:get()
						end
					end

					for v5, v6 in {
						{
							"WindowPadding",
							nil,
							Vector2.zero,
							Vector2.one * 20
						},
						{
							"WindowResizePadding",
							nil,
							Vector2.zero,
							Vector2.one * 20
						},
						{
							"FramePadding",
							nil,
							Vector2.zero,
							Vector2.one * 20
						},
						{
							"ItemSpacing",
							nil,
							Vector2.zero,
							Vector2.one * 20
						},
						{
							"ItemInnerSpacing",
							nil,
							Vector2.zero,
							Vector2.one * 20
						},
						{
							"CellPadding",
							nil,
							Vector2.zero,
							Vector2.one * 20
						},
						{
							"DisplaySafeAreaPadding",
							nil,
							Vector2.zero,
							Vector2.one * 20
						}
					} do
						local v7 = p1.SliderVector2({ table.unpack(v6) }, {
							number = p1.WeakState(p1._config[v6[1]])
						})

						if v7.numberChanged() then
							v1:get()[v6[1]] = v7.number:get()
						end
					end

					for v8, v9 in {
						{ "TextSize", 1, 4, 20 },
						{ "FrameBorderSize", 0.1, 0, 1 },
						{ "FrameRounding", 1, 0, 12 },
						{ "GrabRounding", 1, 0, 12 },
						{ "WindowBorderSize", 0.1, 0, 1 },
						{ "PopupBorderSize", 0.1, 0, 1 },
						{ "PopupRounding", 1, 0, 12 },
						{ "ScrollbarSize", 1, 0, 20 },
						{ "GrabMinSize", 1, 0, 20 }
					} do
						local v10 = p1.SliderNum({ table.unpack(v9) }, {
							number = p1.WeakState(p1._config[v9[1]])
						})

						if v10.numberChanged() then
							v1:get()[v9[1]] = v10.number:get()
						end
					end

					for v11, v12 in { "WindowTitleAlign" } do
						local v13 = p1.ComboEnum({ v12 }, {
							index = p1.WeakState(p1._config[v12])
						}, p1._config[v12].EnumType)

						if v13.closed() then
							p1.UpdateGlobalConfig({
								[v12] = v13.index:get()
							})
						end
					end
				end },
			{ "Colors", function() --[[ Line: 598 | Upvalues: p1 (ref) ]]
					local v1 = p1.State({})

					if p1.Button({ "Update Config" }).clicked() then
						p1.UpdateGlobalConfig(v1:get())
						v1:set({})
					end

					for v2, v3 in { "BorderColor", "BorderActiveColor" } do
						local v4 = p1.InputColor3({ v3 }, {
							color = p1.WeakState(p1._config[v3])
						})

						if v4.numberChanged() then
							p1.UpdateGlobalConfig({
								[v3] = v4.color:get()
							})
						end
					end

					for v5, v6 in {
						"Text",
						"TextDisabled",
						"WindowBg",
						"ScrollbarGrab",
						"TitleBg",
						"TitleBgActive",
						"TitleBgCollapsed",
						"MenubarBg",
						"FrameBg",
						"FrameBgHovered",
						"FrameBgActive",
						"Button",
						"ButtonHovered",
						"ButtonActive",
						"SliderGrab",
						"SliderGrabActive",
						"Header",
						"HeaderHovered",
						"HeaderActive",
						"SelectionImageObject",
						"SelectionImageObjectBorder",
						"TableBorderStrong",
						"TableBorderLight",
						"TableRowBg",
						"TableRowBgAlt",
						"NavWindowingHighlight",
						"NavWindowingDimBg",
						"Separator",
						"CheckMark"
					} do
						local v7 = p1.InputColor4({ v6 }, {
							color = p1.WeakState(p1._config[v6 .. "Color"]),
							transparency = p1.WeakState(p1._config[v6 .. "Transparency"])
						})

						if v7.numberChanged() then
							v1:get()[v6 .. "Color"] = v7.color:get()
							v1:get()[v6 .. "Transparency"] = v7.transparency:get()
						end
					end
				end }
		}

		p1.Window({ "Style Editor" }, {
			isOpened = v4
		})
		p1.Text({ "Customize the look of Iris in realtime." })
		p1.SameLine()

		if p1.SmallButton({ "Light Theme" }).clicked() then
			p1.UpdateGlobalConfig(p1.TemplateConfig.colorLight)
		end

		if p1.SmallButton({ "Dark Theme" }).clicked() then
			p1.UpdateGlobalConfig(p1.TemplateConfig.colorDark)
		end

		p1.End()
		p1.SameLine()

		if p1.SmallButton({ "Classic Size" }).clicked() then
			p1.UpdateGlobalConfig(p1.TemplateConfig.sizeDefault)
		end

		if p1.SmallButton({ "Larger Size" }).clicked() then
			p1.UpdateGlobalConfig(p1.TemplateConfig.sizeClear)
		end

		p1.End()

		if p1.SmallButton({ "Reset Everything" }).clicked() then
			p1.UpdateGlobalConfig(p1.TemplateConfig.colorDark)
			p1.UpdateGlobalConfig(p1.TemplateConfig.sizeDefault)
		end

		p1.Separator()
		p1.SameLine()

		for i, v in ipairs(list) do
			p1.RadioButton({ v[1], i }, {
				index = v1
			})
		end

		p1.End()
		list[v1:get()][2]()
		p1.End()
	end

	local function widgetEventInteractivity() --[[ widgetEventInteractivity | Line: 698 | Upvalues: p1 (copy) ]]
		p1.CollapsingHeader({ "Widget Event Interactivity" })

		local v1 = p1.State(0)

		if p1.Button({ "Click to increase Number" }).clicked() then
			v1:set(v1:get() + 1)
		end

		p1.Text({ "The Number is: " .. v1:get() })
		p1.Separator()

		local v2 = p1.State(false)
		local v3 = p1.State("clicked")

		p1.SameLine()
		p1.RadioButton({ "clicked", "clicked" }, {
			index = v3
		})
		p1.RadioButton({ "rightClicked", "rightClicked" }, {
			index = v3
		})
		p1.RadioButton({ "doubleClicked", "doubleClicked" }, {
			index = v3
		})
		p1.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
			index = v3
		})
		p1.End()
		p1.SameLine()

		if p1.Button({ v3:get() .. " to reveal text" })[v3:get()]() then
			v2:set(not v2:get())
		end

		if v2:get() then
			p1.Text({ "Here i am!" })
		end

		p1.End()
		p1.Separator()

		local v4 = p1.State(0)

		p1.SameLine()

		if p1.Button({ "Click to show text for 20 frames" }).clicked() then
			v4:set(20)
		end

		if v4:get() > 0 then
			p1.Text({ "Here i am!" })
		end

		p1.End()
		v4:set((math.max(0, v4:get() - 1)))
		p1.Text({ "Text Timer: " .. v4:get() })

		local v6 = p1.Checkbox({ "Event-tracked checkbox" })

		p1.Indent()

		local t = {}

		t[1] = "unchecked: " .. tostring(v6.unchecked())
		p1.Text(t)

		local t2 = {}

		t2[1] = "checked: " .. tostring(v6.checked())
		p1.Text(t2)
		p1.End()
		p1.SameLine()

		if p1.Button({ "Hover over me" }).hovered() then
			p1.Text({ "The button is hovered" })
		end

		p1.End()
		p1.End()
	end

	local function widgetStateInteractivity() --[[ widgetStateInteractivity | Line: 754 | Upvalues: p1 (copy) ]]
		p1.CollapsingHeader({ "Widget State Interactivity" })
		p1.Text({ (("isChecked: %*\n"):format(p1.Checkbox({ "Widget-Generated State" }).state.isChecked.value)) })
		p1.Text({ (("isChecked: %*\n"):format(p1.Checkbox({ "User-Generated State" }, {
				isChecked = p1.State(false)
			}).state.isChecked.value)) })
		p1.Text({ (("isChecked: %*\n"):format(p1.Checkbox({ "Coupled to above Checkbox" }, {
				isChecked = p1.Checkbox({ "Widget Coupled State" }).state.isChecked
			}).state.isChecked.value)) })

		local v6 = p1.State(false)

		p1.Checkbox({ "Widget and Code Coupled State" }, {
			isChecked = v6
		})

		if p1.Button({ "Click to toggle above checkbox" }).clicked() then
			v6:set(not v6:get())
		end

		p1.Text({ (("isChecked: %*\n"):format(v6.value)) })

		local v7 = p1.State(true)
		local v8 = p1.ComputedState(v7, function(p1) --[[ Line: 776 ]]
			return not p1
		end)

		p1.Checkbox({ "ComputedState (dynamic coupling)" }, {
			isChecked = v7
		})
		p1.Checkbox({ "Inverted of above checkbox" }, {
			isChecked = v8
		})
		p1.Text({ (("isChecked: %*\n"):format(v8.value)) })
		p1.End()
	end

	local function dynamicStyle() --[[ dynamicStyle | Line: 786 | Upvalues: p1 (copy), helpMarker (copy) ]]
		p1.CollapsingHeader({ "Dynamic Styles" })

		local v1 = p1.State(0)

		p1.SameLine()

		if p1.Button({ "Change Color" }).clicked() then
			v1:set(math.random())
		end

		local t = {}

		t[1] = "Hue: " .. math.floor(v1:get() * 255)
		p1.Text(t)
		helpMarker("Using PushConfig with a changing value, this can be done with any config field")
		p1.End()
		p1.PushConfig({
			TextColor = Color3.fromHSV(v1:get(), 1, 1)
		})
		p1.Text({ "Text with a unique and changable color" })
		p1.PopConfig()
		p1.End()
	end

	local function tablesDemo() --[[ tablesDemo | Line: 802 | Upvalues: p1 (copy), helpMarker (copy) ]]
		local v1 = p1.State(false)

		p1.CollapsingHeader({ "Tables & Columns" }, {
			isUncollapsed = v1
		})

		if v1.value ~= false then
			p1.SameLine()
			p1.Text({ "Table using NextRow and NextColumn syntax:" })
			helpMarker("calling Iris.NextRow() in the outer loop, and Iris.NextColumn()in the inner loop")
			p1.End()
			p1.Table({ 3 })

			for i = 1, 4 do
				p1.NextRow()

				for j = 1, 3 do
					p1.NextColumn()
					p1.Text({ (("Row: %*, Column: %*"):format(i, j)) })
				end
			end

			p1.End()
			p1.Text({ "" })
			p1.SameLine()
			p1.Text({ "Table using NextColumn only syntax:" })
			helpMarker("only calling Iris.NextColumn() in the inner loop, the result is identical")
			p1.End()
			p1.Table({ 2 })

			for k = 1, 4 do
				for n = 1, 2 do
					p1.NextColumn()
					p1.Text({ (("Row: %*, Column: %*"):format(k, n)) })
				end
			end

			p1.End()
			p1.Separator()

			local v2 = p1.State(false)
			local v3 = p1.State(false)
			local v4 = p1.State(true)
			local v5 = p1.State(true)
			local v6 = p1.State(3)

			p1.Text({ "Table with Customizable Arguments" })
			p1.Table({
				4,
				[p1.Args.Table.RowBg] = v2.value,
				[p1.Args.Table.BordersOuter] = v3.value,
				[p1.Args.Table.BordersInner] = v4.value
			})

			for m = 1, v6:get() do
				for i = 1, 4 do
					p1.NextColumn()

					if v5.value then
						p1.Button({ (("Month: %*, Week: %*"):format(m, i)) })

						continue
					end

					p1.Text({ (("Month: %*, Week: %*"):format(m, i)) })
				end
			end

			p1.End()
			p1.Checkbox({ "RowBg" }, {
				isChecked = v2
			})
			p1.Checkbox({ "BordersOuter" }, {
				isChecked = v3
			})
			p1.Checkbox({ "BordersInner" }, {
				isChecked = v4
			})
			p1.SameLine()
			p1.RadioButton({ "Buttons", true }, {
				index = v5
			})
			p1.RadioButton({ "Text", false }, {
				index = v5
			})
			p1.End()
			p1.InputNum({
				"Number of rows",
				[p1.Args.InputNum.Min] = 0,
				[p1.Args.InputNum.Max] = 100,
				[p1.Args.InputNum.Format] = "%d"
			}, {
				number = v6
			})
		end

		p1.End()
	end

	local function layoutDemo() --[[ layoutDemo | Line: 887 | Upvalues: p1 (copy), helpMarker (copy) ]]
		p1.CollapsingHeader({ "Widget Layout" })
		p1.Tree({ "Content Width" })

		local v1 = p1.State(50)
		local v2 = p1.State(Enum.Axis.X)

		p1.Text({ "The Content Width is a size property which determines the width of input fields." })
		p1.SameLine()
		p1.Text({ "By default the value is UDim.new(0.65, 0)" })
		helpMarker("This is the default value from Dear ImGui.\nIt is 65% of the window width.")
		p1.End()
		p1.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." })
		p1.Text({ "Therefore, we can use Iris.PushConfig() to change the width" })
		p1.Separator()
		p1.SameLine()
		p1.Text({ "Content Width = 150 pixels" })
		helpMarker("UDim.new(0, 150)")
		p1.End()
		p1.PushConfig({
			ContentWidth = UDim.new(0, 150)
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = v1
		})
		p1.ComboEnum({ "axis" }, {
			index = v2
		}, Enum.Axis)
		p1.PopConfig()
		p1.SameLine()
		p1.Text({ "Content Width = 50% window width" })
		helpMarker("UDim.new(0.5, 0)")
		p1.End()
		p1.PushConfig({
			ContentWidth = UDim.new(0.5, 0)
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = v1
		})
		p1.ComboEnum({ "axis" }, {
			index = v2
		}, Enum.Axis)
		p1.PopConfig()
		p1.SameLine()
		p1.Text({ "Content Width = -150 pixels from the right side" })
		helpMarker("UDim.new(1, -150)")
		p1.End()
		p1.PushConfig({
			ContentWidth = UDim.new(1, -150)
		})
		p1.DragNum({ "number", 1, 0, 100 }, {
			number = v1
		})
		p1.InputEnum({ "axis" }, {
			index = v2
		}, Enum.Axis)
		p1.PopConfig()
		p1.End()
		p1.End()
	end

	local function windowlessDemo() --[[ windowlessDemo | Line: 934 | Upvalues: p1 (copy), helpMarker (copy) ]]
		p1.PushConfig({
			ItemWidth = UDim.new(0, 150)
		})
		p1.SameLine()
		p1.TextWrapped({ "Windowless widgets" })
		helpMarker("Widgets which are placed outside of a window will appear on the top left side of the screen.")
		p1.End()
		p1.Button({})
		p1.Tree({})
		p1.InputText({})
		p1.End()
		p1.PopConfig()
	end

	return function() --[[ Line: 948 | Upvalues: p1 (copy), v1 (copy), mainMenuBar (copy), widgetEventInteractivity (copy), widgetStateInteractivity (copy), v7 (copy), dynamicStyle (copy), t2 (copy), t (copy), tablesDemo (copy), layoutDemo (copy), v2 (copy), v8 (copy), v3 (copy), runtimeInfo (copy), v4 (copy), f10 (ref), v5 (copy), windowlessDemo (copy), v6 (copy) ]]
		local v12 = p1.State(false)
		local v22 = p1.State(false)
		local v32 = p1.State(false)
		local v42 = p1.State(true)
		local v52 = p1.State(false)
		local v62 = p1.State(false)
		local v72 = p1.State(false)
		local v82 = p1.State(false)
		local v9 = p1.State(false)

		if v1.value == false then
			p1.Checkbox({ "Open main window" }, {
				isChecked = v1
			})

			return
		end

		p1.Window({
			"Iris Demo Window",
			[p1.Args.Window.NoTitleBar] = v12.value,
			[p1.Args.Window.NoBackground] = v22.value,
			[p1.Args.Window.NoCollapse] = v32.value,
			[p1.Args.Window.NoClose] = v42.value,
			[p1.Args.Window.NoMove] = v52.value,
			[p1.Args.Window.NoScrollbar] = v62.value,
			[p1.Args.Window.NoResize] = v72.value,
			[p1.Args.Window.NoNav] = v82.value,
			[p1.Args.Window.NoMenu] = v9.value
		}, {
			size = p1.State(Vector2.new(600, 550)),
			position = p1.State(Vector2.new(100, 25)),
			isOpened = v1
		})
		mainMenuBar()
		p1.Text({ "Iris says hello. (2.1.1)" })
		p1.CollapsingHeader({ "Window Options" })
		p1.Table({ 3, false, false, false })
		p1.NextColumn()
		p1.Checkbox({ "NoTitleBar" }, {
			isChecked = v12
		})
		p1.NextColumn()
		p1.Checkbox({ "NoBackground" }, {
			isChecked = v22
		})
		p1.NextColumn()
		p1.Checkbox({ "NoCollapse" }, {
			isChecked = v32
		})
		p1.NextColumn()
		p1.Checkbox({ "NoClose" }, {
			isChecked = v42
		})
		p1.NextColumn()
		p1.Checkbox({ "NoMove" }, {
			isChecked = v52
		})
		p1.NextColumn()
		p1.Checkbox({ "NoScrollbar" }, {
			isChecked = v62
		})
		p1.NextColumn()
		p1.Checkbox({ "NoResize" }, {
			isChecked = v72
		})
		p1.NextColumn()
		p1.Checkbox({ "NoNav" }, {
			isChecked = v82
		})
		p1.NextColumn()
		p1.Checkbox({ "NoMenu" }, {
			isChecked = v9
		})
		p1.End()
		p1.End()
		widgetEventInteractivity()
		widgetStateInteractivity()
		p1.CollapsingHeader({ "Recursive Tree" })

		if p1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
			v7()
		end

		p1.End()
		p1.End()
		dynamicStyle()
		p1.Separator()
		p1.CollapsingHeader({ "Widgets" })

		for v10, v11 in t2 do
			t[v11]()
		end

		p1.End()
		tablesDemo()
		layoutDemo()
		p1.End()

		if v2.value then
			v8(v2)
		end

		if v3.value then
			runtimeInfo()
		end

		if v4.value then
			f10()
		end

		if v5.value then
			windowlessDemo()
		end

		if not v6.value then
			return
		end

		local AbsoluteSize = p1.Internal._rootWidget.Instance.PseudoWindowScreenGui.AbsoluteSize

		mainMenuBar()
	end
end