-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):

local u1 = game.Players.LocalPlayer
local u2 = script.Parent.Parent
local u3 = u2:WaitForChild("Progress")
local u4 = u2:WaitForChild("Main"):WaitForChild("Prompt", 10)
local v5 = u2:WaitForChild("Remotes")
local u6 = v5:WaitForChild("RE")
local u7 = v5:WaitForChild("RF")
local u8 = require(game.ReplicatedStorage.Modules.Util)
local u9 = require(game.ReplicatedStorage.Modules.Sounds)
local u10 = nil
local u11 = {}
local u12 = {}
local u13 = nil
local u14 = false
local u15 = {
    ["Center"] = {
        ["Crouch"] = "rbxassetid://98236095796453",
        ["GetUp"] = "rbxassetid://73366656069996",
        ["FixingLoop"] = "rbxassetid://116787193763192",
        ["MissSkillCheck"] = "rbxassetid://123764169071995"
    },
    ["Left"] = {
        ["Crouch"] = "rbxassetid://88097739509103",
        ["GetUp"] = "rbxassetid://105295276078262",
        ["FixingLoop"] = "rbxassetid://106362304435190",
        ["MissSkillCheck"] = "rbxassetid://71238970074155"
    },
    ["Right"] = {
        ["Crouch"] = "rbxassetid://117746129818102",
        ["GetUp"] = "rbxassetid://105699866498264",
        ["FixingLoop"] = "rbxassetid://88166658847908",
        ["MissSkillCheck"] = "rbxassetid://129496766476934"
    }
}
task.spawn(function() --[[Anonymous function at line 47]]
    --[[
    Upvalues:
        [1] = u15
    --]]
    local v16 = {}
    for _, v17 in pairs(u15) do
        for _, v18 in pairs(v17) do
            table.insert(v16, v18)
        end
    end
    game.ContentProvider:PreloadAsync(v16)
end)
local function u22(p19) --[[Anonymous function at line 58]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v20 = u1.PlayerGui.TemporaryUI:FindFirstChild("GeneratorWarning")
    if v20 then
        v20:Destroy()
    end
    local u21 = script.Warning:Clone()
    u21.Name = "GeneratorWarning"
    u21.Title.Text = tostring(p19)
    u21.Parent = u1.PlayerGui.TemporaryUI
    local _ = u21.Size
    u21.Size = u21.Size + UDim2.fromScale(0.025, 0.01)
    game.TweenService:Create(u21, TweenInfo.new(0.35), {
        ["Size"] = u21.Size
    }):Play()
    task.delay(3, function() --[[Anonymous function at line 75]]
        --[[
        Upvalues:
            [1] = u21
        --]]
        if u21.Parent then
            game.Debris:AddItem(u21, 1)
            game.TweenService:Create(u21, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["BackgroundTransparency"] = 1
            }):Play()
            game.TweenService:Create(u21.Title, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["TextTransparency"] = 1,
                ["TextStrokeTransparency"] = 1,
                ["BackgroundTransparency"] = 1
            }):Play()
        end
    end)
