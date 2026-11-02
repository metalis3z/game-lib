
local v_u_1 = game:GetService("Debris")
local v_u_2 = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ServerScriptService")
local v4 = game:GetService("ReplicatedStorage")
local v5 = v4:WaitForChild("Packages")
local v_u_6 = require(v5.Net)
local v_u_7 = require(v5.Debounce)
local v_u_8 = require(v4.Packages.FFlags)
require(v4.Packages.Trove)
local v_u_9 = require(v4.Shared.VFX)
local v_u_10
if v_u_2:IsServer() then
    v_u_10 = require(v_u_3.Services.CombatService)
else
    v_u_10 = nil
end
local v_u_11 = {}
local v_u_12 = 0
v_u_2.Heartbeat:Connect(function(p13)
    debug.profilebegin("Items:UpdateHUE")
    v_u_12 = v_u_12 + p13 * 0.2
    if v_u_12 > 1 then
        v_u_12 = v_u_12 - 1
    end
    local v14 = Color3.fromHSV(v_u_12, 1, 1)
    for _, v15 in v_u_11 do
        if v15 and v15.Parent then
            v15.FillColor = v14
        end
    end
    debug.profileend()
end)
local v_u_16, v_u_17, v_u_18, v_u_19
if v_u_2:IsServer() then
    local v20 = v_u_3.Services
    v_u_16 = require(v20.StealService)
    local v21 = v_u_3.ToolsCode
    v_u_17 = v21.AdditionalItems
    v_u_18 = v21.AdditionalScripts
    v_u_19 = v21.AdditionalSounds
else
    v_u_17 = nil
    v_u_18 = nil
    v_u_16 = nil
    v_u_19 = nil
