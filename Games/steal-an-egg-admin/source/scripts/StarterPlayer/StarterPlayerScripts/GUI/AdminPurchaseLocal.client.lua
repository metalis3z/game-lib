-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local MonetizationRequest = ReplicatedStorage:WaitForChild("MonetizationRequest")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v1 = {}

local function bind(v2) -- line 7 | captures: LocalPlayer, MonetizationRequest, v1
    local Lock, v3, v4
    if v2.Name == "AdminPanel" and v2:IsA("GuiObject") then
        if v1[v2] then
            v4 = true
        else
            Lock = v2:FindFirstChild("Lock")
            v3 = Lock and Lock:FindFirstChild("ClickBlocker")
            v4 = false
        end
    else
        v4 = true
    end
    if v4 then
        return
    end
    local v5, v6
    if v3 then
        v5 = v3:FindFirstChild("Permanet")
        v6 = v3:FindFirstChild("Temp")
    else
        v5 = v3
        v6 = v3
    end
    local v7
    if v5 and v6 then
        v1[v2] = true
        v3.Active = true
        v7 = (-1/0)

        local function prompt(v8) -- line 17 | captures: v7, MonetizationRequest
            if not (os.clock() - v7 < 2) then
                v7 = os.clock()
                MonetizationRequest:FireServer(v8)
            end
        end

        v5.Activated:Connect(function() -- line 22 | captures: v7, MonetizationRequest
            if not (os.clock() - v7 < 2) then
                v7 = os.clock()
                MonetizationRequest:FireServer("AdminPermanent")
            end
        end)
        v6.Activated:Connect(function() -- line 23 | captures: v7, MonetizationRequest
            if not (os.clock() - v7 < 2) then
                v7 = os.clock()
                MonetizationRequest:FireServer("AdminTemporary")
            end
        end)
        local Lock_2 = Lock

        local function refresh() -- line 24 | captures: Lock_2, LocalPlayer
            Lock_2.Visible = LocalPlayer:GetAttribute("HasAdminAccess") ~= true
        end

        LocalPlayer:GetAttributeChangedSignal("HasAdminAccess"):Connect(refresh)
        v2:GetPropertyChangedSignal("Visible"):Connect(function() -- line 28 | captures: v7, v2, Lock_2, LocalPlayer, MonetizationRequest
            Lock_2.Visible = LocalPlayer:GetAttribute("HasAdminAccess") ~= true
            if not (v2.Visible and LocalPlayer:GetAttribute("HasPermanentAdmin") ~= true) then
                return
            end
            if os.clock() - v7 < 2 then
                return
            end
            v7 = os.clock()
            MonetizationRequest:FireServer("AdminPermanent")
        end)
        Lock.Visible = LocalPlayer:GetAttribute("HasAdminAccess") ~= true
    else
        return
    end
    if v2.Visible and LocalPlayer:GetAttribute("HasPermanentAdmin") ~= true and not (os.clock() - v7 < 2) then
        v7 = os.clock()
        MonetizationRequest:FireServer("AdminPermanent")
    end
end

for v9, v10 in PlayerGui:GetDescendants() do
    bind(v10)
end
PlayerGui.DescendantAdded:Connect(function(v11) -- line 36 | captures: PlayerGui, bind
    task.defer(function() -- line 37 | captures: v11, PlayerGui, bind
        local v12 = v11
        while v12 do
            if v12 == PlayerGui then
                break
            end
            bind(v12)
            v12 = v12.Parent
        end
    end)
end)
