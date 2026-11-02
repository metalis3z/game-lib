-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = require(v_u_2.Modules.Sounds)
local v_u_5 = require(v_u_2.Modules.Util)
require(v_u_2.Modules.Network)
local v_u_6 = require(v_u_2.Modules.Actors)
require(v_u_2.Modules.Statuses)
local v_u_7 = require(v_u_2.Modules.Misc.Maid)
local v_u_8 = {}
local v_u_9 = {}
local v61 = {}
v_u_9.__index = v_u_9
function v_u_9.getObject(p10)
	-- upvalues: (copy) v_u_8
	return v_u_8[p10]
end
function v_u_9.new(p11, p_u_12)
	-- upvalues: (copy) v_u_9, (copy) v_u_7, (copy) v_u_5, (copy) v_u_4, (copy) v_u_1
	local v13 = v_u_9
	local v_u_14 = setmetatable({}, v13)
	local v15 = p11.Player == game.Players.LocalPlayer
	v_u_14.Root = p_u_12
	v_u_14.Owner = p11.Player
	v_u_14.IsLocal = v15
	v_u_14.Maid = v_u_7.new()
	v_u_14.Model = v_u_14:Create(p11)
	v_u_14.Range = p11.Config.VandalismRange
	v_u_14.Width = p11.Config.VandalismWidth
	v_u_14.LastProgression = p_u_12:GetAttribute("Progression") or 0
	v_u_14.LastProgressionChange = 0
	v_u_14.Sounds = {}
	for _, v16 in ipairs({
		"Progression",
		"Wiping",
		"Completed",
		"Destroyed"
	}) do
		local v17 = p11.Config.Sounds[("Spray%*"):format(v16)]
		if v17 then
			local v18 = v_u_14.Sounds
			if typeof(v17) == "table" then
				v17 = v_u_5:CopyTable(v17)
			end
			v18[v16] = v17
		else
			local v19 = ("Failed to cache sound %*!"):format(v16)
			warn((("[Veeronica/SprayVisual]: %*"):format(v19)))
		end
	end
	if v15 then
		v_u_14.IndicationBeam = v_u_14:CreateIndicationBeam(p11)
		v_u_14.ProgressBar = v_u_14:CreateProgressBar(p11)
		v_u_14.RangeIndicator = v_u_14:CreateRangeIndicator(p11)
		v_u_14:ToggleBeam(true)
		v_u_14:ToggleInRange(true)
	end
	local v_u_20 = v_u_4:Play(v_u_14.Sounds.Progression, {
		["Looped"] = true,
		["Parent"] = v_u_14.Model
	})
	local v_u_21 = v_u_4:Play(v_u_14.Sounds.Wiping, {
		["Looped"] = true,
		["Parent"] = v_u_14.Model
	})
	v_u_14.Maid:Add(v_u_1.PreRender:Connect(function()
		-- upvalues: (copy) v_u_14, (copy) v_u_21, (copy) v_u_20
		if os.clock() - v_u_14.LastProgressionChange >= 0.05 then
			local v22 = v_u_21
			if v22.Playing ~= false then
				v22.Playing = false
			end
			local v23 = v_u_20
			if v23.Playing ~= false then
				v23.Playing = false
			end
		end
	end))
	v_u_14.Maid:Add(p_u_12:GetAttributeChangedSignal("Progression"):Connect(function()
		-- upvalues: (copy) p_u_12, (copy) v_u_14, (copy) v_u_20, (copy) v_u_21
		local v24 = p_u_12:GetAttribute("Progression") or 1
		if v24 - v_u_14.LastProgression > 0 then
			local v25 = v_u_20
			if v25.Playing ~= true then
				v25.Playing = true
			end
			local v26 = v_u_21
			if v26.Playing ~= false then
				v26.Playing = false
			end
		elseif v24 - v_u_14.LastProgression < 0 then
			local v27 = v_u_21
			if v27.Playing ~= true then
				v27.Playing = true
			end
			local v28 = v_u_20
			if v28.Playing ~= false then
				v28.Playing = false
			end
		end
		v_u_14:ProgressionChanged(v24)
		v_u_14.LastProgression = v24
		v_u_14.LastProgressionChange = os.clock()
	end))
	v_u_14.Maid:Add(p_u_12:GetAttributeChangedSignal("Completed"):Connect(function()
		-- upvalues: (copy) p_u_12, (ref) v_u_4, (copy) v_u_14
		if p_u_12:GetAttribute("Completed") then
			v_u_4:Play(v_u_14.Sounds.Completed, {
				["Parent"] = v_u_14.Model
			})
			v_u_14:OnCompleted()
		else
			v_u_14:OnUncompleted()
		end
	end))
	v_u_14.Maid:Add(v_u_20)
	v_u_14.Maid:Add(v_u_21)
	p11.SprayVisuals[p_u_12] = v_u_14
	return v_u_14
