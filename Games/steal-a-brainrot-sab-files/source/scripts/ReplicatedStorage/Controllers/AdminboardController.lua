-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Players")
local u3 = require(v1.Packages.CreateTween)
local u4 = require(v1.Packages.Observers)
local u5 = require(v1.Packages.Trove)
local v6 = require(v1.Packages.Net)
local u7 = require(v1.Shared.Animals)
local TimeUtils = require(v1.Utils.TimeUtils)
local u8 = v6:RemoteFunction("AdminboardService/ListCycle")
return {
	["Start"] = function(_)
		local u9 = u8:InvokeServer()
		u4.observeTag("Adminboard", function(u10)
			local u11 = u5.new()
			local u12 = u10.SurfaceGui
			u12.Parent = u2.LocalPlayer.PlayerGui
			u11:Add(u12)
			local u13 = u12.EventChosen.Slots
			local u14 = u12.LuckMulti.Slots
			local u15 = u12.Item.Slots

			local timerFrame = u12:FindFirstChild("Timer")
			local timerTitle = u12:FindFirstChild("TimerTitle")
			local timerValue = timerFrame and timerFrame:FindFirstChild("Timer")

			local function v24(u16, u17)
				local u18 = nil
				local u19 = u11:Add(Instance.new("NumberValue"))
				u19.Value = 1
				u19.Changed:Connect(function(p20)
					u16.Frame.Position = UDim2.fromScale(-((p20 - 1) % u17), 0.5)
				end)
				return function(p21, p22)
					if u18 then
						u18:Cancel()
						u18 = nil
					end
					u19.Value = 0
					local v23 = u17 * 8 + p21 - u19.Value % u17
					if p22 then
						u19.Value = v23
					else
						u18 = u3(u19, TweenInfo.new(4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
							["Value"] = v23
						})
					end
				end
			end
			local u25 = v24(u13, #u9.Events)
			local u26 = v24(u14, #u9.Luck)
			local u27 = v24(u15, #u9.Items)
			for v28 = 1, #u9.Events + 1 do
				local v29 = u9.Events[(v28 - 1) % #u9.Events + 1]
				local v30 = u13.Frame.UIListLayout.Entry:Clone()
				v30.LayoutOrder = v28
				v30.Image = v29.Icon or "rbxassetid://17451423471"
				v30.Parent = u13.Frame
			end
			for v31 = 1, #u9.Luck + 1 do
				local v32 = u9.Luck[(v31 - 1) % #u9.Luck + 1]
				local v33 = u14.Frame.UIListLayout.Entry:Clone()
				v33.LayoutOrder = v31
				v33.Image = v32.Icon or "rbxassetid://17451423471"
				v33.Parent = u14.Frame
			end
			for v34 = 1, #u9.Items + 1 do
				local v35 = u9.Items[(v34 - 1) % #u9.Items + 1]
				local v36 = u15.Frame.UIListLayout.Entry:Clone()
				v36.LayoutOrder = v34
				local v37 = u7:AttachOnViewport(v35.Name, v36, true, nil, true)
				if v37 then
					u11:Add(v37)
				end
				v36.Parent = u15.Frame
			end
			local function v40(p38)
				local v39 = u10:GetAttribute("Luck")
				if v39 then
					u26(v39, p38)
				end
			end
			local function v43(p41)
				local v42 = u10:GetAttribute("Item")
				if v42 then
					u27(v42, p41)
				end
			end

			u11:Add(u10:GetAttributeChangedSignal("SpinningIn"):Connect(function()
				local v44 = u10:GetAttribute("SpinningIn") == true
				u13.Visible = not v44
				u12.EventChosen.Mark.Visible = v44
				u14.Visible = not v44
				u12.LuckMulti.Mark.Visible = v44
				u15.Visible = not v44
				u12.Item.Mark.Visible = v44

				if timerTitle and timerTitle:IsA("TextLabel") then
					if v44 then
						timerTitle.Text = "Spinning in:"
					else
						timerTitle.Text = "Next Event in:"
					end
				end
			end))

			local v45 = u10:GetAttribute("SpinningIn") == true
			u13.Visible = not v45
			u12.EventChosen.Mark.Visible = v45
			u14.Visible = not v45
			u12.LuckMulti.Mark.Visible = v45
			u15.Visible = not v45
			u12.Item.Mark.Visible = v45

			if timerTitle and timerTitle:IsA("TextLabel") then
				if v45 then
					timerTitle.Text = "Spinning in:"
				else
					timerTitle.Text = "NEXT Random Event in:"
				end
			end

			u11:Add(u10:GetAttributeChangedSignal("TimerDisplay"):Connect(function()
				local remaining = u10:GetAttribute("TimerDisplay") or 0
				if timerValue and timerValue:IsA("TextLabel") then
					timerValue.Text = TimeUtils:E(remaining)
				end
			end))

			local initialTimer = u10:GetAttribute("TimerDisplay") or 0
			if timerValue and timerValue:IsA("TextLabel") then
				timerValue.Text = TimeUtils:E(initialTimer)
			end

			u11:Add(u10:GetAttributeChangedSignal("Event"):Connect(function(p46)
				local v47 = u10:GetAttribute("Event")
				if v47 then
					u25(v47, p46)
				end
			end))
			local v48 = u10:GetAttribute("Event")
			if v48 then
				u25(v48, true)
			end
			u11:Add(u10:GetAttributeChangedSignal("Luck"):Connect(v40))
			local v49 = u10:GetAttribute("Luck")
			if v49 then
				u26(v49, true)
			end
			u11:Add(u10:GetAttributeChangedSignal("Item"):Connect(v43))
			local v50 = u10:GetAttribute("Item")
			if v50 then
				u27(v50, true)
			end
			return u11:WrapClean()
		end, { workspace })
	end
}