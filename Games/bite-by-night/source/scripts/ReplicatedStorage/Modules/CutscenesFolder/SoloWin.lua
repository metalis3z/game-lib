-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Duration"] = 6.167,
    ["Activate"] = function(p_u_1)
        if game:GetService("Players").LocalPlayer:GetAttribute("LOADED") ~= false then
            workspace.GAME.STOP_MUSIC.Value = true
            game:GetService("Players").LocalPlayer:SetAttribute("LOADED", false)
            p_u_1.Character:FindFirstChild("HumanoidRootPart").Anchored = true
            p_u_1.Character:FindFirstChild("HumanoidRootPart").CFrame = workspace.Lobby:FindFirstChild("Player Position").CFrame
            local v2 = p_u_1.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.Animation)
            v2:Play()
            workspace.LandingSFX:Play()
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Shop.Visible = false
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Inventory.Visible = false
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Currency.Visible = true
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Buttons.Visible = true
            game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer").Visible = false
            p_u_1.Character:AddTag("CantMove")
            p_u_1.Character:AddTag("Cutscene")
            if game:GetService("Players").LocalPlayer.Character then
                local v3 = next
                local v4, v5 = game:GetService("Players").LocalPlayer.Character:GetDescendants()
                for _, v6 in v3, v4, v5 do
                    if v6:IsA("BasePart") then
                        v6.LocalTransparencyModifier = v6.Transparency
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
                local v_u_9 = Instance.new("CFrameValue")
                v_u_9.Value = CFrame.new(0, 200, 0)
                local v_u_10 = Elevator:GetPivot()
                local v11 = game:GetService("RunService").Stepped:Connect(function()
                    Elevator:PivotTo(v_u_10 * v_u_9.Value)
                    if workspace.IGNORE:FindFirstChild("CameraRig") then
                        workspace.IGNORE:FindFirstChild("CameraRig"):PivotTo(workspace:FindFirstChild("Lobby")["Camera Position"].CFrame * v_u_9.Value)
                    end
                    p_u_1.Character:WaitForChild("HumanoidRootPart").CFrame = workspace:WaitForChild("Lobby"):WaitForChild("Player Position").CFrame * v_u_9.Value
                end)
                workspace.LandingSFX:Play()
                game:GetService("TweenService"):Create(v_u_9, TweenInfo.new(3.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Value"] = CFrame.new(0, 0, 0)
                }):Play()
                task.wait(4)
                v_u_9:Destroy()
                v11:Disconnect()
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
            v2.Stopped:Wait()
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
            game:GetService("Players").LocalPlayer:SetAttribute("LOADED", true)
            p_u_1.Character:RemoveTag("CantMove")
            p_u_1.Character:RemoveTag("Cutscene")
            workspace.GAME.STOP_MUSIC.Value = false
            p_u_1.Character:FindFirstChild("HumanoidRootPart").Anchored = false
        end
    end
}
