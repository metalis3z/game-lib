-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v3 = {};
local v4 = {
    Color3.fromRGB(255, 0, 0), 
    Color3.fromRGB(255, 85, 0), 
    Color3.fromRGB(255, 255, 0), 
    Color3.fromRGB(0, 255, 0), 
    Color3.fromRGB(59, 206, 255), 
    Color3.fromRGB(170, 0, 127), 
    Color3.fromRGB(0, 0, 255), 
    Color3.fromRGB(255, 255, 255)
};
local v5 = nil;
local v6 = nil;
local v7 = nil;
local v8 = {};
local v9 = 0;
local v10 = nil;
local function _(v11) --[[ Line: 72 ]] --[[ Name: dtDragFactor ]]
    return 0.985 ^ (v11 * 60);
end;
local function v17() --[[ Line: 78 ]] --[[ Name: ensureGui ]]
    -- upvalues: v5 (ref), v6 (ref), v7 (ref), l_LocalPlayer_0 (copy)
    if v5 and v6 and v7 then
        return;
    else
        local l_PlayerGui_0 = l_LocalPlayer_0:FindFirstChild("PlayerGui");
        if not l_PlayerGui_0 then
            return;
        else
            local l_ScreenGui_0 = Instance.new("ScreenGui");
            l_ScreenGui_0.Name = "ConfettiFX";
            l_ScreenGui_0.IgnoreGuiInset = true;
            l_ScreenGui_0.ResetOnSpawn = false;
            l_ScreenGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
            l_ScreenGui_0.Parent = l_PlayerGui_0;
            local l_Frame_0 = Instance.new("Frame");
            l_Frame_0.Name = "Holder";
            l_Frame_0.BackgroundTransparency = 1;
            l_Frame_0.Size = UDim2.fromScale(1, 1);
            l_Frame_0.Parent = l_ScreenGui_0;
            local l_Frame_1 = Instance.new("Frame");
            l_Frame_1.Name = "Flash";
            l_Frame_1.BackgroundColor3 = Color3.new(1, 1, 1);
            l_Frame_1.BackgroundTransparency = 1;
            l_Frame_1.Size = UDim2.fromScale(1, 1);
            l_Frame_1.ZIndex = 50;
            l_Frame_1.Parent = l_ScreenGui_0;
            v5 = l_ScreenGui_0;
            v6 = l_Frame_0;
            v7 = l_Frame_1;
            return;
        end;
    end;
end;
local function v21() --[[ Line: 113 ]] --[[ Name: makePiece ]]
    -- upvalues: v6 (ref)
    local l_v6_0 = v6;
    local l_Frame_2 = Instance.new("Frame");
    l_Frame_2.Name = "P";
    l_Frame_2.BorderSizePixel = 0;
    l_Frame_2.BackgroundTransparency = 0;
    l_Frame_2.AnchorPoint = Vector2.new(0.5, 0.5);
    l_Frame_2.Visible = false;
    l_Frame_2.ZIndex = 40;
    l_Frame_2.Parent = l_v6_0;
    local l_UICorner_0 = Instance.new("UICorner");
    l_UICorner_0.CornerRadius = UDim.new(0, 6);
    l_UICorner_0.Parent = l_Frame_2;
    return {
        gui = l_Frame_2, 
        pos = Vector2.zero, 
        vel = Vector2.zero, 
        rot = 0, 
        rotVel = 0, 
        age = 0, 
        life = 1, 
        swayPhase = 0, 
        swayFreq = 4, 
        alive = false
    };
end;
local function _() --[[ Line: 144 ]] --[[ Name: getFromPool ]]
    -- upvalues: v8 (copy), v21 (copy)
    if #v8 < 260 then
        local v22 = v21();
        table.insert(v8, v22);
        return v22;
    else
        for v23 = 1, #v8 do
            if not v8[v23].alive then
                return v8[v23];
            end;
        end;
        return nil;
    end;
