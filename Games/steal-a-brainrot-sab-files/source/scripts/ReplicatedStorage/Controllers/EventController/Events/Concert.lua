
local u1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("ContentProvider")
game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = game:GetService("Lighting")
local u5 = game:GetService("Players")
require(u1.Shared.EventTypes)
local v6 = {}
local u7 = require(u1.Controllers.EncryptedAssetsController)
local u8 = require(u1.Controllers.EventController.ClientEventUtils)
local u9 = require(u1.Controllers.EffectController)
local u10 = require(u1.Controllers.CameraController)
local u11 = require(u1.Controllers.SoundController)
local u12 = require(u1.Controllers.EventController)
local u13 = require(u1.Controllers.CycleController)
local u14 = require(u1.Packages.CreateTween)
local u15 = require(u1.Packages.Observers)
local u16 = require(u1.Datas.ServerData)
local u17 = require(u1.Utils.MathUtils)
local u18 = require(u1.Packages.Signal)
local u19 = require(u1.Packages.Trove)
local v20 = require(u1.Packages.Net)
local u21 = require(u1.Shared.VFX)
local u22 = u5.LocalPlayer
local u23 = workspace.CurrentCamera
local u24 = script.Name
local u25 = workspace.Sounds.Concert
local u26 = v20:RemoteEvent("EventService/Concert/Shoot")
local u27 = u19.new()
local u28 = nil
function v6.OnStart(_)
    local u29 = u12:GetActiveEventData(u24)
    assert(u29)
    local function u40(p30, u31, u32)
        local function u35()
            local v33 = u31
            local v34 = u29.startedAt + v33 - workspace:GetServerTimeNow()
            return math.max(v34, 0)
        end
        local function v36()
            u32(u35)
        end
        local u37 = nil
        local v38 = u29.startedAt + p30 - workspace:GetServerTimeNow()
        local v39 = math.max(v38, 0)
        if v39 > 0 then
            u37 = task.delay(v39, v36)
        else
            u32(u35)
        end
        return function()
            if u37 and coroutine.status(u37) == "suspended" then
                pcall(task.cancel, u37)
            end
        end
    end
    u27:Add(function()
        u9:Activate("Blink")
        u13:Update()
        u11:UpdateOST()
    end)
    local u41 = u4:FindFirstChild("Atmosphere")
    if u41 then
        u41.Parent = u1
        u27:Add(function()
            u41.Parent = u4
        end)
    end
    u27:Clone(script.Atmosphere).Parent = u4
    local u42 = u4:FindFirstChild("Cartoon")
    if u42 then
        u42.Parent = u1
        u27:Add(function()
            u42.Parent = u4
        end)
    end
    local u43 = nil
    local u44 = u27:Clone(Instance.new("ColorCorrectionEffect"))
    u44.Parent = u23
    local function u171()
        u4.Ambient = Color3.new(0, 0, 0)
        u4.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
        u4.EnvironmentDiffuseScale = 0
        u4.EnvironmentSpecularScale = 0
        u27:Add(function()
            u4.Ambient = Color3.fromRGB(241, 241, 241)
            u4.OutdoorAmbient = Color3.fromRGB(212, 212, 212)
            u4.EnvironmentDiffuseScale = 1
            u4.EnvironmentSpecularScale = 0.5
        end)
        u27:Add(function()
			u25:Stop()
			u1:SetAttribute("ConcertEventMusic", nil)
        end)
        u27:Add(task.spawn(function()
            local v45 = u25
            local v46 = u25.TimePosition
			local v47 = workspace:GetServerTimeNow() - (u29.startedAt + 5)
			u1:SetAttribute("ConcertEventMusic", true)
            v45.TimePosition = math.max(v46, v47)
            u25:Play()
        end))
        local u48 = {
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(255, 128, 0),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(128, 255, 0),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 255, 128),
            Color3.fromRGB(0, 255, 255),
            Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(128, 0, 255),
            Color3.fromRGB(255, 0, 255),
            Color3.fromRGB(255, 0, 128),
            Color3.fromRGB(255, 0, 255),
            Color3.fromRGB(0, 128, 255)
        }
        u27:Clone(script.Night_Sky).Parent = u4
        local v49
        if u16.IsBiggerServer() then
            v49 = u27:Clone(script.StageBigger)
        else
            v49 = u27:Clone(script.Stage)
        end
        local u50
        if u16.IsBiggerServer() then
            u50 = u27:Clone(script.VFXBigger)
        else
            u50 = u27:Clone(script.VFX)
        end
        local u51 = u50.SmokeStage
        u27:Add(u51)
        u51.Parent = workspace
        u50.Parent = v49
        u21.disable(u50)
        local u52 = v49.SpotLights:GetChildren()
        local _ = #u52
        local u53 = {}
        local u54 = {}
        local u55 = {}
        local u56 = {}
        local u57 = {}
        local u58 = {}
        local u59 = {}
        local u60 = {}
        local u61 = false
        local u62 = false
        local u63 = {}
        for _, v64 in u52 do
            u53[v64] = v64:GetPivot()
            u54[v64] = 0
            u55[v64] = 0
            u56[v64] = 25
            v64.Rotate.Neon["1"].LightBeam:Destroy()
            local v65 = script.lightbeambig.Beams:Clone()
            for _, v66 in v65:GetChildren() do
                v66.Attachment0 = v64.Rotate.Neon["1"]
                v66.Attachment1 = v64.Rotate.Neon["2"]
                v66.Parent = v64.Rotate.Neon
                table.insert(u57, v66)
            end
            v65:Destroy()
        end
        v49.Parent = workspace
        u27:Add(u15.observeTag("HideInConcert", function(u67)
            local u68 = u67.Parent
            u67.Parent = script
            return function()
                pcall(function()
                    u67.Parent = u68
                end)
            end
        end, { workspace, script }))
        local u69 = { v49.Rigs.Tralalero, v49.Rigs.Chimpanzini, v49.Rigs.Chimpanzini2 }
        local u70 = {}
        for _, v71 in u69 do
            local v72 = {}
            local v73 = v71.Throw
            local v74 = v71.AnimationController.Animator:LoadAnimation(v73)
            u27:Add(v74, "Stop")
            u27:Add(v74)
            v72.Throw = v74
            local v75 = v71.Shuffle
            local v76 = v71.AnimationController.Animator:LoadAnimation(v75)
            u27:Add(v76, "Stop")
            u27:Add(v76)
            v72.Shuffle = v76
            u70[v71] = v72
        end
        local u77 = u27:Add(Instance.new("Color3Value"))
        u77.Value = Color3.fromRGB(0, 0, 0)
        for _, v78 in u70 do
            v78.Shuffle:Play()
        end
        local u79 = true
        u27:Add(function()
            u79 = false
        end)
		u27:Add(u26.OnClientEvent:Connect(function(p80, u81, u82)
			local v83 = u69[p80] or u69[1]
			if v83 then
				u70[v83].Throw:Play()
				task.wait(0.25)
				if u79 then
					local u84 = v83:FindFirstChild("SHOOT", true).WorldPosition
					task.spawn(function()
						u11:PlaySound(u1.Sounds.Events.Concert.Shoot, u84)
					end)
					local u85 = script.DiscoProjectile:Clone()
					u85.Part.CFrame = CFrame.new(u84)
					u85.Parent = workspace
					local u86 = nil
					u86 = u3.PreRender:Connect(function()
						debug.profilebegin("Concert Disco Shoot")
						local v87 = u8.getAnimalPosition(u81)
						local v88 = u84 + (v87 - u84) * 0.5 + Vector3.new(0, 90, 0)
						local v89 = 1 - (u82 + 3 - workspace:GetServerTimeNow()) / 3
						local v90 = u17.quadBezier(math.clamp(v89, 0, 1), u84, v88, v87)
						u85.Part.CFrame = CFrame.new(v90)
						if v89 >= 1 then
							u86:Disconnect()
							u85:Destroy()
							u8.playBurst(script.DiscoExplosion, u81, { u1.Sounds.Events.Concert.Hit })
							u26:FireServer(p80, u81, u82)
						end
						debug.profileend()
					end)
				end
			else
				return
			end
		end))
        for _, v91 in u57 do
            v91.Enabled = false
        end
        u27:Add((u40(10, 15, function(u92)
            u21.enable(u50)
            local u93 = 1
            local u94 = 0
            local u95 = 0
            local u96 = 0
            local u97 = 0
            local u98 = {}
            local u99 = Color3.new(0, 0, 0)
            local u100 = ColorSequence.new(u99)
            task.delay(u92(), function()
                for _, v101 in u57 do
                    v101.Enabled = true
                end
            end)
            u27:Add(function()
                workspace.Gravity = 196.2
            end)
            u27:Add(u3.PostSimulation:Connect(function(p102)
                debug.profilebegin("Concert:Update")
                workspace.Gravity = 29.429999999999996
                u95 = u95 - p102
                u94 = u94 - p102
                u97 = u97 - p102
                u96 = u96 - p102
                local v103 = u25.TimePosition
                local v104
                if v103 >= 20 and v103 <= 25 then
                    v104 = true
                elseif v103 >= 70 then
                    v104 = v103 <= 94.5
                else
                    v104 = false
                end
                local v105 = (u25.PlaybackLoudness - 100) / 900
                local v106 = math.clamp(v105, 0, 1)
                for _, v107 in u59 do
                    local v108 = v106 / 0.05
                    v107.TimeScale = math.clamp(v108, 1, 2) * u63[v107]
                end
                for _, v109 in u70 do
                    local v110 = v109.Shuffle
                    local v111 = v106 / 0.13
                    v110:AdjustSpeed((math.clamp(v111, 0.5, 1.5)))
                end
                if u43 then
                    local v112 = u43
                    local v113
                    if v104 then
                        v113 = 3
                    else
                        local v114 = v106 / 0.06
                        v113 = math.clamp(v114, 1, 3)
                    end
                    v112:AdjustSpeed(v113)
                end
                local v115
                if v103 >= 70 and v103 <= 94.5 then
                    if v103 >= 85 then
                        v115 = 0.05
                    else
                        local v116 = (v103 - 70) / 12
                        local v117 = math.min(v116, 1)
                        v115 = math.lerp(0.5, 0.2, v117)
                    end
                else
                    v115 = v104 and 0.1 or 0.3
                end
                if (v106 >= 0.11 or v104) and (u96 <= 0 and u92() <= 0) then
                    u96 = v115
                    u93 = u93 % #u48 + 1
                    u14(u77, TweenInfo.new(0.2), {
                        ["Value"] = u48[u93]
                    })
                end
                local v118 = u77.Value
                if v103 >= 94.3 and v103 <= 97.7 then
                    v118 = u99
                end
                local v119 = ColorSequence.new(v118)
                for _, v120 in u58 do
                    local v121
                    if u98[v120] then
                        v121 = u100
                    else
                        v121 = v119
                    end
                    v120.Color = v121
                end
                for _, v122 in u60 do
                    local v123
                    if u98[v122] then
                        v123 = u99
                    else
                        v123 = v118
                    end
                    v122.Color = v123
                end
                local v124
                if v104 then
                    v124 = 1.5
                else
                    local v125 = v106 / 0.25
                    v124 = math.clamp(v125, 0.05, 1)
                end
                local v126 = p102 * v124
                for _, v127 in u52 do
                    local v128 = u55[v127] or 0
                    local v129 = u56[v127] or 0
                    local v130 = (u54[v127] or 0) + v126
                    local v131 = math.clamp(v130, 0, 1)
                    u54[v127] = v131
                    if v131 >= 1 then
                        u54[v127] = 0
                        u55[v127] = v129
                        local v132 = u56
                        v132[v127] = v132[v127] * -1
                    else
                        local v133 = math.lerp(v128, v129, v131)
                        local v134 = math.rad(v133)
                        v127:PivotTo(u53[v127] * CFrame.Angles(0, v134, not u61 and 0 or v134))
                        if u61 then
                            for _, v135 in v127.Rotate.Neon:GetChildren() do
                                if v135.Name == "CustomAttachment_-1" or (v135.Name == "2" or v135.Name == "CustomAttachment_2") then
                                    local v136 = v135.Position.X
                                    local v137 = v131 * 3.141592653589793
                                    local v138 = math.sin(v137) * 100
                                    v135.Position = Vector3.new(v136, v138, 300)
                                end
                            end
                        end
                    end
                end
                if v104 and u95 <= 0 then
                    local v139 = math.random(100, 200)
                    u95 = v139 / 1000
                    local v140 = {}
                    for _, u141 in u57 do
                        v140[u141] = true
                        local v142 = u141.Width0 - 0.5
                        u141.Width0 = math.max(v142, 0.5)
                        local v143 = u141.Width1 - 2.5
                        u141.Width1 = math.max(v143, 1)
                        local v144 = u141.Brightness + 0.5
                        u141.Brightness = math.min(v144, 13)
                        u141.Enabled = false
                        task.delay(math.random(50, v139) / 1000, function()
                            u141.Enabled = true
                        end)
                    end
                    for _, u145 in u58 do
                        if not v140[u145] then
                            u98[u145] = true
                            task.delay(math.random(50, v139) / 1000, function()
                                u98[u145] = nil
                            end)
                        end
                    end
                    for _, u146 in u60 do
                        u98[u146] = true
                        task.delay(math.random(50, v139) / 1000, function()
                            u98[u146] = nil
                        end)
                    end
                end
                if v103 >= 25 and not u62 then
                    u62 = true
                    for _, v147 in u52 do
                        local v148 = v147.Rotate.Neon["1"]
                        local v149 = v147.Rotate.Neon["2"]
                        local v150 = v149:Clone()
                        v150.Name = "CustomAttachment_1"
                        v150.Parent = v147.Rotate.Neon
                        u14(v149, TweenInfo.new(5), {
                            ["Position"] = v149.Position + Vector3.new(15, 0, 0)
                        })
                        u14(v150, TweenInfo.new(5), {
                            ["Position"] = v149.Position - Vector3.new(15, 0, 0)
                        })
                        local v151 = script.lightbeambig.Beams:Clone()
                        for _, v152 in v151:GetChildren() do
                            v152.Width0 = 0.5
                            v152.Width1 = 1
                            v152.Brightness = 13
                            v152.Attachment0 = v148
                            v152.Attachment1 = v150
                            v152.Parent = v147.Rotate.Neon
                            local v153 = u57
                            table.insert(v153, v152)
                            local v154 = u58
                            table.insert(v154, v152)
                        end
                        v151:Destroy()
                    end
                end
                if v103 >= 71 and not u61 then
                    u21.enable(u51)
                    task.delay(5, function()
                        u21.disable(u51)
                    end)
                    u61 = true
                    for _, v155 in u52 do
                        local v156 = v155.Rotate.Neon["1"]
                        local v157 = v155.Rotate.Neon["2"]
                        local v158 = v157.Position - Vector3.new(15, 0, 0)
                        u14(v157, TweenInfo.new(5), {
                            ["Position"] = v158
                        })
                        for v159 = -2, 2 do
                            if v159 ~= 0 then
                                local v160 = v157:Clone()
                                v160.Name = ("CustomAttachment_%*"):format(v159)
                                v160.Parent = v155.Rotate.Neon
                                local v161 = u14
                                local v162 = TweenInfo.new(5)
                                local v163 = {}
                                local v164 = v159 * 30
                                v163.Position = v158 + Vector3.new(v164, 0, 0)
                                v161(v160, v162, v163)
                                local v165 = script.lightbeambig.Beams:Clone()
                                for _, v166 in v165:GetChildren() do
                                    v166.Width0 = 0.5
                                    v166.Width1 = 1
                                    v166.Brightness = 13
                                    v166.Attachment0 = v156
                                    v166.Attachment1 = v160
                                    v166.Parent = v155.Rotate.Neon
                                    local v167 = u57
                                    table.insert(v167, v166)
                                    local v168 = u58
                                    table.insert(v168, v166)
                                end
                                v165:Destroy()
                            end
                        end
                    end
                end
                if (v106 >= 0.2 or v104) and u94 <= 0 then
                    u94 = v104 and 0.2 or 0.1
                    u10:Fov((v106 - 0.2) * 15 + 70, 0.1)
                end
                debug.profileend()
            end))
        end)))
        for _, v169 in v49:GetDescendants() do
            if v169:IsA("BasePart") and v169.Name == "Neon" or v169:IsA("SpotLight") then
                table.insert(u60, v169)
            elseif v169:IsA("ParticleEmitter") or v169:IsA("Beam") then
                table.insert(u58, v169)
                if v169:IsA("ParticleEmitter") then
                    u63[v169] = v169.TimeScale
                    table.insert(u59, v169)
                end
            end
        end
        u27:Add((u40(10, 15, function(p170)
            u14(u77, TweenInfo.new(p170()), {
                ["Value"] = u48[1]
            })
        end)))
    end
    u27:Add((u40(0, 5, function(p172)
        u14(u44, TweenInfo.new(p172(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["Brightness"] = -1.2
        })
        task.delay(p172(), u171)
        u9:Run("ConcertEvent", "GrassRecolor")
        u27:Add(function()
            u9:Stop("ConcertEvent", "GrassRecolor")
        end)
        u9:Run("ConcertEvent", "WallRecolor")
        u27:Add(function()
            u9:Stop("ConcertEvent", "WallRecolor")
        end)
        u9:Run("ConcertEvent", "WallBottomRecolor")
        u27:Add(function()
            u9:Stop("ConcertEvent", "WallBottomRecolor")
        end)
    end)))
    u27:Add((u40(10, 15, function(p173)
        u14(u44, TweenInfo.new(p173(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["Brightness"] = -0.05
        })
    end)))
    local v174 = u27
    local v175 = task.delay
    local v176 = u29.startedAt + 24.5 - workspace:GetServerTimeNow()
    v174:Add(v175(math.max(v176, 0), function()
        u27:Add(u18.new())
        u27:Add(u15.observeCharacter(u5.LocalPlayer, function(_, u177)
            local u178 = u19.new()
            u178:Add(task.spawn(function()
                local u179 = u177:WaitForChild("Humanoid")
                if u179 then
                    local v180 = u179:WaitForChild("Animator")
                    if v180 then
                        local u181 = v180:LoadAnimation(script.Dance)
                        u181.Priority = Enum.AnimationPriority.Action
                        u43 = u181
                        local u182 = 0
                        u178:Add(u3.PostSimulation:Connect(function(p183)
                            debug.profilebegin("Concert:Player:Dance")
                            workspace:GetServerTimeNow()
                            local v184 = u29.startedAt + 84.5 - workspace:GetServerTimeNow()
                            if math.max(v184, 0) > 0 then
                                if not u181.IsPlaying then
                                    u181:Play()
                                end
                                debug.profileend()
                            else
                                if u179.MoveDirection ~= Vector3.new(0, 0, 0) or u22:GetAttribute("Stealing") then
                                    u182 = 0
                                    if u181.IsPlaying then
                                        u181:Stop()
                                    end
                                elseif u182 < 3 then
                                    u182 = u182 + p183
                                elseif not u181.IsPlaying then
                                    u181:Play()
                                end
                                debug.profileend()
                            end
                        end))
                        u178:Add(function()
                            u181:Stop()
                            u181:Destroy()
                            u43 = nil
                        end)
                    end
                else
                    return
                end
            end))
            return u178:WrapClean()
        end))
    end))
    u13:Update()
    u11:UpdateOST()
end
function v6.OnStop(_)
    u27:Destroy()
    u28 = nil
end
function v6.OnLoad(_)
    task.spawn(function()
        u2:PreloadAsync(script:GetChildren())
    end)
    task.spawn(function()
        u2:PreloadAsync({ u25 })
    end)
end
return v6