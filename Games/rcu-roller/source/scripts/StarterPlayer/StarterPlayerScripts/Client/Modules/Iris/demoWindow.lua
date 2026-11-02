-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:28
-- Luau version 6, Types version 3
-- Time taken: 0.037256 seconds

return function(arg1) -- Line 3
	local any_State_result1_13_upvr = arg1.State(true)
	local any_State_result1_16_upvr = arg1.State(false)
	local any_State_result1_57_upvr = arg1.State(false)
	local any_State_result1_62_upvr = arg1.State(false)
	local any_State_result1_71_upvr = arg1.State(false)
	local any_State_result1_15_upvr = arg1.State(false)
	local any_State_result1_14_upvr = arg1.State(false)
	local function helpMarker_upvr(arg1_2) -- Line 12, Named "helpMarker"
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1.PushConfig({
			TextColor = arg1._config.TextDisabledColor;
		})
		arg1.PopConfig()
		arg1.PushConfig({
			ContentWidth = UDim.new(0, 350);
		})
		if arg1.Text({"(?)"}).hovered() then
			local tbl_11 = {}
			tbl_11[1] = arg1_2
			arg1.Tooltip(tbl_11)
		end
		arg1.PopConfig()
	end
	local tbl_5_upvr = {
		Basic = function() -- Line 26, Named "Basic"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Basic"})
			arg1.SeparatorText({"Basic"})
			local any_State_result1_30 = arg1.State(1)
			arg1.Button({"Button"})
			arg1.SmallButton({"SmallButton"})
			arg1.Text({"Text"})
			arg1.TextWrapped({string.rep("Text Wrapped ", 5)})
			arg1.TextColored({"Colored Text", Color3.fromRGB(255, 128, 0)})
			arg1.Text({"Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>", true, nil, true})
			arg1.SameLine()
			arg1.RadioButton({"Index '1'", 1}, {
				index = any_State_result1_30;
			})
			arg1.RadioButton({"Index 'two'", "two"}, {
				index = any_State_result1_30;
			})
			if arg1.RadioButton({"Index 'false'", false}, {
				index = any_State_result1_30;
			}).active() == false then
				if arg1.SmallButton({"Select last"}).clicked() then
					any_State_result1_30:set(false)
				end
			end
			arg1.End()
			arg1.Text({"The Index is: "..tostring(any_State_result1_30.value)})
			arg1.SeparatorText({"Inputs"})
			arg1.InputNum({})
			arg1.DragNum({})
			arg1.SliderNum({})
			arg1.End()
		end;
		Image = function() -- Line 62, Named "Image"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Image"})
			arg1.SeparatorText({"Image Controls"})
			local any_State_result1_35 = arg1.State("rbxasset://textures/ui/common/robux.png")
			local any_State_result1_23 = arg1.State(UDim2.fromOffset(100, 100))
			local any_State_result1_21 = arg1.State(Rect.new(0, 0, 0, 0))
			local any_State_result1_56 = arg1.State(Enum.ScaleType.Stretch)
			local any_State_result1_50 = arg1.State(false)
			local any_ComputedState_result1 = arg1.ComputedState(any_State_result1_50, function(arg1_3) -- Line 72
				if not arg1_3 or not Enum.ResamplerMode.Pixelated then
				end
				return Enum.ResamplerMode.Default
			end)
			local any_State_result1_3 = arg1.State(arg1._config.ImageColor)
			local any_State_result1_41 = arg1.State(arg1._config.ImageTransparency)
			arg1.InputColor4({"Image Tint"}, {
				color = any_State_result1_3;
				transparency = any_State_result1_41;
			})
			arg1.Combo({"Asset"}, {
				index = any_State_result1_35;
			})
			arg1.Selectable({"Robux Small", "rbxasset://textures/ui/common/robux.png"}, {
				index = any_State_result1_35;
			})
			arg1.Selectable({"Robux Large", "rbxasset://textures//ui/common/robux@3x.png"}, {
				index = any_State_result1_35;
			})
			arg1.Selectable({"Loading Texture", "rbxasset://textures//loading/darkLoadingTexture.png"}, {
				index = any_State_result1_35;
			})
			arg1.Selectable({"Hue-Saturation Gradient", "rbxasset://textures//TagEditor/huesatgradient.png"}, {
				index = any_State_result1_35;
			})
			arg1.Selectable({"famfamfam.png (WHY?)", "rbxasset://textures//TagEditor/famfamfam.png"}, {
				index = any_State_result1_35;
			})
			arg1.End()
			arg1.SliderUDim2({"Image Size", nil, nil, UDim2.new(1, 240, 1, 240)}, {
				number = any_State_result1_23;
			})
			arg1.SliderRect({"Image Rect", nil, nil, Rect.new(256, 256, 256, 256)}, {
				number = any_State_result1_21;
			})
			arg1.Combo({"Scale Type"}, {
				index = any_State_result1_56;
			})
			arg1.Selectable({"Stretch", Enum.ScaleType.Stretch}, {
				index = any_State_result1_56;
			})
			arg1.Selectable({"Fit", Enum.ScaleType.Fit}, {
				index = any_State_result1_56;
			})
			arg1.Selectable({"Crop", Enum.ScaleType.Crop}, {
				index = any_State_result1_56;
			})
			arg1.End()
			arg1.Checkbox({"Pixelated"}, {
				isChecked = any_State_result1_50;
			})
			arg1.PushConfig({
				ImageColor = any_State_result1_3:get();
				ImageTransparency = any_State_result1_41:get();
			})
			arg1.Image({any_State_result1_35:get(), any_State_result1_23:get(), any_State_result1_21:get(), any_State_result1_56:get(), any_ComputedState_result1:get()})
			arg1.PopConfig()
			arg1.SeparatorText({"Tile"})
			local any_State_result1_45 = arg1.State(UDim2.fromScale(0.5, 0.5))
			arg1.SliderUDim2({"Tile Size", nil, nil, UDim2.new(1, 240, 1, 240)}, {
				number = any_State_result1_45;
			})
			arg1.PushConfig({
				ImageColor = any_State_result1_3:get();
				ImageTransparency = any_State_result1_41:get();
			})
			arg1.Image({"rbxasset://textures/grid2.png", any_State_result1_23:get(), nil, Enum.ScaleType.Tile, any_ComputedState_result1:get(), any_State_result1_45:get()})
			arg1.PopConfig()
			arg1.SeparatorText({"Slice"})
			local any_State_result1_40 = arg1.State(1)
			arg1.SliderNum({"Image Slice Scale", 0.1, 0.1, 5}, {
				number = any_State_result1_40;
			})
			arg1.PushConfig({
				ImageColor = any_State_result1_3:get();
				ImageTransparency = any_State_result1_41:get();
			})
			arg1.Image({"rbxasset://textures/ui/chatBubble_blue_notify_bkg.png", any_State_result1_23:get(), nil, Enum.ScaleType.Slice, any_ComputedState_result1:get(), nil, Rect.new(12, 12, 56, 56), 1}, any_State_result1_40:get())
			arg1.PopConfig()
			arg1.SeparatorText({"Image Button"})
			local any_State_result1_70 = arg1.State(0)
			arg1.SameLine()
			arg1.PushConfig({
				ImageColor = any_State_result1_3:get();
				ImageTransparency = any_State_result1_41:get();
			})
			if arg1.ImageButton({"rbxasset://textures/AvatarCompatibilityPreviewer/add.png", UDim2.fromOffset(20, 20)}).clicked() then
				any_State_result1_70:set(any_State_result1_70.value + 1)
			end
			arg1.PopConfig()
			arg1.Text({`Click count: {any_State_result1_70.value}`})
			arg1.End()
			arg1.End()
		end;
		Selectable = function() -- Line 153, Named "Selectable"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Selectable"})
			local any_State_result1_10 = arg1.State(2)
			arg1.Selectable({"Selectable #1", 1}, {
				index = any_State_result1_10;
			})
			arg1.Selectable({"Selectable #2", 2}, {
				index = any_State_result1_10;
			})
			if arg1.Selectable({"Double click Selectable", 3, true}, {
				index = any_State_result1_10;
			}).doubleClicked() then
				any_State_result1_10:set(3)
			end
			arg1.Selectable({"Impossible to select", 4, true}, {
				index = any_State_result1_10;
			})
			if arg1.Button({"Select last"}).clicked() then
				any_State_result1_10:set(4)
			end
			arg1.Selectable({"Independent Selectable"})
			arg1.End()
		end;
		Combo = function() -- Line 173, Named "Combo"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Combo"})
			arg1.PushConfig({
				ContentWidth = UDim.new(1, -200);
			})
			local any_State_result1_63 = arg1.State("No Selection")
			arg1.SameLine()
			local any_Checkbox_result1_3 = arg1.Checkbox({"No Preview"})
			local any_Checkbox_result1_4 = arg1.Checkbox({"No Button"})
			if any_Checkbox_result1_3.checked() and any_Checkbox_result1_4.isChecked.value == true then
				any_Checkbox_result1_4.isChecked:set(false)
			end
			if any_Checkbox_result1_4.checked() and any_Checkbox_result1_3.isChecked.value == true then
				any_Checkbox_result1_3.isChecked:set(false)
			end
			arg1.End()
			arg1.Combo({"Basic Usage", any_Checkbox_result1_4.isChecked:get(), any_Checkbox_result1_3.isChecked:get()}, {
				index = any_State_result1_63;
			})
			arg1.Selectable({"Select 1", "One"}, {
				index = any_State_result1_63;
			})
			arg1.Selectable({"Select 2", "Two"}, {
				index = any_State_result1_63;
			})
			arg1.Selectable({"Select 3", "Three"}, {
				index = any_State_result1_63;
			})
			arg1.End()
			arg1.ComboArray({"Using ComboArray"}, {
				index = "No Selection";
			}, {"Red", "Green", "Blue"})
			local any_State_result1_22 = arg1.State("7 AM")
			arg1.Combo({"Combo with Inner widgets"}, {
				index = any_State_result1_22;
			})
			arg1.Tree({"Morning Shifts"})
			arg1.Selectable({"Shift at 7 AM", "7 AM"}, {
				index = any_State_result1_22;
			})
			arg1.Selectable({"Shift at 11 AM", "11 AM"}, {
				index = any_State_result1_22;
			})
			arg1.Selectable({"Shift at 3 PM", "3 PM"}, {
				index = any_State_result1_22;
			})
			arg1.End()
			arg1.Tree({"Night Shifts"})
			arg1.Selectable({"Shift at 6 PM", "6 PM"}, {
				index = any_State_result1_22;
			})
			arg1.Selectable({"Shift at 9 PM", "9 PM"}, {
				index = any_State_result1_22;
			})
			arg1.End()
			arg1.End()
			arg1.Text({"Selected: "..arg1.ComboEnum({"Using ComboEnum"}, {
				index = Enum.UserInputState.Begin;
			}, Enum.UserInputState).index:get().Name})
			arg1.PopConfig()
			arg1.End()
		end;
		Tree = function() -- Line 229, Named "Tree"
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: helpMarker_upvr (readonly)
			]]
			arg1.Tree({"Trees"})
			arg1.Tree({"Tree using SpanAvailWidth", true})
			helpMarker_upvr("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area")
			arg1.End()
			arg1.Text({"Im inside the first tree!"})
			arg1.Button({"Im a button inside the first tree!"})
			arg1.Tree({"Im a tree inside the first tree!"})
			arg1.Text({"I am the innermost text!"})
			arg1.End()
			arg1.End()
			arg1.Checkbox({"Toggle above tree"}, {
				isChecked = arg1.Tree({"Tree with Children"}).state.isUncollapsed;
			})
			arg1.End()
		end;
		CollapsingHeader = function() -- Line 255, Named "CollapsingHeader"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Collapsing Headers"})
			arg1.CollapsingHeader({"A header"})
			arg1.Text({"This is under the first header!"})
			arg1.End()
			local any_State_result1_7 = arg1.State(false)
			arg1.CollapsingHeader({"Another header"}, {
				isUncollapsed = any_State_result1_7;
			})
			if arg1.Button({"Shhh... secret button!"}).clicked() then
				any_State_result1_7:set(true)
			end
			arg1.End()
			arg1.End()
		end;
		Group = function() -- Line 276, Named "Group"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Groups"})
			arg1.SameLine()
			arg1.Group()
			arg1.Text({"I am in group A"})
			arg1.Button({"Im also in A"})
			arg1.End()
			arg1.Separator()
			arg1.Group()
			arg1.Text({"I am in group B"})
			arg1.Button({"Im also in B"})
			arg1.Button({"Also group B"})
			arg1.End()
			arg1.End()
			arg1.End()
		end;
		Indent = function() -- Line 303, Named "Indent"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Indents"})
			arg1.Text({"Not Indented"})
			arg1.Indent()
			arg1.Text({"Indented"})
			arg1.Indent({7})
			arg1.Text({"Indented by 7 more pixels"})
			arg1.End()
			arg1.Indent({-7})
			arg1.Text({"Indented by 7 less pixels"})
			arg1.End()
			arg1.End()
			arg1.End()
		end;
		Input = function() -- Line 325, Named "Input"
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: helpMarker_upvr (readonly)
			]]
			arg1.Tree({"Input"})
			local any_State_result1_37 = arg1.State(false)
			arg1.PushConfig({
				ContentWidth = UDim.new(1, -120);
			})
			local any_InputNum_result1 = arg1.InputNum({
				[arg1.Args.InputNum.Text] = "Input Number";
				[arg1.Args.InputNum.NoButtons] = any_State_result1_37.value;
				[arg1.Args.InputNum.Min] = arg1.State(0).value;
				[arg1.Args.InputNum.Max] = arg1.State(100).value;
				[arg1.Args.InputNum.Increment] = arg1.State(1).value;
				[arg1.Args.InputNum.Format] = {arg1.State("%d").value};
			})
			arg1.PopConfig()
			arg1.Text({"The Value is: "..any_InputNum_result1.number.value})
			if arg1.Button({"Randomize Number"}).clicked() then
				any_InputNum_result1.number:set(math.random(1, 99))
			end
			local any_Checkbox_result1_6 = arg1.Checkbox({"NoField"}, {
				isChecked = arg1.State(false);
			})
			local any_Checkbox_result1_5 = arg1.Checkbox({"NoButtons"}, {
				isChecked = any_State_result1_37;
			})
			if any_Checkbox_result1_6.checked() and any_Checkbox_result1_5.isChecked.value == true then
				any_Checkbox_result1_5.isChecked:set(false)
			end
			if any_Checkbox_result1_5.checked() and any_Checkbox_result1_6.isChecked.value == true then
				any_Checkbox_result1_6.isChecked:set(false)
			end
			arg1.PushConfig({
				ContentWidth = UDim.new(1, -120);
			})
			arg1.InputVector2({"InputVector2"})
			arg1.InputVector3({"InputVector3"})
			arg1.InputUDim({"InputUDim"})
			arg1.InputUDim2({"InputUDim2"})
			local any_State_result1_54 = arg1.State(false)
			local any_State_result1_26 = arg1.State(false)
			local any_State_result1_68 = arg1.State(Color3.new())
			local any_State_result1_67 = arg1.State(0)
			arg1.SliderNum({"Transparency", 0.01, 0, 1}, {
				number = any_State_result1_67;
			})
			arg1.InputColor3({"InputColor3", any_State_result1_54:get(), any_State_result1_26:get()}, {
				color = any_State_result1_68;
			})
			arg1.InputColor4({"InputColor4", any_State_result1_54:get(), any_State_result1_26:get()}, {
				color = any_State_result1_68;
				transparency = any_State_result1_67;
			})
			arg1.SameLine()
			arg1.Text({any_State_result1_68:get():ToHex()})
			arg1.Checkbox({"Use Floats"}, {
				isChecked = any_State_result1_54;
			})
			arg1.Checkbox({"Use HSV"}, {
				isChecked = any_State_result1_26;
			})
			arg1.End()
			arg1.PopConfig()
			arg1.Separator()
			arg1.SameLine()
			arg1.Text({"Slider Numbers"})
			helpMarker_upvr("ctrl + click slider number widgets to input a number")
			arg1.End()
			arg1.PushConfig({
				ContentWidth = UDim.new(1, -120);
			})
			arg1.SliderNum({"Slide Int", 1, 1, 8})
			arg1.SliderNum({"Slide Float", 0.01, 0, 100})
			arg1.SliderNum({"Small Numbers", 0.001, -2, 1, "%f radians"})
			arg1.SliderNum({"Odd Ranges", 0.001, (-math.pi), math.pi, "%f radians"})
			arg1.SliderNum({"Big Numbers", 10000, 100000, 10000000})
			arg1.SliderNum({"Few Numbers", 1, 0, 3})
			arg1.PopConfig()
			arg1.Separator()
			arg1.SameLine()
			arg1.Text({"Drag Numbers"})
			helpMarker_upvr("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed")
			arg1.End()
			arg1.PushConfig({
				ContentWidth = UDim.new(1, -120);
			})
			arg1.DragNum({"Drag Int"})
			arg1.DragNum({"Slide Float", 0.001, -10, 10})
			arg1.DragNum({"Percentage", 1, 0, 100, "%d %%"})
			arg1.PopConfig()
			arg1.End()
		end;
		InputText = function() -- Line 408, Named "InputText"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Input Text"})
			arg1.Text({"The text is: "..arg1.InputText({"Input Text Test", "Input Text here"}).text.value})
			arg1.End()
		end;
		MultiInput = function() -- Line 417, Named "MultiInput"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Multi-Component Input"})
			local any_State_result1_39 = arg1.State(Vector2.new())
			local any_State_result1_19 = arg1.State(Vector3.new())
			local any_State_result1_59 = arg1.State(UDim.new())
			local any_State_result1_4 = arg1.State(UDim2.new())
			local any_State_result1_20 = arg1.State(Color3.new())
			local any_State_result1_2 = arg1.State(Rect.new(0, 0, 0, 0))
			arg1.SeparatorText({"Input"})
			arg1.InputVector2({}, {
				number = any_State_result1_39;
			})
			arg1.InputVector3({}, {
				number = any_State_result1_19;
			})
			arg1.InputUDim({}, {
				number = any_State_result1_59;
			})
			arg1.InputUDim2({}, {
				number = any_State_result1_4;
			})
			arg1.InputRect({}, {
				number = any_State_result1_2;
			})
			arg1.SeparatorText({"Drag"})
			arg1.DragVector2({}, {
				number = any_State_result1_39;
			})
			arg1.DragVector3({}, {
				number = any_State_result1_19;
			})
			arg1.DragUDim({}, {
				number = any_State_result1_59;
			})
			arg1.DragUDim2({}, {
				number = any_State_result1_4;
			})
			arg1.DragRect({}, {
				number = any_State_result1_2;
			})
			arg1.SeparatorText({"Slider"})
			arg1.SliderVector2({}, {
				number = any_State_result1_39;
			})
			arg1.SliderVector3({}, {
				number = any_State_result1_19;
			})
			arg1.SliderUDim({}, {
				number = any_State_result1_59;
			})
			arg1.SliderUDim2({}, {
				number = any_State_result1_4;
			})
			arg1.SliderRect({}, {
				number = any_State_result1_2;
			})
			arg1.SeparatorText({"Color"})
			arg1.InputColor3({}, {
				color = any_State_result1_20;
			})
			arg1.InputColor4({}, {
				color = any_State_result1_20;
			})
			arg1.End()
		end;
		Tooltip = function() -- Line 459, Named "Tooltip"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.PushConfig({
				ContentWidth = UDim.new(0, 250);
			})
			arg1.Tree({"Tooltip"})
			if arg1.Text({"Hover over me to reveal a tooltip"}).hovered() then
				arg1.Tooltip({"I am some helpful tooltip text"})
			end
			local any_State_result1_9 = arg1.State("Hello ")
			local any_State_result1_28 = arg1.State(1)
			if arg1.InputNum({"# of repeat", 1, 1, 50}, {
				number = any_State_result1_28;
			}).numberChanged() then
				any_State_result1_9:set(string.rep("Hello ", any_State_result1_28:get()))
			end
			if arg1.Checkbox({"Show dynamic text tooltip"}).isChecked.value then
				arg1.Tooltip({any_State_result1_9:get()})
			end
			arg1.End()
			arg1.PopConfig()
		end;
		Plotting = function() -- Line 479, Named "Plotting"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1.Tree({"Plotting"})
			local any_State_result1_36 = arg1.State(0)
			any_State_result1_36:set(math.clamp(math.abs(os.clock() * 15 % 100 - 50) - 7.5, 0, 35) / 35)
			arg1.ProgressBar({"Progress Bar"}, {
				progress = any_State_result1_36;
			})
			arg1.ProgressBar({"Progress Bar", `{math.floor(any_State_result1_36:get() * 1753)}/1753`}, {
				progress = any_State_result1_36;
			})
			arg1.End()
		end;
	}
	local tbl_17_upvr = {"Basic", "Image", "Selectable", "Combo", "Tree", "CollapsingHeader", "Group", "Indent", "Input", "MultiInput", "InputText", "Tooltip", "Plotting"}
	local function recursiveTree_upvr() -- Line 497, Named "recursiveTree"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: recursiveTree_upvr (readonly)
		]]
		if arg1.Tree({"Recursive Tree"}).state.isUncollapsed.value then
			recursiveTree_upvr()
		end
		arg1.End()
	end
	local function recursiveWindow_upvr(arg1_4) -- Line 507, Named "recursiveWindow"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: recursiveWindow_upvr (readonly)
		]]
		local tbl_8 = {
			size = arg1.State(Vector2.new(175, 100));
		}
		tbl_8.isOpened = arg1_4
		arg1.Window({"Recursive Window"}, tbl_8)
		local any_Checkbox_result1_2 = arg1.Checkbox({"Recurse Again"})
		arg1.End()
		if any_Checkbox_result1_2.isChecked.value then
			recursiveWindow_upvr(any_Checkbox_result1_2.isChecked)
		end
	end
	local function runtimeInfo_upvr() -- Line 521, Named "runtimeInfo"
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: any_State_result1_57_upvr (readonly)
			[3]: helpMarker_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		-- KONSTANTERROR: [0] 1. Error Block 50 start (CF ANALYSIS FAILED)
		local any_Window_result1 = arg1.Window({"Runtime Info"}, {
			isOpened = any_State_result1_57_upvr;
		})
		local _lastVDOM = arg1.Internal._lastVDOM
		local _states = arg1.Internal._states
		local any_State_result1_49 = arg1.State(3)
		local any_State_result1_17 = arg1.State(0)
		local any_State_result1_53 = arg1.State(os.clock())
		arg1.SameLine()
		arg1.InputNum({
			[arg1.Args.InputNum.Text] = "";
			[arg1.Args.InputNum.Format] = "%d Seconds";
			[arg1.Args.InputNum.Max] = 10;
		}, {
			number = any_State_result1_49;
		})
		if arg1.Button({"Disable"}).clicked() then
			arg1.Disabled = true
			task.delay(any_State_result1_49:get(), function() -- Line 536
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1.Disabled = false
			end)
		end
		arg1.End()
		local os_clock_result1 = os.clock()
		any_State_result1_17.value += (os_clock_result1 - any_State_result1_53.value - any_State_result1_17.value) * 0.2
		any_State_result1_53.value = os_clock_result1
		arg1.Text({string.format("Average %.3f ms/frame (%.1f FPS)", any_State_result1_17.value * 1000, 1 / any_State_result1_17.value)})
		arg1.Text({string.format("Window Position: (%d, %d), Window Size: (%d, %d)", any_Window_result1.position.value.X, any_Window_result1.position.value.Y, any_Window_result1.size.value.X, any_Window_result1.size.value.Y)})
		arg1.SameLine()
		arg1.Text({"Enter an ID to learn more about it."})
		helpMarker_upvr("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs")
		arg1.End()
		arg1.PushConfig({
			ItemWidth = UDim.new(1, -150);
		})
		local value = arg1.InputText({"ID field"}, {
			text = arg1.State(any_Window_result1.ID);
		}).text.value
		arg1.PopConfig()
		arg1.Indent()
		local var345 = _lastVDOM[value]
		local var346 = _states[value]
		if var345 then
			arg1.Table({1})
			arg1.Text({string.format("The ID, \"%s\", is a widget", value)})
			arg1.NextRow()
			arg1.Text({string.format("Widget is type: %s", var345.type)})
			arg1.NextRow()
			arg1.Tree({"Widget has Args:"}, {
				isUncollapsed = arg1.State(true);
			})
			for i, v in var345.arguments do
				arg1.Text({i.." - "..tostring(v)})
			end
			arg1.End()
			arg1.NextRow()
			if var345.state then
				local tbl_20 = {}
				v = arg1
				i = v.State
				v = true
				i = i(v)
				tbl_20.isUncollapsed = i
				arg1.Tree({"Widget has State:"}, tbl_20)
				for i_2, v_2 in var345.state do
					arg1.Text({i_2.." - "..tostring(v_2.value)})
				end
				arg1.End()
			end
			arg1.End()
			-- KONSTANTWARNING: GOTO [523] #363
		end
		-- KONSTANTERROR: [0] 1. Error Block 50 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [390] 270. Error Block 51 start (CF ANALYSIS FAILED)
		if var346 then
			arg1.Table({1})
			local tbl_21 = {}
			i_2 = "The ID, \"%s\", is a state"
			v_2 = value
			tbl_21[1] = string.format(i_2, v_2)
			arg1.Text(tbl_21)
			arg1.NextRow()
			local tbl_3 = {}
			i_2 = "Value is type: %s, Value = %s"
			v_2 = typeof(var346.value)
			tbl_3[1] = string.format(i_2, v_2, tostring(var346.value))
			arg1.Text(tbl_3)
			arg1.NextRow()
			local tbl_10 = {}
			v_2 = arg1
			i_2 = v_2.State
			v_2 = true
			i_2 = i_2(v_2)
			tbl_10.isUncollapsed = i_2
			arg1.Tree({"state has connected widgets:"}, tbl_10)
			for i_3, v_3 in var346.ConnectedWidgets do
				arg1.Text({i_3.." - "..v_3.type})
			end
			arg1.End()
			arg1.NextRow()
			arg1.Text({string.format("state has: %d connected functions", #var346.ConnectedFunctions)})
			arg1.End()
		else
			arg1.Text({string.format("The ID, \"%s\", is not a state or widget", value)})
		end
		arg1.End()
		local _ = {"Widgets"}
		local var365
		if var365 then
			var365 = 0
			for _, v_4 in _lastVDOM do
				var365 += 1
			end
			arg1.Text({"Number of Widgets: "..var365})
			arg1.Text({""..'\n'..v_4.ID.." - "..v_4.type})
		end
		arg1.End()
		local _ = {"States"}
		local var369
		if var369 then
			var369 = 0
			for i_5, v_5 in _states do
				var369 += 1
			end
			arg1.Text({"Number of States: "..var369})
			arg1.Text({""..'\n'..i_5.." - "..tostring(v_5.value)})
		end
		arg1.End()
		arg1.End()
		-- KONSTANTERROR: [390] 270. Error Block 51 end (CF ANALYSIS FAILED)
	end
	local function debugPanel_upvr() -- Line 645, Named "debugPanel"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: any_State_result1_14_upvr (readonly)
		]]
		arg1.Window({"Debug Panel"}, {
			isOpened = any_State_result1_14_upvr;
		})
		arg1.CollapsingHeader({"Widgets"})
		arg1.SeparatorText({"GuiService"})
		arg1.Text({`GuiOffset: {arg1.Internal._utility.GuiOffset}`})
		arg1.Text({`MouseOffset: {arg1.Internal._utility.MouseOffset}`})
		arg1.SeparatorText({"UserInputService"})
		arg1.Text({`MousePosition: {arg1.Internal._utility.UserInputService:GetMouseLocation()}`})
		arg1.Text({`MouseLocation: {arg1.Internal._utility.getMouseLocation()}`})
		arg1.Text({`Left Control: {arg1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)}`})
		arg1.Text({`Right Control: {arg1.Internal._utility.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)}`})
		arg1.End()
		arg1.End()
	end
	local function recursiveMenu_upvr() -- Line 666, Named "recursiveMenu"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: recursiveMenu_upvr (readonly)
		]]
		if arg1.Menu({"Recursive"}).state.isOpened.value then
			arg1.MenuItem({"New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl})
			arg1.MenuItem({"Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl})
			arg1.MenuItem({"Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl})
			arg1.Separator()
			arg1.MenuToggle({"Autosave"})
			arg1.MenuToggle({"Checked"})
			arg1.Separator()
			arg1.Menu({"Options"})
			arg1.MenuItem({"Red"})
			arg1.MenuItem({"Yellow"})
			arg1.MenuItem({"Green"})
			arg1.MenuItem({"Blue"})
			arg1.Separator()
			recursiveMenu_upvr()
			arg1.End()
		end
		arg1.End()
	end
	local function mainMenuBar_upvr() -- Line 687, Named "mainMenuBar"
		--[[ Upvalues[9]:
			[1]: arg1 (readonly)
			[2]: recursiveMenu_upvr (readonly)
			[3]: any_State_result1_13_upvr (readonly)
			[4]: any_State_result1_16_upvr (readonly)
			[5]: any_State_result1_71_upvr (readonly)
			[6]: any_State_result1_15_upvr (readonly)
			[7]: any_State_result1_57_upvr (readonly)
			[8]: any_State_result1_62_upvr (readonly)
			[9]: any_State_result1_14_upvr (readonly)
		]]
		arg1.MenuBar()
		arg1.Menu({"File"})
		arg1.MenuItem({"New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl})
		arg1.MenuItem({"Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl})
		arg1.MenuItem({"Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl})
		recursiveMenu_upvr()
		if arg1.MenuItem({"Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt}).clicked() then
			any_State_result1_13_upvr:set(false)
		end
		arg1.End()
		arg1.Menu({"Examples"})
		arg1.MenuToggle({"Recursive Window"}, {
			isChecked = any_State_result1_16_upvr;
		})
		arg1.MenuToggle({"Windowless"}, {
			isChecked = any_State_result1_71_upvr;
		})
		arg1.MenuToggle({"Main Menu Bar"}, {
			isChecked = any_State_result1_15_upvr;
		})
		arg1.End()
		arg1.Menu({"Tools"})
		arg1.MenuToggle({"Runtime Info"}, {
			isChecked = any_State_result1_57_upvr;
		})
		arg1.MenuToggle({"Style Editor"}, {
			isChecked = any_State_result1_62_upvr;
		})
		arg1.MenuToggle({"Debug Panel"}, {
			isChecked = any_State_result1_14_upvr;
		})
		arg1.End()
		arg1.End()
	end
	local function _() -- Line 721, Named "mainMenuBarExample"
		--[[ Upvalues[1]:
			[1]: mainMenuBar_upvr (readonly)
		]]
		mainMenuBar_upvr()
	end
	local function var413_upvw() -- Line 736
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: any_State_result1_62_upvr (readonly)
		]]
		local any_State_result1_69 = arg1.State(1)
		local tbl_25 = {{"Sizing", function() -- Line 742
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			local any_State_result1_66_upvr = arg1.State({})
			if arg1.Button({"Update Config"}).clicked() then
				arg1.UpdateGlobalConfig(any_State_result1_66_upvr:get())
				any_State_result1_66_upvr:set({})
			end
			local function SliderInput(arg1_5, arg2) -- Line 750
				--[[ Upvalues[2]:
					[1]: arg1 (copied, readonly)
					[2]: any_State_result1_66_upvr (readonly)
				]]
				local any_any_result1 = arg1[arg1_5](arg2, {
					number = arg1.WeakState(arg1._config[arg2[1]]);
				})
				if any_any_result1.numberChanged() then
					any_State_result1_66_upvr:get()[arg2[1]] = any_any_result1.number:get()
				end
			end
			local function BooleanInput(arg1_6) -- Line 757
				--[[ Upvalues[2]:
					[1]: arg1 (copied, readonly)
					[2]: any_State_result1_66_upvr (readonly)
				]]
				local any_Checkbox_result1 = arg1.Checkbox(arg1_6, {
					isChecked = arg1.WeakState(arg1._config[arg1_6[1]]);
				})
				if any_Checkbox_result1.checked() or any_Checkbox_result1.unchecked() then
					any_State_result1_66_upvr:get()[arg1_6[1]] = any_Checkbox_result1.isChecked:get()
				end
			end
			arg1.SeparatorText({"Main"})
			SliderInput("SliderVector2", {"WindowPadding", nil, Vector2.zero, Vector2.one * 20})
			SliderInput("SliderVector2", {"WindowResizePadding", nil, Vector2.zero, Vector2.one * 20})
			SliderInput("SliderVector2", {"FramePadding", nil, Vector2.zero, Vector2.one * 20})
			SliderInput("SliderVector2", {"ItemSpacing", nil, Vector2.zero, Vector2.one * 20})
			SliderInput("SliderVector2", {"ItemInnerSpacing", nil, Vector2.zero, Vector2.one * 20})
			SliderInput("SliderVector2", {"CellPadding", nil, Vector2.zero, Vector2.one * 20})
			SliderInput("SliderNum", {"IndentSpacing", 1, 0, 36})
			SliderInput("SliderNum", {"ScrollbarSize", 1, 0, 20})
			SliderInput("SliderNum", {"GrabMinSize", 1, 0, 20})
			arg1.SeparatorText({"Borders & Rounding"})
			SliderInput("SliderNum", {"FrameBorderSize", 0.1, 0, 1})
			SliderInput("SliderNum", {"WindowBorderSize", 0.1, 0, 1})
			SliderInput("SliderNum", {"PopupBorderSize", 0.1, 0, 1})
			SliderInput("SliderNum", {"SeparatorTextBorderSize", 1, 0, 20})
			SliderInput("SliderNum", {"FrameRounding", 1, 0, 12})
			SliderInput("SliderNum", {"GrabRounding", 1, 0, 12})
			SliderInput("SliderNum", {"PopupRounding", 1, 0, 12})
			arg1.SeparatorText({"Widgets"})
			SliderInput("SliderVector2", {"DisplaySafeAreaPadding", nil, Vector2.zero, Vector2.one * 20})
			SliderInput("SliderVector2", {"SeparatorTextPadding", nil, Vector2.zero, Vector2.one * 36})
			SliderInput("SliderUDim", {"ItemWidth", nil, UDim.new(), UDim.new(1, 200)})
			SliderInput("SliderUDim", {"ContentWidth", nil, UDim.new(), UDim.new(1, 200)})
			SliderInput("SliderNum", {"TextSize", 1, 4, 20})
			SliderInput("SliderNum", {"ImageBorderSize", 1, 0, 12})
			local any_ComboEnum_result1 = arg1.ComboEnum({"WindowTitleAlign"}, {
				index = arg1.WeakState(arg1._config.WindowTitleAlign);
			}, Enum.LeftRight)
			if any_ComboEnum_result1.closed() then
				any_State_result1_66_upvr:get().WindowTitleAlign = any_ComboEnum_result1.index:get()
			end
			BooleanInput({"RichText"})
			BooleanInput({"TextWrapped"})
			arg1.SeparatorText({"Config"})
			BooleanInput({"UseScreenGUIs"})
			SliderInput("DragNum", {"DisplayOrderOffset", 1, 0})
			SliderInput("DragNum", {"ZIndexOffset", 1, 0})
			SliderInput("SliderNum", {"MouseDoubleClickTime", 0.1, 0, 5})
			SliderInput("SliderNum", {"MouseDoubleClickMaxDist", 0.1, 0, 20})
		end}, {"Colors", function() -- Line 808
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			local any_State_result1_5 = arg1.State({})
			if arg1.Button({"Update Config"}).clicked() then
				arg1.UpdateGlobalConfig(any_State_result1_5:get())
				any_State_result1_5:set({})
			end
			for _, v_6 in {"BorderColor", "BorderActiveColor"} do
				local any_InputColor3_result1 = arg1.InputColor3({v_6}, {
					color = arg1.WeakState(arg1._config[v_6]);
				})
				if any_InputColor3_result1.numberChanged() then
					arg1.UpdateGlobalConfig({
						[v_6] = any_InputColor3_result1.color:get();
					})
				end
			end
			for _, v_7 in {"Text", "TextDisabled", "WindowBg", "PopupBg", "ScrollbarGrab", "TitleBg", "TitleBgActive", "TitleBgCollapsed", "MenubarBg", "FrameBg", "FrameBgHovered", "FrameBgActive", "Button", "ButtonHovered", "ButtonActive", "Image", "SliderGrab", "SliderGrabActive", "Header", "HeaderHovered", "HeaderActive", "SelectionImageObject", "SelectionImageObjectBorder", "TableBorderStrong", "TableBorderLight", "TableRowBg", "TableRowBgAlt", "NavWindowingHighlight", "NavWindowingDimBg", "Separator", "CheckMark"} do
				local any_InputColor4_result1 = arg1.InputColor4({v_7}, {
					color = arg1.WeakState(arg1._config[v_7.."Color"]);
					transparency = arg1.WeakState(arg1._config[v_7.."Transparency"]);
				})
				if any_InputColor4_result1.numberChanged() then
					any_State_result1_5:get()[v_7.."Color"] = any_InputColor4_result1.color:get()
					any_State_result1_5:get()[v_7.."Transparency"] = any_InputColor4_result1.transparency:get()
				end
			end
		end}}
		arg1.Text({`Clicked close: {arg1.Window({"Style Editor"}, {
			isOpened = any_State_result1_62_upvr;
		}).closed()}`})
		arg1.Text({"Customize the look of Iris in realtime."})
		arg1.SameLine()
		if arg1.SmallButton({"Light Theme"}).clicked() then
			arg1.UpdateGlobalConfig(arg1.TemplateConfig.colorLight)
		end
		if arg1.SmallButton({"Dark Theme"}).clicked() then
			arg1.UpdateGlobalConfig(arg1.TemplateConfig.colorDark)
		end
		arg1.End()
		arg1.SameLine()
		if arg1.SmallButton({"Classic Size"}).clicked() then
			arg1.UpdateGlobalConfig(arg1.TemplateConfig.sizeDefault)
		end
		if arg1.SmallButton({"Larger Size"}).clicked() then
			arg1.UpdateGlobalConfig(arg1.TemplateConfig.sizeClear)
		end
		arg1.End()
		if arg1.SmallButton({"Reset Everything"}).clicked() then
			arg1.UpdateGlobalConfig(arg1.TemplateConfig.colorDark)
			arg1.UpdateGlobalConfig(arg1.TemplateConfig.sizeDefault)
		end
		arg1.Separator()
		arg1.SameLine()
		for i_8, v_8 in ipairs(tbl_25) do
			arg1.RadioButton({v_8[1], i_8}, {
				index = any_State_result1_69;
			})
		end
		arg1.End()
		tbl_25[any_State_result1_69:get()][2]()
		arg1.End()
	end
	local function widgetEventInteractivity_upvr() -- Line 919, Named "widgetEventInteractivity"
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1.CollapsingHeader({"Widget Event Interactivity"})
		local any_State_result1_48 = arg1.State(0)
		if arg1.Button({"Click to increase Number"}).clicked() then
			any_State_result1_48:set(any_State_result1_48:get() + 1)
		end
		arg1.Text({"The Number is: "..any_State_result1_48:get()})
		arg1.Separator()
		local any_State_result1_47 = arg1.State(false)
		local any_State_result1_27 = arg1.State("clicked")
		arg1.SameLine()
		arg1.RadioButton({"clicked", "clicked"}, {
			index = any_State_result1_27;
		})
		arg1.RadioButton({"rightClicked", "rightClicked"}, {
			index = any_State_result1_27;
		})
		arg1.RadioButton({"doubleClicked", "doubleClicked"}, {
			index = any_State_result1_27;
		})
		arg1.RadioButton({"ctrlClicked", "ctrlClicked"}, {
			index = any_State_result1_27;
		})
		arg1.End()
		arg1.SameLine()
		if arg1.Button({any_State_result1_27:get().." to reveal text"})[any_State_result1_27:get()]() then
			any_State_result1_47:set(not any_State_result1_47:get())
		end
		if any_State_result1_47:get() then
			arg1.Text({"Here i am!"})
		end
		arg1.End()
		arg1.Separator()
		local any_State_result1_34 = arg1.State(0)
		arg1.SameLine()
		if arg1.Button({"Click to show text for 20 frames"}).clicked() then
			any_State_result1_34:set(20)
		end
		if 0 < any_State_result1_34:get() then
			arg1.Text({"Here i am!"})
		end
		arg1.End()
		any_State_result1_34:set(math.max(0, any_State_result1_34:get() - 1))
		arg1.Text({"Text Timer: "..any_State_result1_34:get()})
		local any_Checkbox_result1_7 = arg1.Checkbox({"Event-tracked checkbox"})
		arg1.Indent()
		arg1.Text({"unchecked: "..tostring(any_Checkbox_result1_7.unchecked())})
		arg1.Text({"checked: "..tostring(any_Checkbox_result1_7.checked())})
		arg1.End()
		arg1.SameLine()
		if arg1.Button({"Hover over me"}).hovered() then
			arg1.Text({"The button is hovered"})
		end
		arg1.End()
		arg1.End()
	end
	local function widgetStateInteractivity_upvr() -- Line 989, Named "widgetStateInteractivity"
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1.CollapsingHeader({"Widget State Interactivity"})
		arg1.Text({`isChecked: {arg1.Checkbox({"Widget-Generated State"}).state.isChecked.value}\n`})
		arg1.Text({`isChecked: {arg1.Checkbox({"User-Generated State"}, {
			isChecked = arg1.State(false);
		}).state.isChecked.value}\n`})
		arg1.Text({`isChecked: {arg1.Checkbox({"Coupled to above Checkbox"}, {
			isChecked = arg1.Checkbox({"Widget Coupled State"}).state.isChecked;
		}).state.isChecked.value}\n`})
		local any_State_result1_43 = arg1.State(false)
		local _ = {"Widget and Code Coupled State"}
		local _ = {
			isChecked = any_State_result1_43;
		}
		if arg1.Button({"Click to toggle above checkbox"}).clicked() then
			any_State_result1_43:set(not any_State_result1_43:get())
		end
		arg1.Text({`isChecked: {any_State_result1_43.value}\n`})
		local any_State_result1_42 = arg1.State(true)
		local any_ComputedState_result1_2 = arg1.ComputedState(any_State_result1_42, function(arg1_7) -- Line 1012
			return not arg1_7
		end)
		local _ = {"ComputedState (dynamic coupling)"}
		local _ = {
			isChecked = any_State_result1_42;
		}
		local _ = {"Inverted of above checkbox"}
		local _ = {
			isChecked = any_ComputedState_result1_2;
		}
		arg1.Text({`isChecked: {any_ComputedState_result1_2.value}\n`})
		arg1.End()
	end
	local function dynamicStyle_upvr() -- Line 1022, Named "dynamicStyle"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: helpMarker_upvr (readonly)
		]]
		arg1.CollapsingHeader({"Dynamic Styles"})
		local any_State_result1_60 = arg1.State(0)
		arg1.SameLine()
		if arg1.Button({"Change Color"}).clicked() then
			any_State_result1_60:set(math.random())
		end
		arg1.Text({"Hue: "..math.floor(any_State_result1_60:get() * 255)})
		helpMarker_upvr("Using PushConfig with a changing value, this can be done with any config field")
		arg1.End()
		arg1.PushConfig({
			TextColor = Color3.fromHSV(any_State_result1_60:get(), 1, 1);
		})
		arg1.Text({"Text with a unique and changable color"})
		arg1.PopConfig()
		arg1.End()
	end
	local function tablesDemo_upvr() -- Line 1043, Named "tablesDemo"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: helpMarker_upvr (readonly)
		]]
		local any_State_result1_18 = arg1.State(false)
		arg1.CollapsingHeader({"Tables & Columns"}, {
			isUncollapsed = any_State_result1_18;
		})
		if any_State_result1_18.value == false then
			arg1.End()
		else
			arg1.SameLine()
			arg1.Text({"Table using NextRow and NextColumn syntax:"})
			helpMarker_upvr("calling Iris.NextRow() in the outer loop, and Iris.NextColumn()in the inner loop")
			arg1.End()
			arg1.Table({3})
			for i_10 = 1, 4 do
				arg1.NextRow()
				for i_11 = 1, 3 do
					arg1.NextColumn()
					arg1.Text({`Row: {i_10}, Column: {i_11}`})
				end
			end
			arg1.End()
			arg1.Text({""})
			arg1.SameLine()
			arg1.Text({"Table using NextColumn only syntax:"})
			helpMarker_upvr("only calling Iris.NextColumn() in the inner loop, the result is identical")
			arg1.End()
			arg1.Table({2})
			for i_12 = 1, 4 do
				for i_13 = 1, 2 do
					arg1.NextColumn()
					arg1.Text({`Row: {i_12}, Column: {i_13}`})
				end
			end
			arg1.End()
			arg1.Separator()
			local any_State_result1_38 = arg1.State(false)
			local any_State_result1_52 = arg1.State(false)
			local any_State_result1_24 = arg1.State(true)
			local any_State_result1_65 = arg1.State(true)
			local any_State_result1 = arg1.State(3)
			arg1.Text({"Table with Customizable Arguments"})
			arg1.Table({
				[arg1.Args.Table.NumColumns] = 4;
				[arg1.Args.Table.RowBg] = any_State_result1_38.value;
				[arg1.Args.Table.BordersOuter] = any_State_result1_52.value;
				[arg1.Args.Table.BordersInner] = any_State_result1_24.value;
			})
			for i_14 = 1, any_State_result1:get() do
				for i_15 = 1, 4 do
					arg1.NextColumn()
					if any_State_result1_65.value then
						arg1.Button({`Month: {i_14}, Week: {i_15}`})
					else
						arg1.Text({`Month: {i_14}, Week: {i_15}`})
					end
				end
			end
			arg1.End()
			arg1.Checkbox({"RowBg"}, {
				isChecked = any_State_result1_38;
			})
			arg1.Checkbox({"BordersOuter"}, {
				isChecked = any_State_result1_52;
			})
			arg1.Checkbox({"BordersInner"}, {
				isChecked = any_State_result1_24;
			})
			arg1.SameLine()
			arg1.RadioButton({"Buttons", true}, {
				index = any_State_result1_65;
			})
			arg1.RadioButton({"Text", false}, {
				index = any_State_result1_65;
			})
			arg1.End()
			arg1.InputNum({
				[arg1.Args.InputNum.Text] = "Number of rows";
				[arg1.Args.InputNum.Min] = 0;
				[arg1.Args.InputNum.Max] = 100;
				[arg1.Args.InputNum.Format] = "%d";
			}, {
				number = any_State_result1;
			})
			arg1.End()
		end
	end
	local function layoutDemo_upvr() -- Line 1143, Named "layoutDemo"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: helpMarker_upvr (readonly)
		]]
		arg1.CollapsingHeader({"Widget Layout"})
		arg1.Tree({"Content Width"})
		local any_State_result1_46 = arg1.State(50)
		local any_State_result1_64 = arg1.State(Enum.Axis.X)
		arg1.Text({"The Content Width is a size property which determines the width of input fields."})
		arg1.SameLine()
		arg1.Text({"By default the value is UDim.new(0.65, 0)"})
		helpMarker_upvr("This is the default value from Dear ImGui.\nIt is 65% of the window width.")
		arg1.End()
		arg1.Text({"This works well, but sometimes we know how wide elements are going to be and want to maximise the space."})
		arg1.Text({"Therefore, we can use Iris.PushConfig() to change the width"})
		arg1.Separator()
		arg1.SameLine()
		arg1.Text({"Content Width = 150 pixels"})
		helpMarker_upvr("UDim.new(0, 150)")
		arg1.End()
		arg1.PushConfig({
			ContentWidth = UDim.new(0, 150);
		})
		arg1.DragNum({"number", 1, 0, 100}, {
			number = any_State_result1_46;
		})
		arg1.ComboEnum({"axis"}, {
			index = any_State_result1_64;
		}, Enum.Axis)
		arg1.PopConfig()
		arg1.SameLine()
		arg1.Text({"Content Width = 50% window width"})
		helpMarker_upvr("UDim.new(0.5, 0)")
		arg1.End()
		arg1.PushConfig({
			ContentWidth = UDim.new(0.5, 0);
		})
		arg1.DragNum({"number", 1, 0, 100}, {
			number = any_State_result1_46;
		})
		arg1.ComboEnum({"axis"}, {
			index = any_State_result1_64;
		}, Enum.Axis)
		arg1.PopConfig()
		arg1.SameLine()
		arg1.Text({"Content Width = -150 pixels from the right side"})
		helpMarker_upvr("UDim.new(1, -150)")
		arg1.End()
		arg1.PushConfig({
			ContentWidth = UDim.new(1, -150);
		})
		arg1.DragNum({"number", 1, 0, 100}, {
			number = any_State_result1_46;
		})
		arg1.InputEnum({"axis"}, {
			index = any_State_result1_64;
		}, Enum.Axis)
		arg1.PopConfig()
		arg1.End()
		arg1.Tree({"Content Height"})
		local any_State_result1_51 = arg1.State("a single line")
		local any_State_result1_12 = arg1.State(50)
		local any_State_result1_61 = arg1.State(Enum.Axis.X)
		local any_State_result1_33 = arg1.State(0)
		any_State_result1_33:set(math.clamp(math.abs(os.clock() * 15 % 100 - 50) - 7.5, 0, 35) / 35)
		arg1.Text({"The Content Height is a size property that determines the minimum size of certain widgets."})
		arg1.Text({"By default the value is UDim.new(0, 0), so there is no minimum height."})
		arg1.Text({"We use Iris.PushConfig() to change this value."})
		arg1.Separator()
		arg1.SameLine()
		arg1.Text({"Content Height = 0 pixels"})
		helpMarker_upvr("UDim.new(0, 0)")
		arg1.End()
		arg1.InputText({"text"}, {
			text = any_State_result1_51;
		})
		arg1.ProgressBar({"progress"}, {
			progress = any_State_result1_33;
		})
		arg1.DragNum({"number", 1, 0, 100}, {
			number = any_State_result1_12;
		})
		arg1.ComboEnum({"axis"}, {
			index = any_State_result1_61;
		}, Enum.Axis)
		arg1.SameLine()
		arg1.Text({"Content Height = 60 pixels"})
		helpMarker_upvr("UDim.new(0, 60)")
		arg1.End()
		arg1.PushConfig({
			ContentHeight = UDim.new(0, 60);
		})
		arg1.InputText({"text", nil, nil, true}, {
			text = any_State_result1_51;
		})
		arg1.ProgressBar({"progress"}, {
			progress = any_State_result1_33;
		})
		arg1.DragNum({"number", 1, 0, 100}, {
			number = any_State_result1_12;
		})
		arg1.ComboEnum({"axis"}, {
			index = any_State_result1_61;
		}, Enum.Axis)
		arg1.PopConfig()
		arg1.Text({"This property can be used to force the height of a text box."})
		arg1.Text({"Just make sure you enable the MultiLine argument."})
		arg1.End()
		arg1.End()
	end
	local function windowlessDemo_upvr() -- Line 1253, Named "windowlessDemo"
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: helpMarker_upvr (readonly)
		]]
		arg1.PushConfig({
			ItemWidth = UDim.new(0, 150);
		})
		arg1.SameLine()
		arg1.TextWrapped({"Windowless widgets"})
		helpMarker_upvr("Widgets which are placed outside of a window will appear on the top left side of the screen.")
		arg1.End()
		arg1.Button({})
		arg1.Tree({})
		arg1.InputText({})
		arg1.End()
		arg1.PopConfig()
	end
	return function() -- Line 1273
		--[[ Upvalues[22]:
			[1]: arg1 (readonly)
			[2]: any_State_result1_13_upvr (readonly)
			[3]: mainMenuBar_upvr (readonly)
			[4]: widgetEventInteractivity_upvr (readonly)
			[5]: widgetStateInteractivity_upvr (readonly)
			[6]: recursiveTree_upvr (readonly)
			[7]: dynamicStyle_upvr (readonly)
			[8]: tbl_17_upvr (readonly)
			[9]: tbl_5_upvr (readonly)
			[10]: tablesDemo_upvr (readonly)
			[11]: layoutDemo_upvr (readonly)
			[12]: any_State_result1_16_upvr (readonly)
			[13]: recursiveWindow_upvr (readonly)
			[14]: any_State_result1_57_upvr (readonly)
			[15]: runtimeInfo_upvr (readonly)
			[16]: any_State_result1_14_upvr (readonly)
			[17]: debugPanel_upvr (readonly)
			[18]: any_State_result1_62_upvr (readonly)
			[19]: var413_upvw (read and write)
			[20]: any_State_result1_71_upvr (readonly)
			[21]: windowlessDemo_upvr (readonly)
			[22]: any_State_result1_15_upvr (readonly)
		]]
		local any_State_result1_8 = arg1.State(false)
		local any_State_result1_44 = arg1.State(false)
		local any_State_result1_31 = arg1.State(false)
		local any_State_result1_58 = arg1.State(true)
		local any_State_result1_55 = arg1.State(false)
		local any_State_result1_32 = arg1.State(false)
		local any_State_result1_29 = arg1.State(false)
		local any_State_result1_6 = arg1.State(false)
		local any_State_result1_11 = arg1.State(false)
		if any_State_result1_13_upvr.value == false then
			arg1.Checkbox({"Open main window"}, {
				isChecked = any_State_result1_13_upvr;
			})
			return
		end
		debug.profilebegin("Iris/Demo/Window")
		local any_Window_result1_2 = arg1.Window({
			[arg1.Args.Window.Title] = "Iris Demo Window";
			[arg1.Args.Window.NoTitleBar] = any_State_result1_8.value;
			[arg1.Args.Window.NoBackground] = any_State_result1_44.value;
			[arg1.Args.Window.NoCollapse] = any_State_result1_31.value;
			[arg1.Args.Window.NoClose] = any_State_result1_58.value;
			[arg1.Args.Window.NoMove] = any_State_result1_55.value;
			[arg1.Args.Window.NoScrollbar] = any_State_result1_32.value;
			[arg1.Args.Window.NoResize] = any_State_result1_29.value;
			[arg1.Args.Window.NoNav] = any_State_result1_6.value;
			[arg1.Args.Window.NoMenu] = any_State_result1_11.value;
		}, {
			size = arg1.State(Vector2.new(600, 550));
			position = arg1.State(Vector2.new(100, 25));
			isOpened = any_State_result1_13_upvr;
		})
		if any_Window_result1_2.state.isUncollapsed.value and any_Window_result1_2.state.isOpened.value then
			debug.profilebegin("Iris/Demo/MenuBar")
			mainMenuBar_upvr()
			debug.profileend()
			arg1.Text({"Iris says hello. ("..arg1.Internal._version..')'})
			debug.profilebegin("Iris/Demo/Options")
			arg1.CollapsingHeader({"Window Options"})
			arg1.Table({3, false, false, false})
			arg1.NextColumn()
			arg1.Checkbox({"NoTitleBar"}, {
				isChecked = any_State_result1_8;
			})
			arg1.NextColumn()
			arg1.Checkbox({"NoBackground"}, {
				isChecked = any_State_result1_44;
			})
			arg1.NextColumn()
			arg1.Checkbox({"NoCollapse"}, {
				isChecked = any_State_result1_31;
			})
			arg1.NextColumn()
			arg1.Checkbox({"NoClose"}, {
				isChecked = any_State_result1_58;
			})
			arg1.NextColumn()
			arg1.Checkbox({"NoMove"}, {
				isChecked = any_State_result1_55;
			})
			arg1.NextColumn()
			arg1.Checkbox({"NoScrollbar"}, {
				isChecked = any_State_result1_32;
			})
			arg1.NextColumn()
			arg1.Checkbox({"NoResize"}, {
				isChecked = any_State_result1_29;
			})
			arg1.NextColumn()
			arg1.Checkbox({"NoNav"}, {
				isChecked = any_State_result1_6;
			})
			arg1.NextColumn()
			arg1.Checkbox({"NoMenu"}, {
				isChecked = any_State_result1_11;
			})
			arg1.End()
			arg1.End()
			debug.profileend()
			debug.profilebegin("Iris/Demo/Events")
			widgetEventInteractivity_upvr()
			debug.profileend()
			debug.profilebegin("Iris/Demo/States")
			widgetStateInteractivity_upvr()
			debug.profileend()
			debug.profilebegin("Iris/Demo/Recursive")
			arg1.CollapsingHeader({"Recursive Tree"})
			if arg1.Tree({"Recursive Tree"}).state.isUncollapsed.value then
				recursiveTree_upvr()
			end
			arg1.End()
			arg1.End()
			debug.profileend()
			debug.profilebegin("Iris/Demo/Style")
			dynamicStyle_upvr()
			debug.profileend()
			arg1.Separator()
			debug.profilebegin("Iris/Demo/Widgets")
			arg1.CollapsingHeader({"Widgets"})
			for _, v_9 in tbl_17_upvr do
				debug.profilebegin(`Iris/Demo/Widgets/{v_9}`)
				tbl_5_upvr[v_9]()
				debug.profileend()
			end
			arg1.End()
			debug.profileend()
			debug.profilebegin("Iris/Demo/Tables")
			tablesDemo_upvr()
			debug.profileend()
			debug.profilebegin("Iris/Demo/Layout")
			layoutDemo_upvr()
			debug.profileend()
		end
		arg1.End()
		debug.profileend()
		if any_State_result1_16_upvr.value then
			recursiveWindow_upvr(any_State_result1_16_upvr)
		end
		if any_State_result1_57_upvr.value then
			runtimeInfo_upvr()
		end
		if any_State_result1_14_upvr.value then
			debugPanel_upvr()
		end
		if any_State_result1_62_upvr.value then
			var413_upvw()
		end
		if any_State_result1_71_upvr.value then
			windowlessDemo_upvr()
		end
		if any_State_result1_15_upvr.value then
			mainMenuBar_upvr()
		end
		return any_Window_result1_2
	end
end