-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local StarterGui = game:GetService("StarterGui");
local Modules = require(script.Parent.Parent.Modules);
local SoundController = require(Modules.Controllers.SoundController);
local Quad = Enum.EasingStyle.Quad;
local Out = Enum.EasingDirection.Out;
local u1 = {};

local function shiftColor(p2, p3, p4) -- Line: 61
    local v5, v6, v7 = p2:ToHSV();
    local v8 = p4 or "auto";
    local v9;

    if v8 == "lighten" then
        v9 = math.min(1, v7 + p3);
    elseif v8 == "darken" then
        v9 = math.max(0, v7 - p3);
    elseif v7 < 0.5 then
        v9 = math.min(1, v7 + p3);
    else
        v9 = math.max(0, v7 - p3);
    end;

    return Color3.fromHSV(v5, v6, v9);
end;

local function getTarget(p10) -- Line: 80
    local v11 = p10:GetAttribute("hoverTarget");
    local v12 = v11 and p10:FindFirstChild(v11);

    if v12 then
        return v12;
    end;

    if p10.BackgroundTransparency >= 1 then
        local back = p10:FindFirstChild("back");

        if back then
            return back;
        end;

        local v13 = p10.Parent and p10.Parent:FindFirstChild("back");

        if v13 then
            return v13;
        end;
    end;

    return p10;
end;

local function cleanupInstance(p14) -- Line: 342
    -- upvalues: u1 (copy)
    local v15 = u1[p14];

    if not v15 then
        return;
    end;

    if v15.disconnectVisibilityListeners then
        v15.disconnectVisibilityListeners();
    end;

    for _, v in v15.connections do
        v:Disconnect();
    end;

    u1[p14] = nil;
end;

script.Parent.Parent:WaitForChild("Events"):WaitForChild("ThemeChanged").Event:Connect(function() -- Line: 362
    -- upvalues: u1 (copy)
    for _, v in u1 do
        if v.recaptureColor then
            v.recaptureColor();
        end;
    end;
end);

