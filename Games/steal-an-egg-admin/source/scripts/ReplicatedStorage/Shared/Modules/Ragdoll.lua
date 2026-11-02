-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local RagdollJoints = require(ReplicatedStorage.Shared.Modules.RagdollJoints)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local t = require(ReplicatedStorage.Packages.t)
local v1

if RunService:IsServer() then
    v1 = require(ServerScriptService.Library.Modules.ClientCharacterAction)
end
local Physics = Enum.HumanoidStateType.Physics
local GettingUp = Enum.HumanoidStateType.GettingUp
local v2 = {}
local v3 = 0

local function heldBody(v4) -- line 24
    return v4:FindFirstChildOfClass("Humanoid")
end

local function isLimp(v5) -- line 27 | captures: Physics
    return v5:GetState() == Physics
end

local function goLimp(v6, v7) -- line 32 | captures: Physics
    local RootPart = v6.RootPart
    if RootPart then
        v6:ChangeState(Physics)
        if v7 and typeof(v7) == "Vector3" then
            RootPart:ApplyImpulse(v7)
        end
    end
end

local function standUp(v8) -- line 41 | captures: GettingUp
    local RootPart = v8.RootPart
    if RootPart then
        v8:ChangeState(GettingUp)
        RootPart.CanCollide = true
    end
end

local function beginFor(v9, v10, v11, v12) -- line 48 | captures: v1, Players, Physics
    local v13 = Players:GetPlayerFromCharacter(v9)
    if v13 then
        local v14 = v1
        assert(v14, "ClientCharacterAction is only available on the server").BeginRagdoll(v13, v9, v11, v12)
    else
        local RootPart = v10.RootPart
        if RootPart then
            v10:ChangeState(Physics)
            if v12 and typeof(v12) == "Vector3" then
                RootPart:ApplyImpulse(v12)
            end
        end
    end
end

local function endFor(v15, v16) -- line 62 | captures: v1, Players, GettingUp
    local v17 = Players:GetPlayerFromCharacter(v15)
    if v17 then
        local v18 = v1
        assert(v18, "ClientCharacterAction is only available on the server").EndRagdoll(v17, v15)
    elseif v16 then
        local RootPart = v16.RootPart
        if RootPart then
            v16:ChangeState(GettingUp)
            RootPart.CanCollide = true
        end
    end
end

local v19 = { ClientRagdollRemote = Remotes.Limpness.WriteLimpness }

function v19.IsRagdolled(v20) -- line 78 | captures: t, Physics, v2
    t.strict(t.instanceIsA("Model"))(v20)
    local Humanoid = v20:FindFirstChildOfClass("Humanoid")
    if v2[v20] == nil then
        if Humanoid == nil then
            return false
        end
        return Humanoid:GetState() == Physics
    end
    return true
end

function v19.Ragdoll(v21) -- line 92 | captures: v1, Players, RagdollJoints, Physics
    local Humanoid = v21:WaitForChild("Humanoid")
    if Humanoid:GetState() == Physics then
        return
    end
    Humanoid.BreakJointsOnDeath = false
    local v22 = Players:GetPlayerFromCharacter(v21)
    if v22 then
        local v23 = v1
        assert(v23, "ClientCharacterAction is only available on the server").BeginRagdoll(v22, v21, 5, nil)
    elseif Humanoid.RootPart then
        Humanoid:ChangeState(Physics)
    end
    RagdollJoints.Bind(v21)
end

function v19.NpcRagdoll(v24, v25) -- line 107 | captures: RagdollJoints, Physics, GettingUp
    local Humanoid = v24:FindFirstChild("Humanoid")
    if Humanoid then
        Humanoid.BreakJointsOnDeath = false
        if Humanoid:GetState() ~= Physics then
            Humanoid.PlatformStand = true
            Humanoid:ChangeState(Physics)
            RagdollJoints.Bind(v24)
            task.wait(v25)
            if v24 and v24.Parent then
                Humanoid.PlatformStand = false
                Humanoid:ChangeState(GettingUp)
                RagdollJoints.Release(v24)
            end
        end
    end
