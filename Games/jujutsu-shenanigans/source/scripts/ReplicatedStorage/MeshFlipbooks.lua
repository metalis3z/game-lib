-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_Thrown_0 = game.Workspace.Thrown;
local l_RunService_0 = game:GetService("RunService");
local v3 = {};
v3.new = function(v4)
    local v5 = setmetatable({}, v3);
    v5.start = not v4 and tick() or nil;
    v5.freezeStart = nil;
    v5.freezeTimeSubtract = 0;
    return v5;
end;
v3.GetTimePassed = function(v6)
    return tick() - v6;
end;
v3.Reset = function(v7)
    v7.start = tick();
    v7.freezeStart = nil;
    v7.freezeTimeSubtract = 0;
end;
v3.UpdateFreezeTimeSub = function(v8)
    local l_freezeStart_0 = v8.freezeStart;
    if not l_freezeStart_0 then
        return false;
    else
        v8.freezeTimeSubtract = v8.freezeTimeSubtract + v3.GetTimePassed(l_freezeStart_0);
        v8.freezeStart = tick();
        return true;
    end;
end;
v3.Freeze = function(v10)
    if v10:UpdateFreezeTimeSub() then
        return ;
    else
        v10.freezeStart = tick();
        return ;
    end;
end;
v3.Unfreeze = function(v11)
    v11:UpdateFreezeTimeSub();
    v11.freezeStart = nil;
end;
v3.HasPassedTime = function(v12, v13, v14)
    if not v12.start or v13 <= v12() then
        if not v14 then
            v12:Reset();
        end;
        return true;
    else
        return false;
    end;
end;
v3.GetStopwatchTime = function(v15)
    local v16 = tick();
    v15.start = v15.start or v16;
    v15:UpdateFreezeTimeSub();
    return v3.GetTimePassed(v15.start) - v15.freezeTimeSubtract;
end;
v3.GetAlpha = function(v17, v18, v19, v20)
    local v21 = (v17() + (v20 or 0)) / v18;
    if v19 then
        return v21;
    else
        return (math.clamp(v21, 0, 1));
    end;
end;
v3.newTimer = function(v22, v23, v24)
    v24 = v24 or 0;
    local v25 = v3.new();
    local v26 = v3.new();
    while not v25:HasPassedTime(v22 + v24, true) and not v23(v25:GetAlpha(v22, nil, v24), v25(), v26()) do
        v26:Reset();
        l_RunService_0.Heartbeat:Wait();
    end;
end;
v3.__index = v3;
v3.__call = function(v27)
    return v27:GetStopwatchTime();
end;
local v30 = {
    Random = function(v28, v29)
        return Random.new():NextNumber(v28 or 0.8, v29 or 1.2);
    end, 
    RandomReverseMutlipler = function()
        if math.random(0, 1) == 1 then
            return 1;
        else
            return -1;
        end;
    end
};
v30.RandomRotation = function()
    return v30.Random(-6.283185307179586, 6.283185307179586);
end;
v30.Round = function(v31, v32)
    v32 = v32 or 0;
    local v33 = math.round(v31 * 10 ^ v32) * 10 ^ (-v32);
    return (tonumber(string.format("%." .. v32 .. "f", v33)));
end;
v30.NumberToVector3 = function(v34)
    return (Vector3.new(v34, v34, v34));
end;
v30.ScaleValue = function(v35, v36, v37)
    local v38 = {};
    local function _(v39)
        return v37 * v39 / v35;
    end;
    v38.NumberSequence = function()
        local v41 = {};
        for v42, v43 in pairs(v36.Keypoints) do
            v41[v42] = NumberSequenceKeypoint.new(v43.Time, v37 * v43.Value / v35, v37 * v43.Envelope / v35);
        end;
        return NumberSequence.new(v41);
    end;
    v38.NumberRange = function()
        return NumberRange.new(v37 * v36.Min / v35, v37 * v36.Max / v35);
    end;
    v38.Default = function()
        return v37 * v36 / v35;
    end;
    return (v38[typeof(v36)] or v38.Default)();
end;
v30.GetRootScaleValues = function(v44)
    return Vector3.new(2, 2, 1, 0).Magnitude, v44.Magnitude;
