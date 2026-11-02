-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v1 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
game:GetService("RunService")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Controllers.InterfaceController)
local v_u_4 = require(v1.Classes.AnimatedButton)
local v_u_5 = require(v1.Shared.AdventCalendar)
local v_u_6 = require(v1.Shared.Animals)
local v_u_7 = require(v1.Utils.TimeUtils)
local v_u_8 = require(v1.Packages.Synchronizer)
local v_u_9 = require(v1.Packages.Observers)
require(v1.Shared.Updates)
local v_u_10 = require(v1.Packages.Timer)
local v11 = require(v1.Packages.Net)
local v_u_12 = require(v1.Packages.Spr)
local v_u_13 = v_u_2.LocalPlayer.PlayerGui:WaitForChild("AdventCalendar").Frame
local v_u_14 = v11:RemoteFunction("AdventService/ClaimReward")
local v_u_15 = v11:RemoteEvent("AdventService/Recover")
return {
	["Start"] = function(_)
		-- upvalues: (copy) v_u_8, (copy) v_u_2, (copy) v_u_3, (copy) v_u_13, (copy) v_u_9, (copy) v_u_10, (copy) v_u_5, (copy) v_u_7, (copy) v_u_6, (copy) v_u_4, (copy) v_u_14, (copy) v_u_15, (copy) v_u_12
		local v_u_16 = v_u_8:Wait(v_u_2.LocalPlayer)
		if v_u_16 then
			local v_u_17 = v_u_3:Register("AdventCalendar", v_u_13, "TopQuint")
			v_u_17:AttachCloseButton(v_u_13.Header.Close)
			v_u_17:Close()
			v_u_9.observeTag("AdventCalendarRewardText", function(p_u_18)
				-- upvalues: (ref) v_u_10, (ref) v_u_5, (ref) v_u_7
				local v_u_29 = v_u_10.Simple(1, function()
					-- upvalues: (ref) v_u_5, (copy) p_u_18, (ref) v_u_7
					local v19 = workspace:GetServerTimeNow() // 1
					local v20 = v_u_5.getNextRewardTimestamp(v19)
					if v20 == nil then
						local v21 = v_u_5.timeToReward
						local v22 = #v_u_5.Rewards.Calendar
						local v23 = p_u_18
						local v24 = v_u_7
						local v25 = assert(v21(v22)) + 86400 - v19
						v23.Text = ("Ending in %*"):format((v24:E((math.max(v25, 0)))))
					else
						local v26 = p_u_18
						local v27 = v_u_7
						local v28 = v20 - v19
						v26.Text = ("Next reward in %*"):format((v27:E((math.max(v28, 0)))))
					end
				end)
				return function()
					-- upvalues: (copy) v_u_29
					v_u_29:Disconnect()
				end
			end, { workspace })
			v_u_9.observeTag("AdventCalendarPrompt", function(p30)
				-- upvalues: (ref) v_u_3
				local v_u_31 = p30.Triggered:Connect(function()
					-- upvalues: (ref) v_u_3
					v_u_3:Toggle("AdventCalendar")
				end)
				return function()
					-- upvalues: (copy) v_u_31
					v_u_31:Disconnect()
				end
			end, { workspace })
			local function v35(p32, p33, p34)
				-- upvalues: (ref) v_u_6
				if p32.type == "brainrot" then
					v_u_6:AttachOnViewportWithOptimizations(p32.name, p33:FindFirstChildOfClass("ViewportFrame") or p33.ImageLabel:FindFirstChildOfClass("ViewportFrame"))
					if p34 == "Streak" then
						p33.ImageLabel.Txt.Text = not p32.quantity and "" or ("x%*"):format(p32.quantity)
						return
					end
				elseif p32.type == "luck" then
					p33.ImageLabel.Image = p32.multiplier == "2x" and "rbxassetid://92074411396710" or "rbxassetid://90033075589118"
					if p34 == "Streak" then
						p33.ImageLabel.Txt.Text = p32.multiplier
						return
					end
				elseif p32.type == "mystery" then
					p33.ImageLabel.Image = "rbxassetid://90372480237616"
					if p34 == "Streak" then
						p33.ImageLabel.Txt.Text = ""
						return
					end
				elseif p32.type == "skipfuse" then
					p33.ImageLabel.Image = "rbxassetid://95175068604925"
					if p34 == "Streak" then
						p33.ImageLabel.Txt.Text = ""
						return
					end
				elseif p32.type == "candyCane" then
					p33.ImageLabel.Image = "rbxassetid://81083444361233"
					if p34 == "Streak" then
						p33.ImageLabel.Txt.Text = ("x%*"):format(p32.quantity)
					end
				end
			end
			for v_u_36, v37 in v_u_5.Rewards.Calendar do
				local v38 = v_u_13.ScrollingFrame.UIGridLayout.Template:Clone()
				v38.LayoutOrder = v_u_36
				v38.Parent = v_u_13.ScrollingFrame
				local v_u_39 = v38.Spacer
				v_u_39.Title.Text = ("Day %*"):format(v_u_36)
				v35(v37, v_u_39, "Calendar")
				local v40 = v_u_4.new(v_u_39.Claim)
				v40:Animate()
				v40.OnActivated:Connect(function()
					-- upvalues: (ref) v_u_14, (copy) v_u_36
					v_u_14:InvokeServer("Calendar", v_u_36)
				end)
				if v_u_36 == 25 then
					local v41 = v_u_4.new(v_u_13.Last.Claim)
					v41:Animate()
					v41.OnActivated:Connect(function()
						-- upvalues: (ref) v_u_14, (copy) v_u_36
						v_u_14:InvokeServer("Calendar", v_u_36)
					end)
				end
				local v42 = v_u_4.new(v_u_39.Recover.Recover)
				v42:Animate()
				v42.OnActivated:Connect(function()
					-- upvalues: (ref) v_u_15
					v_u_15:FireServer()
				end)
				local function v_u_50()
					-- upvalues: (copy) v_u_17, (copy) v_u_16, (copy) v_u_36, (ref) v_u_7, (ref) v_u_5, (copy) v_u_39
					if v_u_17:IsOpened() then
						local v43 = v_u_16
						local v44 = {}
						local v45 = v_u_36
						__set_list(v44, 1, {"AdventCalendar", "CalendarRewards", (tostring(v45))})
						local v46 = v43:Get(v44)
						local v47
						if v46 == "Claimed" then
							v47 = "Claimed"
						elseif v46 == "Available" then
							v47 = "Claim"
						else
							local v48 = v_u_7
							local v49 = (v_u_5.timeToReward(v_u_36) or 0) - workspace:GetServerTimeNow()
							v47 = v48:E((math.max(v49, 0)))
						end
						v_u_39.Claim.Txt.Text = v47
					end
				end
				local function v78()
					-- upvalues: (copy) v_u_16, (copy) v_u_36, (ref) v_u_5, (copy) v_u_39, (ref) v_u_12, (copy) v_u_50
					local v51 = v_u_16:Get({ "AdventCalendar", "CalendarRewards" })
					local v52 = v_u_16:Get({ "AdventCalendar", "LastLoginDay" })
					local v53 = v_u_16
					local v54 = {}
					local v55 = v_u_36
					__set_list(v54, 1, {"AdventCalendar", "CalendarRewards", (tostring(v55))})
					local v56 = v53:Get(v54)
					local v57 = v_u_5.getLastFailedDay(v51, v52)
					local v58 = v_u_39.Claim
					local v59
					if v56 == "Available" then
						v59 = true
					elseif v56 == nil then
						v59 = v52 < v_u_36
					else
						v59 = false
					end
					v58.Visible = v59
					v_u_39.Claim.Interactable = v56 == "Available"
					v_u_39.ClaimedCheckmark.Visible = v56 == "Claimed"
					local v60 = v_u_39.Recover
					local v61
					if v56 == nil then
						v61 = v_u_36 < v52
					else
						v61 = false
					end
					v60.Visible = v61
					local v62 = v_u_39.Recover.Recover
					local v63
					if v57 then
						v63 = v_u_36 == v57
					else
						v63 = v57
					end
					v62.Interactable = v63
					local v64 = v_u_39.Locked
					local v65
					if v52 < v_u_36 then
						v65 = v_u_36 ~= v52 + 1
					else
						v65 = false
					end
					v64.Visible = v65
					local v66 = v_u_12.target
					local v67 = v_u_39.Recover.Recover
					local v68 = 1
					local v69 = 5
					local v70 = {}
					local v71
					if v57 and v_u_36 == v57 then
						v71 = Color3.fromRGB(240, 198, 48)
					else
						v71 = Color3.fromRGB(158, 158, 158)
					end
					v70.BackgroundColor3 = v71
					v66(v67, v68, v69, v70)
					local v72 = v_u_12.target
					local v73 = v_u_39.Claim
					local v74 = 1
					local v75 = 5
					local v76 = {}
					local v77
					if v56 == "Claimed" then
						v77 = Color3.fromRGB(158, 158, 158)
					elseif v56 == "Available" then
						v77 = Color3.fromRGB(80, 225, 75)
					else
						v77 = Color3.fromRGB(18, 61, 12)
					end
					v76.BackgroundColor3 = v77
					v72(v73, v74, v75, v76)
					v_u_50()
				end
				v_u_16:OnChanged({ "AdventCalendar", "CalendarRewards", (tostring(v_u_36)) }, v78)
				v_u_16:OnChanged({ "AdventCalendar", "LastLoginDay" }, v78)
				v_u_16:OnChanged({ "AdventCalendar", "Recovers" }, v78)
				v_u_17.OnOpen:Connect(v_u_50)
				v_u_10.Simple(1, v_u_50)
				task.spawn(v78)
			end
			for v_u_79, v80 in v_u_5.Rewards.Streak do
				local v_u_81 = v_u_13.Side.Options.UIListLayout.Template:Clone()
				v_u_81.Name = v_u_79
				v35(v80, v_u_81, "Streak")
				if v_u_79 == 25 then
					v35(v80, v_u_13.Last, "Calendar")
				end
				v_u_81.Parent = v_u_13.Side.Options
				local v82 = v_u_4.new(v_u_81.Claim)
				v82:Animate()
				v82.OnActivated:Connect(function()
					-- upvalues: (ref) v_u_14, (copy) v_u_79
					v_u_14:InvokeServer("Streak", v_u_79)
				end)
				local function v98()
					-- upvalues: (copy) v_u_16, (copy) v_u_79, (ref) v_u_5, (copy) v_u_81, (ref) v_u_12, (ref) v_u_13
					local v83 = v_u_16
					local v84 = {}
					local v85 = v_u_79
					__set_list(v84, 1, {"AdventCalendar", "StreakRewards", (tostring(v85))})
					local v86 = v83:Get(v84)
					local v87 = v_u_16:Get({ "AdventCalendar", "CalendarRewards" })
					local v88 = v_u_16:Get({ "AdventCalendar", "LastLoginDay" })
					local v89 = v_u_5.getStreak(v87, v88)
					local v90 = v88 <= 0 and 0 or v89
					v_u_81.ImageLabel.Claimed.Visible = v86 == "Claimed"
					v_u_81.Claim.Visible = v86 ~= nil
					v_u_81.Claim.Interactable = v86 == "Available"
					v_u_81.Claim.Txt.Text = v86 == "Claimed" and "Claimed" or "Claim"
					v_u_81.Txt.Visible = v86 == nil
					v_u_81.Txt.Text = ("%*/%* Days"):format(v90, v_u_79)
					local v91 = v_u_12.target
					local v92 = v_u_81
					local v93 = 1
					local v94 = 5
					local v95 = {}
					local v96
					if v86 == nil then
						v96 = Color3.fromRGB(18, 61, 12)
					else
						v96 = Color3.fromRGB(80, 225, 75)
					end
					v95.BackgroundColor3 = v96
					v91(v92, v93, v94, v95)
					local v97
					if v86 == "Available" then
						v97 = Color3.fromRGB(233, 66, 66)
					else
						v97 = Color3.fromRGB(158, 158, 158)
					end
					v_u_12.target(v_u_81.Claim, 1, 5, {
						["BackgroundColor3"] = v97
					})
					if v_u_79 == 25 then
						v_u_12.target(v_u_13.Last.Claim, 1, 5, {
							["BackgroundColor3"] = v97
						})
						v_u_13.Last.Claim.BackgroundTransparency = v86 == nil and 1 or 0
						v_u_13.Last.Claim.UIStroke.Transparency = v86 == nil and 1 or 0
						v_u_13.Last.Claim.Txt.Text = v86 == "Claimed" and "Claimed" or (v86 == "Available" and "Claim" or ("%*/%* Days"):format(v90, v_u_79))
					end
				end
				v_u_16:OnChanged({ "AdventCalendar", "StreakRewards", (tostring(v_u_79)) }, v98)
				v_u_16:OnChanged({ "AdventCalendar", "LastLoginDay" }, v98)
				v_u_16:OnChanged({ "AdventCalendar", "Recovers" }, v98)
				task.spawn(v98)
			end
		end
	end
}