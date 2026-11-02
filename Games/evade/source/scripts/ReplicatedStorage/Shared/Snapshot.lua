-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Packages.Net);
local v4 = v3:RemoteEvent("Snapshot/RealiableChannel");
local v5 = v3:UnreliableRemoteEvent("Snapshot/UnrealiableChannel");
local v6 = l_RunService_0:IsServer();
local l_Lerp_0 = CFrame.identity.Lerp;
local l_ToOrientation_0 = CFrame.identity.ToOrientation;
local l_FuzzyEq_0 = CFrame.identity.FuzzyEq;
local l_BulkMoveTo_0 = workspace.BulkMoveTo;
local v11 = 0;
local v12 = {};
local v13 = {};
local v14 = {};
local v15 = {};
local function _(v16) --[[ Line: 35 ]] --[[ Name: getId ]]
    -- upvalues: v12 (copy), v11 (ref), v13 (copy), v14 (copy), v15 (copy)
    local v17 = v12[v16];
    if v17 then
        return v17;
    else
        v11 = v11 + 1;
        v11 = v11 % 65535;
        local l_v11_0 = v11;
        v12[v16] = l_v11_0;
        v13[l_v11_0] = v16;
        v14[tostring(l_v11_0)] = v16;
        v15[tostring(l_v11_0)] = v16;
        return l_v11_0;
    end;
end;
local function _(v20) --[[ Line: 52 ]] --[[ Name: getObjectFromId ]]
    -- upvalues: v13 (copy)
    return v13[v20];
end;
local function _(v22) --[[ Line: 56 ]] --[[ Name: clearId ]]
    -- upvalues: v13 (copy), v12 (copy), v14 (copy)
    if v13[v22] then
        v12[v13[v22]] = nil;
        v13[v22] = nil;
    end;
    v14[tostring(v22)] = nil;
end;
local v24 = {};
local function _(v25) --[[ Line: 65 ]] --[[ Name: removeObject ]]
    -- upvalues: v24 (copy), v12 (copy), v11 (ref), v13 (copy), v14 (copy), v15 (copy)
    local v26 = v24[v25];
    if v26 then
        local v27 = v12[v26];
        local v28;
        if v27 then
            v28 = v27;
        else
            v11 = v11 + 1;
            v11 = v11 % 65535;
            local l_v11_1 = v11;
            v12[v26] = l_v11_1;
            v13[l_v11_1] = v26;
            v14[tostring(l_v11_1)] = v26;
            v15[tostring(l_v11_1)] = v26;
            v28 = l_v11_1;
        end;
        if v13[v28] then
            v12[v13[v28]] = nil;
            v13[v28] = nil;
        end;
        v14[tostring(v28)] = nil;
    end;
    v24[v25] = nil;
end;
local function _(v31, v32) --[[ Line: 75 ]] --[[ Name: addObject ]]
    -- upvalues: v12 (copy), v11 (ref), v13 (copy), v14 (copy), v15 (copy), v24 (copy)
    if not v12[v32] then
        v11 = v11 + 1;
        v11 = v11 % 65535;
        local l_v11_2 = v11;
        v12[v32] = l_v11_2;
        v13[l_v11_2] = v32;
        v14[tostring(l_v11_2)] = v32;
        v15[tostring(l_v11_2)] = v32;
    end;
    v24[v31] = v32;
