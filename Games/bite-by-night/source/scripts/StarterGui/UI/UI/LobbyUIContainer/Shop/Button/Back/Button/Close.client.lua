-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = game.Players.LocalPlayer.PlayerGui
local LobbyUIContainer = PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer")
game.Workspace:WaitForChild("MAPS"):WaitForChild("ShopModel"):WaitForChild("CameraPart2")
local function v_u_4()
    PlayerGui:FindFirstChild("UI"):FindFirstChild("sfx"):FindFirstChild("exit"):Play()
    LobbyUIContainer:WaitForChild("Currency").Visible = true
    LobbyUIContainer:WaitForChild("Buttons").Visible = true
    LobbyUIContainer:WaitForChild("Timer").Visible = true
    LobbyUIContainer:WaitForChild("Shop").Visible = false
end
script.Parent.MouseButton1Click:Connect(function()
    v_u_4()
    game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    game.Workspace.CurrentCamera.FieldOfView = 70
    LocalPlayer.CameraMode = Enum.CameraMode.Classic
    LocalPlayer:RemoveTag("Cutscene")
end)
LocalPlayer:GetAttributeChangedSignal("TEAM"):Connect(function()
    v_u_4()
end)