local function setupInstance(u16, p17) -- Line: 110
    -- upvalues: u1 (copy), StarterGui (copy), getTarget (copy), Quad (copy), Out (copy), TweenService (copy), SoundController (copy), shiftColor (copy)
    if u1[u16] then
        return;
    end;

    if u16:IsDescendantOf(StarterGui) then
        return;
    end;

    if not u16:IsA("GuiButton") then
        return;
    end;

    local u18 = (p17 == "UIEffect" or p17 == "UIEffectColorOnly") and true or p17 == "UIEffectHoverOnly";
    local v19 = {};
    local u20 = getTarget(u16);
    local u21 = u16:GetAttribute("hoverProperty") or "BackgroundColor3";
    local u22 = u16:GetAttribute("hoverDuration") or 0.1;

    if u18 and not u16:GetAttribute("noHoverColor") then
        u16.AutoButtonColor = false;
    else
        u18 = false;
    end;

    local u23 = u16:GetAttribute("hoverColor");
    local u24 = u16:GetAttribute("hoverShiftMode");
    local u25 = u16:GetAttribute("hoverSound") or "HOVER";
    local u26 = u16:GetAttribute("clickSound") or "CLICK";
    local u27 = not ((p17 == "UIEffect" or p17 == "UIEffectSoundOnly") and true or p17 == "UIEffectHoverOnly") or u16:GetAttribute("noHoverSound") == true;
    local u28 = not (p17 ~= "UIEffectColorOnly") or u16:GetAttribute("noClickSound") == true;
    local u29 = TweenInfo.new(u22, Quad, Out);
    local u30 = nil;
    local u31 = false;
    local u32 = false;
    local u33;

    if u18 then
        u33 = u20[u21] or nil;
    else
        u33 = nil;
    end;

    local u34;

    if u16:GetAttribute("hoverShadow") == true then
        u34 = u20:FindFirstChildOfClass("UIShadow");
    else
        u34 = nil;
    end;

    local u35, u36;

    if u34 then
        u35 = {
            Offset = u34.Offset,
            BlurRadius = u34.BlurRadius
        };
        u36 = {
            Offset = UDim2.new(u34.Offset.X.Scale, u34.Offset.X.Offset, u34.Offset.Y.Scale * 1.6, u34.Offset.Y.Offset),
            BlurRadius = UDim.new(u34.BlurRadius.Scale * 1.45, u34.BlurRadius.Offset)
        };
    else
        u35 = nil;
        u36 = nil;
    end;

    local function restoreShadow(p37) -- Line: 153
        -- upvalues: u34 (copy), u35 (ref), TweenService (ref), u29 (copy)
        if not u34 then
            return;
        end;

        if not p37 then
            TweenService:Create(u34, u29, u35):Play();

            return;
        end;

        u34.Offset = u35.Offset;
        u34.BlurRadius = u35.BlurRadius;
    end;

    local u38 = {};
    local u39 = nil;

    local function connectVisibilityListeners() -- Line: 168
        -- upvalues: u16 (copy), u38 (copy), u31 (ref), u32 (ref), u30 (ref), u20 (copy), u21 (copy), u33 (ref), u34 (copy), u35 (ref), u39 (ref)
        local u40 = u16;

        while u40 do
            if not u40:IsA("GuiObject") then
                if u40:IsA("LayerCollector") then
                    local v41 = u40:GetPropertyChangedSignal("Enabled");
                    table.insert(u38, v41:Connect(function() -- Line: 202
                        -- upvalues: u40 (copy), u31 (ref), u32 (ref), u30 (ref), u20 (ref), u21 (ref), u33 (ref), u34 (ref), u35 (ref), u39 (ref)
                        if not u40.Enabled then
                            u31 = false;
                            u32 = false;

                            if u30 then
                                u30:Cancel();
                                u30 = nil;
                            end;

                            u20[u21] = u33;

                            if u34 then
                                u34.Offset = u35.Offset;
                                u34.BlurRadius = u35.BlurRadius;
                            end;

                            u39();
                        end;
                    end));

                    return;
                end;

                break;
            end;

            local v42 = u40:GetPropertyChangedSignal("Visible");
            table.insert(u38, v42:Connect(function() -- Line: 173
                -- upvalues: u40 (copy), u31 (ref), u32 (ref), u30 (ref), u20 (ref), u21 (ref), u33 (ref), u34 (ref), u35 (ref), u39 (ref)
                if not u40.Visible then
                    u31 = false;
                    u32 = false;

                    if u30 then
                        u30:Cancel();
                        u30 = nil;
                    end;

                    u20[u21] = u33;

                    if u34 then
                        u34.Offset = u35.Offset;
                        u34.BlurRadius = u35.BlurRadius;
                    end;

                    u39();
                end;
            end));

            if u40:IsA("CanvasGroup") then
                local v43 = u40:GetPropertyChangedSignal("GroupTransparency");
                table.insert(u38, v43:Connect(function() -- Line: 187
                    -- upvalues: u40 (copy), u31 (ref), u32 (ref), u30 (ref), u20 (ref), u21 (ref), u33 (ref), u34 (ref), u35 (ref), u39 (ref)
                    if u40.GroupTransparency >= 1 then
                        u31 = false;
                        u32 = false;

                        if u30 then
                            u30:Cancel();
                            u30 = nil;
                        end;

                        u20[u21] = u33;

                        if u34 then
                            u34.Offset = u35.Offset;
                            u34.BlurRadius = u35.BlurRadius;
                        end;

                        u39();
                    end;
                end));
            end;

            u40 = u40.Parent;
        end;
    end;

    u39 = function() -- Line: 223
        -- upvalues: u38 (copy)
        for _, v in u38 do
            v:Disconnect();
        end;

        table.clear(u38);
    end;

    table.insert(v19, u16.MouseEnter:Connect(function() -- Line: 230
        -- upvalues: u27 (copy), SoundController (ref), u25 (copy), u34 (copy), TweenService (ref), u29 (copy), u36 (ref), u18 (ref), u30 (ref), u31 (ref), u33 (ref), u20 (copy), u21 (copy), u32 (ref), connectVisibilityListeners (copy), u23 (copy), shiftColor (ref), u24 (copy)
        if not u27 then
            SoundController.PlaySound(u25);
        end;

        if u34 then
            TweenService:Create(u34, u29, u36):Play();
        end;

        if u18 then
            if u30 then
                u30:Cancel();
                u30 = nil;

                if not u31 and u33 then
                    u20[u21] = u33;
                end;
            end;

            if not u31 then
                u33 = u20[u21];
            end;

            u31 = true;
            u32 = false;
            connectVisibilityListeners();
            u30 = TweenService:Create(u20, u29, {
                [u21] = u23 or shiftColor(u33, 0.15, u24)
            });
            u30:Play();
        end;
    end));
    table.insert(v19, u16.MouseLeave:Connect(function() -- Line: 262
        -- upvalues: u34 (copy), TweenService (ref), u29 (copy), u35 (ref), u18 (ref), u31 (ref), u39 (ref), u30 (ref), u32 (ref), u33 (ref), u1 (ref), u16 (copy), u20 (copy), u21 (copy)
        if u34 then
            TweenService:Create(u34, u29, u35):Play();
        end;

        if u18 then
            u31 = false;
            u39();

            if u30 then
                u30:Cancel();
                u30 = nil;
            end;

            if u32 then
                u32 = false;
                local u44 = u33;
                task.delay(0.05, function() -- Line: 277
                    -- upvalues: u31 (ref), u1 (ref), u16 (ref), u20 (ref), u21 (ref), u44 (copy), u33 (ref), u30 (ref), TweenService (ref), u29 (ref)
                    if u31 then
                        return;
                    end;

                    if not u1[u16] then
                        return;
                    end;

                    local v45 = u20[u21];

                    if v45 ~= u44 then
                        u33 = v45;

                        return;
                    end;

                    u30 = TweenService:Create(u20, u29, {
                        [u21] = u44
                    });
                    u30:Play();
                end);

                return;
            end;

            u30 = TweenService:Create(u20, u29, {
                [u21] = u33
            });
            u30:Play();
        end;
    end));
    table.insert(v19, u16.Activated:Connect(function() -- Line: 295
        -- upvalues: u28 (copy), SoundController (ref), u26 (copy), u18 (ref), u32 (ref), u30 (ref), u20 (copy), u21 (copy), u33 (ref), u22 (copy), u31 (ref), u1 (ref), u16 (copy), u39 (ref), TweenService (ref), u29 (copy)
        if not u28 then
            SoundController.PlaySound(u26);
        end;

        if u18 then
            u32 = true;

            if u30 then
                u30:Cancel();
                u30 = nil;
                u20[u21] = u33;
            end;

            task.delay(u22 + 0.05, function() -- Line: 309
                -- upvalues: u31 (ref), u1 (ref), u16 (ref), u32 (ref), u39 (ref), u20 (ref), u21 (ref), u33 (ref), u30 (ref), TweenService (ref), u29 (ref)
                if not u31 then
                    return;
                end;

                if not u1[u16] then
                    return;
                end;

                u31 = false;
                u32 = false;
                u39();
                local v46 = u20[u21];

                if v46 ~= u33 then
                    u33 = v46;

                    return;
                end;

                u30 = TweenService:Create(u20, u29, {
                    [u21] = u33
                });
                u30:Play();
            end);
        end;
    end));
    u1[u16] = {
        connections = v19,
        disconnectVisibilityListeners = u39,

        recaptureColor = function() -- Line: 329, Name: recaptureColor
            -- upvalues: u18 (ref), u31 (ref), u33 (ref), u20 (copy), u21 (copy)
            if u18 and not u31 then
                u33 = u20[u21];
            end;
        end
    };
end;

for _, v in { "UIEffect", "UIEffectSoundOnly", "UIEffectColorOnly", "UIEffectHoverOnly" } do
    CollectionService:GetInstanceAddedSignal(v):Connect(function(p47) -- Line: 371
        -- upvalues: setupInstance (copy), v (copy)
        setupInstance(p47, v);
    end);
    CollectionService:GetInstanceRemovedSignal(v):Connect(function(p48) -- Line: 375
        -- upvalues: u1 (copy)
        local v49 = u1[p48];

        if not v49 then
            return;
        end;

        if v49.disconnectVisibilityListeners then
            v49.disconnectVisibilityListeners();
        end;

        for _, v2 in v49.connections do
            v2:Disconnect();
        end;

        u1[p48] = nil;
    end);

    for _, v2 in CollectionService:GetTagged(v) do
        task.defer(setupInstance, v2, v);
    end;
end;