end;
local function v55(v35, v36) --[[ Line: 80 ]] --[[ Name: create ]]
    -- upvalues: v6 (copy), v12 (copy), v11 (ref), v13 (copy), v14 (copy), v15 (copy), v24 (copy)
    assert(v6, "create can only be used by server");
    if not v12[v36] then
        v11 = v11 + 1;
        v11 = v11 % 65535;
        local l_v11_3 = v11;
        v12[v36] = l_v11_3;
        v13[l_v11_3] = v36;
        v14[tostring(l_v11_3)] = v36;
        v15[tostring(l_v11_3)] = v36;
    end;
    v24[v35] = v36;
    local v43 = v36.Destroying:Once(function() --[[ Line: 85 ]]
        -- upvalues: v35 (copy), v24 (ref), v12 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref)
        local l_v35_0 = v35;
        local v39 = v24[l_v35_0];
        if v39 then
            local v40 = v12[v39];
            local v41;
            if v40 then
                v41 = v40;
            else
                v11 = v11 + 1;
                v11 = v11 % 65535;
                local l_v11_4 = v11;
                v12[v39] = l_v11_4;
                v13[l_v11_4] = v39;
                v14[tostring(l_v11_4)] = v39;
                v15[tostring(l_v11_4)] = v39;
                v41 = l_v11_4;
            end;
            if v13[v41] then
                v12[v13[v41]] = nil;
                v13[v41] = nil;
            end;
            v14[tostring(v41)] = nil;
        end;
        v24[l_v35_0] = nil;
    end);
    local v49 = v35.Destroying:Once(function() --[[ Line: 89 ]]
        -- upvalues: v35 (copy), v24 (ref), v12 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref)
        local l_v35_1 = v35;
        local v45 = v24[l_v35_1];
        if v45 then
            local v46 = v12[v45];
            local v47;
            if v46 then
                v47 = v46;
            else
                v11 = v11 + 1;
                v11 = v11 % 65535;
                local l_v11_5 = v11;
                v12[v45] = l_v11_5;
                v13[l_v11_5] = v45;
                v14[tostring(l_v11_5)] = v45;
                v15[tostring(l_v11_5)] = v45;
                v47 = l_v11_5;
            end;
            if v13[v47] then
                v12[v13[v47]] = nil;
                v13[v47] = nil;
            end;
            v14[tostring(v47)] = nil;
        end;
        v24[l_v35_1] = nil;
    end);
    return function() --[[ Line: 93 ]]
        -- upvalues: v43 (copy), v49 (copy), v35 (copy), v24 (ref), v12 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref)
        v43:Disconnect();
        v49:Disconnect();
        local l_v35_2 = v35;
        local v51 = v24[l_v35_2];
        if v51 then
            local v52 = v12[v51];
            local v53;
            if v52 then
                v53 = v52;
            else
                v11 = v11 + 1;
                v11 = v11 % 65535;
                local l_v11_6 = v11;
                v12[v51] = l_v11_6;
                v13[l_v11_6] = v51;
                v14[tostring(l_v11_6)] = v51;
                v15[tostring(l_v11_6)] = v51;
                v53 = l_v11_6;
            end;
            if v13[v53] then
                v12[v13[v53]] = nil;
                v13[v53] = nil;
            end;
            v14[tostring(v53)] = nil;
        end;
        v24[l_v35_2] = nil;
    end;
