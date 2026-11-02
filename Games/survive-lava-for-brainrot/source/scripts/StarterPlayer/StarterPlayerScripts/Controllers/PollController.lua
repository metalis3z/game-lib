-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {}
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("ReplicatedStorage")
local v4 = v2.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD")
local v_u_5 = require(script.Parent.UIController)
local v_u_6 = v_u_3:WaitForChild("Events")
local v_u_7 = v4:WaitForChild("Poll")
local v8 = v_u_7:WaitForChild("InsiderFrame")
local v_u_9 = v8:WaitForChild("Btn1")
local v_u_10 = v8:WaitForChild("Btn2")
local v_u_11 = v_u_7:WaitForChild("Header"):WaitForChild("CloseButton")
local v_u_12 = v8:WaitForChild("Question")
local v_u_13 = v4:WaitForChild("PollCreate")
local v_u_14 = v_u_13:WaitForChild("CloseBtn")
local v_u_15 = v_u_13:WaitForChild("CreatePollBtn")
local v_u_16 = v_u_13:WaitForChild("Prompt1Box")
local v_u_17 = v_u_13:WaitForChild("Prompt2Box")
local v_u_18 = v_u_13:WaitForChild("QuestionBox")
local v_u_19 = false
local v_u_20 = 60
function v1.OpenPollCreate(_, p21, p22)
	-- upvalues: (copy) v_u_3, (ref) v_u_20, (copy) v_u_18, (copy) v_u_16, (copy) v_u_17, (copy) v_u_5, (copy) v_u_13
	v_u_3.Assets.GlobalCommandTest.Value = p21
	v_u_20 = p22 or 60
	v_u_18.Text = ""
	v_u_16.Text = ""
	v_u_17.Text = ""
	v_u_5:OpenFrame(v_u_13, true)
end
function v1.Init(_)
	-- upvalues: (copy) v_u_6, (copy) v_u_14, (copy) v_u_5, (copy) v_u_13, (copy) v_u_11, (copy) v_u_7, (copy) v_u_15, (copy) v_u_18, (copy) v_u_16, (copy) v_u_17, (copy) v_u_3, (ref) v_u_20, (copy) v_u_9, (ref) v_u_19, (copy) v_u_10, (copy) v_u_12
	local v_u_23 = v_u_6:WaitForChild("Poll")
	v_u_14.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_5, (ref) v_u_13
		v_u_5:CloseFrame(v_u_13)
	end)
	v_u_11.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_5, (ref) v_u_7
		v_u_5:CloseFrame(v_u_7)
	end)
	v_u_15.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_18, (ref) v_u_16, (ref) v_u_17, (copy) v_u_23, (ref) v_u_3, (ref) v_u_20, (ref) v_u_5, (ref) v_u_13
		local v24 = v_u_18.Text
		local v25 = v_u_16.Text
		local v26 = v_u_17.Text
		if v24 and v24 ~= "" then
			if v25 and v25 ~= "" then
				if v26 and v26 ~= "" then
					v_u_23:FireServer("CreatePoll", {
						["Question"] = v24,
						["Option1"] = v25,
						["Option2"] = v26,
						["Global"] = v_u_3.Assets.GlobalCommandTest.Value,
						["Duration"] = v_u_20
					})
					v_u_5:CloseFrame(v_u_13)
				end
			else
				return
			end
		else
			return
		end
	end)
	v_u_9.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_19, (copy) v_u_23, (ref) v_u_5, (ref) v_u_7
		if not v_u_19 then
			v_u_19 = true
			v_u_23:FireServer("Vote", 1)
			v_u_5:CloseFrame(v_u_7)
		end
	end)
	v_u_10.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_19, (copy) v_u_23, (ref) v_u_5, (ref) v_u_7
		if not v_u_19 then
			v_u_19 = true
			v_u_23:FireServer("Vote", 2)
			v_u_5:CloseFrame(v_u_7)
		end
	end)
	v_u_23.OnClientEvent:Connect(function(p27, p28)
		-- upvalues: (ref) v_u_19, (ref) v_u_12, (ref) v_u_9, (ref) v_u_10, (ref) v_u_5, (ref) v_u_7
		if p27 == "Open" then
			v_u_19 = false
			v_u_12.Text = p28.Question
			v_u_9.Text.Text = p28.Option1
			v_u_10.Text.Text = p28.Option2
			v_u_9.BackgroundTransparency = 0
			v_u_10.BackgroundTransparency = 0
			v_u_5:OpenFrame(v_u_7, true)
			task.delay(p28.Duration or 60, function()
				-- upvalues: (ref) v_u_5, (ref) v_u_7, (ref) v_u_19
				v_u_5:CloseFrame(v_u_7)
				v_u_19 = false
			end)
		elseif p27 == "Close" then
			v_u_5:CloseFrame(v_u_7)
			v_u_19 = false
		end
	end)
end
return v1