end;
v30.GetLargestAxis = function(v45)
    local v46 = {
        size = v45.X, 
        name = "X"
    };
    local function _(v47)
        local v48 = v45[v47];
        if v46.size <= v48 then
            v46.size = v48;
            v46.name = v47;
        end;
    end;
    local l_Y_0 = v45.Y;
    if v46.size <= l_Y_0 then
        v46.size = l_Y_0;
        v46.name = "Y";
    end;
    l_Y_0 = v45.Z;
    if v46.size <= l_Y_0 then
        v46.size = l_Y_0;
        v46.name = "Z";
    end;
    return v46.size, v46.name;
end;
v30.SineBetween = function(v51, v52, v53, v54, v55)
    return ((v52 - v53) * math.sin(v51 * v54 + v55) + v52 + v53) / 2;
end;
local v56 = {};
v56.__index = v56;
v56.new = function(v57, v58)
    local v59 = setmetatable({}, v56);
    v59.ImageObject = v57;
    v59.TextureParamName = v58 or "Texture";
    return v59;
end;
v56.Play = function(v60, v61, v62, v63, v64)
    local v65 = v3.new();
    local function _()
        local v66 = v65() / v62;
        if v63 then
            v66 = v63(v66);
        end;
        v60.ImageObject[v60.TextureParamName] = v56.GetTextureFromAlpha(v61, v66);
    end;
    task.spawn(function()
        while not v65:HasPassedTime(v62) do
            local v68 = v65() / v62;
            if v63 then
                v68 = v63(v68);
            end;
            v60.ImageObject[v60.TextureParamName] = v56.GetTextureFromAlpha(v61, v68);
            task.wait();
        end;
        if v64 then
            v60:Delete();
        end;
    end);
end;
v56.Delete = function(v69)
    for v70, _ in v69 do
        v69[v70] = nil;
    end;
end;
v56.GetTextureFromAlpha = function(v72, v73)
    local v74 = #v72;
    return v72[math.clamp(math.round(v73 * v74), 1, v74)];
end;
v56.SetTextureFromAlpha = function(v75, v76, v77)
    v75.ImageObject[v75.TextureParamName] = v56.GetTextureFromAlpha(v76, v77);
