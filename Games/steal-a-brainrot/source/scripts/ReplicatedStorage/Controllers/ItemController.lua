local v1 = game:GetService("Players")
game:GetService("StarterGui")
game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = v_u_2:WaitForChild("Packages")
local v_u_4 = require(v3.Net)
local v_u_5 = require(v_u_2.Packages.Observers)
local v_u_6 = require(v_u_2.Controllers.BackpackController)
local v_u_7 = v1.LocalPlayer
local v_u_8 = v_u_7.PlayerGui
local v_u_9 = nil
local v10 = Instance.new("Highlight")
v10.Name = "MainHighlight"
v10.DepthMode = Enum.HighlightDepthMode.Occluded
v10.FillColor = Color3.fromRGB(255, 0, 0)
v10.FillTransparency = 0.5
v10.OutlineColor = Color3.fromRGB(155, 0, 0)
v10.OutlineTransparency = 0.8
v10.Parent = workspace
v10.Adornee = script
local v_u_11 = {}
local v12 = {}
local function v_u_21(p13)
	local v14 = p13:GetAttribute("CurrentSlot")
	local v15 = p13:GetAttribute("CooldownTime") or 0
	local v16 = tonumber(v15) or 0
	if v_u_9 and v14 then
		local v17 = v_u_9:FindFirstChild(v14)
		if v17 then
			local v18 = v17:FindFirstChild("Icon")
			if v18 then
				local v19 = v16 > 0
				local v20 = v18:FindFirstChild("CooldownTextLabel")
				if v20 then
					v20.Text = string.format("%0.1f", v16)
					v20.Visible = v19
				end
				v18.ImageColor3 = v19 and Color3.fromRGB(90, 90, 90) or Color3.fromRGB(255, 255, 255)
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_23(p_u_22)
	p_u_22:GetAttributeChangedSignal("CooldownTime"):Connect(function()
		v_u_21(p_u_22)
	end)
	p_u_22:GetAttributeChangedSignal("CurrentSlot"):Connect(function()
		v_u_21(p_u_22)
	end)
	task.spawn(v_u_21, p_u_22)
end
function v12.Load(_)
	for _, v24 in script:GetChildren() do
		if v24:IsA("ModuleScript") then
			local v25, v26 = pcall(require, v24)
			if v25 and (v26 and v26.Start) then
				v26:Start()
			end
		end
	end
end
function v12.Start(_)
	local function v28()
		local v27 = not (v_u_7:GetAttribute("BlockTools") or (v_u_7:GetAttribute("Stealing") or v_u_7:GetAttribute("CartSeated") or (v_u_7:GetAttribute("TrainSeated") or v_u_7:GetAttribute("SleighSeated"))))
		if v27 then
			v27 = not v_u_2:GetAttribute("InTrainTravelCutscene")
		end
		v_u_6:SetEnabled("BlockTools", v27)
	end
	v_u_2:GetAttributeChangedSignal("InTrainTravelCutscene"):Connect(v28)
	v_u_7:GetAttributeChangedSignal("SleighSeated"):Connect(v28)
	v_u_7:GetAttributeChangedSignal("TrainSeated"):Connect(v28)
	v_u_7:GetAttributeChangedSignal("CartSeated"):Connect(v28)
	v_u_7:GetAttributeChangedSignal("BlockTools"):Connect(v28)
	v_u_7:GetAttributeChangedSignal("Stealing"):Connect(v28)
	task.spawn(v28)
	v_u_9 = v_u_8:WaitForChild("BackpackGui"):WaitForChild("Backpack"):WaitForChild("Hotbar")
	v_u_5.observeCharacter(v_u_7, function(p29, _)
		local v30 = p29:WaitForChild("Backpack")
		if not v30 then
			return nil
		end
		for _, v31 in v30:GetChildren() do
			if v31:IsA("Tool") then
				task.spawn(v_u_23, v31)
			end
		end
		local v_u_33 = v30.ChildAdded:Connect(function(p32)
			if p32:IsA("Tool") then
				v_u_23(p32)
			end
		end)
		return function()
			v_u_33:Disconnect()
		end
	end)
	v_u_4:RemoteEvent("Tools/Cooldown").OnClientEvent:Connect(function(p_u_34, p_u_35)
		local v_u_36 = os.clock()
		local v37 = v_u_11[p_u_34.Name]
		if v37 and coroutine.status(v37) ~= "suspended" then
			task.cancel(v37)
			p_u_34:SetAttribute("CooldownTime", nil)
			v_u_11[p_u_34.Name] = nil
		end
		local v39 = task.spawn(function()
			while true do
				local v38 = p_u_35 - (os.clock() - v_u_36)
				if v38 <= 0 then
					break
				end
				p_u_34:SetAttribute("CooldownTime", v38)
				task.wait(0.05)
			end
			p_u_34:SetAttribute("CooldownTime", nil)
			v_u_11[p_u_34.Name] = nil
		end)
		v_u_11[p_u_34.Name] = v39
	end)
end
return v12