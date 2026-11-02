local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("Lighting")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v6 = {}
local v7 = require(v_u_1.Packages.Net)
local v8 = require(v_u_1.Packages.Trove)
local v_u_9 = require(v_u_1.Packages.CreateTween)
local v_u_10 = require(script.Parent.Parent)
local v_u_11 = require(v_u_1.Controllers.NotificationController)
local v_u_12 = require(v_u_1.Controllers.SkullEmojiEffectController)
local v_u_13 = require(v_u_1.Shared.VFX)
local v_u_14 = require(v_u_1.Controllers.AnimalController)
local v_u_15 = require(v_u_1.Controllers.SoundController)
local v_u_16 = script.Name
local v_u_17 = v8.new()
local v_u_18 = v8.new()
local v_u_19 = v_u_4.LocalPlayer
local v_u_20 = Random.new()
local v_u_21 = {}
local v_u_22 = nil
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = v7:RemoteEvent((("EventService/%*/PlaySleepVFX"):format(v_u_16)))
local v_u_27 = v_u_1.Models.Events.Sleepy
local v_u_28 = workspace.Events["Phase 1: Sleepy"]
local v_u_29 = v_u_1.Animations.Events["Phase 1: Sleepy"]
local function v_u_40()
    if v_u_24 or v_u_22 then
        return
    else
        v_u_24 = time()
        local v30 = {}
        local v31, v32 = pcall(v_u_19.GetFriendsOnline, v_u_19, 15)
        if v31 then
            for _, v33 in v32 do
                local v34 = v33.VisitorId
                table.insert(v30, v34)
                local v35 = v_u_21
                local v36 = v33.VisitorId
                table.insert(v35, v36)
            end
        end
        if #v30 >= 15 then
            return v30
        else
            local _, v37 = pcall(v_u_4.GetFriendsAsync, v_u_4, v_u_19.UserId)
            if v37 then
                for _, v38 in v37:GetCurrentPage() do
                    if not table.find(v_u_21, v38.Id) then
                        local v39 = v38.Id
                        table.insert(v30, v39)
                    end
                end
                return v30
            else
                warn((("Players:GetFriendsAsync() failed: %*"):format(v37)))
                return nil
            end
        end
    end
end
local function v_u_45(p_u_41)
    local v_u_42 = v_u_18:Clone(script.NPCTemplate)
    v_u_42:PivotTo(CFrame.new(0, 100000, 0))
    v_u_42.Parent = v_u_28
    local v43, v44 = pcall(function()
        return v_u_42.Humanoid:ApplyDescription(p_u_41)
    end)
    if v43 then
        v_u_18:Add(task.delay(3, function()
            if v_u_42.Parent == v_u_28 then
                v_u_42.Parent = nil
            end
        end))
        return v_u_42
    end
    warn((("Failed to createNPC(): %*"):format(v44)))
    v_u_42:Destroy()
    return nil
end
local function v_u_48(p46)
    for _, v47 in Enum.HumanoidStateType:GetEnumItems() do
        if v47 ~= Enum.HumanoidStateType.None then
            p46:SetStateEnabled(v47, false)
        end
    end