end;
local v78 = {
    Wind0 = {
        [1] = "rbxassetid://11461678568", 
        [2] = "rbxassetid://11461678488", 
        [3] = "rbxassetid://11461678409", 
        [4] = "rbxassetid://11461678313", 
        [5] = "rbxassetid://11461678244", 
        [6] = "rbxassetid://11461675803", 
        [7] = "rbxassetid://11461675738", 
        [8] = "rbxassetid://11461675605", 
        [9] = "rbxassetid://11461675546", 
        [10] = "rbxassetid://11461675422", 
        [11] = "rbxassetid://11461675356"
    }, 
    Wind1 = {
        "rbxassetid://12709087413", 
        "rbxassetid://12709089414", 
        "rbxassetid://12709091338", 
        "rbxassetid://12709052082", 
        "rbxassetid://12709051925", 
        "rbxassetid://12709051840", 
        "rbxassetid://12709046645", 
        "rbxassetid://12709046514", 
        "rbxassetid://12709046410", 
        "rbxassetid://12709046344", 
        "rbxassetid://12709046207", 
        "rbxassetid://12709046012", 
        "rbxassetid://12709041406", 
        "rbxassetid://12709041294", 
        "rbxassetid://12709041173", 
        "rbxassetid://12709041095", 
        "rbxassetid://12709040977", 
        "rbxassetid://12709040841", 
        "rbxassetid://12709035460", 
        "rbxassetid://12709035361", 
        "rbxassetid://12709035226", 
        "rbxassetid://12709035099", 
        "rbxassetid://12709034940", 
        "rbxassetid://12709034804", 
        "rbxassetid://12709029886", 
        "rbxassetid://12709029739", 
        "rbxassetid://12709029558", 
        "rbxassetid://12709029448", 
        "rbxassetid://12709029377", 
        "rbxassetid://12709029200"
    }, 
    Wind2 = {
        [1] = "rbxassetid://13470338298", 
        [2] = "rbxassetid://13470338205", 
        [3] = "rbxassetid://13470338069", 
        [4] = "rbxassetid://13470337936", 
        [5] = "rbxassetid://13470337799", 
        [6] = "rbxassetid://13470337705", 
        [7] = "rbxassetid://13470337605", 
        [8] = "rbxassetid://13470337504", 
        [9] = "rbxassetid://13470337307", 
        [10] = "rbxassetid://13470337065", 
        [11] = "rbxassetid://13470336871", 
        [12] = "rbxassetid://13470336729", 
        [13] = "rbxassetid://13470336566", 
        [14] = "rbxassetid://13470336437", 
        [15] = "rbxassetid://13470336294", 
        [16] = "rbxassetid://13470336113", 
        [17] = "rbxassetid://13470336008", 
        [18] = "rbxassetid://13470335851", 
        [19] = "rbxassetid://13470335752", 
        [20] = "rbxassetid://13470335638"
    }, 
    Wind3 = {
        [1] = "rbxassetid://15583581350", 
        [2] = "rbxassetid://15583581268", 
        [3] = "rbxassetid://15583581163", 
        [4] = "rbxassetid://15583581073", 
        [5] = "rbxassetid://15583580947", 
        [6] = "rbxassetid://15583580830", 
        [7] = "rbxassetid://15583580724", 
        [8] = "rbxassetid://15583580608", 
        [9] = "rbxassetid://15583580488", 
        [10] = "rbxassetid://15583580288", 
        [11] = "rbxassetid://15583580138", 
        [12] = "rbxassetid://15583580039", 
        [13] = "rbxassetid://15583579925", 
        [14] = "rbxassetid://15583579776", 
        [15] = "rbxassetid://15583579583", 
        [16] = "rbxassetid://15583579386", 
        [17] = "rbxassetid://15583579213", 
        [18] = "rbxassetid://15583579007", 
        [19] = "rbxassetid://15583578841", 
        [20] = "rbxassetid://15583578616", 
        [21] = "rbxassetid://15583578452", 
        [22] = "rbxassetid://15583578183"
    }, 
    DiceyWind0 = {
        [1] = "rbxassetid://13769737333", 
        [2] = "rbxassetid://13769737186", 
        [3] = "rbxassetid://13769737005", 
        [4] = "rbxassetid://13769736812", 
        [5] = "rbxassetid://13769759577", 
        [6] = "rbxassetid://13769736174", 
        [7] = "rbxassetid://13769735915", 
        [8] = "rbxassetid://13769735699", 
        [9] = "rbxassetid://13769735432", 
        [10] = "rbxassetid://13769735245", 
        [11] = "rbxassetid://13769734982"
    }, 
    Slash0 = {
        [1] = "rbxassetid://13204898262", 
        [2] = "rbxassetid://13204897736", 
        [3] = "rbxassetid://13204897313", 
        [4] = "rbxassetid://13204896833", 
        [5] = "rbxassetid://13204896227", 
        [6] = "rbxassetid://13204895744", 
        [7] = "rbxassetid://13204895210", 
        [8] = "rbxassetid://13204894750", 
        [9] = "rbxassetid://13204894286", 
        [10] = "rbxassetid://13204893811", 
        [11] = "rbxassetid://13204893290", 
        [12] = "rbxassetid://13204892795", 
        [13] = "rbxassetid://13204892226", 
        [14] = "rbxassetid://13204891702", 
        [15] = "rbxassetid://13204891035", 
        [16] = "rbxassetid://13204890584", 
        [17] = "rbxassetid://13204890049", 
        [18] = "rbxassetid://13204889468", 
        [19] = "rbxassetid://13204888992"
    }, 
    SlashWind0 = {
        "rbxassetid://14127444698", 
        "rbxassetid://14127393320", 
        "rbxassetid://14127393204", 
        "rbxassetid://14127393113", 
        "rbxassetid://14127392987", 
        "rbxassetid://14127392831", 
        "rbxassetid://14127392695", 
        "rbxassetid://14127392572", 
        "rbxassetid://14127392433", 
        "rbxassetid://14127392308", 
        "rbxassetid://14127448226", 
        "rbxassetid://14127392018", 
        "rbxassetid://14127391892"
    }, 
    UpLines0 = {
        [1] = "rbxassetid://14334428426", 
        [2] = "rbxassetid://14334428426", 
        [3] = "rbxassetid://14334428243", 
        [4] = "rbxassetid://14334428107", 
        [5] = "rbxassetid://14334427908", 
        [6] = "rbxassetid://14334427593", 
        [7] = "rbxassetid://14334427593", 
        [8] = "rbxassetid://14334427409", 
        [9] = "rbxassetid://14334427313", 
        [10] = "rbxassetid://14334427189", 
        [11] = "rbxassetid://14334427002", 
        [12] = "rbxassetid://14334427002", 
        [13] = "rbxassetid://14334426739", 
        [14] = "rbxassetid://14334426626"
    }, 
    UpLines1 = {
        "rbxassetid://16349253150", 
        "rbxassetid://16349253003", 
        "rbxassetid://16349252865", 
        "rbxassetid://16349252630", 
        "rbxassetid://16349252435", 
        "rbxassetid://16349252319", 
        "rbxassetid://16349252232", 
        "rbxassetid://16349252127", 
        "rbxassetid://16349251934", 
        "rbxassetid://16349251721", 
        "rbxassetid://16349251510", 
        "rbxassetid://16349251398", 
        "rbxassetid://16349251243", 
        "rbxassetid://16349251093", 
        "rbxassetid://16349250958"
    }, 
    DotDissolve = {
        [1] = "rbxassetid://15494257040", 
        [2] = "rbxassetid://15494256947", 
        [3] = "rbxassetid://15494256825", 
        [4] = "rbxassetid://15494254516", 
        [5] = "rbxassetid://15494254445", 
        [6] = "rbxassetid://15494254370", 
        [7] = "rbxassetid://15494254273", 
        [8] = "rbxassetid://15494254222", 
        [9] = "rbxassetid://15494254167", 
        [10] = "rbxassetid://15494254118", 
        [11] = "rbxassetid://15494254073", 
        [12] = "rbxassetid://15494254030", 
        [13] = "rbxassetid://15494253978", 
        [14] = "rbxassetid://15494253921", 
        [15] = "rbxassetid://15494253857", 
        [16] = "rbxassetid://15494253812", 
        [17] = "rbxassetid://15494253754", 
        [18] = "rbxassetid://15494253685", 
        [19] = "rbxassetid://15494253626", 
        [20] = "rbxassetid://15494253569", 
        [21] = "rbxassetid://15494253511", 
        [22] = "rbxassetid://15494253430", 
        [23] = "rbxassetid://15494253331", 
        [24] = "rbxassetid://15494253331", 
        [25] = "rbxassetid://15494253227", 
        [26] = "rbxassetid://15494285181", 
        [27] = "rbxassetid://15494289522", 
        [28] = "rbxassetid://15494253021", 
        [29] = "rbxassetid://15494252936"
    }, 
    SphereWind0 = {
        "rbxassetid://15117059121", 
        "rbxassetid://15117060921", 
        "rbxassetid://15117061899", 
        "rbxassetid://15117062959", 
        "rbxassetid://15117062959", 
        "rbxassetid://15117065207", 
        "rbxassetid://15117066547", 
        "rbxassetid://15117067537"
    }
};
v78.__index = v78;
v78.new = function(v79, v80, v81, v82, v83, v84)
    local v85 = setmetatable({}, v78);
    v83 = v83 or Vector3.new(0.5, 0);
    v84 = v84 or Color3.fromRGB(330, 510, 498);
    local v86 = game.ReplicatedStorage.Resources.Claw.FlipbookMeshes[v79]:Clone();
    local l_Mesh_0 = v86.Mesh;
    local l_Decal_0 = v86.Decal;
    local l_CFrameValue_0 = Instance.new("CFrameValue");
    local function v92()
        local l_WeldPart_0 = v85.WeldPart;
        local l_Value_0 = l_CFrameValue_0.Value;
        v86.CFrame = if l_WeldPart_0 then l_WeldPart_0.CFrame:ToWorldSpace(l_Value_0) else l_Value_0;
    end;
    local v96 = v81 and v81.Changed:Connect(function(v93)
        if v93 ~= "CFrame" then
            return ;
        else
            local l_WeldPart_1 = v85.WeldPart;
            local l_Value_1 = l_CFrameValue_0.Value;
            v86.CFrame = if l_WeldPart_1 then l_WeldPart_1.CFrame:ToWorldSpace(l_Value_1) else l_Value_1;
            return ;
        end;
    end);
    l_CFrameValue_0.Changed:Connect(v92);
    local v97 = v56.new(l_Decal_0);
    v85.Part = v86;
    v85.Mesh = l_Mesh_0;
    v85.Decal = l_Decal_0;
    v85.Flipbook = v97;
    v85.Textures = v80;
    v85.CFValue = l_CFrameValue_0;
    v85.WeldPart = v81;
    v85.WeldPartStartCF = v81 and v81.CFrame;
    v85.WeldUpdate = v96;
    l_Mesh_0.Scale = v83;
    l_Decal_0.Color3 = v84;
    l_CFrameValue_0.Value = v85:ConvertCFrame(v82);
    v86.Parent = l_Thrown_0;
    v85:SetTextureFromAlpha(0);
    return v85;
