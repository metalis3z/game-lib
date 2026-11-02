-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = require(v2.Modules.Misc.Trove)
local v_u_5 = require(v2.Modules.Util)
local v_u_6 = require(v2.Modules.Thread)
local v12 = {
	["OnExecution"] = function(_, p_u_7, p_u_8)
		local v_u_9 = p_u_8:FindFirstChild("Humanoid")
		local v_u_10 = require(game.ReplicatedStorage.Modules.Ragdolls)
		task.delay(2.31, function()
			-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) p_u_8, (copy) p_u_7
			if v_u_9 then
				v_u_10.AddProfile(p_u_8, {
					["AnchorDelay"] = true,
					["Applied"] = os.clock() + 5,
					["Velocity"] = p_u_7.Rig.PrimaryPart.CFrame.LookVector.Unit * 35
				})
				local v11 = p_u_8:FindFirstChild("Humanoid")
				if v11 then
					v11.BreakJointsOnDeath = false
					v11.Health = 0
				end
				if p_u_8 and p_u_8.PrimaryPart then
					p_u_8.PrimaryPart.Anchored = false
				end
			end
		end)
	end
}
local v_u_13 = {
	"Big",
	"Flames",
	"Shockwave",
	"Small :D",
	"SmokeBLACK",
	"SmokeRed"
}
function v12.OnIntroduction(_, p14, p_u_15, p16)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_13, (copy) v_u_5, (copy) v_u_6, (copy) v_u_3
	local v_u_17 = v_u_4.new()
	v_u_1.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true)
	workspace.CurrentCamera.FieldOfView = 44
	for _, v18 in v_u_13 do
		local v19 = p_u_15.Head.EyesFlare:FindFirstChild(v18)
		if v19 then
			v19.Enabled = false
		end
	end
	for _, v20 in p_u_15.Head.Eyes:GetChildren() do
		if v20:IsA("ParticleEmitter") then
			v20.Enabled = false
		end
	end
	for _, v21 in p_u_15.Head.RightEye:GetChildren() do
		if v21:IsA("ParticleEmitter") then
			v21.Enabled = false
		end
	end
	v_u_17:Add(v_u_6.delay(2.966666666666667, function(...)
		-- upvalues: (ref) v_u_13, (copy) p_u_15
		for _, v22 in v_u_13 do
			local v23 = p_u_15.Head.EyesFlare:FindFirstChild(v22)
			if v23 then
				v23.Enabled = true
			end
		end
		for _, v24 in p_u_15.Head.Eyes:GetChildren() do
			if v24:IsA("ParticleEmitter") then
				v24.Enabled = true
			end
		end
		for _, v25 in p_u_15.Head.RightEye:GetChildren() do
			if v25:IsA("ParticleEmitter") then
				v25.Enabled = true
			end
		end
	end))
	v_u_17:Add(v_u_6.delay(3.066666666666667, function(...)
		-- upvalues: (ref) v_u_13, (copy) p_u_15
		for _, v26 in v_u_13 do
			local v27 = p_u_15.Head.EyesFlare:FindFirstChild(v26)
			if v27 then
				v27.Enabled = false
			end
		end
	end))
	v_u_17:Add(v_u_6.delay(3.1166666666666667, function(...)
		workspace.CurrentCamera.FieldOfView = 35
	end))
	v_u_17:Add(v_u_6.delay(3.8833333333333333, function(...)
		-- upvalues: (ref) v_u_3, (copy) v_u_17
		local v28 = v_u_3:Create(workspace.CurrentCamera, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			["FieldOfView"] = 28
		})
		v28:Play()
		v_u_17:Add(v28)
	end))
	v_u_17:Add(v_u_6.delay(4.483333333333333, function(...)
		-- upvalues: (copy) p_u_15
		p_u_15.Crazyblox.Wings.Transparency = 0
		for _, v29 in p_u_15.ExtraModels:GetDescendants() do
			if v29:IsA("BasePart") then
				v29.Transparency = 0
			end
		end
	end))
	v_u_17:Add(v_u_6.delay(4.55, function(...)
		-- upvalues: (ref) v_u_3, (copy) v_u_17
		local v30 = v_u_3:Create(workspace.CurrentCamera, TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["FieldOfView"] = 35
		})
		v30:Play()
		v_u_17:Add(v30)
	end))
	if workspace.Misc:WaitForChild("KillerCutsceneBackground", 5) then
		v_u_5:PlayDummyCutsceneAnimations(p14, p16, "Introduction")
	end
	p_u_15.Crazyblox.Wings.Transparency = 1
	for _, v31 in p_u_15.ExtraModels:GetDescendants() do
		if v31:IsA("BasePart") then
			v31.Transparency = 1
		end
	end
	task.delay(p16, function()
		-- upvalues: (ref) v_u_1, (copy) v_u_17
		v_u_1.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil)
		v_u_17:Destroy()
	end)
end
function v12.OnVictory(p32, p33, p34, _, p35)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_5, (copy) v_u_6, (copy) v_u_3
	if p33 == "Start" then
		local v_u_36 = v_u_4.new()
		p32.__outroTrove = v_u_36
		v_u_1.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true)
		workspace.CurrentCamera.FieldOfView = 30
		v_u_36:Add(v_u_6.spawn(function(...)
			-- upvalues: (ref) v_u_3, (copy) v_u_36
			local v37 = v_u_3:Create(workspace.CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				["FieldOfView"] = 60
			})
			v37:Play()
			v_u_36:Add(v37)
		end))
		v_u_36:Add(v_u_6.delay(0.4, function(...)
			workspace.CurrentCamera.FieldOfView = 60
		end))
		v_u_36:Add(v_u_6.delay(2.6666666666666665, function(...)
			workspace.CurrentCamera.FieldOfView = 40
		end))
		if workspace.Misc:WaitForChild("KillerCutsceneBackground", 5) then
			v_u_5:PlayDummyCutsceneAnimations(p34, p35, "Victory")
			return
		end
	elseif p33 == "End" then
		v_u_1.LocalPlayer:SetAttribute("FOVMultipliersDisabled", false)
		p32.__outroTrove:Destroy()
		p32.__outroTrove = nil
	end
end
return v12