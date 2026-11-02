-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved soon!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-01-12 17:20:20
-- Luau version 6, Types version 3
-- Time taken: 0.006920 seconds

local clock_upvr = os.clock
local Workspace_upvr = game:GetService("Workspace")
local RunService_upvr = game:GetService("RunService")
local Part_upvr = Instance.new("Part")
Part_upvr.TopSurface = 0
Part_upvr.BottomSurface = 0
Part_upvr.Anchored = true
Part_upvr.CanCollide = false
Part_upvr.Locked = true
Part_upvr.CastShadow = false
Part_upvr.Name = "BoltPart"
Part_upvr.Material = Enum.Material.Neon
Part_upvr.Color = Color3.new(1, 1, 1)
Part_upvr.Transparency = 1
local function CubicBezier_upvr(arg1, arg2, arg3, arg4, arg5) -- Line 34, Named "CubicBezier"
    return arg2 * (1 - arg1) ^ 3 + arg3 * 3 * arg1 * (1 - arg1) ^ 2 + arg4 * 3 * (1 - arg1) * arg1 ^ 2 + arg5 * arg1 ^ 3
end
local function DiscretePulse_upvr(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 41, Named "DiscretePulse"
    return math.clamp((arg4) / (2 * arg5) - math.abs((arg1 - arg2 * arg3 + 0.5 * arg4) / arg5), arg6, arg7)
end
local function ExtrudeCenter_upvr(arg1) -- Line 45, Named "ExtrudeCenter"
    return math.exp(-5000 * (arg1 - 0.5) ^ 10)
end
local function _(arg1, arg2, arg3, arg4, arg5) -- Line 49, Named "NoiseBetween"
    return arg4 + (arg5 - arg4) * (math.noise(arg1, arg2, arg3) + 0.5)
end
local tbl_upvr = {}
local module_upvr = {
    __type = "LightningBolt";
}
module_upvr.__index = module_upvr
function module_upvr.new(arg1, arg2, arg3) -- Line 70
    --[[ Upvalues[8]:
        [1]: module_upvr (readonly)
        [2]: CubicBezier_upvr (readonly)
        [3]: DiscretePulse_upvr (readonly)
        [4]: ExtrudeCenter_upvr (readonly)
        [5]: Part_upvr (readonly)
        [6]: Workspace_upvr (readonly)
        [7]: clock_upvr (readonly)
        [8]: tbl_upvr (readonly)
    ]]
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.Enabled = true
    setmetatable_result1.Attachment0 = arg1
    setmetatable_result1.Attachment1 = arg2
    setmetatable_result1.CurveSize0 = 0
    setmetatable_result1.CurveSize1 = 0
    setmetatable_result1.MinRadius = 0
    setmetatable_result1.MaxRadius = 2.4
    setmetatable_result1.Frequency = 1
    setmetatable_result1.AnimationSpeed = 7
    setmetatable_result1.Thickness = 1
    setmetatable_result1.MinThicknessMultiplier = 0.2
    setmetatable_result1.MaxThicknessMultiplier = 1
    setmetatable_result1.MinTransparency = 0
    setmetatable_result1.MaxTransparency = 1
    setmetatable_result1.PulseSpeed = 2
    setmetatable_result1.PulseLength = 1000000
    setmetatable_result1.FadeLength = 0.2
    setmetatable_result1.ContractFrom = 0.5
    setmetatable_result1.Color = Color3.new(1, 1, 1)
    setmetatable_result1.ColorOffsetSpeed = 3
    setmetatable_result1.SpaceCurveFunction = CubicBezier_upvr
    setmetatable_result1.OpacityProfileFunction = DiscretePulse_upvr
    setmetatable_result1.RadialProfileFunction = ExtrudeCenter_upvr
    setmetatable_result1._Parts = {}
    for i = 1, arg3 or 30 do
        setmetatable_result1._Parts[i] = Part_upvr:Clone()
        setmetatable_result1._Parts[i].Parent = Workspace_upvr.Effects
    end
    setmetatable_result1._PartsHidden = false
    setmetatable_result1._DisabledTransparency = 1
    setmetatable_result1._StartT = clock_upvr()
    setmetatable_result1._RanNum = math.random() * 100
    setmetatable_result1._RefIndex = #tbl_upvr + 1
    tbl_upvr[setmetatable_result1._RefIndex] = setmetatable_result1
    return setmetatable_result1
end
function module_upvr.Destroy(arg1) -- Line 144
    --[[ Upvalues[1]:
        [1]: tbl_upvr (readonly)
    ]]
    tbl_upvr[arg1._RefIndex] = nil
    for i_2 = 1, #arg1._Parts do
        arg1._Parts[i_2]:Destroy()
    end
end
function module_upvr.DestroyDissipate(arg1, arg2, arg3) -- Line 154
    --[[ Upvalues[2]:
        [1]: clock_upvr (readonly)
        [2]: RunService_upvr (readonly)
    ]]
    local clock_upvr_result1_upvr = clock_upvr()
    local MinThicknessMultiplier_upvr = arg1.MinThicknessMultiplier
    local var14_upvw = arg2 or 0.2
    local MinTransparency_upvr = arg1.MinTransparency
    local ContractFrom_upvr = arg1.ContractFrom
    local var17_upvr = arg1.ContractFrom + (1) / (#arg1._Parts * arg1.FadeLength)
    local MaxRadius_upvr = arg1.MaxRadius
    local var19_upvw = arg3 or 0.5
    local var20_upvw
    var20_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 164
        --[[ Upvalues[11]:
            [1]: clock_upvr (copied, readonly)
            [2]: clock_upvr_result1_upvr (readonly)
            [3]: arg1 (readonly)
            [4]: MinThicknessMultiplier_upvr (readonly)
            [5]: var14_upvw (read and write)
            [6]: MinTransparency_upvr (readonly)
            [7]: ContractFrom_upvr (readonly)
            [8]: var17_upvr (readonly)
            [9]: MaxRadius_upvr (readonly)
            [10]: var19_upvw (read and write)
            [11]: var20_upvw (read and write)
        ]]
        local var21 = clock_upvr() - clock_upvr_result1_upvr
        arg1.MinThicknessMultiplier = MinThicknessMultiplier_upvr + (-2 - MinThicknessMultiplier_upvr) * var21 / var14_upvw
        if var21 < var14_upvw * 0.4 then
            arg1.MinTransparency = MinTransparency_upvr + (ContractFrom_upvr - MinTransparency_upvr) * ((var21) / (var14_upvw * 0.4))
        else
            if var21 < var14_upvw then
                local var22 = (var21 - var14_upvw * 0.4) / (var14_upvw * 0.6)
                arg1.MinTransparency = ContractFrom_upvr + (var17_upvr - ContractFrom_upvr) * var22
                arg1.MaxRadius = MaxRadius_upvr * (1 + var19_upvw * var22)
                arg1.MinRadius += (arg1.MaxRadius - arg1.MinRadius) * var22
                return
            end
            if clock_upvr() - arg1._StartT < (arg1.PulseLength + 1) / arg1.PulseSpeed then
                arg1:Destroy()
            end
            var20_upvw:Disconnect()
            var20_upvw = nil
        end
    end)
end
local any_inverse_result1_upvr = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):inverse()
function module_upvr._UpdateGeometry(arg1, arg2, arg3, arg4, arg5, arg6, arg7) -- Line 192
    --[[ Upvalues[1]:
        [1]: any_inverse_result1_upvr (readonly)
    ]]
    local any_OpacityProfileFunction_result1 = arg1.OpacityProfileFunction(arg3, arg4, arg1.PulseSpeed, arg1.PulseLength, arg1.FadeLength, 1 - arg1.MaxTransparency, 1 - arg1.MinTransparency)
    local var25 = arg1.Thickness * arg5 * any_OpacityProfileFunction_result1
    local var26
    local function INLINED() -- Internal function, doesn't exist in bytecode
        var26 = any_OpacityProfileFunction_result1
        return var26
    end
    if 0 >= var25 or not INLINED() then
        var26 = 0
    end
    local var27 = var26
    var26 = 1 - arg1.ContractFrom
    local len_2 = #arg1._Parts
    if var26 < var27 then
        arg2.Size = Vector3.new((arg7 - arg6).Magnitude, var25, var25)
        arg2.CFrame = CFrame.lookAt((arg6 + arg7) * 0.5, arg7) * any_inverse_result1_upvr
        arg2.Transparency = 1 - var27
    else
        if var26 - (1) / (len_2 * arg1.FadeLength) < var27 then
            local var29 = ((var27) - (var26 - (1) / (len_2 * arg1.FadeLength))) * len_2 * arg1.FadeLength
            if arg3 < arg4 * arg1.PulseSpeed - 0.5 * arg1.PulseLength then
                var29 = 1
            else
                var29 = -1
            end
            local var30 = (1 - var29) * var29
            arg2.Size = Vector3.new((1 - math.abs(var30)) * (arg7 - arg6).Magnitude, var25, var25)
            arg2.CFrame = CFrame.lookAt(arg6 + (arg7 - arg6) * (math.max(0, var30) + 0.5 * (1 - math.abs(var30))), arg7) * any_inverse_result1_upvr
            arg2.Transparency = 1 - var27
            return
        end
        arg2.Transparency = 1
    end