end;
v78.Tween = function(v98, v99, v100, v101, v102)
    local v103 = l_TweenService_0:Create(v98[v99], v100, v101);
    if not v102 then
        v103:Play();
    end;
    return v103;
end;
v78.TweenDecal = function(v104, v105, v106, v107)
    return v104:Tween("Decal", v105, v106, v107);
end;
v78.TweenPart = function(v108, v109, v110, v111)
    return v108:Tween("Part", v109, v110, v111);
end;
v78.TweenMesh = function(v112, v113, v114, v115)
    return v112:Tween("Mesh", v113, v114, v115);
end;
v78.TweenTransparency = function(v116, v117, v118, v119)
    return v116:TweenDecal(v118, {
        Transparency = v117
    }, v119);
end;
v78.TweenCFrame = function(v120, v121, v122, v123)
    return v120:Tween("CFValue", v122, {
        Value = v120:ConvertCFrame(v121)
    }, v123);
end;
v78.SetTransparency = function(v124, v125)
    v124.Decal.Transparency = v125;
end;
v78.SetCFrame = function(v126, v127)
    v126.CFValue.Value = v126:ConvertCFrame(v127);
end;
v78.ConvertCFrame = function(v128, v129)
    local l_WeldPart_2 = v128.WeldPart;
    local _ = nil;
    if l_WeldPart_2 then
        return (v128.WeldPartStartCF:ToObjectSpace(v129));
    else
        return v129;
    end;