end
local function u28(p23) --[[Anonymous function at line 84]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u4
        [3] = u9
        [4] = u2
        [5] = u10
        [6] = u13
        [7] = u11
        [8] = u12
        [9] = u1
    --]]
    u14 = false
    if u4 then
        u4.Enabled = true
    end
    if p23 then
        u9:Play("puzzlesDone", {
            ["Parent"] = u2.PrimaryPart
        })
    end
    if u10 then
        u10:endGame()
    end
    if u13 then
        game.Debris:AddItem(u13, 0.4)
        game.TweenService:Create(u13.Background, TweenInfo.new(0.4), {
            ["BackgroundTransparency"] = 1
        }):Play()
        for _, v24 in pairs(u13:GetDescendants()) do
            if v24:IsA("ImageLabel") then
                game.TweenService:Create(v24, TweenInfo.new(0.3), {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end
        if p23 then
            task.spawn(function() --[[Anonymous function at line 105]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                game.TweenService:Create(u13.Background.BarHolder.Bar.Clipping, TweenInfo.new(0.2), {
                    ["Size"] = UDim2.fromScale(1, 1)
                }):Play()
                game.TweenService:Create(u13.Background.BarHolder.Bar.Clipping.Top, TweenInfo.new(0.2), {
                    ["Size"] = UDim2.fromScale(1, 1)
                }):Play()
            end)
        end
    end
    for _, v25 in pairs(u11) do
        v25:Disconnect()
    end
    table.clear(u11)
    for _, v26 in pairs(u12) do
        v26:Stop()
    end
    local _ = u12.GetUp
    table.clear(u12)
    local v27 = u1.Character
    if v27 then
        v27 = u1.Character:FindFirstChild("SpeedMultipliers")
    end
    if v27 then
        v27 = v27:FindFirstChild("FixingGenerator")
    end
    if v27 then
        print("stopped fixing")
        v27:Destroy()
    end
end
local function u60(p29, u30) --[[Anonymous function at line 133]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u14
        [3] = u4
        [4] = u15
        [5] = u12
        [6] = u8
        [7] = u2
        [8] = u10
        [9] = u13
        [10] = u3
        [11] = u11
        [12] = u6
        [13] = u9
        [14] = u28
    --]]
    local v31 = u1.Character
    if v31 then
        if v31.PrimaryPart then
            local u32 = v31:FindFirstChild("Humanoid")
            if u32 then
                if u30 then
                    if u30.Parent then
                        u14 = true
                        if u4 then
                            u4.Enabled = false
                        end
                        local v33 = u15[p29.Name] or u15.Center
                        for v34, v35 in pairs(v33) do
                            u12[v34] = u8:LoadAnimationFromID(u1.Character, v35, false)
                        end
                        u12.Crouch:Play(0)
                        u12.FixingLoop:Play()
                        local u36 = u2:GetAttribute("Size")
                        u10 = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager)
                        u10:startGame(u36)
                        if u13 then
                            u13:Destroy()
                        end
                        u13 = script.BackgroundUI:Clone()
                        u13.Parent = u1.PlayerGui:FindFirstChild("TemporaryUI")
                        game.TweenService:Create(u13.Background, TweenInfo.new(0.4), {
                            ["BackgroundTransparency"] = 0.75
                        }):Play()
                        if not game.Players.LocalPlayer:GetAttribute("CompletedGenPuzzle") then
                            u13.Background.Position = UDim2.fromScale(0.5, 0.55)
                        end
                        for _, v37 in pairs(u13:GetDescendants()) do
                            if v37:IsA("ImageLabel") then
                                local v38 = v37.ImageTransparency
                                v37.ImageTransparency = 1
                                game.TweenService:Create(v37, TweenInfo.new(0.4), {
                                    ["ImageTransparency"] = v38
                                }):Play()
                            end
                        end
                        local function v43(p39) --[[Anonymous function at line 180]]
                            --[[
                            Upvalues:
                                [1] = u13
                                [2] = u3
                            --]]
                            if u13.Parent then
                                local v40 = u3.Value / 100
                                local v41 = math.clamp(v40, 0, 1)
                                local v42 = v41 == 0 and 0 or 1 / v41
                                if p39 == true then
                                    u13.Background.BarHolder.Bar.Clipping.Size = UDim2.fromScale(1, v41)
                                    u13.Background.BarHolder.Bar.Clipping.Top.Size = UDim2.fromScale(1, v42)
                                    return
                                end
                                game.TweenService:Create(u13.Background.BarHolder.Bar.Clipping, TweenInfo.new(0.2), {
                                    ["Size"] = UDim2.fromScale(1, v41)
                                }):Play()
                                game.TweenService:Create(u13.Background.BarHolder.Bar.Clipping.Top, TweenInfo.new(0.2), {
                                    ["Size"] = UDim2.fromScale(1, v42)
                                }):Play()
                            end
                        end
                        v43(true)
                        u11.ProgressUI = u3:GetPropertyChangedSignal("Value"):Connect(v43)
                        local function u48(p44) --[[Anonymous function at line 197]]
                            --[[
                            Upvalues:
                                [1] = u3
                                [2] = u2
                                [3] = u6
                                [4] = u14
                                [5] = u9
                                [6] = u10
                                [7] = u36
                                [8] = u11
                                [9] = u48
                                [10] = u13
                            --]]
                            if p44 == "finishedPuzzle" then
                                local v45 = u3.Value + u2:GetAttribute("PowerGain")
                                u6:FireServer()
                                if v45 < 100 and u14 then
                                    u9:Play("puzzleDone", {
                                        ["Parent"] = u2.PrimaryPart
                                    })
                                    u10 = require(game.ReplicatedStorage.Modules.Misc.FlowGameManager)
                                    u10:startGame(u36)
                                    if u11.Completed then
                                        u11.Completed:Disconnect()
                                        u11.Completed = nil
                                    end
                                    local v46 = u11
                                    local v47 = u10.Completed
                                    if v47 then
                                        v47 = u10.Completed:Connect(u48)
                                    end
                                    v46.Completed = v47
                                    game.TweenService:Create(u13.Background, TweenInfo.new(1), {
                                        ["Position"] = UDim2.fromScale(0.5, 0.5)
                                    }):Play()
                                    return
                                end
                            else
                                local _ = p44 == "leaveGenerator"
                            end
                        end
                        local v49 = u11
                        local v50 = u10.Completed
                        if v50 then
                            v50 = u10.Completed:Connect(u48)
                        end
                        v49.Completed = v50
                        if u30 and u30.Parent then
                            u11.SpeedGiven = u30.AncestryChanged:Connect(function(_, p51) --[[Anonymous function at line 227]]
                                --[[
                                Upvalues:
                                    [1] = u28
                                    [2] = u30
                                --]]
                                if not p51 then
                                    u28(u30:GetAttribute("Completed"))
                                end
                            end)
                        else
                            u28()
                        end
                        local u52 = u32.MoveDirection.Magnitude
                        local u53 = tick()
                        local u54 = false
                        u11.Moved = u32:GetPropertyChangedSignal("MoveDirection"):Connect(function() --[[Anonymous function at line 234]]
                            --[[
                            Upvalues:
                                [1] = u32
                                [2] = u52
                                [3] = u53
                                [4] = u54
                                [5] = u28
                            --]]
                            local v55 = u32.MoveDirection.Magnitude
                            if u52 == 0 and (v55 > 0 and (tick() >= u53 + 0.25 and not u54)) then
                                u54 = true
                                u28()
                                toggleGeneratorState("leave")
                            end
                            u52 = v55
                        end)
                        local v56 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
                        local v57 = u11
                        local v58 = v56.SprintToggled
                        if v58 then
                            v58 = v56.SprintToggled:Connect(function(p59) --[[Anonymous function at line 246]]
                                --[[
                                Upvalues:
                                    [1] = u28
                                --]]
                                if p59 then
                                    u28()
                                    toggleGeneratorState("leave")
                                end
                            end)
                        end
                        v57.Sprinted = v58
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
function toggleGeneratorState(p61)
    --[[
    Upvalues:
        [1] = u1
        [2] = u7
        [3] = u22
        [4] = u60
    --]]
    local v62 = u1.Character
    if v62 and v62.PrimaryPart then
        local v63, v64, v65 = u7:InvokeServer(p61)
        local v66 = {
            ["tooFar"] = "Move a bit closer to an available side of the generator and try again.",
            ["positionOccupied"] = "Move to another side of the generator and try again.",
            ["tooMany"] = "Too many people are fixing the generator right now. Try again later.",
            ["alreadyFixed"] = "This generator\'s already been fixed. Go try fixing another one.",
            ["dead"] = "Try not to die next time.",
            ["isKiller"] = "You\'re supposed to be killing them, not helping them. Go do that.",
            ["isUnknownTeam"] = "Dude what r u doing rn you\'re a spectator",
            ["leftAlready"] = ""
        }
        if v66[v63] then
            u22(v66[v63])
        elseif not v63 then
            u22("An unknown error occurred while trying to fix the generator. Try again.")
        end
        if v63 == "fixing" then
            u60(v64, v65)
        else
            local _ = v63 == "notFixing"
        end
    else
        return
    end
end
if u4 then
    u4.Triggered:Connect(function() --[[Anonymous function at line 285]]
        toggleGeneratorState("enter")
    end)
end
u3:GetPropertyChangedSignal("Value"):Connect(function() --[[Anonymous function at line 291]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v67 = u2.Instances.Generator.Progress.BarUI.Bar
    local v68 = u3.Value / 100
    game.TweenService:Create(v67, TweenInfo.new(0.5), {
        ["Size"] = UDim2.fromScale(v68, 1),
        ["BackgroundTransparency"] = 1 - v68
    }):Play()
end)
u2.AncestryChanged:Connect(function(_, p69) --[[Anonymous function at line 298]]
    --[[
    Upvalues:
        [1] = u28
    --]]
    if not p69 then
        u28()
    end
end)