end
function module_upvr._UpdateColor(arg1, arg2, arg3, arg4) -- Line 238
    if typeof(arg1.Color) == "Color3" then
        arg2.Color = arg1.Color
    else
        local var32 = (arg1._RanNum + arg3 - arg4 * arg1.ColorOffsetSpeed) % 1
        local Keypoints = arg1.Color.Keypoints
        for i_6 = 1, #Keypoints - 1 do
            if Keypoints[i_6].Time < var32 and var32 < Keypoints[i_6 + 1].Time then
                arg2.Color = Keypoints[i_6].Value:lerp(Keypoints[i_6 + 1].Value, (var32 - Keypoints[i_6].Time) / (Keypoints[i_6 + 1].Time - Keypoints[i_6].Time))
                return
            end
        end
    end
end
function module_upvr._Disable(arg1) -- Line 256
    arg1.Enabled = false
    for _, v in ipairs(arg1._Parts) do
        v.Transparency = arg1._DisabledTransparency
    end
end
RunService_upvr.Heartbeat:Connect(function() -- Line 263
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: clock_upvr (readonly)
    ]]
    debug.profilebegin("LightningBolt")
    for _, v_2 in pairs(tbl_upvr) do
        if v_2.Enabled == true then
            v_2._PartsHidden = false
            local MinRadius = v_2.MinRadius
            local _Parts = v_2._Parts
            local len = #_Parts
            local _RanNum = v_2._RanNum
            local AnimationSpeed = v_2.AnimationSpeed
            local Frequency = v_2.Frequency
            local MinThicknessMultiplier = v_2.MinThicknessMultiplier
            local var56 = clock_upvr() - v_2._StartT
            local SpaceCurveFunction = v_2.SpaceCurveFunction
            local Attachment0 = v_2.Attachment0
            local Attachment1 = v_2.Attachment1
            local WorldPosition_2 = Attachment0.WorldPosition
            local var61 = Attachment0.WorldPosition + Attachment0.WorldAxis * v_2.CurveSize0
            local var62 = Attachment1.WorldPosition - Attachment1.WorldAxis * v_2.CurveSize1
            local WorldPosition = Attachment1.WorldPosition
            local var57_result1_2 = SpaceCurveFunction(0, WorldPosition_2, var61, var62, WorldPosition)
            if var56 < (v_2.PulseLength + 1) / v_2.PulseSpeed then
                for i_5 = 1, len do
                    local var65 = _Parts[i_5]
                    local var66 = i_5 / len
                    local var67 = AnimationSpeed * -var56 + Frequency * 10 * var66 - 0.2 + _RanNum * 4
                    local var68 = 5 * (AnimationSpeed * 0.01 * -var56 / 10 + Frequency * var66) + _RanNum * 4
                    local var57_result1 = SpaceCurveFunction(var66, WorldPosition_2, var61, var62, WorldPosition)
                    local var70
                    local function INLINED_2() -- Internal function, doesn't exist in bytecode
                        var70 = (CFrame.new(var57_result1_2, var57_result1) * CFrame.Angles(0, 0, (0 + 0.6283185307179586 * (math.noise(5 * var67, 1.5, 1 * var68) + 0.5)) + (0 + 5.654866776461628 * (math.noise(0.5 * var67, 1.5, 0.1 * var68) + 0.5))) * CFrame.Angles(math.acos(math.clamp(6.123233995736766e-17 + 0.9999999999999999 * (math.noise(var68, var67, 2.7) + 0.5), -1, 1)), 0, 0) * CFrame.new(0, 0, -((MinRadius + (v_2.MaxRadius - MinRadius) * (math.noise(3.4, var68, var67) + 0.5)) * v_2.RadialProfileFunction(var66)))).Position
                        return var70
                    end
                    if i_5 == len or not INLINED_2() then
                        var70 = var57_result1
                    end
                    v_2:_UpdateGeometry(var65, var66, var56, MinThicknessMultiplier + (v_2.MaxThicknessMultiplier - MinThicknessMultiplier) * (math.noise(2.3, var68, var67) + 0.5), var57_result1_2, var70)
                    v_2:_UpdateColor(var65, var66, var56)
                end
            else
                v_2:Destroy()
            end
        elseif v_2._PartsHidden == false then
            v_2._PartsHidden = true
            v_2:_Disable()
        end
    end
    debug.profileend()
end)
return module_upvr