end;
v78.TweenSize = function(v132, v133, v134, v135)
    return v132:TweenMesh(v134, {
        Scale = v133
    }, v135);
end;
v78.Play = function(v136, v137, v138, v139, v140)
    v136.WeldPartStartCF = v136.WeldPart and v136.WeldPart.CFrame;
    v136.Flipbook:Play(v136.Textures or v140, v137, v138, true);
    if not v139 then
        task.delay(v137, function()
            v136:Destroy();
        end);
    end;
end;
v78.SetTextureFromAlpha = function(v141, v142)
    v141.Flipbook:SetTextureFromAlpha(v141.Textures, v142);
end;
v78.Destroy = function(v143)
    v143.CFValue:Destroy();
    v143.Part:Destroy();
    if v143.WeldUpdate then
        v143.WeldUpdate:Disconnect();
    end;
    for v144, _ in v143 do
        v143[v144] = nil;
    end;
end;
v78.LoadSphereFlipbook = function(...)
    return v78.LoadFlipbook("Sphere", ...);
end;
v78.CreateWind0Flipbook = function(...)
    return v78.new("Cone", v78.Wind0, ...);
end;
v78.CreateWind1Flipbook = function(...)
    return v78.new("Sphere", v78.Wind1, ...);
end;
v78.CreateWind2Flipbook = function(...)
    return v78.new("Sphere", v78.Wind2, ...);
end;
v78.CreateWind3Flipbook = function(...)
    return v78.new("Sphere", v78.Wind3, ...);
end;
v78.CreateDiceyWindFlipbook = function(...)
    return v78.new("Sphere", v78.DiceyWind0, ...);
end;
v78.CreateSlashWind0Flippbok = function(...)
    return v78.new("Sphere", v78.SlashWind0, ...);
end;
v78.CreateAnimatedWind = function(v146, v147, v148, v149, v150, v151, v152)
    local v153 = v146 * CFrame.Angles(0, v30.RandomRotation(), 0) * CFrame.new(0, v148, 0);
    local v154 = (v151 or v78.CreateWind2Flipbook)(nil, v153, Vector3.new(0, v147.Y, 0), Color3.new(1, 1, 1));
    v154:Play(v150);
    v154:TweenSize(v147, TweenInfo.new(v150, Enum.EasingStyle.Cubic));
    v154:SetTransparency(v152 or 0.95);
    v154:TweenCFrame(v153 * CFrame.Angles(0, 1.5707963267948966 * v30.RandomReverseMutlipler(), 0) * CFrame.new(0, v149, 0), TweenInfo.new(v150));
    return v154;
end;
return v78;