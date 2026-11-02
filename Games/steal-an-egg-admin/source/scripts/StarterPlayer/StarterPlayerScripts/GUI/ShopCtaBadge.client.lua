-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = Log.new()
local v2
local v3 = false

local function resolveControls() -- line 15 | captures: GUI
    local v4 = GUI.HUD()
    local v5
    if v4 == nil then
    else
        v5 = v4:FindFirstChild("GameHUD")
    end
    local v6
    if v5 == nil then
    else
        v6 = v5:FindFirstChild("LeftControls")
    end
    if v6 == nil then
        return nil, nil
    end
    local ShopBTN = v6:FindFirstChild("ShopBTN")
    local IndexBTN = v6:FindFirstChild("IndexBTN")
    local v7
    if IndexBTN == nil then
    else
        v7 = IndexBTN:FindFirstChild("NotificationBadge")
    end
    if not (ShopBTN ~= nil and ShopBTN:IsA("GuiObject")) then
        return nil, nil
    end
    if v7 ~= nil and v7:IsA("GuiObject") then
        return ShopBTN, v7
    end
    return ShopBTN, nil
end

local function buildBadge() -- line 50 | captures: v1, resolveControls
    local v8, v9 = resolveControls()
    if v8 ~= nil and v9 ~= nil then
        local ShopCtaBadge = v8:FindFirstChild("ShopCtaBadge")
        if ShopCtaBadge ~= nil then
            ShopCtaBadge:Destroy()
        end
        local v10 = v9:Clone()
        v10.Name = "ShopCtaBadge"
        for v11, v12 in v10:GetDescendants() do
            if v12:IsA("TextLabel") then
                v12.Text = "!"
            end
        end
        v10.Size = UDim2.new(v10.Size.X.Scale * 1.4, v10.Size.X.Offset * 1.4, v10.Size.Y.Scale * 1.4, v10.Size.Y.Offset * 1.4)
        v10.Visible = true
        v10.Parent = v8
        return v10
    end
    v1:AtWarning():Log("Shop CTA badge could not find ShopBTN or the index badge to clone")
    return nil
end

local function destroyBadge() -- line 73 | captures: v2, resolveControls
    v2 = nil
    local v13 = resolveControls()
    local v14
    if v13 == nil then
    else
        v14 = v13:FindFirstChild("ShopCtaBadge")
    end
    if v14 ~= nil then
        v14:Destroy()
    end
end

local function retire() -- line 86 | captures: v2, v3, Remotes, TryCall, resolveControls
    if v3 then
        return
    end
    v3 = true
    v2 = nil
    local v15 = resolveControls()
    local v16
    if v15 == nil then
    else
        v16 = v15:FindFirstChild("ShopCtaBadge")
    end
    if v16 ~= nil then
        v16:Destroy()
    end
    TryCall(function() -- line 102 | captures: Remotes
        return Remotes.ShopCta.FlagSeen:InvokeServer()
    end)
end

Tabs.Shown:Connect(function(v17) -- line 106 | captures: v2, v3, Remotes, TryCall, resolveControls
    local v18, v19
    if v17 == "Shop" then
        if v3 then
            v19 = true
        else
            v3 = true
            v2 = nil
            local v20 = resolveControls()
            if v20 == nil then
            else
                v18 = v20:FindFirstChild("ShopCtaBadge")
            end
            v19 = false
        end
    else
        v19 = true
    end
    if v19 then
        return
    end
    if v18 ~= nil then
        v18:Destroy()
    end
    TryCall(function() -- line 122 | captures: Remotes
        return Remotes.ShopCta.FlagSeen:InvokeServer()
    end)
end)
task.spawn(function() -- line 126 | captures: v2, v3, Remotes, Tabs, TryCall, resolveControls, buildBadge
    local v21, v22 = TryCall(function() -- line 128 | captures: Remotes
        return Remotes.ShopCta.FetchState:InvokeServer()
    end)
    if v21 and v22 == true then
        if v3 then
            if not v3 then
                v3 = true
                v2 = nil
                local v23 = resolveControls()
                local v24
                if v23 == nil then
                else
                    v24 = v23:FindFirstChild("ShopCtaBadge")
                end
                if v24 ~= nil then
                    v24:Destroy()
                end
                TryCall(function() -- line 153 | captures: Remotes
                    return Remotes.ShopCta.FlagSeen:InvokeServer()
                end)
            end
        elseif Tabs.Current() ~= "Shop" then
            v2 = buildBadge()
        end
    end
end)
