-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("ReplicatedStorage")
game:GetService("CollectionService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = require(v_u_2.Modules.Util)
local v_u_5 = require(v_u_2.Modules.Sounds)
local v_u_6 = require(v_u_2.Modules.Network)
local v_u_7 = require(v_u_2.Modules.Actors)
local v_u_8 = v_u_1:IsServer()
local v_u_9 = v_u_1:IsClient()
local v_u_10 = {
    ["Order"] = 5,
    ["AbilityName"] = nil,
    ["RequestTitle"] = "Request Healing",
    ["NotificationTitle"] = "PLAYERNAME is bleeding and wants help!"
}
local v_u_11 = {
    ["SoundId"] = "rbxassetid://7740696902"
}
local v_u_12 = {
    ["SoundId"] = "rbxassetid://1489909826",
    ["Looped"] = true
}
local v_u_13 = {
    ["Healer"] = "rbxassetid://103330499935777",
    ["Victim"] = "rbxassetid://132443828349204"
}
local function v_u_19(p14, p15, p16)
    local v17 = math.clamp(p15, 0, p16) / p16
    local v18 = v17 == 0 and 0 or 1 / v17
    v_u_3:Create(p14.Clipping, TweenInfo.new(0.15), {
        ["Size"] = UDim2.fromScale(v17, 1)
    }):Play()
    v_u_3:Create(p14.Clipping.Top, TweenInfo.new(0.15), {
        ["Size"] = UDim2.fromScale(v18, 1)
    }):Play()
end
local v129 = {
    ["Data"] = {
        ["Duration"] = (1 / 0),
        ["MaxLevel"] = 3,
        ["Description"] = "Slowly makes health unhealable.\nEffect can only be reversed by teammates.\nStacks will increase rate of effect."
    },
    ["Applied"] = function(p_u_20)
        local v_u_21 = p_u_20.Player
        local v_u_22
        if v_u_21 then
            v_u_22 = v_u_21.Character
        else
            v_u_22 = v_u_21
        end
        local v23
        if v_u_21 then
            v23 = v_u_7.CurrentActors[v_u_21]
        else
            v23 = v_u_21
        end
        p_u_20.ConnectionName = ("%*HemmorhageRequest"):format(not v_u_21 and "Unknown" or v_u_21.Name)
        if v_u_8 then
            if p_u_20.Activated2 then
                v_u_22:SetAttribute("HemmorhageProgress", 0)
                return
            end
            local v_u_24 = require(v_u_2.Modules.Statuses)
            local _ = p_u_20.Data.Killer
            v_u_22:SetAttribute("HemmorhageDecay", nil)
            v_u_22:SetAttribute("HemmorhageProgress", 0)
            if v_u_22.PrimaryPart and v_u_22.PrimaryPart:FindFirstChild("HemmorhagePrompt") then
                return
            end
            p_u_20.Particles = {}
            local v25 = v_u_22:FindFirstChild("Torso") or v_u_22.PrimaryPart
            for _, v26 in pairs(script.Particles:GetChildren()) do
                local v27 = v26:Clone()
                v27.Enabled = true
                v27.Parent = v25
                local v28 = p_u_20.Particles
                table.insert(v28, v27)
            end
            local v_u_29 = {}
            p_u_20.Healed = false
            p_u_20.Healing = false
            local function v_u_73(p30)
                if not p_u_20 or (p_u_20.Healed or p_u_20.Healing) then
                    return "Error"
                end
                if p30 == v_u_21 then
                    return "You can\'t heal yourself."
                end
                if not (v_u_4:IsAlive(p30.Character) and p30.Character:IsDescendantOf(workspace.Players.Survivors)) then
                    return "You\'re dead bruh"
                end
                if os.clock() - (v_u_29[p30] or 0) > 15 then
                    return "They haven\'t asked you yet."
                end
                if not v_u_21 then
                    p_u_20.Healed = true
                    v_u_24:RemoveStatus(v_u_22, "Hemmorhage")
                    return "this person wasn\'t a player so we\'ve just gone ahead and removed it automatically ok yeah"
                end
                if p_u_20.Healed then
                    return "They are fully healed already."
                end
                if p_u_20.Healing then
                    return "They are already being healed."
                end
                local v_u_31 = v_u_22
                local v_u_32 = v_u_31:FindFirstChild("Humanoid")
                local v_u_33 = v_u_4:GetActor(v_u_31)
                local v_u_34 = v_u_21
                local v_u_35 = p30.Character
                local v_u_36 = v_u_35:FindFirstChild("Humanoid")
                local v_u_37 = v_u_4:GetActor(v_u_35)
                local v_u_38 = game.Players:GetPlayerFromCharacter(v_u_35)
                if not (v_u_32 and v_u_36) then
                    return "This guy is dead."
                end
                if not (v_u_33 and v_u_37) then
                    return "This person doesn\'t know what he\'s doing."
                end
                if (not (v_u_33 and (v_u_37 and (v_u_33.GetPivot and v_u_37.GetPivot))) and 999 or (v_u_37:GetPivot().Position - v_u_33:GetPivot().Position).Magnitude) > 9 then
                    return "Get closer."
                end
                if v_u_33.AbilitiesDisabled then
                    ::l33::
                    return "They seem occupied with something."
                end
                local v39 = v_u_33.DisabledAbilities
                local v40
                if v39 then
                    for _, v41 in pairs(v39) do
                        if v41 then
                            v40 = true
                            goto l36
                        end
                    end
                    v40 = false
                    goto l36
                else
                    v40 = false
                    ::l36::
                    if not v40 then
                        local v42 = v_u_33.AbilityDisablers
                        local v43
                        if v42 then
                            for _, v44 in pairs(v42) do
                                if v44 then
                                    v43 = true
                                    goto l44
                                end
                            end
                            v43 = false
                            goto l44
                        else
                            v43 = false
                            ::l44::
                            if not (v43 or v_u_31.PrimaryPart.Anchored) then
                                if v_u_37.AbilitiesDisabled then
                                    ::l52::
                                    return "You seem occupied with something."
                                end
                                local v45 = v_u_37.DisabledAbilities
                                local v46
                                if v45 then
                                    for _, v47 in pairs(v45) do
                                        if v47 then
                                            v46 = true
                                            goto l55
                                        end
                                    end
                                    v46 = false
                                    goto l55
                                else
                                    v46 = false
                                    ::l55::
                                    if not v46 then
                                        local v48 = v_u_37.AbilityDisablers
                                        local v49
                                        if v48 then
                                            for _, v50 in pairs(v48) do
                                                if v50 then
                                                    v49 = true
                                                    goto l63
                                                end
                                            end
                                            v49 = false
                                            goto l63
                                        else
                                            v49 = false
                                            ::l63::
                                            if not (v49 or v_u_35.PrimaryPart.Anchored) then
                                                local v_u_51 = CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0)
                                                local v52 = v_u_37:GetPivot()
                                                local v53 = v_u_33:GetPivot()
                                                local v54 = CFrame.new
                                                local v55 = v52.Position
                                                local v56 = v53.Position.X
                                                local v57 = v52.Y
                                                local v58 = v53.Position.Z
                                                local v_u_59 = v54(v55, (Vector3.new(v56, v57, v58)))
                                                if v_u_59 ~= v_u_59 then
                                                    return "Something went wrong."
                                                end
                                                local v60 = RaycastParams.new()
                                                v60.CollisionGroup = "Survivors"
                                                v60.RespectCanCollide = true
                                                v60.FilterType = Enum.RaycastFilterType.Exclude
                                                v60.FilterDescendantsInstances = { workspace.Players }
                                                if workspace:Spherecast(v52.Position, 2, (v_u_59 * v_u_51).Position - v52.Position, v60) then
                                                    return "There is something in the way."
                                                end
                                                if not workspace:Raycast((v_u_59 * v_u_51).Position, Vector3.new(0, -5, 0), v60) then
                                                    return "They will fall. Move to flat ground."
                                                end
                                                v_u_6:FireAllClientConnection("ShowHemmorhagePrompt", "REMOTE_EVENT", false, v_u_22, p_u_20.ConnectionName)
                                                task.spawn(function()
                                                    v_u_4:ToggleAnchored(v_u_31, "Hemmorhage", true)
                                                    v_u_4:ToggleAnchored(v_u_35, "Hemmorhage", true)
                                                    v_u_33:PivotTo(v_u_59 * v_u_51)
                                                    v_u_37:PivotTo(v_u_59)
                                                    v_u_33:DisableAbilities("HealedHemmorhage", true)
                                                    v_u_37:DisableAbilities("HealingHemmorhage", true)
                                                    v_u_29 = {}
                                                    p_u_20.HealingConnections = {}
                                                    p_u_20.Healing = true
                                                    local v_u_61 = true
                                                    local _ = os.clock
                                                    local v62 = v_u_22:GetAttribute("HemmorhageProgress")
                                                    local v63 = 0
                                                    local v64 = ("%*HemmorhageCancel"):format(v_u_34.Name)
                                                    local v65 = v_u_5:Play(v_u_12, {
                                                        ["Parent"] = v_u_31.PrimaryPart
                                                    })
                                                    local v_u_66 = v_u_32.Health
                                                    p_u_20.HealingConnections.HealthChangedVictim = v_u_32.HealthChanged:Connect(function(p67)
                                                        if p67 < v_u_66 then
                                                            v_u_61 = false
                                                        end
                                                        v_u_66 = p67
                                                    end)
                                                    local v_u_68 = v_u_36.Health
                                                    p_u_20.HealingConnections.HealthChangedVictim = v_u_36.HealthChanged:Connect(function(p69)
                                                        if p69 < v_u_68 then
                                                            v_u_61 = false
                                                        end
                                                        v_u_68 = p69
                                                    end)
                                                    v_u_6:SetConnection(v64, "REMOTE_EVENT", function(p70)
                                                        if p70 == v_u_34 or p70 == v_u_38 then
                                                            v_u_61 = false
                                                        end
                                                    end)
                                                    v_u_6:FireClientConnection(v_u_34, "HemmorhageHealStart", "REMOTE_EVENT", v_u_34, v_u_38)
                                                    v_u_6:FireClientConnection(v_u_38, "HemmorhageHealStart", "REMOTE_EVENT", v_u_34, v_u_38)
                                                    while v_u_61 and (v_u_4:IsAlive(v_u_31) and v_u_4:IsAlive(v_u_35)) and ((not (v_u_33 and (v_u_37 and (v_u_33.GetPivot and v_u_37.GetPivot))) and 999 or (v_u_37:GetPivot().Position - v_u_33:GetPivot().Position).Magnitude) < 6 and v62 < 100) do
                                                        local v71 = v63 * 100 / 8
                                                        v_u_22:SetAttribute("HemmorhageProgress", v_u_22:GetAttribute("HemmorhageProgress") + v71)
                                                        v63 = v_u_1.PostSimulation:Wait()
                                                        v62 = not (p_u_20 and v_u_22) and (1 / 0) or v_u_22:GetAttribute("HemmorhageProgress")
                                                    end
                                                    if v_u_33 then
                                                        v_u_33:DisableAbilities("HealedHemmorhage", false)
                                                    end
                                                    if v_u_37 then
                                                        v_u_37:DisableAbilities("HealingHemmorhage", false)
                                                    end
                                                    v_u_6:RemoveConnection(v64, "REMOTE_EVENT")
                                                    if v_u_34 then
                                                        v_u_6:FireClientConnection(v_u_34, "HemmorhageHealStop", "REMOTE_EVENT", v_u_34, v_u_38)
                                                    end
                                                    if v_u_38 then
                                                        v_u_6:FireClientConnection(v_u_38, "HemmorhageHealStop", "REMOTE_EVENT", v_u_34, v_u_38)
                                                    end
                                                    if v65 then
                                                        v65:Destroy()
                                                    end
                                                    v_u_4:RemoveStackableAttribute(v_u_31, "Airborne", "HemmorHeal")
                                                    v_u_4:RemoveStackableAttribute(v_u_35, "Airborne", "HemmorHeal")
                                                    v_u_4:ToggleAnchored(v_u_31, "Hemmorhage", false)
                                                    v_u_4:ToggleAnchored(v_u_35, "Hemmorhage", false)
                                                    for _, v72 in pairs(p_u_20.HealingConnections) do
                                                        v72:Disconnect()
                                                    end
                                                    p_u_20.HealingConnections = nil
                                                    p_u_20.Healing = false
                                                    if v62 >= 100 then
                                                        p_u_20.Healed = true
                                                        v_u_24:RemoveStatus(v_u_21, "Hemmorhage")
                                                        v_u_7:CreateChatInteraction(v_u_34, "Thanks/HemmorhageAsk", v_u_37)
                                                    end
                                                end)
                                                return nil
                                            end
                                            goto l52
                                        end
                                    end
                                    goto l52
                                end
                            end
                            goto l33
                        end
                    end
                    goto l33
                end
            end
            v_u_6:SetConnection(p_u_20.ConnectionName, "REMOTE_EVENT", function(p74)
                local v75 = v_u_73(p74)
                if v75 then
                    v_u_6:FireClientConnection(p74, "HemmorhageDisplayWarning", "REMOTE_EVENT", v75)
                end
            end)
            if v23 then
                v23.Config.Requesting = v23.Config.Requesting or {}
                v23.Config.Requesting.HemmorhageAsk = v_u_4:CopyTable(v_u_10)
                function v23.Config.Requesting.HemmorhageAsk.Callback(p76, p77)
                    game.Players:GetPlayerFromCharacter(p76)
                    local v78 = game.Players:GetPlayerFromCharacter(p77)
                    if not p_u_20.Healing then
                        v_u_29[v78] = os.clock()
                        v_u_6:FireClientConnection(v78, "ShowHemmorhagePrompt", "REMOTE_EVENT", true, v_u_22, p_u_20.ConnectionName)
                    end
                end
            end
            for _, v79 in ipairs(game.Players:GetPlayers()) do
                if v79 ~= v_u_21 then
                    v_u_6:FireClientConnection(v79, "ReplicateHemmorhageRequest", "REMOTE_EVENT", v_u_21, true)
                end
            end
        elseif v_u_9 and (v23 and not p_u_20.Activated2) then
            local v80 = require(v_u_2.Systems.Character.Game.SurvivorRequests)
            v23.Config.Requesting = v23.Config.Requesting or {}
            v23.Config.Requesting.HemmorhageAsk = v_u_4:CopyTable(v_u_10)
            v80:UpdateAll()
        end
        p_u_20.Activated2 = true
    end,
    ["Removed"] = function(p81)
        local v82 = p81.Player
        local v_u_83
        if v82 then
            v_u_83 = v82.Character
        else
            v_u_83 = v82
        end
        local v84
        if v82 then
            v84 = v_u_7.CurrentActors[v82]
        else
            v84 = v82
        end
        if v_u_8 then
            require(game.ReplicatedStorage.Modules.Statuses)
            local v_u_85
            if v_u_83 then
                v_u_85 = v_u_83:FindFirstChild("Humanoid")
            else
                v_u_85 = v_u_83
            end
            p81.Healed = true
            if p81.Particles then
                for _, v86 in ipairs(p81.Particles) do
                    v86:Destroy()
                end
            end
            if v_u_4:IsAlive(v_u_83) then
                v_u_5:Play(v_u_11, {
                    ["Parent"] = v_u_83.PrimaryPart
                })
            end
            if v_u_83 and v_u_85 then
                local v_u_87 = 0
                task.spawn(function()
                    v_u_83:SetAttribute("HemmorhageDecay", true)
                    while v_u_4:IsAlive(v_u_83) and v_u_83:GetAttribute("HemmorhageDecay") do
                        while v_u_87 >= 0.4 do
                            local v88 = v_u_85
                            local v89 = (v_u_85:GetAttribute("HardDamage") or 0) - 1
                            v88:SetAttribute("HardDamage", (math.max(0, v89)))
                            v_u_87 = v_u_87 - 0.4
                        end
                        if v_u_85:GetAttribute("HardDamage") <= 0 then
                            v_u_85:SetAttribute("HardDamage", 0)
                            break
                        end
                        v_u_87 = v_u_87 + task.wait()
                    end
                    if v_u_83 then
                        v_u_83:SetAttribute("HemmorhageDecay", nil)
                    end
                end)
                v_u_83:SetAttribute("HemmorhageProgress", nil)
            end
            v_u_6:RemoveConnection(p81.ConnectionName, "REMOTE_EVENT")
            if v84 and v84.Config then
                v84.Config.Requesting = v84.Config.Requesting or {}
                v84.Config.Requesting.HemmorhageAsk = nil
            end
            for _, v90 in ipairs(game.Players:GetPlayers()) do
                if v90 ~= v82 then
                    v_u_6:FireClientConnection(v90, "ReplicateHemmorhageRequest", "REMOTE_EVENT", v82, false)
                end
            end
        elseif v_u_9 then
            local v91 = require(v_u_2.Systems.Character.Game.SurvivorRequests)
            if v84 then
                v84.Config.Requesting = v84.Config.Requesting or {}
                v84.Config.Requesting.HemmorhageAsk = nil
                v91:UpdateAll()
            end
        end
    end,
    ["Heartbeat"] = function(p92, p93)
        local v94 = p92.Player
        if v94 then
            v94 = v94.Character
        end
        if v_u_8 then
            if not p92.BloodCounter then
                p92.BloodCounter = 0
            end
            if not p92.OrbCounter then
                p92.OrbCounter = 0
            end
            p92.BloodCounter = p92.BloodCounter + p93
            local v95 = v94:FindFirstChild("Humanoid")
            if not v_u_4:IsAlive(v94) then
                p92.Healed = true
                require(game.ReplicatedStorage.Modules.Statuses):RemoveStatus(v94, "Hemmorhage")
                return
            end
            local v96 = p92.Data.Killer
            if not v96 then
                return
            end
            local v97 = v94.PrimaryPart
            local v98 = v96 and v96.Rig
            if v98 then
                v98 = v96.PrimaryPart
            end
            local v99 = v97.AssemblyLinearVelocity.X
            local v100 = v97.AssemblyLinearVelocity.Z
            local v101 = vector.create(v99, 0, v100).Magnitude
            local _ = v98 and (v97.Position - v98.Position).Magnitude
            local v102 = v96 and v96.Chases
            if v102 then
                v102 = v96.Chases[v94]
            end
            local v103 = v102 and 0.5 or ((v94:GetAttribute("BaseSpeed") or 16) + 2 < v101 and 1.25 or 1)
            p92.OrbCounter = p92.OrbCounter + p93 * v103
            if p92.BloodCounter >= 0.8 / (0.5 + p92.Data.Level / 2) then
                local v104 = v95:GetAttribute("HardDamage") or 0
                if v104 + 1 >= v95.MaxHealth - 1 then
                    v95:SetAttribute("HardDamage", v95.MaxHealth - 1)
                else
                    v95:SetAttribute("HardDamage", v104 + 1)
                end
                p92.BloodCounter = 0
            end
            if p92.OrbCounter >= 8 / (0.33 + p92.Data.Level / 3) and (v96 and (v96.Rig and v96.Rig.PrimaryPart)) then
                if v96 and (v96.Behavior and v96.Behavior.SpawnBloodOrb) then
                    v96.Behavior.SpawnBloodOrb(v96, v97.Position, v94)
                end
                p92.OrbCounter = 0
            end
        end
    end,
    ["Init"] = function(_)
        if not v_u_8 then
            if v_u_9 then
                local v_u_105 = game.Players.LocalPlayer
                local v_u_106 = {}
                v_u_6:SetConnection("HemmorhageHealStart", "REMOTE_EVENT", function(p_u_107, _)
                    local v_u_108 = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule)
                    local v109
                    if p_u_107 == v_u_105 then
                        v109 = v_u_13.Victim
                    else
                        v109 = v_u_13.Healer
                    end
                    local v110 = v_u_4:LoadAnimationFromID(v_u_105.Character, v109, false)
                    local v111 = {}
                    local v_u_112 = os.clock()
                    local v_u_113 = false
                    local v_u_114 = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone()
                    v_u_114.Title.Text = "Healing"
                    v_u_114.Parent = v_u_105.PlayerGui:FindFirstChild("TemporaryUI")
                    v110:Play()
                    local v115 = v_u_1.PreRender
                    local function v116(_)
                        if v_u_114 and v_u_114:FindFirstChild("Bar") then
                            v_u_19(v_u_114.Bar, p_u_107 and (p_u_107.Character and p_u_107.Character:GetAttribute("HemmorhageProgress")) or 0, 100)
                            if os.clock() - v_u_112 > 0.4 and (not v_u_113 and workspace.CurrentCamera.CFrame:VectorToWorldSpace(v_u_108:GetMoveVector()) ~= Vector3.new(0, 0, 0)) then
                                v_u_113 = true
                                v_u_6:FireServerConnection(("%*HemmorhageCancel"):format(p_u_107.Name), "REMOTE_EVENT")
                            end
                        end
                    end
                    table.insert(v111, v115:Connect(v116))
                    v_u_106[p_u_107.Character] = {
                        ["Animation"] = v110,
                        ["Connections"] = v111,
                        ["UI"] = v_u_114
                    }
                end)
                v_u_6:SetConnection("HemmorhageHealStop", "REMOTE_EVENT", function(p117, _)
                    local v118 = v_u_106[p117.Character]
                    if v118 then
                        v118.Animation:Stop()
                        if v118.UI then
                            v118.UI:Destroy()
                        end
                        for _, v119 in pairs(v118.Connections) do
                            v119:Disconnect()
                        end
                    end
                end)
                v_u_6:SetConnection("ReplicateHemmorhageRequest", "REMOTE_EVENT", function(p120, p121)
                    local v122 = v_u_7.CurrentActors[p120]
                    if v122 then
                        if p121 then
                            v122.Config.Requesting = v122.Config.Requesting or {}
                            v122.Config.Requesting.HemmorhageAsk = v_u_4:CopyTable(v_u_10)
                        elseif v122.Config.Requesting then
                            v122.Config.Requesting.HemmorhageAsk = nil
                        end
                    else
                        return
                    end
                end)
                v_u_6:SetConnection("ShowHemmorhagePrompt", "REMOTE_EVENT", function(p123, p124, p_u_125)
                    if v_u_4:IsAlive(p124) then
                        local v126 = p124.PrimaryPart:FindFirstChild("HemmorhagePrompt")
                        if v126 then
                            v126:Destroy()
                        end
                        if p123 then
                            local v127 = script.Prompt:Clone()
                            v127.Parent = p124.PrimaryPart
                            v127.Name = "HemmorhagePrompt"
                            game.Debris:AddItem(v127, 13)
                            v127.Triggered:Connect(function()
                                v_u_6:FireServerConnection(p_u_125, "REMOTE_EVENT")
                            end)
                        end
                    end
                end)
                v_u_6:SetConnection("HemmorhageDisplayWarning", "REMOTE_EVENT", function(p128)
                    v_u_4:CreateWarning("HemmorhageWarning", p128)
                end)
            end
        end
    end
}
return v129