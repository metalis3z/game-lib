-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local l_FX_0 = l_ReplicatedStorage_0:WaitForChild("Communication"):WaitForChild("FX");
local v4 = TweenInfo.new(0.25);
local v5 = TweenInfo.new(1);
local v6 = setmetatable({}, {
    __mode = "k"
});
local function v11(v7) --[[ Line: 20 ]] --[[ Name: getEntry ]]
    -- upvalues: v6 (copy), l_TweenService_0 (copy), v4 (copy), v5 (copy)
    local v8 = v6[v7];
    if v8 and v8.hl.Parent == v7 then
        return v8;
    else
        local l_Highlight_0 = v7:FindFirstChild("Highlight");
        if not l_Highlight_0 then
            v6[v7] = nil;
            return nil;
        else
            local v10 = {
                hl = l_Highlight_0, 
                tIn = l_TweenService_0:Create(l_Highlight_0, v4, {
                    FillTransparency = 0
                }), 
                tOut = l_TweenService_0:Create(l_Highlight_0, v5, {
                    FillTransparency = 1
                }), 
                outTask = nil
            };
            v6[v7] = v10;
            return v10;
        end;
    end;
end;
local function v14(v12) --[[ Line: 42 ]] --[[ Name: play ]]
    -- upvalues: v11 (copy), l_TweenService_0 (copy), v5 (copy)
    local v13 = v11(v12);
    if not v13 then
        return;
    else
        if v13.outTask then
            task.cancel(v13.outTask);
            v13.outTask = nil;
        end;
        v13.tIn:Cancel();
        v13.tOut:Cancel();
        v13.tOut = l_TweenService_0:Create(v13.hl, v5, {
            FillTransparency = 1
        });
        v13.hl.FillTransparency = 1;
        v13.tIn:Play();
        v13.outTask = task.delay(0.25, function() --[[ Line: 64 ]]
            -- upvalues: v13 (copy), v12 (copy)
            if v13.hl.Parent ~= v12 then
                return;
            else
                v13.tOut:Play();
                v13.outTask = nil;
                return;
            end;
        end);
        return;
    end;
end;
l_FX_0.OnClientEvent:Connect(function(v15) --[[ Line: 71 ]]
    -- upvalues: l_Players_0 (copy), v14 (copy)
    local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(v15);
    if not l_l_Players_0_PlayerByUserId_0 then
        return;
    else
        local l_Character_0 = l_l_Players_0_PlayerByUserId_0.Character;
        if not l_Character_0 then
            return;
        else
            v14(l_Character_0);
            return;
        end;
    end;
end);