end;
local function _(v25) --[[ Line: 162 ]] --[[ Name: popFlash ]]
    -- upvalues: v7 (ref), l_RunService_0 (copy)
    local l_v7_0 = v7;
    if not l_v7_0 then
        return;
    else
        local v27 = 1 - (math.clamp(v25, 0, 1) * 0.12 + 0.85);
        l_v7_0.BackgroundTransparency = 1;
        l_v7_0.Visible = true;
        local v28 = 0;
        l_v7_0.BackgroundTransparency = v27;
        local v29 = nil;
        v29 = l_RunService_0.Heartbeat:Connect(function(v30) --[[ Line: 183 ]]
            -- upvalues: v28 (ref), l_v7_0 (copy), v29 (ref), v27 (copy)
            v28 = v28 + v30;
            local v31 = v28 / 0.12;
            if v31 >= 1 then
                l_v7_0.BackgroundTransparency = 1;
                l_v7_0.Visible = false;
                if v29 then
                    v29:Disconnect();
                end;
                return;
            else
                local v32 = 1 - (1 - v31) * (1 - v31);
                l_v7_0.BackgroundTransparency = v27 + (1 - v27) * v32;
                return;
            end;
        end);
        return;
    end;
end;
local function _() --[[ Line: 198 ]] --[[ Name: startLoop ]]
    -- upvalues: v10 (ref), l_RunService_0 (copy), v9 (ref), v8 (copy)
    if v10 then
        return;
    else
        v10 = l_RunService_0.Heartbeat:Connect(function(v34) --[[ Line: 201 ]]
            -- upvalues: v9 (ref), v10 (ref), v8 (ref)
            if v9 <= 0 then
                v9 = 0;
                if v10 then
                    v10:Disconnect();
                end;
                v10 = nil;
                return;
            else
                local v35 = 0.985 ^ (v34 * 60);
                local v36 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080);
                local v37 = 0;
                for v38 = 1, #v8 do
                    local v39 = v8[v38];
                    if v39.alive then
                        v39.age = v39.age + v34;
                        if v39.age >= v39.life then
                            v39.alive = false;
                            v39.gui.Visible = false;
                            v9 = v9 - 1;
                        else
                            v37 = v37 + 1;
                            v39.vel = Vector2.new(v39.vel.X, v39.vel.Y + 2100 * v34);
                            v39.vel = v39.vel * v35;
                            v39.swayPhase = v39.swayPhase + v34 * v39.swayFreq;
                            local v40 = math.sin(v39.swayPhase) * 110;
                            v39.pos = v39.pos + Vector2.new((v39.vel.X + v40) * v34, v39.vel.Y * v34);
                            v39.rot = v39.rot + v39.rotVel * v34;
                            local v41 = v39.age / v39.life;
                            local v42 = 1;
                            if v41 > 0.7 then
                                local v43 = (v41 - 0.7) / 0.3;
                                v42 = 1 - v43 * v43;
                            end;
                            v39.gui.BackgroundTransparency = 1 - v42;
                            if v39.pos.Y > v36.Y + 120 or v39.pos.X < -120 or v39.pos.X > v36.X + 120 then
                                v39.alive = false;
                                v39.gui.Visible = false;
                                v9 = v9 - 1;
                            else
                                v39.gui.Position = UDim2.fromOffset(v39.pos.X, v39.pos.Y);
                                v39.gui.Rotation = v39.rot;
                            end;
                        end;
                    end;
                end;
                if v37 <= 0 then
                    v9 = 0;
                end;
                return;
            end;
        end);
        return;
    end;
end;
local function _(v45, v46) --[[ Line: 265 ]] --[[ Name: randFloat ]]
    return v45 + (v46 - v45) * math.random();
