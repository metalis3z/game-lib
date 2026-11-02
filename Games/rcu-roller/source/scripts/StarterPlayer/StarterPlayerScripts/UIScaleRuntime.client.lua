-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:24
-- Luau version 6, Types version 3
-- Time taken: 0.005807 seconds

local CollectionService_upvr = game:GetService("CollectionService")
local tbl_5_upvr = {
	Resolution = {
		is = "Vector2";
		default = Vector2.new(1280, 720);
	};
	ScaleRange = {
		is = "NumberRange";
		default = NumberRange.new(0, math.huge);
	};
}
local tbl_2_upvr = {}
local tbl_4_upvr = {}
local function _(arg1, arg2) -- Line 35, Named "removeFromList"
	local table_find_result1_7 = table.find(arg1, arg2)
	if table_find_result1_7 then
		table.remove(arg1, table_find_result1_7)
	end
end
local StarterGui_upvr = game:GetService("StarterGui")
local function update_upvr(arg1) -- Line 43, Named "update"
	--[[ Upvalues[5]:
		[1]: StarterGui_upvr (readonly)
		[2]: tbl_5_upvr (readonly)
		[3]: tbl_2_upvr (readonly)
		[4]: update_upvr (readonly)
		[5]: tbl_4_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var33
	if not arg1:IsA("UIScale") or arg1:IsDescendantOf(StarterGui_upvr) then
	else
		local tbl = {}
		local pairs_result1, pairs_result2, pairs_result3 = pairs(tbl_5_upvr)
		for i_2, v_2 in pairs_result1, pairs_result2, pairs_result3 do
			local attribute = arg1:GetAttribute(i_2)
			if typeof(attribute) ~= v_2.is then
				attribute = v_2.default
				warn(`no '{i_2}' attribute found for {arg1:GetFullName()}, using '{v_2.default}' instead`)
			end
			tbl[i_2] = attribute
		end
		if not arg1.Parent then return end
		pairs_result3 = "GuiBase2d"
		local instance_upvr = arg1.Parent:FindFirstAncestorWhichIsA(pairs_result3)
		pairs_result2 = nil
		local var40 = pairs_result2
		pairs_result3 = nil
		local function INLINED() -- Internal function, doesn't exist in bytecode
			i_2 = instance_upvr:IsA("ScreenGui")
			return i_2
		end
		local function INLINED_2() -- Internal function, doesn't exist in bytecode
			i_2 = instance_upvr.IgnoreGuiInset
			return i_2
		end
		local function INLINED_3() -- Internal function, doesn't exist in bytecode
			v_2 = Enum.ScreenInsets.None
			i_2 = instance_upvr.ScreenInsets
			return i_2 == v_2
		end
		if not instance_upvr or INLINED() and (INLINED_2() or INLINED_3()) then
			v_2 = workspace
			i_2 = v_2.CurrentCamera
			var40 = i_2.ViewportSize
			i_2 = workspace
			pairs_result3 = i_2.CurrentCamera
		else
			var40 = instance_upvr.AbsoluteSize
			pairs_result3 = instance_upvr
		end
		local var45 = tbl_2_upvr[pairs_result3]
		if not var45 then
			local tbl_6 = {
				source = pairs_result3;
				scales = {};
			}
			local var43_upvw
			local changeProp = pairs_result3:IsA("Camera") and "ViewportSize" or "AbsoluteSize"
			tbl_6.signal = pairs_result3:GetPropertyChangedSignal(changeProp):Connect(function()
				for i_3 in var43_upvw.scales do
					update_upvr(i_3)
				end
			end)
			var43_upvw = tbl_6
			var45 = var43_upvw
			tbl_2_upvr[pairs_result3] = var45
		end
		if not var45.scales[arg1] then
			local tbl_3_upvr = {
				listener = var45;
				signals = {};
				text_constraints = {};
			}
			var45.scales[arg1] = tbl_3_upvr
			tbl_4_upvr[arg1] = tbl_3_upvr
			if instance_upvr then
				local function _(arg1_2) -- Line 115, Named "setupCleanup"
					--[[ Upvalues[2]:
						[1]: instance_upvr (readonly)
						[2]: tbl_3_upvr (readonly)
					]]
					local var48_upvw
					var48_upvw = arg1_2.AncestryChanged:Connect(function() -- Line 117
						--[[ Upvalues[4]:
							[1]: arg1_2 (readonly)
							[2]: instance_upvr (copied, readonly)
							[3]: tbl_3_upvr (copied, readonly)
							[4]: var48_upvw (read and write)
						]]
						if arg1_2:IsDescendantOf(instance_upvr) then
						else
							local signals_2 = tbl_3_upvr.signals
							local table_find_result1_3 = table.find(signals_2, var48_upvw)
							if table_find_result1_3 then
								table.remove(signals_2, table_find_result1_3)
							end
							local text_constraints_2 = tbl_3_upvr.text_constraints
							local table_find_result1_4 = table.find(text_constraints_2, arg1_2)
							if table_find_result1_4 then
								table.remove(text_constraints_2, table_find_result1_4)
							end
							print(tbl_3_upvr)
						end
					end)
					table.insert(tbl_3_upvr.signals, var48_upvw)
				end
				for _, v_3_upvr in instance_upvr:GetDescendants() do
					if v_3_upvr:IsA("UITextSizeConstraint") then
						table.insert(tbl_3_upvr.text_constraints, v_3_upvr)
						v_3_upvr:SetAttribute("__uitools_reference_range", NumberRange.new(v_3_upvr.MinTextSize, v_3_upvr.MaxTextSize))
						local var57_upvw
						var57_upvw = v_3_upvr.AncestryChanged:Connect(function() -- Line 117
							--[[ Upvalues[4]:
								[1]: v_3_upvr (readonly)
								[2]: instance_upvr (readonly)
								[3]: tbl_3_upvr (readonly)
								[4]: var57_upvw (read and write)
							]]
							if v_3_upvr:IsDescendantOf(instance_upvr) then
							else
								local signals = tbl_3_upvr.signals
								local table_find_result1 = table.find(signals, var57_upvw)
								if table_find_result1 then
									table.remove(signals, table_find_result1)
								end
								local text_constraints = tbl_3_upvr.text_constraints
								local table_find_result1_6 = table.find(text_constraints, v_3_upvr)
								if table_find_result1_6 then
									table.remove(text_constraints, table_find_result1_6)
								end
								print(tbl_3_upvr)
							end
						end)
						table.insert(tbl_3_upvr.signals, var57_upvw)
					end
				end
				table.insert(tbl_3_upvr.signals, instance_upvr.DescendantAdded:Connect(function(arg1_3) -- Line 145
					--[[ Upvalues[3]:
						[1]: tbl_3_upvr (readonly)
						[2]: arg1 (readonly)
						[3]: instance_upvr (readonly)
					]]
					if not arg1_3:IsA("UITextSizeConstraint") then
					else
						table.insert(tbl_3_upvr.text_constraints, arg1_3)
						local __uitools_reference_range = arg1_3:GetAttribute("__uitools_reference_range")
						if typeof(__uitools_reference_range) == "NumberRange" then
							arg1_3.MinTextSize = __uitools_reference_range.Min * arg1.Scale
							arg1_3.MaxTextSize = __uitools_reference_range.Max * arg1.Scale
						end
						local var65_upvw
						var65_upvw = arg1_3.AncestryChanged:Connect(function() -- Line 117
							--[[ Upvalues[4]:
								[1]: arg1_3 (readonly)
								[2]: instance_upvr (copied, readonly)
								[3]: tbl_3_upvr (copied, readonly)
								[4]: var65_upvw (read and write)
							]]
							if arg1_3:IsDescendantOf(instance_upvr) then
							else
								local signals_3 = tbl_3_upvr.signals
								local table_find_result1_2 = table.find(signals_3, var65_upvw)
								if table_find_result1_2 then
									table.remove(signals_3, table_find_result1_2)
								end
								local text_constraints_3 = tbl_3_upvr.text_constraints
								local table_find_result1_5 = table.find(text_constraints_3, arg1_3)
								if table_find_result1_5 then
									table.remove(text_constraints_3, table_find_result1_5)
								end
								print(tbl_3_upvr)
							end
						end)
						table.insert(tbl_3_upvr.signals, var65_upvw)
					end
				end))
			end
		end
		local var70 = math.min(var40.X, var40.Y)
		arg1.Scale = math.clamp(1 / tbl.Resolution.Y * math.clamp((1 / tbl.Resolution.X * var40.X) / (1 / tbl.Resolution.Y * var70), 0, 1) * var70, tbl.ScaleRange.Min, tbl.ScaleRange.Max)
		if not plugin then
			local _scaleRec = tbl_4_upvr[arg1]
			if _scaleRec then
				for _, v_4 in _scaleRec.text_constraints do
					local __uitools_reference_range_2 = v_4:GetAttribute("__uitools_reference_range")
					if typeof(__uitools_reference_range_2) == "NumberRange" then
						v_4.MinTextSize = __uitools_reference_range_2.Min * arg1.Scale
						v_4.MaxTextSize = __uitools_reference_range_2.Max * arg1.Scale
					end
				end
			end
		end
	end
end
;(function() -- Line 189, Named "updateAll"
	--[[ Upvalues[2]:
		[1]: CollectionService_upvr (readonly)
		[2]: update_upvr (readonly)
	]]
	for _, v in CollectionService_upvr:GetTagged("UIScaleRuntimeObject") do
		if v:IsA("UIScale") then
			update_upvr(v)
		end
	end
end)()
CollectionService_upvr:GetInstanceAddedSignal("UIScaleRuntimeObject"):Connect(update_upvr)
CollectionService_upvr:GetInstanceRemovedSignal("UIScaleRuntimeObject"):Connect(function(arg1) -- Line 201, Named "cleanupScale"
	--[[ Upvalues[2]:
		[1]: tbl_4_upvr (readonly)
		[2]: tbl_2_upvr (readonly)
	]]
	if not arg1:IsA("UIScale") then
	else
		local var79 = tbl_4_upvr[arg1]
		if not var79 then return end
		arg1.Scale = 1
		tbl_4_upvr[arg1] = nil
		if var79.signals then
			for _, v_5 in var79.signals do
				v_5:Disconnect()
			end
		end
		var79.listener.scales[arg1] = nil
		if next(var79.listener.scales) == nil then
			var79.listener.signal:Disconnect()
			tbl_2_upvr[var79.listener.source] = nil
		end
	end
end)