end
function v_u_9.Destroy(p29)
	-- upvalues: (copy) v_u_4
	if not p29.Dead then
		p29.Dead = true
		local v30 = p29:GetActor()
		if v30 and v30.SprayVisuals then
			v30.SprayVisuals[p29.Root] = nil
		else
			warn("Failed to remove cached SprayVisual!")
		end
		v_u_4:Play(p29.Sounds.Destroyed, {
			["Parent"] = p29.Model
		})
		task.spawn(p29.ToggleBeam, p29, false)
		task.spawn(p29.OnDestroyed, p29)
		p29.Maid:Destroy()
		table.clear(p29)
	end
end
function v_u_9.Create(p31, p32)
	local v33
	if p32 and (p32.Player and p32.Player.Name == "ffPrankster") then
		v33 = { "rbxassetid://83450503791840" }
	elseif math.random(1, 25000) == 1 then
		v33 = p32.Config.VandalismRareSprayImages
	else
		v33 = p32.Config.VandalismSprayImages
	end
	local v34 = p32.Config.VandalismPreset:Clone()
	v34.ImageBeam.Texture = v33[math.random(#v33)]
	v34.ImageBeam.Width0 = 3
	v34.ImageBeam.Width1 = 3
	v34.ImageBeam.Brightness = 0
	v34.Name = ("%*Spray"):format(p32.Player.Name)
	v34.Parent = workspace.Map.Ingame
	v34.CFrame = p31.Root:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0)
	v34.Name = "GraffitiCL"
	local v35
	if v34 then
		v35 = v34:IsA("BasePart")
	else
		v35 = v34
	end
	assert(v35, "SprayVisual must be a BasePart!")
	return v34
end
function v_u_9.CreateIndicationBeam(p36, p37)
	if p37.Rig and p37.Rig:FindFirstChild("Torso") then
		local v38 = p37.Config.VandalismSprayBeam:Clone()
		v38.Enabled = false
		v38.Attachment0 = p36.Model.AttachmentMain
		v38.Attachment1 = p37.Rig.Torso.BodyBackAttachment
		v38.Parent = p36.Model
		return v38
	end
	warn("[Veeronica/SprayVisual]: Failed to find torso for indication beam!")
end
function v_u_9.CreateProgressBar(p39, _)
	local v40 = script.BillboardGui:Clone()
	v40.Parent = p39.Model
	v40.StudsOffset = Vector3.new(0, 0, 0.05)
	return v40
end
function v_u_9.CreateRangeIndicator(p41, _)
	-- upvalues: (copy) v_u_2
	local v42 = v_u_2.Assets.Instances.Nothingburger:Clone()
	local v43 = p41.Width
	local v44 = p41.Width
	local v45 = p41.Range
	v42.Size = vector.create(v43, v44, v45)
	v42.Parent = p41.Model
	v42.CFrame = p41.Root:GetPivot() * CFrame.new(0, 0, p41.Range / 2 + 1)
	v42.Transparency = 1
	v42.Name = "SprayRangeIndicator"
	return v42
end
function v_u_9.OnDestroyed(p46)
	-- upvalues: (copy) v_u_3
	local v47 = p46.Model
	if v47 then
		local v48 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		v_u_3:Create(v47.ImageBeam, v48, {
			["Width0"] = 0,
			["Width1"] = 0,
			["Brightness"] = -0.5
		}):Play()
		v_u_3:Create(v47.AttachmentBottom, v48, {
			["Position"] = Vector3.new(0, -2.5, 0),
			["Orientation"] = Vector3.new(50, 0, 90)
		})
		if p46.RangeIndicator then
			v_u_3:Create(p46.RangeIndicator, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Transparency"] = 1
			}):Play()
		end
		p46:ToggleBeam(false)
		game.Debris:AddItem(v47, 2)
	else
		warn("what is happpening")
	end