end
local function v_u_64(p49, p50)
    if not (v_u_25 or v_u_23) or p50 then
        v_u_25 = time()
        local v51 = {}
        if p50 or not v_u_22 then
            for _ = 1, p49 do
                local v52 = v_u_18
                local v53 = script.BaconTemplate
                table.insert(v51, v52:Clone(v53))
            end
            return v51
        end
        local v54 = table.clone(v_u_21 or {})
        local v55 = table.clone(v_u_22 or {})
        while #v51 < p49 do
            local v_u_56 = nil
            local v57 = nil
            local v58
            if #v54 > 0 then
                v58 = v54
            else
                v58 = v55
            end
            if #v58 > 0 then
                local v59 = v_u_20:NextInteger(1, #v58)
                v_u_56 = v58[v59]
                table.remove(v58, v59)
            end
            if v_u_56 then
                local v60, v61 = pcall(function()
                    return v_u_4:GetHumanoidDescriptionFromUserId(v_u_56)
                end)
                if v60 then
                    v57 = v61 or v57
                end
            end
            local v62
            if v57 then
                v57.BackAccessory = 0
                v57.BodyTypeScale = 0
                v57.ProportionScale = 0
                v57.DepthScale = 1
                v57.HeadScale = 1
                v57.HeightScale = 1
                v57.WidthScale = 1
                v62 = v_u_45(v57)
            else
                v62 = nil
            end
            local v63 = v62 or v_u_18:Clone(script.BaconTemplate)
            v_u_48(v63.Humanoid)
            v_u_5:AddItem(v63, 300)
            table.insert(v51, v63)
        end
        return v51
    end
end
function v6.OnStart(_)
    local v65 = v_u_10:GetActiveEventData(v_u_16)
    assert(v65)
    v_u_1:SetAttribute("Phase1SleepyEvent", true)
    v_u_15:UpdateOST()
    v_u_17:Add(function()
        v_u_1:SetAttribute("Phase1SleepyEvent", nil)
        v_u_15:UpdateOST()
	end)
	v_u_18 = v8.new()
    local v_u_66 = v65.endsAt - 10
    local v_u_67 = workspace:GetServerTimeNow()
    local v68 = v_u_66 - workspace:GetServerTimeNow()
    local v69 = math.max(v68, 0)
    local v70 = math.min(v69, 4)
    local v_u_71 = math.max(0.1, v70)
    local v_u_72 = TweenInfo.new(v_u_71, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v73 = v69 - v_u_71
    local v_u_74 = math.max(v73, 0)
    v_u_17:Add(task.delay(v_u_74, function()
        if v_u_66 >= v_u_67 and v_u_74 ~= 0 then
            local v75 = v_u_17:Clone(script.ImageLabel)
            v75.Size = UDim2.fromScale(10, 10)
            v75.Parent = v_u_4.LocalPlayer.PlayerGui:WaitForChild("CoinsShop")
            v_u_9(v75, v_u_72, {
                ["Size"] = UDim2.fromScale(2, 1.5)
            })
            local v_u_76 = v_u_17:Add(Instance.new("BlurEffect"))
            v_u_76.Size = 0
            v_u_76.Parent = v_u_3
            v_u_9(v_u_76, v_u_72, {
                ["Size"] = 10
            })
            task.wait(v_u_71)
            v_u_17:Add(task.delay(v_u_66 + 0.1 + 4 - workspace:GetServerTimeNow(), function()
                v_u_17:Remove(v_u_76)
            end))
            v_u_12:Play(4.5, "Lower")
            task.delay(0.5, function()
                v_u_11:Notify("YOU FELL ASLEEP", 4)
            end)
        end
    end))
    v_u_18:Add(task.delay(v65.endsAt + 45 - workspace:GetServerTimeNow(), function()
        v_u_18:Destroy()
    end))
    local function v_u_108(p77, p78, p_u_79)
        local function v95(p_u_80, p_u_81, p_u_82, p83)
            local v_u_84 = p_u_80.CFrame
            local v85 = p83 and 0 or p_u_81.X
            local v86 = p83 and 0 or p_u_81.Z
            local v87 = Vector3.new(v85, 0, v86)
            local v88 = v_u_84 * CFrame.new(0, -(p_u_81.Y - v87.Y) / 2, 0)
            p_u_80.Size = v87
            p_u_80.CFrame = v88
            local v_u_89 = p_u_80.Transparency
            p_u_80.Transparency = 1
            local v90 = v_u_18
            local v91 = task.delay
            local v92
            if p_u_79 then
                v92 = p_u_79(p_u_82)
            else
                v92 = p_u_82
            end
            v90:Add(v91(v92, function()
                p_u_80.Transparency = v_u_89
                local v93 = not p_u_79 and 1 or p_u_79(p_u_82 + 1)
                local v94 = TweenInfo.new(v93, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                v_u_9(p_u_80, v94, {
                    ["Size"] = p_u_81
                })
                v_u_9(p_u_80, v94, {
                    ["CFrame"] = v_u_84
                })
            end))
        end
        local v96 = {}
        local v97 = (1 / 0)
        local v98 = (-1 / 0)
        for _, v99 in p77:GetDescendants() do
            if v99:IsA("BasePart") and v99.Transparency < 1 then
                table.insert(v96, v99)
                local v100 = v99.Position.Y
                v97 = math.min(v97, v100)
                local v101 = v99.Position.Y
                v98 = math.max(v98, v101)
            end
        end
        table.sort(v96, function(p102, p103)
            return p102.Position.Y < p103.Position.Y
        end)
        local v104 = v98 - v97
        for _, v105 in v96 do
            local v106 = v105.Color.R * 255 < 90
            local v107 = (v105.Position.Y - v97) / v104 * p78
            if v106 then
                v107 = v107 + 0.2
            end
            v95(v105, v105.Size, v107, v106)
        end
    end
    local v_u_109 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 4)
    local function v_u_124(p110, p111, p112, p113)
        local v114 = p110:FindFirstChild("Head")
        local v115 = p110.PrimaryPart
        if not (v114 and v115) then
            return false
        end
        v115.Anchored = true
        p110:PivotTo(p112)
        v_u_18:Clone(v_u_1.Models.Traits.Sleepy.Sleepy.SLEEPY_VFX_ATTACHMENT).Parent = v114
		v_u_18:Add(p110)
		p110.Parent = v_u_28.NPCs
        for _, v116 in p110:GetChildren() do
            if v116:IsA("BasePart") then
                v116.CanCollide = false
                v116.CollisionGroup = "PlayerNoCollision"
            end
        end
        v_u_18:Add(p110.Humanoid.Animator:LoadAnimation(v_u_29.SleepIdle)):Play()
        local v117 = p111:GetExtentsSize()
        if not p113 then
            local v118 = v117.X
            local v119 = v117.Z
            local v120 = math.max(v118, v119) / 2
            p113 = CFrame.new(0, 0, v120 + 0.5)
        end
        local v121 = p112 * p113
        p111:PivotTo(v121)
        local v122 = Instance.new("Part")
        v122.Transparency = 1
        v122.CanCollide = false
        v122.CanQuery = false
        v122.CanTouch = false
        v122.Anchored = true
        v122.Name = "Hitbox"
        v122.Size = v117
        v122.CFrame = v121 * CFrame.new(0, v117.Y, 0)
        v122.Parent = p111
        p111.PrimaryPart = v122
        local v123 = v_u_18:Clone(v_u_27.GrowTimer)
        v123.TextLabel.Text = ("%* years left"):format((v_u_20:NextInteger(2, 10)))
        v123.Parent = v122
        v123.TextLabel.TextTransparency = 1
        v123.TextLabel.UIStroke.Transparency = 1
        v_u_9(v123.TextLabel, v_u_109, {
            ["TextTransparency"] = 0
        })
        v_u_9(v123.TextLabel.UIStroke, v_u_109, {
            ["Transparency"] = 0
        })
		v_u_18:Add(p111)
		p111.Parent = v_u_28.Plants
        v_u_108(p111, 4)
        return true
    end
    task.defer(function()
        local v_u_125 = {}
        local v126 = v_u_18:Clone(v_u_27["Jandel R15"])
        v_u_48(v126.Humanoid)
        v_u_124(v126, v_u_18:Clone(v_u_27.Beanstalk), v_u_28.JandelSpawn:GetPivot(), CFrame.new(0, 0, 3.5))
        v_u_125[v126] = v126
        local function v129(p127)
            for _, v128 in v_u_125 do
                if (p127 - v128:GetPivot().Position).Magnitude < 15 then
                    return false
                end
            end
            return true
        end
        if not v_u_24 then
            task.spawn(v_u_40)
        end
        local v130 = time()
        local v131 = v130 - (v_u_24 or v130)
        if not v_u_22 and v131 < 5 then
            task.wait(5 - v131)
        end
        local v132 = time()
        if not v_u_23 and v132 - (v_u_25 or v132) < 5 then
            task.wait(5 - v131)
        end
        local v133 = v_u_23 or v_u_64(15, true)
        if not v133 then
            warn("No NPCs generated by generateNPCs")
            return
        end
		for _, v134 in v133 do
			v_u_125[v134] = v134
			local v135 = v_u_28.PlantSpawns:GetChildren()
			local v136 = v135[v_u_20:NextInteger(1, #v135)]
			local v137 = v136.Position
			local v138 = v136.Size
			local v139 = 0
			local v144 = v137
			while v139 < 20 do
				v139 = v139 + 1
				local v141 = v137.X + v_u_20:NextNumber(-v138.X * 0.5, v138.X * 0.5)
				local v142 = v137.Y + v138.Y * 0.5
				local v143 = v137.Z + v_u_20:NextNumber(-v138.Z * 0.5, v138.Z * 0.5)
				local v_pos = Vector3.new(v141, v142, v143)
				if v129(v_pos) then
					v144 = v_pos
					break
				end
			end
			local v145 = CFrame.new(0, -0.4, 0)
			local v146 = CFrame.Angles(0, v_u_20:NextNumber(0, 6.283185307179586), 0)
			local v147 = CFrame.new(v144) * v145 * v146
			local v148 = v_u_27.Plants:GetChildren()
			if not v_u_124(v134, v_u_18:Clone(v148[v_u_20:NextInteger(1, #v148)]), v147) then
				v_u_125[v134] = nil
				v134:Destroy()
			end
		end
    end)
end
function v6.OnStop(_)
	v_u_17:Destroy() 
	v_u_18:Destroy() 

	v_u_22 = nil
	v_u_23 = nil
end
function v6.OnLoad(_)
    v_u_26.OnClientEvent:Connect(function(p149)
        local v150 = v_u_14:GetAnimals()[p149]
        if v150 then
            local v151 = v150.AnimalModel
            local v152 = v150.AnimalModel
            if v152 then
                v152 = v151.PrimaryPart
            end
            local v153 = v150.Instance
            local v154
            if v153 then
                v154 = v153.PrimaryPart
            else
                v154 = v153
            end
            if v154 and v152 then
                local v155 = v_u_17:Clone(v_u_27.SleepyImpact.SleepyImpact)
                v155:PivotTo(v154.CFrame * CFrame.new(0, (v155.Size.Y + v151:GetExtentsSize().Y) / 2, 0))
                v155.Parent = v153
                v_u_13.weld(v155, v152)
                v_u_13.emit(v155)
                v_u_5:AddItem(v155, 5)
                v_u_15:PlaySound(v_u_1.Sounds.Events["Phase 1: Sleepy"].Hit, v154.CFrame.Position, false)
            end
        else
            return
        end
    end)
    task.defer(function()
        v_u_22 = v_u_40()
        v_u_23 = v_u_64(15)
    end)
    task.spawn(pcall, function()
        v_u_2:PreloadAsync(script:GetChildren())
    end)
    task.spawn(pcall, function()
        v_u_2:PreloadAsync(v_u_1.Models.Events["Phase 1: Sleepy"])
    end)
end
return v6