end

function v19.TimedRagdoll(v26, v27, v28) -- line 130 | captures: v1, v3, Players, RagdollJoints, Physics, GettingUp, v2
    local Humanoid = v26:WaitForChild("Humanoid")
    Humanoid.BreakJointsOnDeath = false
    local v29 = Humanoid:GetState() == Physics
    local v30 = v2[v26]
    v3 += 1
    local v31 = v3
    local v32 = if v30 then v30.OwnsConstraints else not v29
    v2[v26] = {
        Token = v31,
        OwnsConstraints = v32
    }
    if v30 == nil and not v29 then
        RagdollJoints.Bind(v26)
    end
    local v33 = Players:GetPlayerFromCharacter(v26)
    if v33 then
        local v34 = v1
        assert(v34, "ClientCharacterAction is only available on the server").BeginRagdoll(v33, v26, v27, v28)
    else
        local RootPart = Humanoid.RootPart
        if RootPart then
            Humanoid:ChangeState(Physics)
            if v28 and typeof(v28) == "Vector3" then
                RootPart:ApplyImpulse(v28)
            end
        end
    end
    task.wait(v27)
    local v35 = v2[v26]
    if v35 and v35.Token == v31 then
        v2[v26] = nil
        local v36 = Players:GetPlayerFromCharacter(v26)
        if v36 then
            local v37 = v1
            assert(v37, "ClientCharacterAction is only available on the server").EndRagdoll(v36, v26)
        elseif Humanoid then
            local RootPart = Humanoid.RootPart
            if RootPart then
                Humanoid:ChangeState(GettingUp)
                RootPart.CanCollide = true
            end
        end
    else
        return
    end
    if v35.OwnsConstraints then
        RagdollJoints.Release(v26)
    end
end

function v19.TimedRagdollAsync(v38, v39, v40) -- line 180
    task.spawn((nil).TimedRagdoll, v38, v39, v40)
end

function v19.ApplyClientRagdoll(v41, v42) -- line 183 | captures: RagdollJoints, Physics
    local Humanoid = v41:FindFirstChildOfClass("Humanoid")
    local v43 = Humanoid ~= nil
    local v44 = ("%* has no Humanoid to ragdoll"):format((v41:GetFullName()))
    assert(v43, v44)
    Humanoid.BreakJointsOnDeath = false
    local v45 = Humanoid:GetState() == Physics
    local RootPart = Humanoid.RootPart
    if RootPart then
        Humanoid:ChangeState(Physics)
        if v42 and typeof(v42) == "Vector3" then
            RootPart:ApplyImpulse(v42)
        end
    end
    if not v45 then
        RagdollJoints.Bind(v41)
    end
end

function v19.ClearClientRagdoll(v46) -- line 201 | captures: RagdollJoints, GettingUp
    local Humanoid = v46:FindFirstChildOfClass("Humanoid")
    local v47 = Humanoid ~= nil
    local v48 = ("%* has no Humanoid to stand up"):format((v46:GetFullName()))
    assert(v47, v48)
    local RootPart = Humanoid.RootPart
    if RootPart then
        Humanoid:ChangeState(GettingUp)
        RootPart.CanCollide = true
    end
    RagdollJoints.Release(v46)
end

function v19.Unragdoll(v49) -- line 212 | captures: v1, Players, RagdollJoints, GettingUp, v2
    v2[v49] = nil
    local Humanoid = v49:FindFirstChildOfClass("Humanoid")
    local v50 = Players:GetPlayerFromCharacter(v49)
    if v50 then
        local v51 = v1
        assert(v51, "ClientCharacterAction is only available on the server").EndRagdoll(v50, v49)
    elseif Humanoid then
        local RootPart = Humanoid.RootPart
        if RootPart then
            Humanoid:ChangeState(GettingUp)
            RootPart.CanCollide = true
        end
    end
    RagdollJoints.Release(v49)
end

return v19
