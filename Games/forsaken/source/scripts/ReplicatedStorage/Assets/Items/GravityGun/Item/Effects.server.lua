-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

if script:GetAttribute("Initialized") then
    return;
else
    script:SetAttribute("Initialized", true);
    local l_RunService_0 = game:GetService("RunService");
    local l_TweenService_0 = game:GetService("TweenService");
    local l_Parent_0 = script.Parent;
    local l_Body_0 = l_Parent_0:WaitForChild("Body");
    local l_Reliable_0 = l_Parent_0:WaitForChild("Reliable");
    local l_Unreliable_0 = l_Parent_0:WaitForChild("Unreliable");
    local l_Effects_0 = l_Parent_0:WaitForChild("Data"):WaitForChild("Effects");
    local l_Hold_0 = l_Effects_0:WaitForChild("Hold");
    local l_Blast_0 = l_Effects_0:WaitForChild("Blast");
    local l_Impact_0 = l_Effects_0:WaitForChild("Impact");
    local l_l_Blast_0_PropertyChangedSignal_0 = l_Blast_0:GetPropertyChangedSignal("Enabled");
    local l_l_Parent_0_AttributeChangedSignal_0 = l_Parent_0:GetAttributeChangedSignal("_state");
    local v12 = TweenInfo.new(0.1, Enum.EasingStyle.Sine);
    local v13 = TweenInfo.new(0.05, Enum.EasingStyle.Quad);
    local v14 = TweenInfo.new(0.5, Enum.EasingStyle.Quad);
    local v15 = TweenInfo.new(0.25, Enum.EasingStyle.Quad);
    local v16 = TweenInfo.new(1, Enum.EasingStyle.Quad);
    local v17 = Random.new();
    local v18 = nil;
    local v19 = nil;
    local v20 = {};
    local v21 = false;
    local v22 = false;
    local v23 = true;
    local l_StateFlags_0 = require(l_Parent_0.Shared).StateFlags;
    local function _(v25, v26, v27) --[[ Line: 56 ]] --[[ Name: createTween ]]
        -- upvalues: l_TweenService_0 (copy)
        return l_TweenService_0:Create(v25, v26, v27);
    end;
    local function _(v29, v30, v31) --[[ Line: 60 ]] --[[ Name: setWithTween ]]
        if v30 then
            task.spawn(v31);
        end;
        v29.Completed:Once(function(v32) --[[ Line: 65 ]]
            -- upvalues: v31 (copy)
            if v32 == Enum.PlaybackState.Completed then
                v31();
            end;
        end);
        v29:Play();
    end;
    local function _(v34) --[[ Line: 74 ]] --[[ Name: getSound ]]
        -- upvalues: l_Body_0 (copy)
        local l_l_Body_0_FirstChild_0 = l_Body_0:FindFirstChild(v34);
        if l_l_Body_0_FirstChild_0 and l_l_Body_0_FirstChild_0:IsA("Sound") then
            return l_l_Body_0_FirstChild_0;
        else
            return nil;
        end;
    end;
    local function _(v37) --[[ Line: 84 ]] --[[ Name: playSound ]]
        -- upvalues: l_Body_0 (copy)
        local l_l_Body_0_FirstChild_1 = l_Body_0:FindFirstChild(v37);
        local v39 = if l_l_Body_0_FirstChild_1 and l_l_Body_0_FirstChild_1:IsA("Sound") then l_l_Body_0_FirstChild_1 else nil;
        if v39 then
            v39:Play();
        end;
    end;
    local function v58() --[[ Line: 92 ]] --[[ Name: onBlasting ]]
        -- upvalues: l_Blast_0 (copy), v18 (ref), l_Parent_0 (copy), l_Impact_0 (copy), v15 (copy), l_TweenService_0 (copy), v17 (copy), l_Body_0 (copy)
        if not l_Blast_0.Enabled then
            return;
        else
            if v18 then
                v18:Cancel();
                v18 = nil;
            end;
            local l_l_Parent_0_FirstChild_0 = l_Parent_0:FindFirstChild("BlastFx", true);
            local l_Attachment1_0 = l_Blast_0.Attachment1;
            if l_l_Parent_0_FirstChild_0 and l_l_Parent_0_FirstChild_0:IsA("ParticleEmitter") then
                l_l_Parent_0_FirstChild_0:Emit(100);
            end;
            l_Blast_0.Width0 = 4;
            l_Blast_0.Width1 = 6;
            l_Blast_0:SetTextureOffset(math.random());
            if l_Attachment1_0 then
                local v43 = l_Impact_0:Clone();
                v43.Parent = l_Attachment1_0;
                v43:Emit(64);
                local l_PointLight_0 = Instance.new("PointLight");
                l_PointLight_0.Color = Color3.new(1, 1, 1);
                l_PointLight_0.Brightness = 20;
                l_PointLight_0.Range = 12;
                l_PointLight_0.Parent = l_Attachment1_0;
                local l_SpotLight_0 = Instance.new("SpotLight");
                l_SpotLight_0.Face = Enum.NormalId.Bottom;
                l_SpotLight_0.Color = l_PointLight_0.Color;
                l_SpotLight_0.Shadows = true;
                l_SpotLight_0.Range = 60;
                l_SpotLight_0.Angle = 60;
                l_SpotLight_0.Parent = l_Attachment1_0;
                local l_v15_0 = v15;
                local v47 = {
                    Brightness = 0, 
                    Range = 0
                };
                local v48 = l_TweenService_0:Create(l_PointLight_0, l_v15_0, v47);
                v47 = v15;
                local v49 = {
                    Brightness = 0, 
                    Angle = 180, 
                    Range = 10
                };
                l_v15_0 = l_TweenService_0:Create(l_SpotLight_0, v47, v49);
                local l_v43_0 = v43 --[[ copy: 2 -> 9 ]];
                local l_l_PointLight_0_0 = l_PointLight_0 --[[ copy: 3 -> 10 ]];
                local l_l_SpotLight_0_0 = l_SpotLight_0 --[[ copy: 4 -> 11 ]];
                task.delay(v43.Lifetime.Max, function() --[[ Line: 143 ]]
                    -- upvalues: l_v43_0 (copy), l_l_PointLight_0_0 (copy), l_l_SpotLight_0_0 (copy)
                    l_v43_0:Destroy();
                    l_l_PointLight_0_0:Destroy();
                    l_l_SpotLight_0_0:Destroy();
                end);
                v48:Play();
                l_v15_0:Play();
            end;
            local l_l_Blast_0_0 = l_Blast_0;
            local l_v15_1 = v15;
            local v55 = {
                Width0 = 0, 
                Width1 = 0
            };
            local v56 = l_TweenService_0:Create(l_l_Blast_0_0, l_v15_1, v55);
            l_v15_1 = "Launch" .. v17:NextInteger(1, 4);
            local l_l_Body_0_FirstChild_2 = l_Body_0:FindFirstChild(l_v15_1);
            v55 = if l_l_Body_0_FirstChild_2 and l_l_Body_0_FirstChild_2:IsA("Sound") then l_l_Body_0_FirstChild_2 else nil;
            if v55 then
                v55:Play();
            end;
            v56:Play();
            v18 = v56;
            return;
        end;
    end;
    local function v69(v59) --[[ Line: 165 ]] --[[ Name: updateExpanded ]]
        -- upvalues: v23 (ref), l_Body_0 (copy), v12 (copy), l_TweenService_0 (copy)
        local v60 = v23 and "Expand" or "Collapse";
        if not v59 then
            local l_l_Body_0_FirstChild_3 = l_Body_0:FindFirstChild(v60);
            local v62 = if l_l_Body_0_FirstChild_3 and l_l_Body_0_FirstChild_3:IsA("Sound") then l_l_Body_0_FirstChild_3 else nil;
            if v62 then
                v62:Play();
            end;
        end;
        for _, v64 in l_Body_0:GetDescendants() do
            if v64:IsA("Bone") and not v64:GetAttribute("Ignore") then
                local v65 = v64:GetAttribute(v60) or CFrame.identity;
                local l_v64_Attribute_0 = v64:GetAttribute("_startCF");
                if l_v64_Attribute_0 == nil then
                    l_v64_Attribute_0 = v64.CFrame;
                    v64:SetAttribute("_startCF", l_v64_Attribute_0);
                end;
                if typeof(v65) == "CFrame" then
                    if v59 then
                        v64.CFrame = l_v64_Attribute_0 * v65;
                    else
                        local l_v12_0 = v12;
                        local v68 = {
                            CFrame = l_v64_Attribute_0 * v65
                        };
                        l_TweenService_0:Create(v64, l_v12_0, v68):Play();
                    end;
                end;
            elseif v64:IsA("ParticleEmitter") and v64.Name == "Active" then
                v64.Enabled = v23;
            end;
        end;
    end;
    local function v74() --[[ Line: 199 ]] --[[ Name: updateBeams ]]
        -- upvalues: l_Hold_0 (copy), v17 (copy), v13 (copy), l_TweenService_0 (copy)
        for _, v71 in l_Hold_0:GetChildren() do
            if v71:IsA("Beam") then
                v71:SetTextureOffset((v17:NextNumber()));
                local l_v13_0 = v13;
                local v73 = {
                    CurveSize0 = v17:NextNumber(-1, 1) * 0.75, 
                    CurveSize1 = v17:NextNumber(-1, 1) * 0.75
                };
                l_TweenService_0:Create(v71, l_v13_0, v73):Play();
            end;
        end;
    end;
    local function _() --[[ Line: 215 ]] --[[ Name: updatePulling ]]
        -- upvalues: l_Body_0 (copy), v22 (ref)
        local l_l_Body_0_FirstChild_4 = l_Body_0:FindFirstChild("PullFx", true);
        if l_l_Body_0_FirstChild_4 and l_l_Body_0_FirstChild_4:IsA("ParticleEmitter") then
            l_l_Body_0_FirstChild_4.Enabled = v22;
        end;
    end;
    local function v98(v77) --[[ Line: 223 ]] --[[ Name: updatePowered ]]
        -- upvalues: l_Body_0 (copy), v21 (ref), l_Hold_0 (copy), v12 (copy), l_TweenService_0 (copy), v13 (copy), v19 (ref), l_RunService_0 (copy), v74 (copy), v14 (copy), v16 (copy)
        local l_Pull_0 = l_Body_0:FindFirstChild("Pull");
        local v79 = if l_Pull_0 and l_Pull_0:IsA("Sound") then l_Pull_0 else nil;
        if v79 and v21 then
            v79:Stop();
        end;
        for _, v81 in l_Hold_0:GetChildren() do
            if v81:IsA("Beam") then
                local l_v12_1 = v12;
                local v83 = {
                    Width0 = v21 and 0.2 or 0, 
                    Width1 = v21 and 1 or 0
                };
                local v84 = l_TweenService_0:Create(v81, l_v12_1, v83);
                l_v12_1 = v21;
                function v83() --[[ Line: 237 ]]
                    -- upvalues: v81 (copy), v21 (ref)
                    v81.Enabled = v21;
                end;
                if l_v12_1 then
                    task.spawn(v83);
                end;
                v84.Completed:Once(function(v85) --[[ Line: 65 ]]
                    -- upvalues: v83 (copy)
                    if v85 == Enum.PlaybackState.Completed then
                        v83();
                    end;
                end);
                v84:Play();
            end;
        end;
        for _, v87 in l_Body_0:GetDescendants() do
            if v87:IsA("ParticleEmitter") and v87.Name == "_powered" then
                local l_v13_1 = v13;
                local v89 = {
                    Brightness = v21 and 3 or 0
                };
                local v90 = l_TweenService_0:Create(v87, l_v13_1, v89);
                l_v13_1 = v21;
                function v89() --[[ Line: 249 ]]
                    -- upvalues: v21 (ref), v87 (copy)
                    if v21 then
                        v87:Emit(1);
                        return;
                    else
                        v87:Clear();
                        return;
                    end;
                end;
                if l_v13_1 then
                    task.spawn(v89);
                end;
                v90.Completed:Once(function(v91) --[[ Line: 65 ]]
                    -- upvalues: v89 (copy)
                    if v91 == Enum.PlaybackState.Completed then
                        v89();
                    end;
                end);
                v90:Play();
            end;
        end;
        if v21 and not v19 then
            v19 = l_RunService_0.Heartbeat:Connect(v74);
        elseif not v21 and v19 then
            l_Pull_0 = v19;
            v19 = nil;
            local l_l_Pull_0_0 = l_Pull_0 --[[ copy: 2 -> 10 ]];
            task.delay(v12.Time, function() --[[ Line: 265 ]]
                -- upvalues: l_l_Pull_0_0 (copy)
                l_l_Pull_0_0:Disconnect();
            end);
        end;
        if not v77 then
            local l_Holding_0 = l_Body_0:FindFirstChild("Holding");
            l_Pull_0 = if l_Holding_0 and l_Holding_0:IsA("Sound") then l_Holding_0 else nil;
            l_Holding_0 = v21 and "Pickup" or "Drop";
            local l_l_Body_0_FirstChild_5 = l_Body_0:FindFirstChild(l_Holding_0);
            local v95 = if l_l_Body_0_FirstChild_5 and l_l_Body_0_FirstChild_5:IsA("Sound") then l_l_Body_0_FirstChild_5 else nil;
            if v95 then
                v95:Play();
            end;
            if l_Pull_0 then
                l_Holding_0 = v21 and v14 or v16;
                l_l_Body_0_FirstChild_5 = {
                    PlaybackSpeed = v21 and 1 or 0.5, 
                    Volume = v21 and 0.8 or 0
                };
                v95 = l_TweenService_0:Create(l_Pull_0, l_Holding_0, l_l_Body_0_FirstChild_5);
                l_l_Body_0_FirstChild_5 = v21;
                local function v96() --[[ Line: 282 ]]
                    -- upvalues: l_Pull_0 (copy), v21 (ref)
                    l_Pull_0.Playing = v21;
                end;
                if l_l_Body_0_FirstChild_5 then
                    task.spawn(v96);
                end;
                v95.Completed:Once(function(v97) --[[ Line: 65 ]]
                    -- upvalues: v96 (copy)
                    if v97 == Enum.PlaybackState.Completed then
                        v96();
                    end;
                end);
                v95:Play();
            end;
        end;
    end;
    local function v103(v99) --[[ Line: 289 ]] --[[ Name: onChildAdded ]]
        -- upvalues: v14 (copy), l_TweenService_0 (copy)
        if v99:IsA("IKControl") then
            local l_v14_0 = v14;
            local v101 = {
                Weight = 1
            };
            local v102 = l_TweenService_0:Create(v99, l_v14_0, v101);
            v99.Weight = 0;
            v102:Play();
        end;
    end;
    local function v112(v104, v105, v106, v107) --[[ Line: 300 ]] --[[ Name: onImpulseEvent ]]
        if not v104 or not v105 or not v106 then
            return;
        else
            local l_WorldPosition_0 = v106.WorldPosition;
            local v109 = (l_WorldPosition_0 - v105.WorldPosition).Unit * math.min(10000, v107);
            if v104.Name == "HumanoidRootPart" then
                local l_Parent_1 = v104.Parent;
                local v111 = l_Parent_1 and l_Parent_1:FindFirstChildOfClass("Humanoid");
                if v111 then
                    v111:ChangeState(Enum.HumanoidStateType.FallingDown);
                end;
            end;
            v104:ApplyImpulseAtPosition(v109, l_WorldPosition_0);
            return;
        end;
    end;
    local function v124() --[[ Line: 320 ]] --[[ Name: stepWobble ]]
        -- upvalues: v20 (copy)
        local v113 = os.clock();
        local v114 = nil;
        while script.Parent do
            local v115, v116 = next(v20, v114);
            if v115 then
                local l_Freq_0 = v116.Freq;
                local l_Power_0 = v116.Power;
                local l_Decay_0 = v116.Decay;
                local v120 = v113 - v116.Start;
                local v121 = l_Power_0 * math.sin(v120 * 3.141592653589793 * l_Freq_0 * 8) / 8 ^ (v120 * l_Decay_0);
                if v120 < 3 / l_Decay_0 then
                    local v122 = v115:GetAttribute("Disp") or v116.Disp;
                    local l_v115_Attribute_0 = v115:GetAttribute("_baseCF");
                    if l_v115_Attribute_0 == nil then
                        l_v115_Attribute_0 = v115.CFrame;
                        v115:SetAttribute("_baseCF", l_v115_Attribute_0);
                    end;
                    v115.CFrame = l_v115_Attribute_0 * CFrame.identity:Lerp(v122, v121);
                    v114 = v115;
                else
                    v20[v115] = nil;
                end;
            else
                break;
            end;
        end;
    end;
    local function v127(v125, v126) --[[ Line: 354 ]] --[[ Name: onWobbleEvent ]]
        -- upvalues: v20 (copy)
        if v125 then
            v20[v125] = {
                Start = os.clock(), 
                Power = v126.Power or 1, 
                Decay = v126.Decay or 1, 
                Freq = v126.Freq or 1, 
                Disp = v126.Disp
            };
        end;
    end;
    local function v129(v128, ...) --[[ Line: 366 ]] --[[ Name: onBridgeEvent ]]
        -- upvalues: v112 (copy), v127 (copy)
        if v128 == "Impulse" then
            v112(...);
            return;
        else
            if v128 == "Wobble" then
                v127(...);
            end;
            return;
        end;
    end;
    local function v136(v130) --[[ Line: 374 ]] --[[ Name: updateState ]]
        -- upvalues: l_Parent_0 (copy), l_StateFlags_0 (copy), v21 (ref), v98 (copy), v22 (ref), l_Body_0 (copy), v23 (ref), v69 (copy)
        local v131 = tonumber(l_Parent_0:GetAttribute("_state")) or 0;
        local v132 = bit32.btest(v131, l_StateFlags_0.PULLING);
        local v133 = bit32.btest(v131, l_StateFlags_0.EXPANDED);
        local v134 = v133 and bit32.btest(v131, l_StateFlags_0.POWERED);
        if v21 ~= v134 then
            v21 = v134;
            v98(v130);
        end;
        if v22 ~= v132 then
            v22 = v132;
            local l_l_Body_0_FirstChild_6 = l_Body_0:FindFirstChild("PullFx", true);
            if l_l_Body_0_FirstChild_6 and l_l_Body_0_FirstChild_6:IsA("ParticleEmitter") then
                l_l_Body_0_FirstChild_6.Enabled = v22;
            end;
        end;
        if v23 ~= v133 then
            v23 = v133;
            v69(v130);
        end;
    end;
    v136(true);
    l_l_Blast_0_PropertyChangedSignal_0:Connect(v58);
    l_l_Parent_0_AttributeChangedSignal_0:Connect(v136);
    l_Parent_0.ChildAdded:Connect(v103);
    l_RunService_0.Stepped:Connect(v124);
    l_Reliable_0.OnClientEvent:Connect(v129);
    l_Unreliable_0.OnClientEvent:Connect(v129);
    return;
end;