-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_1 = game:GetService("Players"):GetPlayerFromCharacter(script.Parent)
local new = CFrame.new
local Angles = CFrame.Angles
local asin = math.asin
function castRay(p5, p6, p7)
    local v8 = RaycastParams.new()
    v8.FilterDescendantsInstances = {
        p5,
        workspace.IGNORE,
        workspace.PLAYERS,
        workspace.Terrain
    }
    local v9 = workspace:Raycast(p6, p7, v8)
    local v10 = v9 and v9.Position or p6 + p7
    return (p6 - v10).Magnitude, p6, v10, v9
end
if v_u_1 then
    script:WaitForChild("AudioDeviceInput", 100).Player = v_u_1
    local VoiceBox = v_u_1.Character:WaitForChild("VoiceBox")
    local AudioAnalyzer = VoiceBox.AudioAnalyzer
    if game:GetService("Players").LocalPlayer == v_u_1 then
        script:WaitForChild("AudioDeviceInput", 100).Volume = 0
    end
    local OsLowerJaw = script.Parent:FindFirstChild("OsLowerJaw", true)
    local CFrame = OsLowerJaw.CFrame
    local Neck = script.Parent:FindFirstChild("Neck", true)
    local v_u_16 = Neck.CFrame.Y
    game:GetService("RunService"):BindToRenderStep("CameraOffset", Enum.RenderPriority.Camera.Value - 1, function()
        local magnitude = (workspace.CurrentCamera.CFrame.p - workspace.CurrentCamera.Focus.p).magnitude
        if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.LockCenter and magnitude > 2 then
            local v18 = script.Parent.RootPart.CFrame.RightVector * 1.75
            game:GetService("TweenService"):Create(script.Parent.Humanoid, TweenInfo.new(0.3), {
                ["CameraOffset"] = (script.Parent.HumanoidRootPart.CFrame + Vector3.new(0, 1.5, 0)):pointToObjectSpace(script.Parent:FindFirstChild("HeadAttachment", true).WorldCFrame.p + v18)
            }):Play()
            return
        elseif game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.LockCenter and magnitude <= 2 then
            local Position = script.Parent.RootPart.Position
            local v20 = script.Parent:FindFirstChild("HeadAttachment", true).WorldCFrame.p
            local v21 = v20 - Position
            local _, _, v22, v23 = castRay(v_u_1.Character, Position, v21)
            if v23 then
                v20 = v22 - (v21.Magnitude == 0 and Vector3.new(0, 0, 0) or v21.Unit) * 0.1
            end
            game:GetService("TweenService"):Create(script.Parent.Humanoid, TweenInfo.new(0), {
                ["CameraOffset"] = (script.Parent.HumanoidRootPart.CFrame + Vector3.new(0, 1.5, 0)):pointToObjectSpace(v20)
            }):Play()
        else
            game:GetService("TweenService"):Create(script.Parent.Humanoid, TweenInfo.new(0.3), {
                ["CameraOffset"] = (script.Parent.HumanoidRootPart.CFrame + Vector3.new(0, 1.5, 0)):pointToObjectSpace(script.Parent:FindFirstChild("HeadAttachment", true).WorldCFrame.p)
            }):Play()
        end
    end)
    local v_u_24 = 0
    local function v_u_28(p25)
        if game:GetService("Players"):GetPlayerFromCharacter(script.Parent) == game:GetService("Players").LocalPlayer then
            if script.Parent:HasTag("Cutscene") then
                Neck.CFrame = new(0, v_u_16, 0) * Angles(-0.45451864380436335, 0, -0)
                v_u_24 = v_u_24 + p25
                if v_u_24 > 0.25 then
                    v_u_24 = 0
                    script:WaitForChild("Replicator"):FireServer({ Neck, OsLowerJaw }, { Neck.CFrame, OsLowerJaw.CFrame })
                end
            else
                local lookVector = script.Parent:FindFirstChild("HeadDefaultAttachment", true).WorldCFrame:toObjectSpace(game:GetService("Workspace").CurrentCamera.CFrame).lookVector
                if Neck then
                    local v27 = new(0, v_u_16, 0) * Angles(-0.45451864380436335, 0, -0) * Angles(0, -asin(lookVector.x), 0) * Angles(asin(lookVector.y), 0, 0)
                    Neck.CFrame = Neck.CFrame:Lerp(v27, 0.9 * p25 * 15)
                end
                v_u_24 = v_u_24 + p25
                if v_u_24 > 0.25 then
                    v_u_24 = 0
                    script:WaitForChild("Replicator"):FireServer({ Neck }, { Neck.CFrame })
                end
            end
        else
            return
        end
    end
    local v_u_29 = tick()
    game:GetService("RunService").Stepped:Connect(function(_, p30)
        if tick() - v_u_29 > 0.5 then
            VoiceBox:FindFirstChild("Audio").Pitch = Random.new():NextNumber(0.7, 0.9)
            v_u_29 = tick()
        else
            VoiceBox:FindFirstChild("Audio").Pitch = 0.8
        end
        v_u_28(p30)
        local v31 = AudioAnalyzer.RmsLevel * 15
        local v32 = math.clamp(v31, 0, 45)
        OsLowerJaw.CFrame = CFrame * CFrame.fromEulerAnglesXYZ(-math.rad(v32), 0, 0)
    end)
end
