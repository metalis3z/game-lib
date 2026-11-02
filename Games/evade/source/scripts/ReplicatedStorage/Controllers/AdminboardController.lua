-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Packages.CreateTween)
local v_u_4 = require(v1.Packages.Observers)
local v_u_5 = require(v1.Packages.Trove)
local v6 = require(v1.Packages.Net)
local v_u_7 = require(v1.Shared.Animals)
local v_u_8 = v6:RemoteFunction("AdminboardService/ListCycle")
return {
	["Start"] = function(_)
		-- upvalues: (copy) v_u_8, (copy) v_u_4, (copy) v_u_5, (copy) v_u_2, (copy) v_u_3, (copy) v_u_7
		local v_u_9 = v_u_8:InvokeServer()
		v_u_4.observeTag("Adminboard", function(p_u_10)
			-- upvalues: (ref) v_u_5, (ref) v_u_2, (ref) v_u_3, (copy) v_u_9, (ref) v_u_7
			local v_u_11 = v_u_5.new()
			local v_u_12 = p_u_10.SurfaceGui
			v_u_12.Parent = v_u_2.LocalPlayer.PlayerGui
			v_u_11:Add(v_u_12)
			local v_u_13 = v_u_12.EventChosen.Slots
			local v_u_14 = v_u_12.LuckMulti.Slots
			local v_u_15 = v_u_12.Item.Slots
			local function v24(p_u_16, p_u_17)
				-- upvalues: (copy) v_u_11, (ref) v_u_3
				local v_u_18 = nil
				local v_u_19 = v_u_11:Add(Instance.new("NumberValue"))
				v_u_19.Value = 1
				v_u_19.Changed:Connect(function(p20)
					-- upvalues: (copy) p_u_16, (copy) p_u_17
					p_u_16.Frame.Position = UDim2.fromScale(-((p20 - 1) % p_u_17), 0.5)
				end)
				return function(p21, p22)
					-- upvalues: (ref) v_u_18, (copy) v_u_19, (copy) p_u_17, (ref) v_u_3
					if v_u_18 then
						v_u_18:Cancel()
						v_u_18 = nil
					end
					v_u_19.Value = 0
					local v23 = p_u_17 * 8 + p21 - v_u_19.Value % p_u_17
					if p22 then
						v_u_19.Value = v23
					else
						v_u_18 = v_u_3(v_u_19, TweenInfo.new(4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
							["Value"] = v23
						})
					end
				end
			end
			local v_u_25 = v24(v_u_13, #v_u_9.Events)
			local v_u_26 = v24(v_u_14, #v_u_9.Luck)
			local v_u_27 = v24(v_u_15, #v_u_9.Items)
			for v28 = 1, #v_u_9.Events + 1 do
				local v29 = v_u_9.Events[(v28 - 1) % #v_u_9.Events + 1]
				local v30 = v_u_13.Frame.UIListLayout.Entry:Clone()
				v30.LayoutOrder = v28
				v30.Image = v29.Icon or "rbxassetid://17451423471"
				v30.Parent = v_u_13.Frame
			end
			for v31 = 1, #v_u_9.Luck + 1 do
				local v32 = v_u_9.Luck[(v31 - 1) % #v_u_9.Luck + 1]
				local v33 = v_u_14.Frame.UIListLayout.Entry:Clone()
				v33.LayoutOrder = v31
				v33.Image = v32.Icon or "rbxassetid://17451423471"
				v33.Parent = v_u_14.Frame
			end
			for v34 = 1, #v_u_9.Items + 1 do
				local v35 = v_u_9.Items[(v34 - 1) % #v_u_9.Items + 1]
				local v36 = v_u_15.Frame.UIListLayout.Entry:Clone()
				v36.LayoutOrder = v34
				local v37 = v_u_7:AttachOnViewport(v35.Name, v36, true, nil, true)
				if v37 then
					v_u_11:Add(v37)
				end
				v36.Parent = v_u_15.Frame
			end
			local function v40(p38)
				-- upvalues: (copy) p_u_10, (copy) v_u_26
				local v39 = p_u_10:GetAttribute("Luck")
				if v39 then
					v_u_26(v39, p38)
				end
			end
			local function v43(p41)
				-- upvalues: (copy) p_u_10, (copy) v_u_27
				local v42 = p_u_10:GetAttribute("Item")
				if v42 then
					v_u_27(v42, p41)
				end
			end
			v_u_11:Add(p_u_10:GetAttributeChangedSignal("SpinningIn"):Connect(function()
				-- upvalues: (copy) p_u_10, (copy) v_u_13, (copy) v_u_12, (copy) v_u_14, (copy) v_u_15
				local v44 = p_u_10:GetAttribute("SpinningIn") == true
				v_u_13.Visible = not v44
				v_u_12.EventChosen.Mark.Visible = v44
				v_u_14.Visible = not v44
				v_u_12.LuckMulti.Mark.Visible = v44
				v_u_15.Visible = not v44
				v_u_12.Item.Mark.Visible = v44
			end))
			local v45 = p_u_10:GetAttribute("SpinningIn") == true
			v_u_13.Visible = not v45
			v_u_12.EventChosen.Mark.Visible = v45
			v_u_14.Visible = not v45
			v_u_12.LuckMulti.Mark.Visible = v45
			v_u_15.Visible = not v45
			v_u_12.Item.Mark.Visible = v45
			v_u_11:Add(p_u_10:GetAttributeChangedSignal("Event"):Connect(function(p46)
				-- upvalues: (copy) p_u_10, (copy) v_u_25
				local v47 = p_u_10:GetAttribute("Event")
				if v47 then
					v_u_25(v47, p46)
				end
			end))
			local v48 = p_u_10:GetAttribute("Event")
			if v48 then
				v_u_25(v48, true)
			end
			v_u_11:Add(p_u_10:GetAttributeChangedSignal("Luck"):Connect(v40))
			local v49 = p_u_10:GetAttribute("Luck")
			if v49 then
				v_u_26(v49, true)
			end
			v_u_11:Add(p_u_10:GetAttributeChangedSignal("Item"):Connect(v43))
			local v50 = p_u_10:GetAttribute("Item")
			if v50 then
				v_u_27(v50, true)
			end
			return v_u_11:WrapClean()
		end, { workspace })
	end
}