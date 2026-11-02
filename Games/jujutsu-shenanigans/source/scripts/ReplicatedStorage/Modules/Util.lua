local RunService_upvr = game:GetService("RunService")
local module_upvr = {}
local tbl_upvr_2 = {}
local tbl_upvr = {}

function module_upvr.EmitParticlesAlt(arg1, arg2) -- Line 12
    for _, v in pairs(arg2:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            v:Emit(v:GetAttribute("EmitCount"), v:GetAttribute("EmitDelay"))
        end
    end
end
function module_upvr.AddToCoreLoop(arg1, arg2)
    table.insert(tbl_upvr_2, arg2)
end
function module_upvr.FetchQuickPart(arg1)
    local Part = Instance.new("Part")
    Part.Anchored = false
    Part.CanCollide = false
    Part.Transparency = 1
    Part.CanCollide = false
    Part.CastShadow = false
    Part.Massless = true
    Part.CanQuery = false
    return Part
end
function module_upvr.AddTempFunction(arg1, arg2, arg3)
    local var11
    if arg3 or true then
        local tbl_2 = {}
        tbl_2.callback = arg2
        tbl_2.Creation = os.clock()
        tbl_2.HasWarned = false
        tbl_2.traceback = debug.traceback()
        var11 = tbl_2
    else
        local tbl = {}
        tbl.callback = arg2
        tbl.DONTWARN = true
        var11 = tbl
    end
    table.insert(tbl_upvr, var11)
end
function module_upvr.BindWithSpacing(arg1, arg2, arg3, arg4, arg5)
    local os_clock_result1_upvw_2 = os.clock()
    local var16_upvw = false
    module_upvr:AddTempFunction(function()
        local var17 = os.clock() - os_clock_result1_upvw_2
        if arg3 < var17 then
            os_clock_result1_upvw_2 = os.clock() + arg3
            arg2((os.clock() - os_clock_result1_upvw_2) / arg4, var17, Lerp(1, 0, (os.clock() - os_clock_result1_upvw_2) / arg4), os.clock() - os_clock_result1_upvw_2)
        end
        if not var16_upvw and arg4 < os.clock() - os_clock_result1_upvw_2 then
            var16_upvw = true
            if arg5 then
                arg5((os.clock() - os_clock_result1_upvw_2) / arg4, var17)
            end
            return true
        end
    end)
end
local TweenService_upvr = game:GetService("TweenService")
function module_upvr.FadePointLightIn(arg1, arg2, arg3)
    arg2.Brightness = 0
    arg2.Range = 0
    TweenService_upvr:Create(arg2, TweenInfo.new(arg3), {
        Brightness = arg2.Brightness;
        Range = arg2.Range;
    }):Play()
end
function module_upvr.DisableAllVisuals(arg1, arg2)
    for _, v_2 in ipairs(arg2:GetDescendants()) do
        if v_2:IsA("ParticleEmitter") or v_2:IsA("Beam") or v_2:IsA("Trail") or v_2:IsA("PointLight") then
            v_2.Enabled = false
        end
    end
end
function module_upvr.EnabledAllVisuals(arg1, arg2)
    for _, v_3 in pairs(arg2:GetDescendants()) do
        if v_3:IsA("ParticleEmitter") or v_3:IsA("Beam") or v_3:IsA("Trail") or v_3:IsA("PointLight") then
            v_3.Enabled = true
        end
    end
end
function module_upvr.EmitAllParticles(arg1, arg2)
    for _, v_4 in ipairs(arg2:GetDescendants()) do
        if v_4:IsA("ParticleEmitter") then
            v_4:Emit(v_4.Rate)
        end
    end
end
function module_upvr.ScaleParticles(arg1, arg2, arg3)
	local var51
	
    for _, v_5 in pairs(arg2:GetDescendants()) do
        if v_5:IsA("ParticleEmitter") then
            for i_6 = 1, #v_5.Size.Keypoints do
                table.insert({}, NumberSequenceKeypoint.new(v_5.Size.Keypoints[i_6].Time, v_5.Size.Keypoints[i_6].Value * arg3, v_5.Size.Keypoints[i_6].Envelope))
            end
            v_5.Speed = NumberRange.new(v_5.Speed.Min * arg3, v_5.Speed.Max * arg3)
            v_5.Acceleration *= arg3
            v_5.Size = NumberSequence.new(var51)
            table.clear(var51)
        end
    end
end
local function Lerp(arg1, arg2, arg3)
    return arg1 + (arg2 - arg1) * arg3
end
Lerp = Lerp
function module_upvr.Lerp(arg1, arg2, arg3, arg4)
    return arg2 + (arg3 - arg2) * arg4
end
local random_state_upvr = Random.new(12312)
function module_upvr.ReturnRandomAngle(arg1)
    return CFrame.Angles(random_state_upvr:NextNumber(-360, 360), random_state_upvr:NextNumber(-360, 360), random_state_upvr:NextNumber(-360, 360))
end
function module_upvr.ConvertNormalPosToCF(arg1, arg2, arg3)
    local UpVector = CFrame.lookAt(arg3, arg3 + arg2).UpVector
    return CFrame.fromMatrix(arg3, -UpVector:Cross(arg2), arg2, UpVector)
end
function module_upvr.UnixConnection2(arg1, arg2, arg3, arg4, arg5)
    local var55_upvw = false
    local tick_result1_upvr = tick()
    local var57_upvw = false
    module_upvr:AddTempFunction(function(arg1_2)
        local var58
        if tick() >= tick_result1_upvr + arg2 then
            var58 = false
        else
            var58 = true
        end
        var55_upvw = not var58
        if arg3 then
            if arg4 and arg4() or arg4 == nil or not var55_upvw then
                var58 = tick() - tick_result1_upvr
                local var59 = var58 / arg2
                var58 = Lerp(1, 0, var59)
                arg3(var59, arg1_2, var58, tick() - tick_result1_upvr)
                return
            end
        end
        if not var57_upvw then
            var57_upvw = true
            if arg3 and var55_upvw then
                var58 = 1
                arg3(var58, arg1_2, 0, arg2)
            end
            if arg5 then
                var58 = 1
                arg5(var58, arg1_2, 0)
            end
            return true
        end
    end)
end
local function UnixConnection(arg1, arg2, arg3, arg4, arg5)
    local var60
    if RunService_upvr:IsClient() then
        var60 = RunService_upvr.RenderStepped
    else
        var60 = RunService_upvr.Heartbeat
    end
    local var62_upvw = false
    local var63_upvw = false
    local os_clock_result1_upvr = os.clock()
    local var65_upvw
    var65_upvw = var60:Connect(function(arg1_3)
        local var66
        var62_upvw = true
        if os.clock() >= os_clock_result1_upvr + arg2 then
            var66 = false
        else
            var66 = true
        end
        var63_upvw = not var66
    end)
    return var65_upvw
end
module_upvr.UnixConnection = UnixWithFrequency
function UnixWithFrequency(arg1, arg2, arg3, arg4, arg5)
    local os_clock_result1_upvw = os.clock()
    local var69
    if RunService_upvr:IsServer() then
        var69 = RunService_upvr.Heartbeat
    else
        var69 = RunService_upvr.RenderStepped
    end
    local var71_upvw
    var71_upvw = var69:Connect(function(arg1_4)
        local var73 = os.clock() - os_clock_result1_upvw
        if arg3 < var73 then
            os_clock_result1_upvw = os.clock()
            arg4((os.clock() - os_clock_result1_upvw) / arg2, var73)
        end
        if var71_upvw and arg2 < os.clock() - os_clock_result1_upvw then
            var71_upvw:Disconnect()
            var71_upvw = nil
            if arg5 then
                arg5(1, var73)
            end
        end
    end)
end
local var67 = UnixWithFrequency
module_upvr.UnixWithFrequency = var67
if RunService_upvr:IsServer() then
    var67 = RunService_upvr.Heartbeat
else
    var67 = RunService_upvr.RenderStepped
end
var67:Connect(function(arg1)
    for _, v_6 in pairs(tbl_upvr_2) do
        v_6(arg1)
    end
    for _, v_7 in pairs(tbl_upvr) do
        if v_7.callback(arg1) then
            table.remove(tbl_upvr, table.find(tbl_upvr, v_7))
        end
    end
end)
return module_upvr