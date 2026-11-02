-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = game.Players.LocalPlayer.PlayerGui
local LobbyUIContainer = PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer")
local Settings = LobbyUIContainer:WaitForChild("Settings")
local CameraPart2 = game.Workspace:WaitForChild("MAPS"):WaitForChild("ShopModel"):WaitForChild("CameraPart2")
local Black = LobbyUIContainer:WaitForChild("Black")
local v_u_8 = TweenService:Create(Black, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
    ["Transparency"] = 0
})
local v_u_9 = TweenService:Create(Black, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
    ["Transparency"] = 1
})
script.Parent.MouseButton1Click:Connect(function()
    if (not Black.Visible or Black.Transparency == 1) and not LobbyUIContainer.Inventory.Visible then
        PlayerGui:WaitForChild("UI"):WaitForChild("sfx"):FindFirstChild("open"):Play()
        Black.Transparency = 1
        Black.Visible = true
        v_u_8:Play()
        TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            ["CFrame"] = game.Workspace.CurrentCamera.CFrame * CFrame.Angles(0.6981317007977318, 0, 0)
        }):Play()
        task.wait(0.3)
        task.wait(0.2)
        Settings.Visible = false
        Settings.Position = UDim2.new(0.5, 0, 0.5, 0)
        LobbyUIContainer:WaitForChild("Currency").Visible = false
        LobbyUIContainer:WaitForChild("Buttons").Visible = false
        LobbyUIContainer:WaitForChild("Shop").Visible = true
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
        game.Workspace.CurrentCamera.CFrame = CameraPart2.CFrame * CFrame.fromEulerAnglesXYZ(-0.3490658503988659, 0, 0)
        v_u_9:Play()
        game.Workspace.CurrentCamera.FieldOfView = 10
        TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0), {
            ["FieldOfView"] = 10
        }):Play()
        TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ["CFrame"] = CameraPart2.CFrame
        }):Play()
        LocalPlayer:AddTag("Cutscene")
    end
end)
