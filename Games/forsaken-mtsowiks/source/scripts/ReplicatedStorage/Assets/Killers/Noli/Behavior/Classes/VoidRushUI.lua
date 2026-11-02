-- Decompiled by Krnl

local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = require(v2.Modules.Misc.RadialImage)
function lerp(p6, p7, p8)
	return p6 + (p7 - p6) * p8
end
function v_u_1.new(p9)
	-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_5
	local v10 = v_u_3:IsClient()
	assert(v10, "VoidRushUI should not be created on the server.")
	if p9.Behavior.VoidRushUI then
		p9.Behavior.VoidRushUI:Destroy()
	end
	local v11 = v_u_1
	local v_u_12 = setmetatable({}, v11)
	v_u_12.Frame = script.VoidRushBar:Clone()
	v_u_12.Fill = script.VoidRushBarFill:Clone()
	v_u_12.Text = v_u_12.Frame.Title
	v_u_12.Radial = v_u_5.new("{\"version\":1,\"size\":121,\"count\":120,\"columns\":8,\"rows\":8,\"images\":[\"rbxassetid://135944191173421\",\"rbxassetid://123902757620598\"]}", v_u_12.Fill)
	v_u_12.Actor = p9
	v_u_12.Frame.Parent = p9.Player.PlayerGui.TemporaryUI
	v_u_12.Fill.Parent = v_u_12.Frame.Outline
	v_u_12.Fill.Visible = true
	v_u_12.Blinking = false
	v_u_12.BlinkSpeed = 10
	v_u_12.CurrentAlpha = 1
	v_u_12.BlinkingThread = task.spawn(function()
		-- upvalues: (copy) v_u_12, (ref) v_u_3
		local v13 = v_u_12.Frame.Outline.VoidstarGlow
		local v14 = v_u_12.Frame.Outline.Voidstar
		local _ = v_u_12.Fill
		local v15 = 0
		while v_u_12 and not v_u_12.Dead do
			if v_u_12.Blinking then
				local v16 = (v_u_12.CurrentAlpha + 0.5) / 1.5
				local v17 = v_u_12.BlinkSpeed
				local v18 = v15 % v17 / v17
				local v19 = Color3.fromRGB(255 - 50 * v18, 255 - 220 * v18, 255)
				v15 = v15 + v_u_3.RenderStepped:Wait() / v16
				v13.ImageColor3 = v19
				v14.ImageColor3 = v19
			else
				local v20 = Color3.new(1, 1, 1)
				v13.ImageColor3 = v20
				v14.ImageColor3 = v20
				v_u_3.RenderStepped:Wait()
				v15 = 0
			end
			v13.ImageTransparency = 1 - v_u_12.CurrentAlpha * 0.9
		end
	end)
	return v_u_12
end
function v_u_1.SetText(p21, p22)
	p21.Text.Text = p22
end
function v_u_1.TweenRadial(p_u_23, p_u_24, p_u_25, p_u_26)
	-- upvalues: (copy) v_u_3
	if not p_u_23.Dead then
		if p_u_23.RadialTweenConnection then
			p_u_23.RadialTweenConnection:Disconnect()
		end
		p_u_23.Radial:UpdateLabel(p_u_25)
		local v_u_27 = 0
		p_u_23.RadialTweenConnection = v_u_3.Heartbeat:Connect(function(p28)
			-- upvalues: (ref) v_u_27, (copy) p_u_23, (copy) p_u_24, (copy) p_u_25, (copy) p_u_26
			if v_u_27 == 1 or (not p_u_23 or (not p_u_23.Radial or p_u_23.Dead)) then
				p_u_23.RadialTweenConnection:Disconnect()
			end
			local v29 = v_u_27 + p28 / p_u_24
			v_u_27 = math.clamp(v29, 0, 1)
			p_u_23.CurrentAlpha = lerp(p_u_25, p_u_26, v_u_27)
			p_u_23.Radial:UpdateLabel(p_u_23.CurrentAlpha)
		end)
	end
end
function v_u_1.FadeOut(p_u_30, p31, p32)
	-- upvalues: (copy) v_u_4
	if not p_u_30.Dead then
		p_u_30.Actor.Behavior.VoidRushUI = nil
		if p_u_30.RadialTweenConnection then
			p_u_30.RadialTweenConnection:Disconnect()
		end
		p_u_30.Dead = true
		local v33 = p32 and Color3.new(0.5, 1, 0.5) or Color3.new(0.8, 0.2, 0.2)
		local v34 = p_u_30.Frame
		local v35 = p_u_30.Fill
		local _ = p_u_30.Radial
		for _, v36 in ipairs({
			v34.Outline,
			v34.Outline.Background,
			v34.Outline.Voidstar,
			v34.Outline.VoidstarGlow,
			v35
		}) do
			v_u_4:Create(v36, TweenInfo.new(p31), {
				["BackgroundTransparency"] = 1,
				["ImageTransparency"] = 1
			}):Play()
		end
		v_u_4:Create(v34.Title, TweenInfo.new(p31), {
			["TextTransparency"] = 1,
			["TextStrokeTransparency"] = 1
		}):Play()
		v34.Title.TextColor3 = v33
		v35.ImageColor3 = v33
		task.delay(p31 + 0.1, function()
			-- upvalues: (copy) p_u_30
			p_u_30:Destroy()
		end)
	end
end
function v_u_1.Destroy(p37)
	if p37.RadialTweenConnection then
		p37.RadialTweenConnection:Disconnect()
	end
	if p37.Radial then
		p37.Radial:Destroy()
	end
	if p37.Frame then
		p37.Frame:Destroy()
	end
end
return v_u_1