end
local v22 = {
    ["Slap"] = {
        ["Name"] = "Slap",
        ["Icon"] = "rbxassetid://111744314864127",
        ["Cooldown"] = 0.7,
        ["Force"] = 550,
        ["RagdollDuration"] = 3
    },
    ["Iron Slap"] = {
        ["Name"] = "Iron Slap",
        ["Icon"] = "rbxassetid://126416331206871",
        ["Cooldown"] = 0.7,
        ["Force"] = 600,
        ["RagdollDuration"] = 3
    },
    ["Gold Slap"] = {
        ["Name"] = "Gold Slap",
        ["Icon"] = "rbxassetid://73587459668895",
        ["Cooldown"] = 0.7,
        ["Force"] = 650,
        ["RagdollDuration"] = 3
    },
    ["Diamond Slap"] = {
        ["Name"] = "Diamond Slap",
        ["Icon"] = "rbxassetid://103400414014905",
        ["Cooldown"] = 0.7,
        ["Force"] = 700,
        ["RagdollDuration"] = 3
    },
    ["Emerald Slap"] = {
        ["Name"] = "Emerald Slap",
        ["Icon"] = "rbxassetid://125486072175077",
        ["Cooldown"] = 0.7,
        ["Force"] = 750,
        ["RagdollDuration"] = 3
    },
    ["Ruby Slap"] = {
        ["Name"] = "Ruby Slap",
        ["Icon"] = "rbxassetid://135484448648993",
        ["Cooldown"] = 0.7,
        ["Force"] = 800,
        ["RagdollDuration"] = 3
    }
}
local v23 = {
    ["Name"] = "Blackhole Slap",
    ["Icon"] = "rbxassetid://78729379185611",
    ["Cooldown"] = 0.7,
    ["Force"] = 850,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = false,
    ["HighlightConfig"] = {
        ["FillColor"] = Color3.fromRGB(255, 0, 0),
        ["FillTransparency"] = 0.5
    }
}
v22["Blackhole Slap"] = v23
local v24 = {
    ["Name"] = "Flame Slap",
    ["Icon"] = "rbxassetid://107751993012682",
    ["Cooldown"] = 0.7,
    ["Force"] = 850,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true,
    ["HighlightConfig"] = {
        ["OutlineColor"] = Color3.fromRGB(),
        ["OutlineTransparency"] = 0
    }
}
v22["Flame Slap"] = v24
local v25 = {
    ["Name"] = "Dark Matter Slap",
    ["Icon"] = "rbxassetid://116359699709899",
    ["Cooldown"] = 0.7,
    ["Force"] = 900,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true,
    ["HighlightConfig"] = {
        ["FillTransparency"] = 0.9,
        ["OutlineTransparency"] = 0
    }
}
v22["Dark Matter Slap"] = v25
local v26 = {
    ["Name"] = "Nuclear Slap",
    ["Icon"] = "rbxassetid://94800671695541",
    ["Cooldown"] = 0.7,
    ["Force"] = 950,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true,
    ["HighlightConfig"] = {
        ["OutlineColor"] = Color3.fromRGB(234, 255, 0),
        ["OutilineTransparency"] = 0
    }
}
v22["Nuclear Slap"] = v26
v22["Galaxy Slap"] = {
    ["Name"] = "Galaxy Slap",
    ["Icon"] = "rbxassetid://79582982176990",
    ["Cooldown"] = 0.7,
    ["Force"] = 1050,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true
}
local v27 = {
    ["Name"] = "Bloodmoon Slap",
    ["Icon"] = "rbxassetid://105241258528205",
    ["Cooldown"] = 0.7,
    ["Force"] = 1050,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true,
    ["HighlightConfig"] = {
        ["FillTransparency"] = 0.9,
        ["OutlineTransparency"] = 0
    }
}
v22["Bloodmoon Slap"] = v27
v22["Glitched Slap"] = {
    ["Name"] = "Glitched Slap",
    ["Icon"] = "rbxassetid://87821905406599",
    ["Cooldown"] = 0.7,
    ["Force"] = 1150,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true
}
v22["Rainbow Slap"] = {
    ["Name"] = "Rainbow Slap",
    ["Icon"] = "rbxassetid://76888105480836",
    ["Cooldown"] = 0.7,
    ["Force"] = 1150,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true
}
v22["Candy Slap"] = {
    ["Name"] = "Candy Slap",
    ["Icon"] = "rbxassetid://116411677446062",
    ["Cooldown"] = 0.7,
    ["Force"] = 1200,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true
}
v22["Lava Slap"] = {
    ["Name"] = "Lava Slap",
    ["Icon"] = "rbxassetid://80560167115825",
    ["Cooldown"] = 0.7,
    ["Force"] = 1200,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true
}
v22["Splatter Slap"] = {
    ["Name"] = "Splatter Slap",
    ["Icon"] = "rbxassetid://88294870214352",
    ["Cooldown"] = 0.7,
    ["Force"] = 1200,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true,
    ["OnHit"] = function(p28)
        if v_u_2:IsServer() then
            v_u_6:RemoteEvent("UseItem"):FireClient(p28, "PaintballHitted", 9)
        end
    end
}
v22["Alien Slap"] = {
    ["Name"] = "Alien Slap",
    ["Icon"] = "rbxassetid://89070555394271",
    ["Cooldown"] = 0.7,
    ["Force"] = 1250,
    ["RagdollDuration"] = 5,
    ["HasHighlight"] = true,
    ["OnHit"] = function(p_u_29, p_u_30)
        local v31 = script:FindFirstChild("AlienSlap")
        if not v31 then
            return
        end
        local v32 = p_u_30:FindFirstChild("HumanoidRootPart")
        local v33
        if v32 then
            v33 = v32:FindFirstChild("RootAttachment")
        else
            v33 = v32
        end
        if not (v32 and (p_u_30:FindFirstChildOfClass("Humanoid") and v33)) then
            return
        end
        task.wait(1)
        local v34 = os.clock()
        local v35 = 0
        local function v40(p36)
            local v37 = RaycastParams.new()
            v37.FilterType = Enum.RaycastFilterType.Exclude
            v37.FilterDescendantsInstances = { p_u_30 }
            local v38 = p36 + Vector3.new(0, 3, 0)
            local v39 = workspace:Raycast(v38, Vector3.new(0, -20, 0), v37)
            if v39 then
                return v39.Position
            else
                return p36 - Vector3.new(0, 3, 0)
            end
        end
        while true do
            while true do
                if os.clock() - v34 >= 5 then
                    if v35 >= 0.3 then
                        local v_u_41 = {}
                        for v42 = 1, 4 do
                            local v43 = v42 / 4 * 3.141592653589793 * 2
                            local v44 = math.cos(v43)
                            local v45 = math.sin(v43)
                            local v46 = Vector3.new(v44, 0, v45) * 5
                            local v47 = v40(v32.Position + v46)
                            local v48 = v31:FindFirstChild("florPart")
                            if v48 then
                                local v49 = v48:Clone()
                                v49.Anchored = true
                                v49.CFrame = CFrame.new(v47)
                                v49.Parent = workspace
                                table.insert(v_u_41, v49)
                            end
                        end
                        v40(v32.Position)
                        local v50 = v31:FindFirstChild("Part")
                        local v_u_51
                        if v50 then
                            v_u_51 = v50["002"]:Clone()
                            v_u_51.WorldCFrame = v33.WorldCFrame
                            v_u_51.CFrame = v33.CFrame
                            v_u_51.Parent = v33
                            for _, v52 in v_u_41 do
                                for _, v53 in v52["001"]:GetChildren() do
                                    if v53:IsA("Beam") then
                                        v53.Attachment0 = v52["001"]
                                        v53.Attachment1 = v_u_51
                                    end
                                end
                            end
                        else
                            v_u_51 = nil
                        end
                        local v54 = v_u_19["Alien slap"]:Clone()
                        v54.Parent = v32
                        v54:Play()
                        p_u_29:SetAttribute("Freeze", true)
                        task.delay(3, function()
                            if v_u_51 and v_u_51.Parent then
                                v_u_51:Destroy()
                            end
                            for _, v55 in v_u_41 do
                                if v55 and v55.Parent then
                                    v55:Destroy()
                                end
                            end
                            p_u_29:SetAttribute("Freeze", false)
                        end)
                    end
                end
                local v56 = v32.AssemblyLinearVelocity.Y
                if math.abs(v56) >= 1.5 then
                    break
                end
                local v57 = v32.AssemblyLinearVelocity
                local v58 = v57.X
                local v59 = v57.Z
                local v60
                if Vector3.new(v58, 0, v59).Magnitude < 1 then
                    local v61 = v32.AssemblyLinearVelocity.Y
                    v60 = math.abs(v61) < 1.5
                else
                    v60 = false
                end
                v35 = v35 + task.wait(0.05)
                if v35 >= 0.3 then
                    break
                end
            end
            task.wait(0.05)
            v35 = 0
        end
    end
}
local v93 = {
    ["Name"] = "Yin Yang Slap",
    ["Icon"] = "rbxassetid://72523518394942",
    ["Cooldown"] = 0.7,
    ["Force"] = 1260,
    ["RagdollDuration"] = 6,
    ["HasHighlight"] = true,
    ["HighlightConfig"] = {
        ["FillTransparency"] = 1,
        ["OutlineTransparency"] = 0,
        ["OutlineColor"] = Color3.fromRGB(255, 0, 0)
    },
    ["OnHit"] = function(_, p_u_62)
        local v63 = script.YinYangSlap
        local v64 = p_u_62:FindFirstChild("HumanoidRootPart")
        local v65
        if v64 then
            v65 = v64:FindFirstChild("RootAttachment")
        else
            v65 = v64
        end
        if not (v64 and (p_u_62:FindFirstChildOfClass("Humanoid") and v65)) then
            return
        end
        local function v70(p66)
            local v67 = RaycastParams.new()
            v67.FilterType = Enum.RaycastFilterType.Exclude
            v67.FilterDescendantsInstances = { p_u_62 }
            local v68 = p66 + Vector3.new(0, 3, 0)
            local v69 = workspace:Raycast(v68, Vector3.new(0, -20, 0), v67)
            if v69 then
                return v69.Position
            else
                return p66 - Vector3.new(0, 3, 0)
            end
        end
        task.wait(1)
        local v_u_71 = p_u_62:FindFirstChildOfClass("Shirt")
        if v_u_71 then
            v_u_71.Parent = nil
        end
        local v_u_72 = p_u_62:FindFirstChildOfClass("Pants")
        if v_u_72 then
            v_u_72.Parent = nil
        end
        local v73 = {}
        local v_u_74 = {}
        for _, v75 in p_u_62:GetChildren() do
            local v76
            if v75:IsA("Accessory") or v75:IsA("Tool") then
                v76 = false
            else
                v76 = v75:IsA("BasePart") and v75.Name ~= "HumanoidRootPart" and true or false
            end
            if v76 then
                table.insert(v73, v75)
                local v77 = {
                    ["part"] = v75,
                    ["color"] = v75.Color
                }
                table.insert(v_u_74, v77)
            end
        end
        for _, v78 in v73 do
            v78.Color = math.random(1, 2) == 1 and Color3.fromRGB() or Color3.fromRGB(255, 255, 255)
        end
        local v79 = p_u_62:FindFirstChild("Head")
        if v79 then
            local v80 = v63.SleepVFX.SLEEPY_VFX_ATTACHMENT:Clone()
            v80.Parent = v79
            v_u_1:AddItem(v80, 6)
        end
        local v81 = os.clock()
        local v82 = 0
        while true do
            while true do
                if os.clock() - v81 >= 5 then
                    if v82 >= 0.3 then
                        local v83 = v70(v64.Position)
                        local v84 = v63:FindFirstChild("yinyang")
                        if v84 then
                            local v85 = v84:Clone()
                            v85.CFrame = CFrame.new(v83)
                            v85.Parent = workspace
                            v_u_1:AddItem(v85, 4)
                        end
                        task.delay(4, function()
                            for _, v86 in v_u_74 do
                                if v86.part and v86.part.Parent then
                                    v86.part.Color = v86.color
                                end
                            end
                            if v_u_71 then
                                v_u_71.Parent = p_u_62
                            end
                            if v_u_72 then
                                v_u_72.Parent = p_u_62
                            end
                        end)
                    end
                end
                local v87 = v64.AssemblyLinearVelocity.Y
                if math.abs(v87) >= 1.5 then
                    break
                end
                local v88 = v64.AssemblyLinearVelocity
                local v89 = v88.X
                local v90 = v88.Z
                local v91
                if Vector3.new(v89, 0, v90).Magnitude < 1 then
                    local v92 = v64.AssemblyLinearVelocity.Y
                    v91 = math.abs(v92) < 1.5
                else
                    v91 = false
                end

                v82 = v82 + task.wait(0.05)
                if v82 >= 0.3 then
                    break
                end
            end
            task.wait(0.05)
            v82 = 0
        end
    end
}
v22["Yin Yang Slap"] = v93
local v99 = {
    ["Name"] = "Radioactive Slap",
    ["Icon"] = "rbxassetid://134911999156077",
    ["Cooldown"] = 0.7,
    ["Force"] = 1200,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true,
    ["HighlightConfig"] = {
        ["FillTransparency"] = 1,
        ["OutlineTransparency"] = 0,
        ["OutlineColor"] = Color3.fromRGB(0, 255, 0)
    },
    ["OnHit"] = function(p_u_94, p95, p_u_96)
        if p95:FindFirstChildOfClass("Humanoid") and p95:FindFirstChild("HumanoidRootPart") then
            local v_u_97 = Instance.new("Highlight")
            v_u_97.DepthMode = Enum.HighlightDepthMode.Occluded
            v_u_97.FillColor = Color3.fromRGB(0, 255, 0)
            v_u_97.FillTransparency = 0.5
            v_u_97.OutlineColor = Color3.fromRGB(75, 155, 0)
            v_u_97.OutlineTransparency = 0
            v_u_97.Adornee = p95
            v_u_97.Parent = p95
            task.delay(5, function()
                if v_u_2:IsServer() then
                    local v98 = {
                        ["Tag"] = "Radioactive Slap",
                        ["Player"] = p_u_96
                    }
                    v_u_10:ApplyImpulse(p_u_94, 500, Vector3.new(), true, 3, true, v98)
                end
            end)
            task.delay(8, function()
                v_u_97:Destroy()
            end)
        end
    end
}
v22["Radioactive Slap"] = v99
local v109 = {
    ["Name"] = "Cursed Slap",
    ["Icon"] = "rbxassetid://101392764194646",
    ["Cooldown"] = 0.7,
    ["Force"] = 1300,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true,
    ["HighlightConfig"] = {
        ["FillTransparency"] = 1,
        ["OutlineTransparency"] = 0,
        ["OutlineColor"] = Color3.fromRGB(255, 23, 23)
    },
    ["OnHit"] = function(p_u_100, p101, p_u_102)
        local v103 = p101:FindFirstChildOfClass("Humanoid")
        local v_u_104 = p101:FindFirstChild("HumanoidRootPart")
        if v103 and v_u_104 then
            local v_u_105 = Instance.new("Highlight")
            v_u_105.DepthMode = Enum.HighlightDepthMode.Occluded
            v_u_105.FillColor = Color3.fromRGB(255, 23, 23)
            v_u_105.FillTransparency = 0.5
            v_u_105.OutlineColor = Color3.fromRGB(155, 0, 0)
            v_u_105.OutlineTransparency = 0
            v_u_105.Adornee = p101
            v_u_105.Parent = p101
            local v_u_106 = require(v_u_3.Services.ItemService.Demon)
            task.delay(1, function()
                local v107 = os.clock()
                while os.clock() - v107 < 5 do
                    local v108 = p_u_100:GetAttribute("RagdollEndTime")
                    if not v108 or v108 < workspace:GetServerTimeNow() then
                        break
                    end
                    task.wait(0.5)
                end
                task.wait(0.3)
                v_u_106.FreezePlayer(p_u_100, v_u_104, p_u_102, 4)
                v_u_105:Destroy()
            end)
        end
    end
}
v22["Cursed Slap"] = v109
local v125 = {
    ["Name"] = "Divine Slap",
    ["Icon"] = "rbxassetid://107787439485133",
    ["Cooldown"] = 0.7,
    ["Force"] = 1400,
    ["RagdollDuration"] = 3,
    ["HasHighlight"] = true,
    ["HighlightConfig"] = {
        ["FillTransparency"] = 1,
        ["OutlineTransparency"] = 0,
        ["OutlineColor"] = Color3.fromRGB(255, 240, 23)
    },
    ["OnHit"] = function(p_u_110, p_u_111, _, _)
        local v112 = p_u_111:FindFirstChildOfClass("Humanoid")
        local v_u_113 = p_u_111:FindFirstChild("HumanoidRootPart")
        local v_u_114 = p_u_111:FindFirstChild("UpperTorso")
        if v112 and (v_u_113 and v_u_114) then
            local v_u_115 = Instance.new("Highlight")
            v_u_115.DepthMode = Enum.HighlightDepthMode.Occluded
            v_u_115.FillColor = Color3.fromRGB(251, 255, 23)
            v_u_115.FillTransparency = 0.85
            v_u_115.OutlineColor = Color3.fromRGB(155, 150, 0)
            v_u_115.OutlineTransparency = 0
            v_u_115.Adornee = p_u_111
            v_u_115.Parent = p_u_111
            task.delay(1, function()
                local v116 = os.clock()
                while os.clock() - v116 < 5 do
                    local v117 = p_u_110:GetAttribute("RagdollEndTime")
                    if not v117 or workspace:GetServerTimeNow() > v117 - 0.1 then
                        break
                    end
                    task.wait(0.1)
                end
                local v118 = v_u_8:GetInstant("DivineSlap/Delay", 1.7)
                local v_u_119 = v_u_8:GetInstant("DivineSlap/ExtraRagdollTime", 0.9)
                p_u_110:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow() + v118 + v_u_119)
                local v_u_120 = script.DivineSlap.TEMP_Halo:Clone()
                v_u_120.Parent = p_u_111
                local v_u_121 = script.DivineSlap.HitEffect:Clone()
                v_u_9.emit(v_u_121)
                local v122 = Instance.new("Weld")
                v122.Part0 = v_u_121
                v122.Part1 = v_u_114
                v122.Parent = v_u_121
                v_u_121.Parent = v_u_114
                local v_u_123 = Instance.new("LinearVelocity")
                v_u_123.Name = "FloatVelocity"
                v_u_123.Attachment0 = v_u_113:FindFirstChildOfClass("Attachment")
                v_u_123.RelativeTo = Enum.ActuatorRelativeTo.World
                local v124 = v_u_8:GetInstant("DivineSlap/UpwardsForce", 20)
                v_u_123.VectorVelocity = Vector3.new(0, v124, 0)
                v_u_123.MaxForce = 1000000000
                v_u_123.Parent = v_u_113
                task.delay(v_u_8:GetInstant("DivineSlap/Delay", v118), function()
                    v_u_123:Destroy()
                    task.wait(v_u_119)
                    v_u_115:Destroy()
                    v_u_120:Destroy()
                    task.wait(2)
                    v_u_121:Destroy()
                end)
            end)
        end
    end
}
v22["Divine Slap"] = v125
v22["Overseer Mace"] = {
    ["Icon"] = "rbxassetid://900731150",
    ["Range"] = Vector3.new(12, 12, 12),
    ["Name"] = "Overseer Mace",
    ["RagdollDuration"] = 3,
    ["Cooldown"] = 0.8,
    ["Force"] = 1000,
    ["OnHit"] = function(p126, p127, p128)
        if p127:FindFirstChildOfClass("Humanoid") and p127:FindFirstChild("HumanoidRootPart") then
            task.wait(3)
            local v129 = 1
            for _ = 1, 10 do
                v129 = v129 - 0.1
                p126:SetAttribute("DivideSpeedBy", v129)
                task.wait(0.6)
            end
            p126:SetAttribute("DivideSpeedBy", nil)
            if v_u_2:IsServer() then
                v_u_10:ApplyImpulse(p126, 500, Vector3.new(), true, 3, true, {
                    ["Tag"] = "Item.Overseer Mace",
                    ["Player"] = p128
                })
                p126:SetAttribute("DivideSpeedBy", nil)
            end
        end
    end
}
v22["Bambu Runcing"] = {
    ["Name"] = "Bambu Runcing",
    ["Icon"] = "rbxassetid://0",
    ["Cooldown"] = 0.8,
    ["Force"] = 1250,
    ["RagdollDuration"] = 3,
    ["Range"] = Vector3.new(25, 25, 25)
}
v22["Sapu Lidi"] = {
    ["Name"] = "Bambu Runcing",
    ["Icon"] = "rbxassetid://0",
    ["Cooldown"] = 0.8,
    ["Force"] = 1200,
    ["RagdollDuration"] = 3,
    ["Range"] = Vector3.new(30, 9, 9)
}
v22["Fire Hand"] = {
    ["Name"] = "Fire Hand",
    ["Icon"] = "http://www.roblox.com/asset/?id=37241858",
    ["Cooldown"] = 0.5,
    ["Force"] = 1000,
    ["RagdollDuration"] = 4,
    ["OnHit"] = function(_, p130)
        local v131 = v_u_2:IsServer() and p130:FindFirstChild("HumanoidRootPart")
        if v131 then
            local v_u_132 = script.Fire.fireOnStep:Clone()
            v_u_132.Parent = v131
            task.delay(4, function()
                v_u_132:Destroy()
            end)
        end
    end
}
v22["Steampunk Glove"] = {
    ["Name"] = "Steampunk Glove",
    ["Icon"] = "rbxassetid://243184138",
    ["Cooldown"] = 0.7,
    ["Force"] = 1500,
    ["RagdollDuration"] = 3
}
v22["Ban Hammer"] = {
    ["Name"] = "Ban Hammer",
    ["Icon"] = "rbxassetid://102903994473061",
    ["Cooldown"] = 0.7,
    ["Force"] = 900,
    ["RagdollDuration"] = 3,
    ["HasParticles"] = function(p133, p134)
        local v_u_135 = Instance.new("Part")
        v_u_135.CanCollide = false
        v_u_135.Size = Vector3.new(1, 1, 1)
        v_u_135.Anchored = false
        v_u_135.Transparency = 1
        v_u_135.CFrame = p133.CFrame * CFrame.new(0, 0.4, -3)
        v_u_135.Parent = workspace
        local v_u_136 = Instance.new("WeldConstraint")
        v_u_136.Part0 = p133
        v_u_136.Part1 = v_u_135
        v_u_136.Parent = v_u_135
        local v_u_137 = p134.Handle.Attachment:Clone()
        v_u_137.Parent = v_u_135
        v_u_137.ParticleEmitter:Emit(2)
        task.delay(1, function()
            if v_u_135 then
                v_u_135:Destroy()
            end
            if v_u_136 then
                v_u_136:Destroy()
            end
            if v_u_137 then
                v_u_137:Destroy()
            end
        end)
    end
}
v22["Bloodmoon Hammer"] = {
    ["Name"] = "Bloodmoon Hammer",
    ["Icon"] = "rbxassetid://96284196754755",
    ["Cooldown"] = 0.7,
    ["Force"] = 900,
    ["RagdollDuration"] = 6,
    ["HasParticles"] = function(p138, p139)
        local v_u_140 = Instance.new("Part")
        v_u_140.CanCollide = false
        v_u_140.Size = Vector3.new(1, 1, 1)
        v_u_140.Anchored = false
        v_u_140.Transparency = 1
        v_u_140.CFrame = p138.CFrame * CFrame.new(0, 0.4, -3)
        v_u_140.Parent = workspace
        local v_u_141 = Instance.new("WeldConstraint")
        v_u_141.Part0 = p138
        v_u_141.Part1 = v_u_140
        v_u_141.Parent = v_u_140
        local v_u_142 = p139.Handle.Attachment:Clone()
        v_u_142.Parent = v_u_140
        v_u_142.ParticleEmitter:Emit(2)
        task.delay(1, function()
            if v_u_140 then
                v_u_140:Destroy()
            end
            if v_u_141 then
                v_u_141:Destroy()
            end
            if v_u_142 then
                v_u_142:Destroy()
            end
        end)
    end,
    ["OnHit"] = function(_, p143)
        local v_u_144 = Instance.new("Highlight")
        v_u_144.DepthMode = Enum.HighlightDepthMode.Occluded
        v_u_144.FillColor = Color3.fromRGB(255, 0, 0)
        v_u_144.FillTransparency = 0.5
        v_u_144.OutlineTransparency = 1
        v_u_144.Adornee = p143
        v_u_144.Parent = p143
        task.delay(2.5, function()
            v_u_144:Destroy()
        end)
    end
}
v22["Rainbow Hammer"] = {
    ["Name"] = "Rainbow Hammer",
    ["Icon"] = "rbxassetid://139876541578910",
    ["Cooldown"] = 0.7,
    ["Force"] = 1000,
    ["RagdollDuration"] = 6,
    ["HasParticles"] = function(p145, p146)
        local v_u_147 = Instance.new("Part")
        v_u_147.CanCollide = false
        v_u_147.Size = Vector3.new(1, 1, 1)
        v_u_147.Anchored = false
        v_u_147.Transparency = 1
        v_u_147.CFrame = p145.CFrame * CFrame.new(0, 0.4, -3)
        v_u_147.Parent = workspace
        local v_u_148 = Instance.new("WeldConstraint")
        v_u_148.Part0 = p145
        v_u_148.Part1 = v_u_147
        v_u_148.Parent = v_u_147
        local v_u_149 = p146.Handle.Attachment:Clone()
        v_u_149.Parent = v_u_147
        v_u_149.ParticleEmitter:Emit(2)
        task.delay(1, function()
            if v_u_147 then
                v_u_147:Destroy()
            end
            if v_u_148 then
                v_u_148:Destroy()
            end
            if v_u_149 then
                v_u_149:Destroy()
            end
        end)
    end,
    ["OnHit"] = function(_, p150)
        local v_u_151 = Instance.new("Highlight")
        v_u_151.DepthMode = Enum.HighlightDepthMode.Occluded
        v_u_151.OutlineTransparency = 0
        v_u_151.FillTransparency = 0.5
        v_u_151.Adornee = p150
        v_u_151.Parent = p150
        local v152 = v_u_11
        table.insert(v152, v_u_151)
        task.delay(2.5, function()
            table.remove(v_u_11, table.find(v_u_11, v_u_151))
            v_u_151:Destroy()
        end)
    end
}
v22["Small Tree"] = {
    ["Name"] = "Small Tree",
    ["Icon"] = "rbxassetid://70956898840223",
    ["Cooldown"] = 0.7,
    ["Force"] = 1000,
    ["Range"] = Vector3.new(12, 12, 12),
    ["RagdollDuration"] = 3
}
v22["Medium Tree"] = {
    ["Name"] = "Medium Tree",
    ["Icon"] = "rbxassetid://117374249944925",
    ["Cooldown"] = 0.7,
    ["Force"] = 1100,
    ["Range"] = Vector3.new(14, 14, 14),
    ["RagdollDuration"] = 3
}
v22["Huge Tree"] = {
    ["Name"] = "Huge Tree",
    ["Icon"] = "rbxassetid://114915257709192",
    ["Cooldown"] = 0.7,
    ["Force"] = 1200,
    ["Range"] = Vector3.new(16, 16, 16),
    ["RagdollDuration"] = 3
}
v22["Rainbow Small Tree"] = {
    ["Name"] = "Rainbow Small Tree",
    ["Icon"] = "rbxassetid://136011850681459",
    ["Cooldown"] = 0.7,
    ["Force"] = 1200,
    ["Range"] = Vector3.new(12, 12, 12),
    ["RagdollDuration"] = 3
}
v22["Rainbow Medium Tree"] = {
    ["Name"] = "Rainbow Medium Tree",
    ["Icon"] = "rbxassetid://83546641619026",
    ["Cooldown"] = 0.7,
    ["Force"] = 1300,
    ["Range"] = Vector3.new(14, 14, 14),
    ["RagdollDuration"] = 3
}
v22["Rainbow Huge Tree"] = {
    ["Name"] = "Rainbow Huge Tree",
    ["Icon"] = "rbxassetid://119257172353286",
    ["Cooldown"] = 0.7,
    ["Force"] = 1400,
    ["Range"] = Vector3.new(16, 16, 16),
    ["RagdollDuration"] = 3
}
v22.Bat = {
    ["Name"] = "Bat",
    ["Icon"] = "rbxassetid://86735158693802",
    ["Cooldown"] = 0.7,
    ["Force"] = 500,
    ["RagdollDuration"] = 3
}
v22.Lollipop = {
    ["Name"] = "Lollipop",
    ["Icon"] = "rbxassetid://95336128645462",
    ["Cooldown"] = 0.7,
    ["Force"] = 800,
    ["RagdollDuration"] = 3,
    ["OnHit"] = function(p_u_158, p159)
        local function v164(p160)
            for _, v161 in p160:GetChildren() do
                if v161:IsA("BasePart") then
                    for _, v162 in script.Effect:GetChildren() do
                        local v_u_163 = v162:Clone()
                        v_u_163.Parent = v161
                        task.delay(5, function()
                            v_u_163:Destroy()
                        end)
                    end
                end
            end
        end
        local v165 = p159:FindFirstChildOfClass("Humanoid")
        local v166 = p159:FindFirstChild("HumanoidRootPart")
        if v165 and v166 then
            local v_u_167 = script.BillboardPart.BillboardGui:Clone()
            v_u_167.Parent = v166
            v164(p159)
            p_u_158:SetAttribute("DivideSpeed", true)
            task.delay(5, function()
                p_u_158:SetAttribute("DivideSpeed", nil)
                v_u_167:Destroy()
            end)
            v_u_6:RemoteEvent("UseItem"):FireClient(p_u_158, "CandyEffect", 5)
        end
    end
}
v22["Candy Cane"] = {
    ["Name"] = "Candy Cane",
    ["Icon"] = "rbxassetid://19250774",
    ["Cooldown"] = 0.4,
    ["Force"] = 500,
    ["RagdollDuration"] = 3
}
v22["Gummy Bear"] = {
    ["Name"] = "Gummy Bear",
    ["Icon"] = "rbxassetid://81350787786383",
    ["Cooldown"] = 0.7,
    ["Force"] = 750,
    ["RagdollDuration"] = 3,
    ["OnHit"] = function(p_u_168, p_u_169)
        if v_u_7(("TurnedToGummy/%*/Server"):format(p_u_168.Name), v_u_8:GetInstant("GummyBearStickCooldown", 6.5)) then
            return
        else
            local v170 = v_u_17:FindFirstChild("GummyBear")
            if v170 then
                if v_u_18:FindFirstChild("GummyController") then
                    if p_u_168:GetAttribute("Web") then
                        return
                    else
                        local v171 = p_u_169:FindFirstChild("HumanoidRootPart")
                        if v171 then
                            local v_u_172 = p_u_169:FindFirstChildWhichIsA("Humanoid")
                            if v_u_172 then
                                p_u_169:PivotTo(CFrame.new(p_u_169:GetPivot().Position + Vector3.new(0, 2, 0)))
                                p_u_169:SetAttribute("SpeedAllowance", v_u_8:GetInstant("GummyBearSpeedAllowance", 120))
                                task.wait(v_u_8:GetInstant("GummyBearHitWaitTime", 0.65))
                                p_u_168:SetAttribute("RagdollEndTime", 0)
                                local v_u_173 = v_u_19.GummyBear:Clone()
                                v_u_173.Parent = v171
                                v_u_173:Play()
                                local v_u_174 = p_u_169:FindFirstChildOfClass("Tool")
                                p_u_168:SetAttribute("Web", true)
                                p_u_168:SetAttribute("BlockTools", true)
                                v_u_16:CancelSteal(p_u_168)
                                v_u_172.PlatformStand = true
                                v_u_172:UnequipTools()
                                local v175 = Instance.new("WeldConstraint")
                                v175.Part0 = v171
                                local v_u_176 = v170:Clone()
                                v_u_176:PivotTo(p_u_169:GetPivot())
                                v_u_176.Color = BrickColor.random().Color
                                v_u_176.Parent = workspace
                                for _, v177 in v_u_176:GetDescendants() do
                                    if v177:IsA("BasePart") then
                                        v177:SetNetworkOwner(p_u_168)
                                    end
                                end
                                v175.Part1 = v_u_176
                                v175.Parent = v_u_176
                                p_u_169:SetAttribute("InGummy", true)
                                p_u_168:SetAttribute("NoMouseLockOffset", true)
                                task.delay(v_u_8:GetInstant("GummyBearDuration", 3), function()
                                    v_u_173:Destroy()
                                    v_u_176:Destroy()
                                    v_u_172.PlatformStand = false
                                    p_u_168:SetAttribute("Web", nil)
                                    p_u_168:SetAttribute("BlockTools", nil)
                                    p_u_169:SetAttribute("SpeedAllowance", nil)
                                    p_u_169:SetAttribute("InGummy", nil)
                                    p_u_168:SetAttribute("NoMouseLockOffset", nil)
                                    if v_u_174 and (v_u_174.Parent == p_u_168.Backpack and (not v_u_16:IsStealing(p_u_168) and v_u_172.Health > 0)) then
                                        v_u_172:EquipTool(v_u_174)
                                    end
                                end)
                            end
                        else
                            return
                        end
                    end
                else
                    return
                end
            else
                return
            end
        end
    end
}
v22["Dev Slap"] = {
    ["Name"] = "Dev Slap",
    ["Icon"] = "",
    ["Cooldown"] = 0.7,
    ["Force"] = 5000,
    ["Range"] = Vector3.new(25, 25, 25),
    ["RagdollDuration"] = 5,
    ["HasHighlight"] = true
}
return v22