-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("RunService")
local v2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(v3.Shared.VirtualInstance)
local v_u_5 = script.FastOverheadTemplate
local v6 = v_u_5.Size.Y / v_u_5.Size.X
local v_u_7 = {
    ["STANDARD"] = {
        ["distance"] = 80,
        ["size"] = Vector2.new(340, 340 * v6)
    },
    ["FAR"] = {
        ["distance"] = (1 / 0),
        ["size"] = Vector2.new(10, 10 * v6)
    }
}
local _ = v2.LocalPlayer
local v_u_8 = workspace.CurrentCamera
local v_u_9 = Vector3.new(0, 1, 0)
local v_u_10 = Vector3.new(0, 0, 1)
local v_u_11 = Vector3.new(0, 0, 0)
local v_u_12 = {}
local v_u_13 = {}
local v_u_14 = {}
return {
    ["createFastOverhead"] = function(p15)
        -- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_12
        local v16 = p15.adornee:IsA("BasePart") and "BasePart" or (p15.adornee:IsA("Attachment") and "Attachment" or error((("invalid adornee \"%*\""):format(p15.adornee))))
        local v_u_17 = v_u_5:Clone()
        v_u_17.CFrame = CFrame.new(0, 10000, 0)
        v_u_17.Parent = workspace.Debris
        local v18 = v_u_17.GUI
        local v_u_19 = {
            ["part"] = v_u_17,
            ["gui"] = v_u_4.wrap(v_u_17.GUI),
            ["adornee"] = p15.adornee,
            ["adorneeType"] = v16,
            ["studsOffsetY"] = p15.studsOffsetY or 2.5,
            ["adorneePosition"] = Vector3.new(0, 10000, 0),
            ["animal"] = p15.animal,
            ["lastPositionCheck"] = -1
        }
        local v20 = v_u_12
        table.insert(v20, v_u_19)
        local v_u_21 = nil
        local v_u_22 = false
        local function v24()
            -- upvalues: (ref) v_u_22, (copy) v_u_17, (ref) v_u_12, (copy) v_u_19, (ref) v_u_21
            if not v_u_22 then
                v_u_22 = true
                v_u_17:Destroy()
                local v23 = table.find(v_u_12, v_u_19)
                if v23 then
                    table.remove(v_u_12, v23)
                end
                if v_u_21 then
                    v_u_21:Disconnect()
                    v_u_21 = nil
                end
            end
        end
        v_u_21 = v18.Destroying:Connect(v24)
        return v_u_17.GUI, v24
    end,
    ["Start"] = function(_)
        -- upvalues: (copy) v_u_12, (ref) v_u_11, (copy) v_u_7, (ref) v_u_9, (ref) v_u_10, (copy) v_u_13, (copy) v_u_14, (copy) v_u_1, (copy) v_u_8
        local function v_u_30()
            -- upvalues: (ref) v_u_12, (ref) v_u_11, (ref) v_u_7
            for _, v25 in v_u_12 do
                local v26 = v25.adornee
                local v27 = v25.adorneeType
                local v28
                if v27 == "BasePart" then
                    v28 = v26.Position
                elseif v27 == "Attachment" then
                    v28 = v26.WorldPosition
                else
                    v28 = nil
                end
                v25.adorneePosition = v28
                local v29
                if (v_u_11 - v28).Magnitude < v_u_7.STANDARD.distance then
                    v29 = v_u_7.STANDARD.size
                else
                    v29 = v_u_7.FAR.size
                end
                v25.gui.CanvasSize = v29
            end
        end
        local function v_u_37()
            -- upvalues: (ref) v_u_12, (ref) v_u_9, (ref) v_u_10, (ref) v_u_13, (ref) v_u_14
            for _, v31 in v_u_12 do
                local v32 = v31.adorneePosition + v_u_9 * v31.studsOffsetY
                local v33 = CFrame.lookAlong(v32, -v_u_10)
                local v34 = v_u_13
                local v35 = v31.part
                table.insert(v34, v35)
                local v36 = v_u_14
                table.insert(v36, v33)
                v31.lastCFrame = v33
            end
            if #v_u_13 > 0 then
                workspace:BulkMoveTo(v_u_13, v_u_14, Enum.BulkMoveMode.FireCFrameChanged)
                table.clear(v_u_13)
                table.clear(v_u_14)
            end
        end
        v_u_1.PreRender:Connect(function(_)
            -- upvalues: (ref) v_u_8, (ref) v_u_10, (ref) v_u_9, (ref) v_u_11, (copy) v_u_30, (copy) v_u_37
            local v38 = v_u_8.CFrame
            v_u_10 = v38.LookVector
            v_u_9 = v38.UpVector
            v_u_11 = v38.Position
            v_u_30()
            v_u_37()
        end)
    end
}