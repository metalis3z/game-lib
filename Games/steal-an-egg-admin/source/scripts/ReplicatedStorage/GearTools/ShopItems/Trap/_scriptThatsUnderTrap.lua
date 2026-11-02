-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local AntiCheatService = require(ServerScriptService.Controllers.AntiCheatService)
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Shared.Globals.Constants)
local GameplayToolGuard = require(ServerScriptService.Library.Tools.Internal.GameplayToolGuard)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local v1 = {}

function v1.Install(v2) -- line 11 | captures: Players, ReplicatedStorage, AntiCheatService, Audio, GameplayToolGuard, Remotes
    local Owner = v2:GetAttribute("Owner")
    local v3 = false
    local v4 = {}
    local v5
    local Hitbox = v2:WaitForChild("Hitbox")
    local BasePart = Hitbox:IsA("BasePart")
    assert(BasePart, "Trap Hitbox must be a BasePart")
    v2.CanTouch = true
    Hitbox.CanTouch = true

    local function createTrapBillboard(v6) -- line 21
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "TrapBillboard"
        BillboardGui.Size = UDim2.fromScale(6, 3)
        BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        BillboardGui.AlwaysOnTop = true
        BillboardGui.MaxDistance = 50
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromScale(1, 1)
        Frame.BackgroundTransparency = 1
        Frame.Parent = BillboardGui
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.fromScale(1, 0.4)
        TextLabel.Position = UDim2.new(0, 0, 0, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = "TRAPPED"
        TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        TextLabel.TextScaled = true
        TextLabel.Font = Enum.Font.SourceSansBold
        TextLabel.Parent = Frame
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = 2.5
        UIStroke.Parent = TextLabel
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Size = UDim2.fromScale(1, 0.5)
        TextLabel_2.Position = UDim2.fromScale(0, 0.5)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Text = tostring(7) .. "s"
        TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.TextScaled = true
        TextLabel_2.Font = Enum.Font.SourceSansBold
        TextLabel_2.Parent = Frame
        local UIStroke_2 = Instance.new("UIStroke")
        UIStroke_2.Thickness = 2.5
        UIStroke_2.Parent = TextLabel_2
        local Head = v6:FindFirstChild("Head")
        if Head then
            BillboardGui.Parent = Head
            task.spawn(function() -- line 60 | captures: BillboardGui, TextLabel_2
                for v7 = 7, 1, -1 do
                    if BillboardGui then
                        if not BillboardGui.Parent then
                            break
                        end
                    else
                        break
                    end
                    local v8 = tostring(v7)
                    TextLabel_2.Text = v8 .. "s"
                    task.wait(1)
                end
                if BillboardGui and BillboardGui.Parent then
                    BillboardGui:Destroy()
                end
            end)
            return BillboardGui
        end
        if v6.PrimaryPart then
            BillboardGui.Parent = v6.PrimaryPart
            task.spawn(function() -- line 83 | captures: BillboardGui, TextLabel_2
                for v9 = 7, 1, -1 do
                    if BillboardGui then
                        if not BillboardGui.Parent then
                            break
                        end
                    else
                        break
                    end
                    local v10 = tostring(v9)
                    TextLabel_2.Text = v10 .. "s"
                    task.wait(1)
                end
                if BillboardGui and BillboardGui.Parent then
                    BillboardGui:Destroy()
                end
            end)
            return BillboardGui
        end
        BillboardGui:Destroy()
        return nil
    end

    local function getModelHeight(v11) -- line 101
        if v11:FindFirstChild("HumanoidRootPart") or v11.PrimaryPart then
            local v12, v13 = v11:GetBoundingBox()
            _ = v12
            return v13.Y / 2
        end
        error("HumanoidRootPart or PrimaryPart not found")
        return 2
    end

    local function getCharacterFromPart(v14) -- line 114
        local v15 = v14
        while true do
            if v15 then
                if v15 == workspace then
                    return nil
                end
                if not (v15:IsA("Model") and v15:FindFirstChildOfClass("Humanoid")) then
                    v15 = v15.Parent
                    continue
                end
                break
            end
            return nil
        end
        return v15
    end

    local function positionCloseModel(v16) -- line 127 | captures: v2
        if v16:IsA("BasePart") then
            v16.CFrame = v2.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
            v16.Anchored = true
        else
            if v16:IsA("PVInstance") then
                v16:PivotTo(v2.CFrame)
            end
            for v17, v18 in v16:GetDescendants() do
                if v18:IsA("BasePart") then
                    v18.Anchored = true
                end
            end
        end
    end

    local function releaseTrappedCharacter(v19) -- line 142 | captures: v4
        local v20 = v4[v19]
        if not v20 then
            return
        end
        v4[v19] = nil
        local carrierConnection = v20.carrierConnection
        if carrierConnection then
            carrierConnection:Disconnect()
        end
        local trapStateConnection = v20.trapStateConnection
        if trapStateConnection then
            trapStateConnection:Disconnect()
        end
        local billboard = v20.billboard
        if billboard and billboard.Parent then
            billboard:Destroy()
        end
        local rootPart = v20.rootPart
        if rootPart and rootPart.Parent then
            rootPart.Anchored = v20.originalRootAnchored
        end
        local humanoid = v20.humanoid
        if humanoid then
            humanoid.JumpHeight = v20.originalJumpHeight
            humanoid.AutoRotate = v20.originalAutoRotate
            humanoid.PlatformStand = false
        end
        if v19 and v19.Parent then
            v19:SetAttribute("IsTrapped", nil)
        end
    end

    local function notifyTrapOwner(v21) -- line 174 | captures: Owner, Players, Remotes
        if typeof(Owner) == "string" then
            local v22 = Players:FindFirstChild(Owner)
            if v22 and v22:IsA("Player") then
                Remotes.Alerts.Raise:FireClient(v22, "Message", "Bottom", {
                    Time = 2,
                    Message = ("You <font color=\"#00FF00\">trapped</font> %*!"):format(v21.DisplayName),
                    Color = Color3.new(1, 1, 1)
                })
            end
        end
    end

    local function freezeCharacter(v23, v24) -- line 184 | captures: v4, createTrapBillboard, releaseTrappedCharacter, notifyTrapOwner, Players, AntiCheatService, Audio, GameplayToolGuard
        if v4[v23] or v23:GetAttribute("IsTrapped") then
            return false
        end
        local Humanoid = v23:FindFirstChildOfClass("Humanoid")
        local v25 = v23:FindFirstChild("HumanoidRootPart") or v23.PrimaryPart
        local v26
        if Humanoid and v25 and v25:IsA("BasePart") then
            v26 = v23:FindFirstChild("HumanoidRootPart") or v23.PrimaryPart
        else
            return false
        end
        local v27
        if v26 then
            local v28, v29 = v23:GetBoundingBox()
            _ = v28
            v27 = v29.Y / 2
        else
            error("HumanoidRootPart or PrimaryPart not found")
            v27 = 2
        end
        local v30 = v24 + Vector3.new(0, v27, 0)
        local v31 = Players:GetPlayerFromCharacter(v23)
        if v31 and GameplayToolGuard.DropHeldEggFromPlayerHit(v31) then
            local v32 = CFrame.new(v30)
            if AntiCheatService.TeleportCharacter(v31, v32) then
                local Anchored = v25.Anchored
                local JumpHeight = Humanoid.JumpHeight
                local AutoRotate = Humanoid.AutoRotate
                v25.Anchored = true
                Humanoid:UnequipTools()
                Humanoid.JumpHeight = 0
                Humanoid.AutoRotate = false
                Humanoid.PlatformStand = true
                v23:SetAttribute("IsTrapped", true)
                notifyTrapOwner(v31)
                local v33 = {
                    character = v23,
                    humanoid = Humanoid,
                    rootPart = v25,
                    originalRootAnchored = Anchored,
                    originalJumpHeight = JumpHeight,
                    originalAutoRotate = AutoRotate
                }
                v4[v23] = v33
                v33.billboard = createTrapBillboard(v23)
                Audio.Play(9091607929, v25.CFrame, {
                    Volume = 1.3,
                    MaxDistance = 70,
                    PlaybackSpeed = { 0.9, 1.1 }
                })
                local CarrierUserId = v23:GetAttributeChangedSignal("CarrierUserId")
                v33.carrierConnection = CarrierUserId:Connect(function() -- line 244 | captures: v23, releaseTrappedCharacter
                    if v23:GetAttribute("CarrierUserId") ~= nil then
                        releaseTrappedCharacter(v23)
                    end
                end)
                local IsTrapped = v23:GetAttributeChangedSignal("IsTrapped")
                v33.trapStateConnection = IsTrapped:Connect(function() -- line 250 | captures: v23, releaseTrappedCharacter
                    if v23:GetAttribute("IsTrapped") ~= true then
                        releaseTrappedCharacter(v23)
                    end
                end)
                task.delay(7, function() -- line 255 | captures: v23, v33, v4, releaseTrappedCharacter
                    if v4[v23] == v33 then
                        releaseTrappedCharacter(v23)
                    end
                end)
                return true
            end
        end
        return false
    end

    local function activateTrap(v34) -- line 264 | captures: v3, v5, v2, Hitbox, positionCloseModel, freezeCharacter, ReplicatedStorage
        local v35
        if v3 then
            v35 = true
        elseif v2.Parent and freezeCharacter(v34, Hitbox.Position - Vector3.new(0, 1, 0) * (Hitbox.Size.Y / 2)) then
            v3 = true
            v2:SetAttribute("TrapActive", true)
            if v5 then
                v5:Disconnect()
                v5 = nil
            end
            v35 = false
        else
            v35 = true
        end
        if v35 then
            return
        end
        local v36 = ReplicatedStorage.Assets.Extra.Close:Clone()
        positionCloseModel(v36)
        v36.Parent = v2
        v2.Transparency = 1
        v2.CanCollide = false
        v2.CanTouch = false
        task.delay(7.5, function() -- line 280 | captures: v36, v2
            if v36 and v36.Parent then
                v36:Destroy()
            end
            if v2 and v2.Parent then
                v2:Destroy()
            end
        end)
    end
end

return v1
