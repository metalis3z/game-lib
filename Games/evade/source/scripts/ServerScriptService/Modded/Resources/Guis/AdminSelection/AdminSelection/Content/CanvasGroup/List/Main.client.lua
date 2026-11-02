-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v1.Datas.Animals)
local v_u_4 = require(v1.Shared.Animals)
local v_u_5 = require(v1.Classes.AnimatedButton)
local v_u_6 = require(v1.Packages.Gradients)
local v_u_7 = require(script.ButtonFX)
local v_u_8 = require(script.AutomaticCanvasSizeModule)
local v_u_9 = script.Parent.Parent.Parent.Parent.Search.TextBox
local function v_u_14(p10)
	-- upvalues: (copy) v_u_8
	local v11 = string.lower(p10 or "")
	for _, v12 in pairs(script.Parent:GetChildren()) do
		if v12:IsA("TextButton") and v12.Name ~= "Template" then
			local v13 = v12.TextLabel.Text
			v12.Visible = v11 == "" and true or string.find(string.lower(v13), v11, 1, true)
		end
	end
	script.Parent.CanvasPosition = Vector2.new(0, 0)
	v_u_8(script.Parent)
end
v_u_9:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (copy) v_u_14, (copy) v_u_9
	v_u_14(v_u_9.Text)
end)
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = {}
local v_u_18 = nil
function _G.SetAdminContent(p_u_19, p_u_20, p21, p22, _)
	-- upvalues: (ref) v_u_18, (ref) v_u_16, (ref) v_u_17, (copy) v_u_9, (copy) v_u_14, (ref) v_u_15, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7, (copy) v_u_4, (copy) v_u_5, (copy) v_u_2, (copy) v_u_8
	if v_u_18 then
		task.cancel(v_u_18)
	end
	local v23 = p21 or "single"
	v_u_16 = v23
	if v23 == "multiple" and (p22 and (p22 ~= "None" and p22 ~= "")) then
		v_u_17 = {}
		for v24 in string.gmatch(p22, "[^, ]+") do
			local v25 = v_u_17
			table.insert(v25, v24)
		end
	else
		v_u_17 = {}
	end
	v_u_9.Text = ""
	v_u_14("")
	_G.AdminSelectionToggle(true)
	for _, v26 in pairs(script.Parent:GetChildren()) do
		if v26:IsA("TextButton") and v26.Name ~= "Template" then
			v26:Destroy()
		end
	end
	if p_u_19 ~= v_u_15 then
		script.Parent.CanvasPosition = Vector2.new(0, 0)
	end
	v_u_15 = p_u_19
	v_u_18 = task.spawn(function()
		-- upvalues: (copy) p_u_19, (ref) v_u_3, (ref) v_u_16, (ref) v_u_17, (ref) v_u_6, (ref) v_u_7, (ref) v_u_4, (ref) v_u_5, (copy) p_u_20, (ref) v_u_2, (ref) v_u_8, (ref) v_u_18
		local v27 = 0
		for _, v_u_28 in pairs(p_u_19) do
			local v_u_29 = script.Parent.Template:Clone()
			v_u_29.Name = "Kiwi"
			v_u_29.TextLabel.Text = v_u_28.DisplayName or ""
			v_u_29.ImageLabel.Image = v_u_28.Icon or ""
			local v_u_30 = nil
			if not v_u_28.Icon then
				for v31, v32 in pairs(v_u_3) do
					if v32 == v_u_28 then
						v_u_30 = v31
						break
					end
				end
			end
			local v_u_33 = v_u_30 or v_u_28.DisplayName
			local v34
			if v_u_16 == "multiple" then
				v34 = table.find(v_u_17, v_u_33)
			else
				v34 = false
			end
			local v_u_35 = v_u_28.Color or Color3.fromRGB(20, 20, 20)
			if v34 then
				v_u_29.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
			elseif v_u_28.GradientPreset then
				v_u_29.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
				v_u_6.apply(v_u_29, v_u_28.GradientPreset, 0.5)
			else
				v_u_29.BackgroundColor3 = v_u_35
			end
			v_u_29.Parent = script.Parent
			v_u_29.Visible = true
			task.defer(function()
				-- upvalues: (ref) v_u_7, (copy) v_u_29, (ref) v_u_30, (copy) v_u_28, (ref) v_u_4, (ref) v_u_5, (ref) v_u_16, (ref) v_u_17, (copy) v_u_33, (ref) v_u_6, (copy) v_u_35, (ref) p_u_20
				v_u_7(v_u_29)
				local v_u_36 = v_u_30 and (not v_u_28.Icon and v_u_4:AttachOnViewport(v_u_30, v_u_29.ViewportFrame, true, nil))
				if v_u_36 then
					v_u_29.Destroying:Once(function()
						-- upvalues: (copy) v_u_36
						v_u_36:Destroy()
					end)
				end
				local v37 = v_u_5.new(v_u_29)
				v37:Animate()
				v37.OnActivated:Connect(function()
					-- upvalues: (ref) v_u_16, (ref) v_u_17, (ref) v_u_33, (ref) v_u_28, (ref) v_u_29, (ref) v_u_6, (ref) v_u_35, (ref) p_u_20
					if v_u_16 == "multiple" then
						local v38 = table.find(v_u_17, v_u_33)
						if v38 then
							table.remove(v_u_17, v38)
							if v_u_28.GradientPreset then
								v_u_29.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
								v_u_6.apply(v_u_29, v_u_28.GradientPreset, 0.5)
							else
								v_u_29.BackgroundColor3 = v_u_35
							end
						else
							local v39 = v_u_17
							local v40 = v_u_33
							table.insert(v39, v40)
							v_u_29.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
						end
						if #v_u_17 > 0 then
							p_u_20(table.concat(v_u_17, ", "))
						else
							p_u_20("None")
						end
					else
						_G.AdminSelectionToggle(false)
						p_u_20(v_u_33)
						return
					end
				end)
			end)
			v27 = v27 + 1
			if v27 % 3 == 0 then
				v_u_2.Heartbeat:Wait()
			end
		end
		task.wait()
		v_u_8(script.Parent)
		v_u_18 = nil
	end)
end
