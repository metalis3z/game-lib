local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v4 = require(v1.Packages.ReplicatorClient)
local v_u_5 = require(v1.Packages.Timer)
local v_u_6 = require(v1.Utils.NumberUtils)
local v_u_7 = require(v1.Packages.Spr)
local v_u_8 = require(v1.Packages.Net)
require(v1.Shared.Poll)
local v_u_9 = v3.LocalPlayer
local v_u_10 = v_u_9.PlayerGui:WaitForChild("TopUI").Frame.Poll
local v_u_11 = v4.get("Polls")
return {
	["Start"] = function(_)
		v_u_11:WaitForLoaded()
		local v_u_12 = false
		local v_u_13 = v_u_10.Bar.Fill1Text
		local v_u_14 = v_u_10.Bar.Fill2Text
		local v_u_15 = 0
		local v_u_16 = 0
		local v_u_17 = 0
		local v_u_18 = 0
		local v_u_19 = 0
		local v_u_20 = 0
		local v_u_21 = nil
		v_u_10.Visible = false
		local function v_u_31()
			local v22 = v_u_11:TryIndex({ "activePoll" })
			local v23
			if v22 then
				v23 = v_u_11:TryIndex({ "polls", v22 })
			else
				v23 = v22
			end
			if v23 then
				if not v_u_12 then
					v_u_12 = true
					v_u_10.Visible = true
					v_u_10.Bar.Fill.UIGradient.Color = ColorSequence.new(Color3.fromHex(v23.option1colorHex or "2197ff"))
					v_u_10.Bar.BackgroundColor3 = Color3.fromHex(v23.option2colorHex or "da261a")
					v_u_10.Buttons["1"].BackgroundColor3 = Color3.fromHex(v23.option1colorHex or "2197ff")
					v_u_10.Buttons["2"].BackgroundColor3 = Color3.fromHex(v23.option2colorHex or "da261a")
				end
				if v_u_21 ~= v22 then
					v_u_21 = v22
					v_u_17 = v23.votes.A
					v_u_18 = v23.votes.B
				end
				v_u_15 = v23.votes.A
				v_u_16 = v23.votes.B
				local v24 = workspace:GetServerTimeNow()
				local v25 = v23.endsAt <= v24
				v_u_10.Buttons["1"].Function.Text = v23.option1
				v_u_10.Buttons["2"].Function.Text = v23.option2
				if v25 then
					v_u_17 = v23.votes.A
					v_u_18 = v23.votes.B
					v_u_19 = 0
					v_u_20 = 0
					v_u_10.Template.Text = v23.text
					v_u_7.target(v_u_10.Buttons["1"].Disabled, 1, 5, {
						["BackgroundTransparency"] = 0.5
					})
					v_u_7.target(v_u_10.Buttons["2"].Disabled, 1, 5, {
						["BackgroundTransparency"] = 0.5
					})
					return
				else
					local v26 = (v23.endsAt - v24) // 1
					local v27 = math.max(0, v26)
					v_u_10.Template.Text = ("%* (%*s)"):format(v23.text, v27)
					local v28 = v23.voted
					local v29 = v_u_9.UserId
					local v30 = v28[tostring(v29)]
					if v30 then
						v_u_7.target(v_u_10.Buttons["1"].Disabled, 1, 5, {
							["BackgroundTransparency"] = v30 == "A" and 1 or 0.5
						})
						v_u_7.target(v_u_10.Buttons["2"].Disabled, 1, 5, {
							["BackgroundTransparency"] = v30 == "B" and 1 or 0.5
						})
					else
						v_u_7.target(v_u_10.Buttons["1"].Disabled, 1, 5, {
							["BackgroundTransparency"] = 1
						})
						v_u_7.target(v_u_10.Buttons["2"].Disabled, 1, 5, {
							["BackgroundTransparency"] = 1
						})
					end
				end
			else
				if v_u_12 then
					v_u_12 = false
					v_u_10.Visible = false
					v_u_21 = nil
				end
				return
			end
		end
		local v_u_32 = -1
		local v_u_33 = -1
		local v_u_34 = -1
		local v_u_35 = -1
		v_u_2.Heartbeat:Connect(function(p36)
			if v_u_12 then
				if v_u_15 ~= v_u_32 then
					v_u_32 = v_u_15
					local v37 = v_u_15 - v_u_17
					v_u_19 = math.abs(v37) < 1 and 0 or v37 / 0.4
				end
				if v_u_16 ~= v_u_33 then
					v_u_33 = v_u_16
					local v38 = v_u_16 - v_u_18
					v_u_20 = math.abs(v38) < 1 and 0 or v38 / 0.4
				end
				local v39 = v_u_15 - v_u_17
				if math.abs(v39) >= 1 then
					v_u_17 = v_u_17 + v_u_19 * p36
					if v_u_19 > 0 then
						local v40 = v_u_17
						local v41 = v_u_15
						v_u_17 = math.min(v40, v41)
					elseif v_u_19 < 0 then
						local v42 = v_u_17
						local v43 = v_u_15
						v_u_17 = math.max(v42, v43)
					end
				else
					v_u_17 = v_u_15
				end
				local v44 = v_u_16 - v_u_18
				if math.abs(v44) >= 1 then
					v_u_18 = v_u_18 + v_u_20 * p36
					if v_u_20 > 0 then
						local v45 = v_u_18
						local v46 = v_u_16
						v_u_18 = math.min(v45, v46)
					elseif v_u_20 < 0 then
						local v47 = v_u_18
						local v48 = v_u_16
						v_u_18 = math.max(v47, v48)
					end
				else
					v_u_18 = v_u_16
				end
				local v49 = v_u_17
				local v50 = math.round(v49)
				local v51 = v_u_18
				local v52 = math.round(v51)
				if v50 ~= v_u_34 or v52 ~= v_u_35 then
					v_u_34 = v50
					v_u_35 = v52
					v_u_13.Text = v_u_6:Comma(v50)
					v_u_14.Text = v_u_6:Comma(v52)
					local v53 = v50 + v52
					local v54 = v53 == 0 and 0.5 or v50 / v53
					v_u_7.target(v_u_10.Bar.Fill.UIGradient, 1, 5, {
						["Offset"] = Vector2.new(math.lerp(-0.5, 0.5, v54), 0)
					})
				end
			end
		end)
		v_u_10.Buttons["1"].Activated:Connect(function()
			local v55 = v_u_11:TryIndex({ "activePoll" })
			if v55 then
				local v56 = v_u_11:TryIndex({ "polls", v55 })
				if v56 and workspace:GetServerTimeNow() < v56.endsAt then
					local v57 = v56.voted
					local v58 = v_u_9.UserId
					if not v57[tostring(v58)] or v56.allowSwitch then
						v_u_8:RemoteEvent("PollService/Vote"):FireServer("1931dcba-f6f9-4e8e-bb80-346e1b072674", v55, "571bdc6b-fedd-4c38-ab3a-1c3b2f28917b")
					end
				else
					return
				end
			else
				return
			end
		end)
		v_u_10.Buttons["2"].Activated:Connect(function()
			local v59 = v_u_11:TryIndex({ "activePoll" })
			if v59 then
				local v60 = v_u_11:TryIndex({ "polls", v59 })
				if v60 and workspace:GetServerTimeNow() < v60.endsAt then
					local v61 = v60.voted
					local v62 = v_u_9.UserId
					if not v61[tostring(v62)] or v60.allowSwitch then
						v_u_8:RemoteEvent("PollService/Vote"):FireServer("1931dcba-f6f9-4e8e-bb80-346e1b072674", v59, "5b86bb8d-0ee7-4a62-b929-523d73c82a93")
					end
				else
					return
				end
			else
				return
			end
		end)
		local v_u_63 = nil
		v_u_11:Observe({ "activePoll" }, function(p64)
			if v_u_63 then
				v_u_63()
				v_u_63 = nil
			end
			if p64 then
				local v_u_65 = v_u_11:Observe({ "polls", p64 }, v_u_31)
				local v_u_66 = v_u_5.Simple(1, v_u_31, true)
				v_u_63 = function()
					v_u_65()
					v_u_66:Disconnect()
				end
			elseif v_u_12 then
				v_u_12 = false
				v_u_10.Visible = false
			end
		end)
	end
}