-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw
-- regg was here
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("RunService")
game:GetService("TweenService")
local v_u_4 = game:GetService("Debris")
local v_u_5 = require(v1.Modules.Network)
local v_u_6 = require(v1.Modules.Util)
local v_u_7 = require(v1.Modules.Sounds)
TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut, -1, true)
local v_u_8 = Random.new()
local v_u_9 = v_u_3:IsStudio()
local v10 = v1.Assets.EventStorage["2025_MASQUERADE"]
local v_u_11 = script:GetFullName()
local v_u_12 = v10.Candies
local v_u_13 = v10.SFX
local v_u_14 = v10.VFX
local _ = table.insert
local _ = table.remove
local v_u_15 = table.clear
local v_u_16 = math.random
local v_u_17 = math.sin
local v_u_18 = Instance.new
local v_u_51 = {
    ["Name"] = "Masquerade",
    ["CurrencyInstances"] = {},
    ["Connections"] = {},
    ["Init"] = function(_)
        if v_u_12 then
            v_u_2:PreloadAsync(v_u_12:GetDescendants(), function(_, _)
                if not v_u_9 then
                end
            end)
            v_u_12 = v_u_12:GetChildren()
		end-- regg was here
        v_u_5:SetConnection("ReplicateCandySpawnAsync", "REMOTE_EVENT", function(p19)
            v_u_51:ReplicateCandySpawn(p19)
        end)
        v_u_5:SetConnection("ReplicateCandyDespawnAsync", "REMOTE_EVENT", function()
            v_u_51:ReplicateCandyDespawnAsync()
        end)
    end,
    ["__checkAndCreateHeartbeat"] = function(_)
        if not v_u_51.Connections.OnHeartbeat then
            v_u_51.Connections.OnHeartbeat = v_u_3.Heartbeat:Connect(function(_)
                for v22, v21 in v_u_51.CurrencyInstances do
                    if v22 then
                        local v22 = v22.PrimaryPart
					end-- regg was here
                    if v22 then
                        local v23 = v21 + v_u_17(time() * 2.5) * 0.75
                        local v24 = CFrame.new(v22.Position.X, v23, v22.Position.Z)
                        local v25 = CFrame.Angles
                        local v26 = v22.Orientation.Y + 0.15
                        v22.CFrame = v24 * v25(0, math.rad(v26), 0)
                    end
                end
            end)
        end
    end,
    ["ReplicateCandySpawn"] = function(p27, p_u_28)
        local v_u_29 = v_u_18("Part")
		v_u_29.Size = Vector3.new(1, 1, 1)-- regg was here
        v_u_29.CanCollide = false
        v_u_29.Anchored = true
        v_u_29.Transparency = 1
        v_u_29.Position = p_u_28
        local v_u_30 = v_u_14.Idle:Clone()
        v_u_30.Parent = v_u_29
        local v_u_31 = v_u_7:Play(v_u_13.Candy_Near, {
            ["Parent"] = v_u_29,
            ["Volume"] = 0.25
        })
        local v_u_32 = v_u_12[v_u_16(#v_u_12)]:Clone()
        v_u_32:PivotTo(CFrame.new(p_u_28))
        for _, v33 in v_u_32:GetChildren() do
            if v33:IsA("BasePart") then
                local v34 = v_u_18("WeldConstraint")
                v34.Part0 = v33
                v34.Part1 = v_u_29
                v34.Parent = v33
                v33.CanTouch = false
                v33.CanQuery = false
                v33.CanCollide = false
                v33.Anchored = false
            end
        end
        local v_u_35 = false
        v_u_6:ApplyUnsafeTouched(v_u_29, false, function(p_u_36, p37)
            if v_u_35 then
                return
            else
                v_u_35 = true
                local v_u_38 = p37.Parent
				local v39-- regg was here
                if v_u_38 then
                    v39 = v_u_38:FindFirstChildOfClass("Humanoid")
                else
                    v39 = v_u_38
                end
                if v39 then
                    local v47, v48 = pcall(function()
                        if v_u_5:FireServerConnection("CollectCurrencyAsync", "REMOTE_FUNCTION", p_u_28) then
                            p_u_36.Disconnect()
                            v_u_51.CurrencyInstances[v_u_32] = nil
                            for _, v40 in v_u_32:GetChildren() do
                                v40.Transparency = 1
                            end
                            v_u_31:Destroy()
                            v_u_30:Destroy()
                            local v41 = v_u_14.Collect:Clone()
                            v41.Parent = v_u_29
                            for _, v42 in v41:GetChildren() do
                                v42:Emit(v42:GetAttribute("EmitCount") or 1)
                            end
                            local v43 = v_u_7
                            local v44 = v_u_13.Candy_Collect
                            local v45 = {}
                            local v46 = v_u_38
                            if v46 then
                                v46 = v_u_38.PrimaryPart
                            end
                            v45.Parent = v46
                            v45.Volume = 0.25
                            v45.PlaybackSpeed = v_u_8:NextNumber(0.995, 1.005)
                            v43:Play(v44, v45)
                            v_u_4:AddItem(v_u_32, 2.5)
						end-- regg was here
                    end)
                    if not v47 then
                        warn((("[%*]: Failed to properly invoke CollectCurrencyAsync due to: %*"):format(v_u_11, v48)))
                    end
                    v_u_35 = false
                else
                    v_u_35 = false
                end
            end
        end)
        v_u_29.Parent = v_u_32
        local v49 = workspace.Map.Ingame:FindFirstChild("CurrencyLocations")
        if not v49 then
            v49 = Instance.new("Folder")
            v49.Name = "CurrencyLocations"
            v49.Parent = workspace.Map.Ingame
		end-- regg was here
        v_u_32.PrimaryPart = v_u_29
        v_u_32.Parent = v49
        v_u_51.CurrencyInstances[v_u_32] = v_u_29.Position.Y
        p27:__checkAndCreateHeartbeat()
    end,
    ["ReplicateCandyDespawnAsync"] = function(_)
        local v50 = workspace.Map.Ingame:FindFirstChild("CurrencyLocations")
        if v50 then
            v50:ClearAllChildren()
            v50:Destroy()
        end
        v_u_15(v_u_51.CurrencyInstances)
        if v_u_51.Connections.OnHeartbeat then
            v_u_51.Connections.OnHeartbeat:Disconnect()
            v_u_51.Connections.OnHeartbeat = nil
        end
    end
}
return v_u_51





















-- regg was here