end;
local function _() --[[ Line: 269 ]] --[[ Name: pickColor ]]
    -- upvalues: v4 (copy)
    return v4[math.random(1, #v4)];
end;
local function v72(v49) --[[ Line: 273 ]] --[[ Name: spawnBurst ]]
    -- upvalues: v17 (copy), v6 (ref), v8 (copy), v21 (copy), v4 (copy), v9 (ref), v10 (ref), l_RunService_0 (copy)
    local v50 = false;
    v17();
    if not v6 then
        return;
    elseif not workspace.CurrentCamera then
        return;
    else
        local l_ViewportSize_0 = workspace.CurrentCamera.ViewportSize;
        local v52 = math.clamp(v49, 0, 100) / 100;
        local v53 = math.clamp(math.floor(v52 ^ 0.75 * 110) + 18, 12, 120);
        local v54 = Vector2.new(l_ViewportSize_0.X * 0.5, l_ViewportSize_0.Y * 0.58);
        for _ = 1, v53 do
            local v56;
            if #v8 < 260 then
                local v57 = v21();
                table.insert(v8, v57);
                v56 = v57;
            else
                for v58 = 1, #v8 do
                    if not v8[v58].alive then
                        v56 = v8[v58];
                        v50 = true;
                    end;
                    if v50 then
                        break;
                    end;
                end;
                if not v50 then
                    v56 = nil;
                end;
            end;
            v50 = false;
            if v56 and v6 then
                v56.alive = true;
                v56.age = 0;
                v56.life = 0.75 + 0.8 * math.random();
                local v59 = 8 + 10 * math.random();
                v56.gui.Size = UDim2.fromOffset(v59, v59 * (0.65 + 0.4999999999999999 * math.random()));
                v56.gui.BackgroundColor3 = v4[math.random(1, #v4)];
                v56.gui.BackgroundTransparency = 0;
                v56.gui.Visible = true;
                v56.pos = v54 + Vector2.new(-18 + 36 * math.random(), -12 + 24 * math.random());
                local v60 = -1.5707963267948966 + (-1.361356816555577 + 2.722713633111154 * math.random());
                local v61 = (720 + 780 * math.random()) * (v52 * 0.55 + 0.72);
                v56.vel = Vector2.new(math.cos(v60) * v61, math.sin(v60) * v61);
                v56.rot = 0 + 360 * math.random();
                v56.rotVel = (-720 + 1440 * math.random()) * (v52 * 0.7 + 0.6);
                v56.swayPhase = 0 + 6.283185307179586 * math.random();
                v56.swayFreq = 3 + 3.5 * math.random();
                v9 = v9 + 1;
            else
                break;
            end;
        end;
        if v10 then
            return;
        else
            v10 = l_RunService_0.Heartbeat:Connect(function(v62) --[[ Line: 201 ]]
                -- upvalues: v9 (ref), v10 (ref), v8 (ref)
                if v9 <= 0 then
                    v9 = 0;
                    if v10 then
                        v10:Disconnect();
                    end;
                    v10 = nil;
                    return;
                else
                    local v63 = 0.985 ^ (v62 * 60);
                    local v64 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080);
                    local v65 = 0;
                    for v66 = 1, #v8 do
                        local v67 = v8[v66];
                        if v67.alive then
                            v67.age = v67.age + v62;
                            if v67.age >= v67.life then
                                v67.alive = false;
                                v67.gui.Visible = false;
                                v9 = v9 - 1;
                            else
                                v65 = v65 + 1;
                                v67.vel = Vector2.new(v67.vel.X, v67.vel.Y + 2100 * v62);
                                v67.vel = v67.vel * v63;
                                v67.swayPhase = v67.swayPhase + v62 * v67.swayFreq;
                                local v68 = math.sin(v67.swayPhase) * 110;
                                v67.pos = v67.pos + Vector2.new((v67.vel.X + v68) * v62, v67.vel.Y * v62);
                                v67.rot = v67.rot + v67.rotVel * v62;
                                local v69 = v67.age / v67.life;
                                local v70 = 1;
                                if v69 > 0.7 then
                                    local v71 = (v69 - 0.7) / 0.3;
                                    v70 = 1 - v71 * v71;
                                end;
                                v67.gui.BackgroundTransparency = 1 - v70;
                                if v67.pos.Y > v64.Y + 120 or v67.pos.X < -120 or v67.pos.X > v64.X + 120 then
                                    v67.alive = false;
                                    v67.gui.Visible = false;
                                    v9 = v9 - 1;
                                else
                                    v67.gui.Position = UDim2.fromOffset(v67.pos.X, v67.pos.Y);
                                    v67.gui.Rotation = v67.rot;
                                end;
                            end;
                        end;
                    end;
                    if v65 <= 0 then
                        v9 = 0;
                    end;
                    return;
                end;
            end);
            return;
        end;
    end;
end;
v3.Burst = function(_, v74) --[[ Line: 338 ]] --[[ Name: Burst ]]
    -- upvalues: v72 (copy)
    if typeof(v74) ~= "number" then
        return;
    else
        v72(v74);
        return;
    end;
end;
return v3;