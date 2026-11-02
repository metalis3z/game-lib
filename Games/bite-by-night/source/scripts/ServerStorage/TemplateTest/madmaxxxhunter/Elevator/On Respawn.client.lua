-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
repeat
    task.wait()
until game:IsLoaded() and (game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
task.wait(0.01)
if script:WaitForChild("Check", 10):InvokeServer(game:GetService("Players").LocalPlayer) == true then
    script:WaitForChild("RemoteEvent", 10):FireServer(true)
    script.Parent.Parent:WaitForChild("HumanoidRootPart").CFrame = workspace:WaitForChild("Lobby"):WaitForChild("Player Position").CFrame
else
    local LobbyUIContainer = PlayerGui:WaitForChild("UI", 10):WaitForChild("Transitions"):WaitForChild("Lobby"):FindFirstChild("LobbyUIContainer") or PlayerGui:WaitForChild("UI", 10):WaitForChild("UI"):WaitForChild("LobbyUIContainer", 10)
    if LobbyUIContainer:FindFirstChild("Buttons") then
        LobbyUIContainer.Buttons.Visible = true
    end
    LobbyUIContainer.Visible = false
    script:WaitForChild("RemoteEvent", 10):FireServer(false)
    ContentProvider:PreloadAsync({
        workspace:WaitForChild("Lobby"),
        script:WaitForChild("Animation"),
        script:WaitForChild("ElevatorIntro"),
        script:WaitForChild("WaitAnimation")
    })
    require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Warp"))
    local m_Cutscenes = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Cutscenes"))
    local m_Maid = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Maid"))
    local Parent = script.Parent.Parent
    local LoadingSFX = workspace.LoadingSFX
    LoadingSFX:Play()
    Parent:WaitForChild("HumanoidRootPart").Anchored = true
    Parent:WaitForChild("Humanoid").AutoRotate = false
    Parent:AddTag("CantMove")
    Parent:AddTag("Cutscene")
    game:GetService("Players").LocalPlayer:AddTag("Cutscene")
    function lerp(p10, p11, p12)
        return p10 + (p11 - p10) * p12
    end
    local Elevator = workspace:WaitForChild("Lobby"):WaitForChild("Elevator")
    Elevator:PivotTo(CFrame.new(483.989, 61.528, 109.666))
    local Shaft = workspace:WaitForChild("Lobby"):WaitForChild("Shaft")
    Shaft:PivotTo(CFrame.new(484.935, 277.252, 109.744))
    local v_u_15 = Instance.new("CFrameValue")
    v_u_15.Value = CFrame.new(0, 0, 0)
    local v_u_16 = Instance.new("CFrameValue")
    v_u_16.Value = CFrame.new(0, 200, 0)
    local v_u_17 = Shaft:GetPivot()
    local v_u_18 = Elevator:GetPivot()
    local v19 = next
    local v20, v21 = Parent:GetDescendants()
    for _, v22 in v19, v20, v21 do
        if v22:IsA("BasePart") then
            v22.LocalTransparencyModifier = v22.Transparency
        end
    end
    local DoorRoot = workspace:WaitForChild("Lobby"):WaitForChild("Elevator"):WaitForChild("Elevator Doors"):WaitForChild("DoorRoot")
    DoorRoot.LDoor.DesiredAngle = 0
    DoorRoot.RDoor.DesiredAngle = 0
    local CurrentCamera = workspace.CurrentCamera
    local ElevatorAlone = m_Cutscenes.ElevatorAlone
    local v_u_26 = ElevatorAlone.CameraRig:Clone()
    v_u_26:PivotTo(workspace:FindFirstChild("Lobby")["Camera Position"].CFrame)
    v_u_26.Parent = workspace.IGNORE
    v_u_26:FindFirstChild(ElevatorAlone.RootPart)
    local v_u_27 = v_u_26:FindFirstChild(ElevatorAlone.CameraPart)
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    local CFrame = CurrentCamera.CFrame
    local _ = CurrentCamera.FieldOfView
    local function v29()
        Shaft:PivotTo(v_u_17 * v_u_15.Value)
        Elevator:PivotTo(v_u_18 * v_u_16.Value)
        v_u_26:PivotTo(workspace:FindFirstChild("Lobby")["Camera Position"].CFrame * v_u_16.Value)
        Parent:WaitForChild("HumanoidRootPart").CFrame = workspace:WaitForChild("Lobby"):WaitForChild("Player Position").CFrame * v_u_16.Value
    end
    local v30 = game:GetService("RunService").Stepped:Connect(v29)
    local v31 = v_u_26:FindFirstChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(script.Animation)
    v31:Play()
    local v32 = Parent:WaitForChild("Humanoid"):LoadAnimation(script:WaitForChild("WaitAnimation"))
    v32:Play()
    local v33
    if game:GetService("Players").LocalPlayer:HasTag("LOADED") then
        v33 = true
    else
        local v_u_34 = false
        game:GetService("Players").LocalPlayer:AddTag("LOADED")
        game:GetService("Players").LocalPlayer:SetAttribute("LOADED", false)
        task.spawn(function()
            local v_u_35 = game:GetService("TweenService"):Create(v_u_15, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0), {
                ["Value"] = CFrame.new(0, 100, 0)
            })
            v_u_35:Play()
            PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading").Visible = true
            local v_u_36 = {
                ElevatorAlone.Animation,
                game:GetService("ReplicatedStorage"),
                game:GetService("StarterGui"),
                game:GetService("Workspace")
            }
            local v37 = 0
            local v_u_38 = 0
            for _, v39 in next, v_u_36 do
                local v40 = next
                local v41, v42 = v39:GetDescendants()
                for _, v43 in v40, v41, v42 do
                    if v43:IsA("Sound") or (v43:IsA("Animation") or (v43:IsA("MeshPart") or (v43:IsA("ImageLabel") or (v43:IsA("ImageButton") or (v43:IsA("Decal") or (v43:IsA("Texture") or (v43:IsA("ParticleEmitter") or v43:IsA("SurfaceAppearance")))))))) then
                        v37 = v37 + 1
                    end
                end
            end
            local v_u_44 = false
            local v_u_45 = false
            task.spawn(function()
                repeat
                    v_u_15.Value = CFrame.new(0, 0, 0)
                    v_u_35:Play()
                    v_u_35.Completed:Wait()
                until v_u_44 == true
            end)
            PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading"):WaitForChild("Loading").Text = "Loading assets (0/" .. v37 .. ")"
            local v_u_46 = nil
            if game:GetService("RunService"):IsStudio() then
                if v_u_44 == false then
                    PlayerGui:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = true
                    Elevator:FindFirstChild("Button").Attachment.PointLight.Enabled = true
                    Elevator:FindFirstChild("Button").Attachment.shine:Emit(1)
                    v_u_46 = PlayerGui:WaitForChild("UI"):WaitForChild("SkipLoading"):WaitForChild("Button").MouseButton1Click:Once(function()
                        PlayerGui:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = false
                        Elevator:FindFirstChild("Button").Attachment.PointLight.Enabled = false
                        PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading").Visible = false
                        v_u_45 = true
                    end)
                end
            else
                task.delay(10, function()
                    if v_u_44 == false then
                        PlayerGui:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = true
                        Elevator:FindFirstChild("Button").Attachment.PointLight.Enabled = true
                        Elevator:FindFirstChild("Button").Attachment.shine:Emit(1)
                        v_u_46 = PlayerGui:WaitForChild("UI"):WaitForChild("SkipLoading"):WaitForChild("Button").MouseButton1Click:Once(function()
                            PlayerGui:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = false
                            Elevator:FindFirstChild("Button").Attachment.PointLight.Enabled = false
                            PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading").Visible = false
                            v_u_45 = true
                        end)
                    end
                end)
            end
            local v_u_47 = false
            task.spawn(function()
                if game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").GamepadEnabled then
                    task.wait(6)
                else
                    ContentProvider:PreloadAsync(v_u_36, function(_, _)
                        v_u_38 = v_u_38 + 1
                    end)
                end
                v_u_47 = true
                PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading"):WaitForChild("Loading").Text = ""
            end)
            local v48 = v_u_47
            local v49 = 0
            while true do
                if tick() - v49 > 0.1 then
                    v49 = tick()
                    PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading"):WaitForChild("Loading").Text = "\nLoading assets (" .. v_u_38 .. "/" .. v_u_38 + game:GetService("ContentProvider").RequestQueueSize .. ")"
                end
                task.wait()
                if v_u_45 or v48 then
                    v_u_47 = true
                    PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading"):WaitForChild("Loading").Text = ""
                    v_u_44 = true
                    v_u_35.Completed:Wait()
                    if v_u_46 then
                        v_u_46:Disconnect()
                    end
                    PlayerGui:WaitForChild("UI"):WaitForChild("SkipLoading").Enabled = false
                    Elevator:FindFirstChild("Button").Attachment.PointLight.Enabled = false
                    PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("Loading").Visible = false
                    v_u_35:Cancel()
                    v_u_34 = true
                    v_u_15.Value = CFrame.new(0, -8, 0)
                    return
                end
            end
        end)
        v33 = v_u_34
    end
    repeat
        CurrentCamera.CFrame = v_u_27.CFrame
        CurrentCamera.FieldOfView = 70
        task.wait()
    until v33 == true
    local v50 = v_u_26:FindFirstChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(ElevatorAlone.Animation)
    repeat
        task.wait()
    until v50.Length > 0
    v32:Stop(0.25)
    v31:Stop(0.25)
    local ElevatorAlone_0 = m_Cutscenes.ElevatorAlone
    local v_u_52 = m_Maid.new()
    v50:Play()
    v_u_52:Mark(v50)
    task.delay(7, v_u_26.Destroy, v_u_26)
    LoadingSFX:Stop()
    workspace.LandingSFX:Play()
    local v53 = Parent:WaitForChild("Humanoid"):LoadAnimation(script:WaitForChild("ElevatorIntro"))
    v53:Play()
    task.spawn(function()
        local v_u_54 = 0.1
        v_u_52:Mark((RunService.PreSimulation:Connect(function(p55)
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            v_u_54 = v_u_54 + p55 * 60
            CurrentCamera.CFrame = v_u_27.CFrame
            if ElevatorAlone_0.FOV then
                local v56 = v_u_54
                if ElevatorAlone_0.FOV[math.ceil(v56)] then
                    local v57 = v_u_54
                    CurrentCamera.FieldOfView = ElevatorAlone_0.FOV[math.ceil(v57)]
                end
            end
        end)))
    end)
    task.delay(v50.Length, function()
        CurrentCamera.CFrame = CFrame
        CurrentCamera.CameraType = Enum.CameraType.Custom
        game:GetService("Players").LocalPlayer:RemoveTag("Cutscene")
        v_u_52:Sweep()
    end)
    game:GetService("TweenService"):Create(v_u_15, TweenInfo.new(0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Value"] = CFrame.new(0, 0, 0)
    }):Play()
    game:GetService("TweenService"):Create(v_u_16, TweenInfo.new(3.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Value"] = CFrame.new(0, 0, 0)
    }):Play()
    task.wait(4)
    v_u_15.Value = CFrame.new(0, 0, 0)
    v_u_16.Value = CFrame.new(0, 0, 0)
    v29()
    v_u_15:Destroy()
    v_u_16:Destroy()
    v30:Disconnect()
    game:GetService("TweenService"):Create(DoorRoot.LDoor, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        ["DesiredAngle"] = 0.6
    }):Play()
    game:GetService("TweenService"):Create(DoorRoot.RDoor, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        ["DesiredAngle"] = 0.6
    }):Play()
    task.wait(3)
    game:GetService("TweenService"):Create(DoorRoot.LDoor, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["DesiredAngle"] = 0
    }):Play()
    game:GetService("TweenService"):Create(DoorRoot.RDoor, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["DesiredAngle"] = 0
    }):Play()
    if v53.IsPlaying then
        v53.Stopped:Wait()
    end
    Parent:RemoveTag("CantMove")
    Parent:RemoveTag("Cutscene")
    Parent:WaitForChild("HumanoidRootPart").Anchored = false
    Parent:WaitForChild("Humanoid").AutoRotate = true
    script.Ambience:Play()
    LobbyUIContainer.Parent = PlayerGui:WaitForChild("UI"):WaitForChild("Transitions"):WaitForChild("Lobby")
    LobbyUIContainer.Visible = true
    PlayerGui:WaitForChild("UI"):WaitForChild("Transitions"):WaitForChild("Lobby").GroupTransparency = 1
    game:GetService("TweenService"):Create(PlayerGui:WaitForChild("UI"):WaitForChild("Transitions"):WaitForChild("Lobby"), TweenInfo.new(0.5), {
        ["GroupTransparency"] = 0
    }):Play()
    task.delay(0.5, function()
        LobbyUIContainer.Parent = PlayerGui:WaitForChild("UI"):WaitForChild("UI")
    end)
    script.RemoteEvent:FireServer(true)
end
