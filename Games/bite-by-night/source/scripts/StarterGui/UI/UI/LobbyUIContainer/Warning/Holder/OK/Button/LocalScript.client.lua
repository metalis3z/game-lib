-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local Parent = script.Parent
task.wait(1)
local LocalPlayer = game:GetService("Players").LocalPlayer
repeat
    task.wait()
until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):WaitForChild("LobbyUIContainer").Visible and LocalPlayer:GetAttribute("LOADED")
Parent.Parent.Parent.Parent.Visible = true
local v_u_4 = script:WaitForChild("Blur"):Clone()
v_u_4.Parent = game:GetService("Lighting")
Parent:GetPropertyChangedSignal("GuiState"):Connect(function()
    if Parent.GuiState == Enum.GuiState.Press then
        task.delay(1.25, function()
            Parent.Parent.Parent.Parent.Visible = false
        end)
        TweenService:Create(v_u_4, TweenInfo.new(0.5), {
            ["Size"] = 0
        }):Play()
        local v5 = game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Warning:GetDescendants()
        local Warning = game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Warning
        table.insert(v5, Warning)
        for _, v7 in next, v5 do
            if v7:IsA("Frame") then
                TweenService:Create(v7, TweenInfo.new(0.5), {
                    ["BackgroundTransparency"] = 1
                }):Play()
            elseif v7:IsA("ImageButton") then
                TweenService:Create(v7, TweenInfo.new(0.5), {
                    ["BackgroundTransparency"] = 1,
                    ["ImageTransparency"] = 1,
                    ["TextTransparency"] = 1
                }):Play()
            elseif v7:IsA("TextButton") or v7:IsA("TextLabel") then
                TweenService:Create(v7, TweenInfo.new(0.5), {
                    ["BackgroundTransparency"] = 1,
                    ["TextTransparency"] = 1
                }):Play()
            elseif v7:IsA("ImageLabel") then
                TweenService:Create(v7, TweenInfo.new(0.5), {
                    ["BackgroundTransparency"] = 1,
                    ["ImageTransparency"] = 1
                }):Play()
            elseif v7:IsA("UIStroke") then
                TweenService:Create(v7, TweenInfo.new(0.5), {
                    ["Thickness"] = 0
                }):Play()
            end
        end
        game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("sfx"):FindFirstChild("close_pop_up"):Play()
        task.wait(1)
        game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.DailyRewards.Visible = true
    end
end)