end
function v_u_9.ToggleInRange(p49, p50)
	local v51 = p49.RangeIndicator
	local v52
	if p50 then
		v52 = Color3.new(0, 1, 0)
	else
		v52 = Color3.new(1, 0, 0)
	end
	v51.Color = v52
end
function v_u_9.ToggleBeam(p53, p54)
	if p53.IndicationBeam then
		p53.IndicationBeam.Enabled = p54
		if p54 then
			p54 = not p53.Completed
		end
		p53:ToggleBar(p54)
	end
end
function v_u_9.ToggleBar(p55, p56)
	-- upvalues: (copy) v_u_3
	if p55.ProgressBar then
		local v57 = TweenInfo.new(0.35)
		v_u_3:Create(p55.ProgressBar.Background, v57, {
			["BackgroundTransparency"] = p56 and 0.35 or 1
		}):Play()
		v_u_3:Create(p55.ProgressBar.Outline, v57, {
			["BackgroundTransparency"] = p56 and 0.35 or 1
		}):Play()
		v_u_3:Create(p55.ProgressBar.Background.Bar, v57, {
			["BackgroundTransparency"] = p56 and 0.35 or 1
		}):Play()
	end
end
function v_u_9.UpdateBeam(p58, p59)
	if not p58.IndicationBeam then
		return
	end
	p58:GetActor()
	local v60 = {
		["IN"] = Color3.fromRGB(13, 255, 0),
		["INBAD"] = Color3.fromRGB(255, 204, 0),
		["OUT"] = Color3.fromRGB(255, 46, 46)
	}
	if p59 then
		if p58.Completed then
			v61 = v60.IN
		else
			v61 = v60.INBAD
		end
		if v61 then
			p58.IndicationBeam.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v61), ColorSequenceKeypoint.new(1, v61) })
			return
		end
	end
	local v61 = v60.OUT
end
function v_u_9.ProgressionChanged(p62, p63)
	-- upvalues: (copy) v_u_3
	local v64 = v_u_3
	local v65 = p63 / 100
	local v66 = v64:GetValue(math.clamp(v65, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	local v67 = p62.Model
	local v68 = v67.ImageBeam
	local _ = v67.AttachmentBottom
	v_u_3:Create(v68, TweenInfo.new(0.08), {
		["Brightness"] = v66 / 2 + 0.5,
		["Width0"] = v66 * 2 + 3,
		["Width1"] = v66 * 2 + 3
	}):Play()
	local v69
	if p62.IsLocal then
		v69 = 0.5 - v66 * 0.5
	else
		v69 = 0.9 - v66 * 0.2
	end
	v68.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, v69), NumberSequenceKeypoint.new(1, v69) })
	if p62 and (p62.ProgressBar and p62.ProgressBar:FindFirstChild("Background")) then
		v_u_3:Create(p62.ProgressBar.Background.Bar, TweenInfo.new(0.05), {
			["Size"] = UDim2.fromScale(v66, 1)
		}):Play()
	end
end
function v_u_9.OnCompleted(p70)
	-- upvalues: (copy) v_u_3
	p70.Completed = true
	if p70.RangeIndicator then
		v_u_3:Create(p70.RangeIndicator, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["Transparency"] = 0.8
		}):Play()
	end
	p70:ToggleBar(false)
	p70.Model.ImageBeam.LightEmission = 2
	v_u_3:Create(p70.Model.ImageBeam, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["LightEmission"] = 0
	}):Play()
end
function v_u_9.OnUncompleted(p71)
	-- upvalues: (copy) v_u_3
	p71.Complete = false
	p71:ToggleBar(true)
	if p71.RangeIndicator then
		v_u_3:Create(p71.RangeIndicator, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			["Transparency"] = 1
		}):Play()
	end
end
function v_u_9.GetActor(p72)
	-- upvalues: (copy) v_u_6
	return v_u_6.CurrentActors[p72.Owner]
end
return v_u_9
