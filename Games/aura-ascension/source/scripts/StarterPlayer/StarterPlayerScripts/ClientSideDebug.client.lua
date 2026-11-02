-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_Stats_0 = game:GetService("Stats");
local _ = game:GetService("Workspace");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v5 = 0;
local v6 = 0;
local v7 = 0;
local v8 = 0;
local v9 = os.clock();
local v10 = 0;
local function _() --[[ Line: 20 ]] --[[ Name: safeGetPingMs ]]
    -- upvalues: l_Stats_0 (copy)
    local v11 = nil;
    pcall(function() --[[ Line: 23 ]]
        -- upvalues: l_Stats_0 (ref), v11 (ref)
        local l_Network_0 = l_Stats_0:FindFirstChild("Network");
        if l_Network_0 then
            local l_ServerStatsItem_0 = l_Network_0:FindFirstChild("ServerStatsItem");
            if l_ServerStatsItem_0 then
                local l_l_ServerStatsItem_0_FirstChild_0 = l_ServerStatsItem_0:FindFirstChild("Data Ping");
                if l_l_ServerStatsItem_0_FirstChild_0 and l_l_ServerStatsItem_0_FirstChild_0.GetValue then
                    v11 = l_l_ServerStatsItem_0_FirstChild_0:GetValue();
                end;
            end;
        end;
    end);
    return v11;
end;
local function v19() --[[ Line: 39 ]] --[[ Name: countClientObjects ]]
    local v16 = {
        Descendants = 0, 
        BaseParts = 0, 
        ParticleEmitters = 0, 
        EnabledParticleEmitters = 0, 
        Beams = 0, 
        Trails = 0, 
        Highlights = 0, 
        Attachments = 0, 
        Sounds = 0, 
        GuiObjects = 0
    };
    for _, v18 in ipairs(game:GetDescendants()) do
        v16.Descendants = v16.Descendants + 1;
        if v18:IsA("BasePart") then
            v16.BaseParts = v16.BaseParts + 1;
        elseif v18:IsA("ParticleEmitter") then
            v16.ParticleEmitters = v16.ParticleEmitters + 1;
            if v18.Enabled then
                v16.EnabledParticleEmitters = v16.EnabledParticleEmitters + 1;
            end;
        elseif v18:IsA("Beam") then
            v16.Beams = v16.Beams + 1;
        elseif v18:IsA("Trail") then
            v16.Trails = v16.Trails + 1;
        elseif v18:IsA("Highlight") then
            v16.Highlights = v16.Highlights + 1;
        elseif v18:IsA("Attachment") then
            v16.Attachments = v16.Attachments + 1;
        elseif v18:IsA("Sound") then
            v16.Sounds = v16.Sounds + 1;
        elseif v18:IsA("GuiObject") then
            v16.GuiObjects = v16.GuiObjects + 1;
        end;
    end;
    return v16;
end;
local function v30() --[[ Line: 81 ]] --[[ Name: printClientSummary ]]
    -- upvalues: v7 (ref), v6 (ref), l_Stats_0 (copy), l_LocalPlayer_0 (copy), v5 (ref), v8 (ref), v10 (ref), v19 (copy), v9 (ref)
    local v20 = os.clock();
    local v21 = v7 > 0 and v6 / v7 or 0;
    local v22 = v21 > 0 and 1 / v21 or 0;
    local v23 = collectgarbage("count") / 1024;
    local v24 = nil;
    local v25;
    do
        local l_v24_0 = v24;
        pcall(function() --[[ Line: 23 ]]
            -- upvalues: l_Stats_0 (ref), l_v24_0 (ref)
            local l_Network_1 = l_Stats_0:FindFirstChild("Network");
            if l_Network_1 then
                local l_ServerStatsItem_1 = l_Network_1:FindFirstChild("ServerStatsItem");
                if l_ServerStatsItem_1 then
                    local l_l_ServerStatsItem_1_FirstChild_0 = l_ServerStatsItem_1:FindFirstChild("Data Ping");
                    if l_l_ServerStatsItem_1_FirstChild_0 and l_l_ServerStatsItem_1_FirstChild_0.GetValue then
                        l_v24_0 = l_l_ServerStatsItem_1_FirstChild_0:GetValue();
                    end;
                end;
            end;
        end);
        v25 = l_v24_0;
    end;
    print("");
    print("========== CLIENT PERF SAMPLE ==========");
    print(string.format("Player: %s", l_LocalPlayer_0.Name));
    print(string.format("Frame avg: %.4f sec", v21));
    print(string.format("Frame max: %.4f sec", v5));
    print(string.format("Estimated FPS: %.1f", v22));
    print(string.format("Frame spikes > %.0fms: %d", 50, v8));
    print(string.format("Lua memory: %.2f MB", v23));
    if v25 ~= nil then
        print(string.format("Ping: %.1f ms", v25));
    end;
    if v20 - v10 >= 15 then
        v10 = v20;
        v24 = v19();
        print("--- Client object counts ---");
        print(string.format("Descendants: %d", v24.Descendants));
        print(string.format("BaseParts: %d", v24.BaseParts));
        print(string.format("Attachments: %d", v24.Attachments));
        print(string.format("ParticleEmitters: %d", v24.ParticleEmitters));
        print(string.format("EnabledParticleEmitters: %d", v24.EnabledParticleEmitters));
        print(string.format("Beams: %d", v24.Beams));
        print(string.format("Trails: %d", v24.Trails));
        print(string.format("Highlights: %d", v24.Highlights));
        print(string.format("Sounds: %d", v24.Sounds));
        print(string.format("GuiObjects: %d", v24.GuiObjects));
    end;
    print("========================================");
    print("");
    v5 = 0;
    v6 = 0;
    v7 = 0;
    v8 = 0;
    v9 = v20;
end;
l_RunService_0.RenderStepped:Connect(function(v31) --[[ Line: 127 ]]
    -- upvalues: v6 (ref), v7 (ref), v5 (ref), v8 (ref), v9 (ref), v30 (copy)
    v6 = v6 + v31;
    v7 = v7 + 1;
    if v5 < v31 then
        v5 = v31;
    end;
    if v31 >= 0.05 then
        v8 = v8 + 1;
        warn(string.format("[ClientPerf] Frame spike detected: %.4f sec", v31));
    end;
    if os.clock() - v9 >= 5 then
        v30();
    end;
end);