end;
if v6 then
    local v56 = 0;
    local v57 = {};
    local v58 = {};
    do
        local l_v56_0 = v56;
        l_RunService_0.PostSimulation:Connect(function(v60) --[[ Line: 106 ]]
            -- upvalues: l_v56_0 (ref), v15 (copy), v58 (copy), v4 (copy), v5 (copy), v24 (copy), v12 (copy), v11 (ref), v13 (copy), v14 (copy), v57 (copy), l_FuzzyEq_0 (copy), l_ToOrientation_0 (copy)
            l_v56_0 = l_v56_0 + v60;
            if l_v56_0 < 0.05 then
                return;
            else
                l_v56_0 = 0;
                debug.profilebegin("Snapshot:Step");
                if next(v15) then
                    for _, v62 in v58 do
                        v4:FireClient(v62, v15);
                    end;
                    table.clear(v15);
                end;
                local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
                local v64 = buffer.create(890);
                local v65 = 0;
                local v66 = 0;
                local function v70() --[[ Line: 130 ]] --[[ Name: sendBuffer ]]
                    -- upvalues: v66 (ref), v64 (ref), l_workspace_ServerTimeNow_0 (copy), v65 (ref), v58 (ref), v5 (ref)
                    if v66 == 0 then
                        return;
                    else
                        debug.profilebegin("Snapshot:SendBuffer");
                        local v67 = buffer.create(v66 + 10);
                        buffer.copy(v67, 10, v64, 0, v66);
                        buffer.writef64(v67, 0, l_workspace_ServerTimeNow_0);
                        buffer.writeu16(v67, 8, v65);
                        for _, v69 in v58 do
                            v5:FireClient(v69, v67);
                        end;
                        v64 = buffer.create(890);
                        v65 = 0;
                        v66 = 0;
                        debug.profileend();
                        return;
                    end;
                end;
                debug.profilebegin("Snapshot:BuildBuffer");
                for v71, v72 in v24 do
                    local v73 = v12[v72];
                    local v74;
                    if v73 then
                        v74 = v73;
                    else
                        v11 = v11 + 1;
                        v11 = v11 % 65535;
                        local l_v11_7 = v11;
                        v12[v72] = l_v11_7;
                        v13[l_v11_7] = v72;
                        v14[tostring(l_v11_7)] = v72;
                        v15[tostring(l_v11_7)] = v72;
                        v74 = l_v11_7;
                    end;
                    v73 = v71:GetPivot();
                    local v76 = v57[v71];
                    if not v76 or not l_FuzzyEq_0(v73, v76) then
                        if v66 + 26 > 900 then
                            v70();
                        end;
                        v57[v71] = v73;
                        v65 = v65 + 1;
                        buffer.writeu16(v64, v66, v74);
                        local v77 = v66 + 2;
                        local l_X_0 = v73.X;
                        buffer.writef32(v64, v77, l_X_0);
                        v77 = v66 + 6;
                        l_X_0 = v73.Y;
                        buffer.writef32(v64, v77, l_X_0);
                        v77 = v66 + 10;
                        l_X_0 = v73.Z;
                        buffer.writef32(v64, v77, l_X_0);
                        local v79, v80;
                        v79, v80, v77 = l_ToOrientation_0(v73);
                        local v81 = v66 + 14;
                        buffer.writef32(v64, v81, v79);
                        v81 = v66 + 18;
                        buffer.writef32(v64, v81, v80);
                        v81 = v66 + 22;
                        buffer.writef32(v64, v81, v77);
                        v66 = v66 + 26;
                    end;
                end;
                debug.profileend();
                v70();
                debug.profileend();
                return;
            end;
        end);
        local function v83(v82) --[[ Line: 190 ]] --[[ Name: onPlayerLoaded ]]
            -- upvalues: v58 (copy), v14 (copy), v4 (copy)
            if table.find(v58, v82) then
                return;
            else
                table.insert(v58, v82);
                if next(v14) then
                    v4:FireClient(v82, v14);
                end;
                return;
            end;
        end;
        l_Players_0.PlayerRemoving:Connect(function(v84) --[[ Line: 203 ]]
            -- upvalues: v58 (copy)
            local v85 = table.find(v58, v84);
            if v85 then
                table.remove(v58, v85);
            end;
        end);
        v4.OnServerEvent:Connect(v83);
        for _, v87 in l_Players_0:GetPlayers() do
            task.defer(v83, v87);
        end;
    end;
