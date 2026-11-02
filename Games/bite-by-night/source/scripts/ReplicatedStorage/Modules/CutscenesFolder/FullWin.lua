-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_17 = {
    ["Duration"] = 6.883,
    ["Activate"] = function(p_u_1)
        if game:GetService("Players").LocalPlayer:GetAttribute("LOADED") ~= false then
            workspace.GAME.STOP_MUSIC.Value = true
            game:GetService("Players").LocalPlayer:SetAttribute("LOADED", false)
            workspace.LandingSFX:Play()
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Shop.Visible = false
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Inventory.Visible = false
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Currency.Visible = true
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Buttons.Visible = true
            game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer").Visible = false
            if game:GetService("Players").LocalPlayer.Character then
                local v2 = next
                local v3, v4 = game:GetService("Players").LocalPlayer.Character:GetDescendants()
                for _, v5 in v2, v3, v4 do
                    if v5:IsA("BasePart") then
                        v5.LocalTransparencyModifier = v5.Transparency
                    end
                end
            end
            task.spawn(function()
                local DoorRoot = workspace:WaitForChild("Lobby"):WaitForChild("Elevator"):WaitForChild("Elevator Doors"):WaitForChild("DoorRoot")
                DoorRoot.LDoor.DesiredAngle = 0
                DoorRoot.RDoor.DesiredAngle = 0
                workspace:WaitForChild("Lobby"):WaitForChild("Shaft"):PivotTo(CFrame.new(484.935, 277.252, 109.744))
                local Elevator = workspace:WaitForChild("Lobby"):WaitForChild("Elevator")
                Elevator:PivotTo(CFrame.new(483.989, 61.528, 109.666))
                local v_u_8 = Instance.new("CFrameValue")
                v_u_8.Value = CFrame.new(0, 200, 0)
                local v_u_9 = Elevator:GetPivot()
                local v12 = game:GetService("RunService").Stepped:Connect(function()
                    Elevator:PivotTo(v_u_9 * v_u_8.Value)
                    workspace.IGNORE:FindFirstChild("CameraRig"):PivotTo(workspace:FindFirstChild("Lobby")["Camera Position"].CFrame * v_u_8.Value)
                    local v10 = 0
                    for _, v11 in p_u_1 do
                        v10 = v10 + 1
                        if v11.Character and v11.Character:FindFirstChild("HumanoidRootPart") then
                            v11.Character:FindFirstChild("HumanoidRootPart").CFrame = workspace:WaitForChild("Lobby"):WaitForChild("FullWinFolder"):WaitForChild(tostring(v10) .. " Point").CFrame * v_u_8.Value
                        end
                    end
                end)
                workspace.LandingSFX:Play()
                game:GetService("TweenService"):Create(v_u_8, TweenInfo.new(3.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Value"] = CFrame.new(0, 0, 0)
                }):Play()
                task.wait(4.5)
                v_u_8:Destroy()
                v12:Disconnect()
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
            end)
            local v13 = 0
            for _, v_u_14 in p_u_1 do
                v13 = v13 + 1
                if v_u_14.Character then
                    v_u_14.Character:AddTag("CantMove")
                    v_u_14.Character:AddTag("Cutscene")
                    v_u_14.Character:FindFirstChild("HumanoidRootPart").Anchored = true
                    v_u_14.Character:FindFirstChild("HumanoidRootPart").CFrame = workspace:WaitForChild("Lobby"):WaitForChild("FullWinFolder"):WaitForChild(tostring(v13) .. " Point").CFrame
                    local v15 = v_u_14.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(script:FindFirstChild("player" .. tostring(v13)))
                    v15:Play()
                    v15.Stopped:Once(function()
                        v_u_14.Character:RemoveTag("CantMove")
                        v_u_14.Character:RemoveTag("Cutscene")
                        v_u_14.Character:FindFirstChild("HumanoidRootPart").CFrame = workspace.Lobby:FindFirstChild("Player Position").CFrame
                        v_u_14.Character:FindFirstChild("HumanoidRootPart").Anchored = false
                    end)
                end
            end
            task.wait(v_u_17.Duration)
            game:GetService("Players").LocalPlayer:SetAttribute("LOADED", true)
            local LobbyUIContainer = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer")
            LobbyUIContainer.Visible = true
            LobbyUIContainer.Parent = game:GetService("Players").LocalPlayer.PlayerGui.UI.Transitions.Lobby
            game:GetService("Players").LocalPlayer.PlayerGui.UI.Transitions.Lobby.GroupTransparency = 1
            game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI.Transitions.Lobby, TweenInfo.new(0.5), {
                ["GroupTransparency"] = 0
            }):Play()
            task.delay(0.5, function()
                LobbyUIContainer.Parent = game:GetService("Players").LocalPlayer.PlayerGui.UI.UI
            end)
            workspace.GAME.STOP_MUSIC.Value = false
        end
    end
}
return v_u_17
