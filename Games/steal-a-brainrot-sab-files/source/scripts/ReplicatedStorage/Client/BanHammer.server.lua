
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = require(v1.Controllers.ActionController)
local v_u_7 = require(v1.UserGenerated.Lang.Janitor)
require(v1.UserGenerated.Lang.WCall)
local v8 = require(v1.Packages.Net)
local v_u_9 = require(v1.Utils.CharacterUtils)
local v_u_10 = require(v1.UserGenerated.Concurrency.Bindable)
local v_u_11 = require(v1.Controllers.ItemController.NightVisionController)
local v_u_12 = v8:RemoteFunction("Tools/BanHammer/Charge")
local v_u_13 = v8:RemoteEvent("Tools/BanHammer/Release")
local v14 = v1:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Ban Hammer")
local v_u_15 = require(v14.Flags)
local v_u_16 = v14:WaitForChild("Indicator")
local v_u_17 = v14:WaitForChild("RunningAnimation")
local v_u_18 = v14:WaitForChild("IdleAnimation")
task.spawn(v3.PreloadAsync, v3, v14:GetDescendants())
script:WaitForChild("Equipped").Event:Connect(function(p_u_19)
    local v_u_20
    if p_u_19.Parent:IsA("Model") then
        v_u_20 = v_u_2:GetPlayerFromCharacter(p_u_19.Parent)
    else
        v_u_20 = p_u_19.Parent.Parent
    end
    local v21
    if v_u_20 then
        v21 = v_u_20:IsA("Player")
    else
        v21 = v_u_20
    end
    assert(v21)
    local v_u_22 = v_u_20.Character or v_u_20.CharacterAdded:Wait()
    local v_u_23 = assert(v_u_22:WaitForChild("HumanoidRootPart", 15))
    local v_u_24 = assert(v_u_22:WaitForChild("Humanoid", 15))
    assert(v_u_24:WaitForChild("Animator", 15))
    local v_u_25 = v_u_7.new()
    v_u_9:SetAnimations(v_u_22, "walk", { v_u_17 })
    v_u_9:SetAnimations(v_u_22, "run", { v_u_17 })
    v_u_9:SetAnimations(v_u_22, "idle", { v_u_18 })
    v_u_25:Add(function()
        v_u_9:RevertAllAnimations(v_u_22)
    end)
    v_u_11.Enable()
    v_u_25:Add(function()
        v_u_11.Disable()
    end)
    local v_u_26 = false
    v_u_25:Add(v_u_6.Pressed:Connect(function(_, _)
        local v27
        if v_u_23.Parent and v_u_24.Health > 0 then
            v27 = not v_u_20:GetAttribute("Stealing")
        else
            v27 = false
        end
        if v27 then
            if not v_u_26 then
                v_u_26 = true
                local v_u_28 = v_u_7.new()
                local v_u_29 = v_u_16:Clone()
                local v_u_30 = v_u_29.Main
                v_u_28:Add(function()
                    if v_u_29.Parent then
                        local v31 = v_u_5:Create(v_u_30, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Transparency"] = 1
                        })
                        v31:Play()
                        v31.Completed:Wait()
                    end
                    v_u_29:Destroy()
                end)
                local v_u_32 = false
                v_u_28:Add(v_u_4.RenderStepped:Connect(function(_)
                    local v33 = p_u_19:GetAttribute("ChargeRadius")
                    local v34 = p_u_19:GetAttribute("ChargePercent") or 0
                    local v35 = v_u_24.HipHeight + 0.5 * v_u_23.Size.Y
                    v_u_29:PivotTo(v_u_23.CFrame * CFrame.new(0, -v35, 0) * v_u_15.SlamOffset)
                    if v33 then
                        local v36 = v_u_30
                        local v37 = v_u_30.Size.X
                        local v38 = v33 * 2
                        local v39 = v33 * 2
                        v36.Size = Vector3.new(v37, v38, v39)
                        v_u_29.Parent = workspace
                        if v34 >= 1 and not v_u_32 then
                            v_u_32 = true
                            v_u_5:Create(v_u_30, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["Transparency"] = 0.5,
                                ["Color"] = Color3.fromRGB(97, 173, 255)
                            }):Play()
                        end
                    end
                end))
                local v_u_40 = coroutine.running()
                v_u_28:Add(v_u_6.Released:Connect(function()
                    task.spawn(v_u_40, false)
                end))
                v_u_28:Add(v_u_25.Destroying:Connect(function()
                    task.spawn(v_u_40, true)
                end))
                local v_u_41 = v_u_10.new()
                local v_u_42 = false
                task.spawn(function()
                    local v43, v44 = pcall(v_u_12.InvokeServer, v_u_12)
                    if not (v43 and v44 or v_u_28:IsDestroyed()) then
                        task.spawn(v_u_40, nil)
                    end
                    v_u_42 = true
                    v_u_41:Fire()
                end)
                local v45 = coroutine.yield()
                v_u_28:Destroy()
                if v45 ~= nil then
                    v_u_13:FireServer(v45)
                end
                if not v_u_42 then
                    v_u_41:Wait()
                end
                v_u_26 = false
            end
        else
            return
        end
    end))
    p_u_19.Unequipped:Connect(function()
        v_u_25:Destroy()
    end)
    v_u_24.Died:Once(function()
        v_u_25:Destroy()
    end)
    p_u_19.AncestryChanged:Connect(function(p46)
        if p46 ~= v_u_22 then
            v_u_25:Destroy()
        end
    end)
end)