else
    local v88 = {};
    local v89 = 0;
    local v90 = 0;
    local function v97(v91, v92) --[[ Line: 222 ]] --[[ Name: getClosestSnapshotToRenderTime ]]
        if #v92 < 2 then
            return nil, nil;
        else
            local v93 = nil;
            local v94 = nil;
            for _, v96 in v92 do
                if v96.t <= v91 then
                    v93 = v96;
                end;
                if v91 < v96.t then
                    v94 = v96;
                    break;
                end;
            end;
            v93 = v93 or v92[1];
            v94 = v94 or v92[2];
            if v93 and v94 and v93.t == v94.t then
                return nil, nil;
            else
                return v93, v94;
            end;
        end;
    end;
    local v98 = nil;
    do
        local l_v89_0, l_v90_0, l_v98_0 = v89, v90, v98;
        l_RunService_0.PreRender:Connect(function(v102) --[[ Line: 249 ]]
            -- upvalues: l_v89_0 (ref), l_v90_0 (ref), l_v98_0 (ref), v88 (copy), v97 (copy), l_Lerp_0 (copy), l_BulkMoveTo_0 (copy)
            debug.profilebegin("Snapshot:Interpolate");
            debug.profilebegin("CalculateRenderTime");
            local v103 = l_v89_0 + (os.clock() - l_v90_0);
            l_v98_0 = (l_v98_0 or v103 - 0.2) + v102;
            local v104 = 0.2 - (v103 - l_v98_0);
            if math.abs(v104) > 0.2 then
                l_v98_0 = v103 - 0.2;
            elseif v104 > 0.01 then
                l_v98_0 = math.max(v103 - 0.2, l_v98_0 - v102 * 0.1);
            elseif v104 < -0.01 then
                l_v98_0 = math.min(v103 - 0.2, l_v98_0 + v102 * 0.1);
            end;
            debug.profileend();
            debug.profilebegin("Interpolate Snapshots");
            local v105 = 0;
            local v106 = {};
            local v107 = {};
            for v108, v109 in v88 do
                local v110, v111 = v97(l_v98_0, v109);
                if v110 and v111 then
                    local v112 = math.clamp((l_v98_0 - v110.t) / (v111.t - v110.t), 0, 1.1);
                    v105 = v105 + 1;
                    v106[v105] = v108;
                    v107[v105] = l_Lerp_0(v110.cf, v111.cf, v112);
                end;
            end;
            debug.profileend();
            debug.profilebegin("BulkMoveTo");
            l_BulkMoveTo_0(workspace, v106, v107, Enum.BulkMoveMode.FireCFrameChanged);
            debug.profileend();
            debug.profileend();
        end);
        v5.OnClientEvent:Connect(function(v113) --[[ Line: 291 ]]
            -- upvalues: l_v89_0 (ref), l_v90_0 (ref), v13 (copy), v88 (copy)
            local v114 = 0;
            local v115 = buffer.readf64(v113, v114);
            v114 = v114 + 8;
            if v115 < l_v89_0 then
                return;
            else
                l_v89_0 = v115;
                l_v90_0 = os.clock();
                local v116 = buffer.readu16(v113, v114);
                v114 = v114 + 2;
                for _ = 1, v116 do
                    local v118 = buffer.readu16(v113, v114);
                    local v119 = CFrame.new(buffer.readf32(v113, v114 + 2), buffer.readf32(v113, v114 + 6), (buffer.readf32(v113, v114 + 10))) * CFrame.fromOrientation(buffer.readf32(v113, v114 + 14), buffer.readf32(v113, v114 + 18), (buffer.readf32(v113, v114 + 22)));
                    v114 = v114 + 26;
                    local v120 = v13[v118];
                    if v120 and v120.Parent then
                        local v121 = {
                            t = v115, 
                            cf = v119
                        };
                        if not v88[v120] then
                            v88[v120] = {
                                v121
                            };
                        else
                            table.insert(v88[v120], v121);
                        end;
                        if #v88[v120] > 100 then
                            table.remove(v88[v120], 1);
                        end;
                    end;
                end;
                return;
            end;
        end);
        v4.OnClientEvent:Connect(function(v122) --[[ Line: 343 ]]
            -- upvalues: v12 (copy), v13 (copy), v14 (copy), v88 (copy)
            for v123, v124 in v122 do
                v123 = tonumber(v123);
                if typeof(v124) ~= "Instance" or not v124.Parent then
                    --[[ close >= 4 ]]
                else
                    if v124:IsA("BasePart") then
                        v124.Anchored = true;
                    end;
                    v12[v124] = v123;
                    v13[v123] = v124;
                    do
                        local l_v123_0 = v123;
                        v124.Destroying:Once(function() --[[ Line: 359 ]]
                            -- upvalues: l_v123_0 (ref), v13 (ref), v12 (ref), v14 (ref), v88 (ref), v124 (copy)
                            local l_l_v123_0_0 = l_v123_0;
                            if v13[l_l_v123_0_0] then
                                v12[v13[l_l_v123_0_0]] = nil;
                                v13[l_l_v123_0_0] = nil;
                            end;
                            v14[tostring(l_l_v123_0_0)] = nil;
                            v88[v124] = nil;
                        end);
                    end;
                end;
            end;
        end);
        v4:FireServer();
    end;
end;
return {
    DELAY = 0.2, 
    create = v55
};