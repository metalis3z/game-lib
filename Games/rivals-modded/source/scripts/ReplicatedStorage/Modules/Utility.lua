-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local LocalizationService = game:GetService("LocalizationService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
local RenderstepForLoop = require(script:WaitForChild("RenderstepForLoop"));
local u1 = { "rbxassetid://17662038408", "rbxassetid://17662038274", "rbxassetid://17662037971" };
local u2 = {
    a = true,
    e = true,
    i = true,
    o = true,
    u = true
};
local u3 = {};
u3.__index = u3;

function u3._new() -- Line: 21
    -- upvalues: u3 (copy)
    local v4 = setmetatable({}, u3);
    v4._particle_hashes = {};
    v4._name_to_input_enum = nil;
    v4._search_translator = nil;
    v4._cached_sound_groups = {};
    v4:_Init();

    return v4;
end;

function u3.IsUIElementVisible(p5, p6) -- Line: 39
    -- upvalues: Players (copy)
    local v7 = (p6:IsDescendantOf(Players.LocalPlayer.PlayerGui) or p6:IsDescendantOf(workspace)) and p5:_RecursiveIsUIElementVisible(p6);

    return v7;
end;

function u3.IsTextBoxFocused(p8) -- Line: 44
    -- upvalues: UserInputService (copy)
    local success, result = pcall(UserInputService.GetFocusedTextBox, UserInputService);

    return not success or result;
end;

function u3.IsAprilFoolsRaw(p9) -- Line: 50
    -- upvalues: ServerOsTime (copy)
    local v10 = DateTime.fromUnixTimestamp(ServerOsTime:Get()):ToUniversalTime();
    local v11;

    if v10.Month == 4 then
        v11 = v10.Day == 1;
    else
        v11 = false;
    end;

    return v11;
end;

function u3.IsAprilFoolsGamemodesEnabled(p12) -- Line: 56
    return p12:IsAprilFoolsRaw();
end;

function u3.IsAprilFools(p13) -- Line: 60
    return false;
end;

function u3.DarkenColor(p14, p15, p16) -- Line: 64
    return Color3.new(p15.R * p16, p15.G * p16, p15.B * p16);
end;

function u3.IsWithinRotatedShape(p17, p18, p19, p20, p21) -- Line: 68
    if p21 == Enum.PartType.Ball then
        return (p18 - p19.Position).Magnitude <= math.max(p20.X, p20.Y, p20.Z) / 2;
    end;

    if p21 == Enum.PartType.Cylinder then
        local v22 = p19:PointToObjectSpace(p18);
        local v23;

        if v22.X >= -p20.X / 2 and v22.X <= p20.X / 2 then
            v23 = math.sqrt(v22.Y ^ 2 + v22.Z ^ 2) <= math.max(p20.Y, p20.Z) / 2;
        else
            v23 = false;
        end;

        return v23;
    end;

    local v24 = p19:PointToObjectSpace(p18);
    local v25;

    if v24.X >= -p20.X / 2 and (v24.X <= p20.X / 2 and (v24.Y >= -p20.Y / 2 and (v24.Y <= p20.Y / 2 and v24.Z >= -p20.Z / 2))) then
        v25 = v24.Z <= p20.Z / 2;
    else
        v25 = false;
    end;

    return v25;
end;

function u3.IsWithinPart(p26, p27, p28, p29) -- Line: 86
    -- upvalues: u3 (copy)
    local v30;

    if (p27.Position - p28).Magnitude < math.max(p27.Size.X, p27.Size.Y, p27.Size.Z) * 1.7320508075688772 then
        v30 = u3:IsWithinRotatedShape(p28, p27.CFrame, p27.Size + (p29 or Vector3.new(0, 0, 0)), p27.ClassName == "Part" and p27.Shape or Enum.PartType.Block);
    else
        v30 = false;
    end;

    return v30;
end;

function u3.IsWithinTaggedParts(p31, p32, p33, p34, p35) -- Line: 91
    -- upvalues: CollectionService (copy)
    local v36 = {};

    for _, v in pairs(CollectionService:GetTagged(p32)) do
        if p31:IsWithinPart(v, p33, p34) then
            if not p35 then
                return v;
            end;

            table.insert(v36, v);
        end;
    end;

    if p35 then
        return v36;
    end;

    return nil;
end;

function u3.LookThrough(p37, p38, p39) -- Line: 113
    for _, child in pairs(p38:GetChildren()) do
        if child:IsA("Model") and child.Name == p39 then
            return child;
        end;

        if child:IsA("Folder") then
            local v40 = p37:LookThrough(child, p39);

            if v40 then
                return v40;
            end;
        end;
    end;
end;

function u3.SilentWaitForChild(p41, p42, p43) -- Line: 127
    while not p42:FindFirstChild(p43) do
        p42.ChildAdded:Wait();
    end;

    return p42[p43];
end;

function u3.WaitForChildRecursive(p44, u45, u46, u47) -- Line: 137
    local v48 = u45:FindFirstChild(u46, true);

    if v48 then
        return v48;
    end;

    local BindableEvent = Instance.new("BindableEvent");

    if u47 then
        task.delay(u47, BindableEvent.Fire, BindableEvent, nil);
    end;

    task.defer(function() -- Line: 150
        -- upvalues: u47 (copy), u45 (copy), u46 (copy), BindableEvent (copy)
        local u49 = false;

        if not u47 then
            task.delay(5, function() -- Line: 154
                -- upvalues: u49 (ref), u45 (ref), u46 (ref)
                if not u49 then
                    warn("Infinite yield possible for", u45:GetFullName() .. ":WaitForChildRecursive(\"" .. u46 .. "\")");
                end;
            end);
        end;

        local v50;

        while true do
            v50 = u45:FindFirstChild(u46, true);

            if v50 then
                break;
            end;

            u45.DescendantAdded:Wait();
        end;

        BindableEvent:Fire(v50);
    end);

    return BindableEvent.Event:Wait();
end;

function u3.GetTaggedIn(p51, p52, p53) -- Line: 181
    -- upvalues: CollectionService (copy)
    local v54 = {};

    for _, v in pairs(CollectionService:GetTagged(p52)) do
        if v:IsDescendantOf(p53 or workspace) then
            table.insert(v54, v);
        end;
    end;

    return v54;
end;

function u3.GetCharacterModel(p55, p56) -- Line: 193
    -- upvalues: Players (copy)
    if not p56 or p56 == workspace then
        return nil;
    end;

    if Players:GetPlayerFromCharacter(p56) then
        return p56;
    end;

    return p55:GetCharacterModel(p56.Parent);
end;

function u3.GetProperArticle(p57, p58) -- Line: 199
    -- upvalues: u2 (copy)
    local string_lower_ret = string.lower(p58);

    return "a" .. (u2[string.sub(string_lower_ret, 1, 1)] and "n" or "");
end;

function u3.AntiBarcodeNames(p59, p60) -- Line: 203
    local v61 = 0;
    local v62 = "";

    for i = 1, #p60 do
        local string_sub_ret = string.sub(p60, i, i);
        local v63;

        if string_sub_ret == "l" or string_sub_ret == "I" then
            v61 = v61 + 1;
            v62 = v62 .. (string_sub_ret == "l" and "L" or (string_sub_ret == "I" and "i" or string_sub_ret));
            v63 = i;
        else
            v62 = v62 .. string_sub_ret;
            v63 = i;
        end;
    end;

    if v61 > 3 then
        p60 = v62 or p60;
    end;

    return p60;
end;

function u3.AntiCircleNames(p64, p65) -- Line: 221
    local v66 = 0;
    local v67 = "";

    for i = 1, #p65 do
        local string_sub_ret = string.sub(p65, i, i);
        local v68;

        if string_sub_ret == "O" or string_sub_ret == "0" then
            v66 = v66 + 1;
            v67 = v67 .. (string_sub_ret == "O" and "o" or string_sub_ret);
            v68 = i;
        else
            v67 = v67 .. string_sub_ret;
            v68 = i;
        end;
    end;

    if v66 > 3 then
        p65 = v67 or p65;
    end;

    return p65;
end;

function u3.SanitizeName(p69, p70) -- Line: 239
    return p69:AntiCircleNames((p69:AntiBarcodeNames(p70)));
end;

function u3.GetName(p71, p72, p73, p74) -- Line: 245
    local v75;

    if p72.HasVerifiedBadge then
        v75 = " " .. utf8.char(57344);
    elseif p74 or not p72.HasRobloxSubscription then
        v75 = (p74 or p72.MembershipType ~= Enum.MembershipType.Premium) and "" or " " .. utf8.char(57345);
    else
        v75 = " " .. utf8.char(57347);
    end;

    return p73 .. v75;
end;

function u3.GetConnectionLevelIcon(p76, p77) -- Line: 254
    -- upvalues: u1 (copy)
    return u1[p77];
end;

function u3.GetConnectionLevel(p78, p79) -- Line: 258
    return p79 < 60 and 3 or (p79 < 150 and 2 or 1);
end;

function u3.GetLocalConnectionPing(p80, p81) -- Line: 268
    -- upvalues: Players (copy)
    local v82 = (p81 or Players.LocalPlayer):GetNetworkPing() * 1000;

    return math.floor(v82);
end;

function u3.DisableShadows(p83, p84) -- Line: 272
    for _, descendant in pairs(p84:GetDescendants()) do
        if not descendant:HasTag("DisabledTexturesBlacklist") then
            if descendant:IsA("Light") then
                descendant.Shadows = false;
            elseif descendant:IsA("BasePart") then
                descendant.CastShadow = false;
            end;
        end;
    end;
end;

function u3.DisableTextures(p85, p86) -- Line: 286
    for _, descendant in pairs(p86:GetDescendants()) do
        if not descendant:HasTag("DisabledTexturesBlacklist") then
            if descendant:IsA("BasePart") then
                local v87 = descendant;

                for _, v in pairs(Enum.NormalId:GetEnumItems()) do
                    v87[v.Name .. "Surface"] = Enum.SurfaceType.Smooth;
                end;

                if v87.Material ~= Enum.Material.ForceField and v87.Material ~= Enum.Material.Neon then
                    local CurrentPhysicalProperties = v87.CurrentPhysicalProperties;
                    v87.Material = Enum.Material.SmoothPlastic;
                    v87.MaterialVariant = "";
                    v87.CustomPhysicalProperties = v87.CustomPhysicalProperties or CurrentPhysicalProperties;
                end;
            elseif (descendant:IsA("Texture") or descendant:IsA("Decal")) and descendant.Texture ~= "rbxassetid://7658055825" then
                descendant:Destroy();
            end;
        end;
    end;
end;

function u3.IsVisibleFromSearch(p88, p89, ...) -- Line: 310
    if not p89 or p89 == "" then
        return true;
    end;

    local v90 = { ... };

    for i = 1, #v90, 2 do
        local v91 = v90[i];
        local v92;

        if v91 then
            local v93 = v90[i + 1] or game;

            if p88._search_translator then
                local success, result = pcall(p88._search_translator.Translate, p88._search_translator, v93, v91);

                if success then
                    v91 = string.lower(result);
                end;
            end;

            if string.find(string.lower(v91), p89) then
                return true;
            end;

            v92 = i;
        else
            v92 = i;
        end;
    end;

    return false;
end;

function u3.IsValidHex(p94, p95) -- Line: 342
    if typeof(p95) ~= "string" or (#p95 ~= 7 or string.sub(p95, 1, 1) ~= "#") then
        return false;
    end;

    for i = 2, 7 do
        local string_sub_ret = string.sub(p95, i, i);
        local string_byte_ret = string.byte(string_sub_ret);

        if not (string_byte_ret >= 48 and string_byte_ret <= 57 or string_byte_ret >= 97 and string_byte_ret <= 102) then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

function u3.Color3FromHex(p96, p97) -- Line: 360
    local v98 = p96:IsValidHex(p97);
    assert(v98, "Argument 1 invalid, expected a valid hex string");
    local v99 = "0x" .. string.sub(p97, 2, 3);
    local v100 = tonumber(v99);
    local v101 = "0x" .. string.sub(p97, 4, 5);
    local v102 = tonumber(v101);
    local v103 = "0x" .. string.sub(p97, 6, 7);
    local v104 = tonumber(v103);

    return Color3.fromRGB(v100, v102, v104);
end;

function u3.HexFromColor3(p105, p106) -- Line: 371
    local v107 = typeof(p106) == "Color3";
    assert(v107, "Argument 1 invalid, expected a Color3");
    local math_floor_ret = math.floor(p106.R * 255 + 0.5);
    local math_floor_ret2 = math.floor(p106.G * 255 + 0.5);
    local math_floor_ret3 = math.floor(p106.B * 255 + 0.5);

    return string.format("#%02x%02x%02x", math_floor_ret, math_floor_ret2, math_floor_ret3);
end;

function u3.GetInputEnumFromName(p108, p109) -- Line: 381
    if not p108._name_to_input_enum then
        p108._name_to_input_enum = {};
        local v110 = {};

        for _, v in pairs({ Enum.KeyCode, Enum.UserInputType }) do
            for _, v2 in pairs(v:GetEnumItems()) do
                if v110[v2] == nil then
                    v110[v2] = true;
                elseif v110[v2] == true then
                    v110[v2] = false;
                end;
            end;
        end;

        for i, v in pairs(v110) do
            if v then
                p108._name_to_input_enum[i.Name] = i;
            end;
        end;
    end;

    return p108._name_to_input_enum[p109];
end;

function u3.SphereLineIntersection(p111, p112, p113, p114, p115) -- Line: 408
    local v116 = p115 - p114;
    local magnitude = v116.magnitude;
    local v117 = p114 - p112;
    local v118 = v117:Dot(v116.unit);
    local v119 = v117:Dot(v117) - p113 * p113;

    if v119 > 0 and v118 > 0 then
        return false;
    end;

    local v120 = v118 * v118 - v119;

    if v120 < 0 then
        return false;
    end;

    return magnitude >= -v118 - math.sqrt(v120);
end;

function u3.Knockback(p121, u122, p123, p124) -- Line: 435
    -- upvalues: BetterDebris (copy)
    u122.Velocity = Vector3.new(0, 0, 0);
    local BodyVelocity = Instance.new("BodyVelocity");
    local v125 = math.abs(p123.X) > 0.1 and 1 or 0;
    local v126 = math.abs(p123.Y) > 0.1 and 1 or 0;
    local v127 = math.abs(p123.Z) > 0.1 and 1 or 0;
    BodyVelocity.MaxForce = Vector3.new(v125, v126, v127) * 100000;
    BodyVelocity.Velocity = p123;
    BodyVelocity.Parent = u122;
    BetterDebris:AddItem(BodyVelocity, 0.2);

    if p124 then
        BetterDebris:AddItem(BodyVelocity, p124);
        task.delay(p124, function() -- Line: 447
            -- upvalues: u122 (copy)
            u122.Velocity = Vector3.new(0, 0, 0);
        end);
    end;

    return BodyVelocity;
end;

function u3.GetArmsData(p128, p129) -- Line: 455
    if p129 then
        local v130 = p129:FindFirstChildOfClass("Shirt");

        if v130 then
            v130 = v130.ShirtTemplate;
        end;

        local v131 = p129:FindFirstChildOfClass("BodyColors");
        local v132;

        if v131 then
            v132 = v131.LeftArmColor3;
        else
            v132 = v131;
        end;

        if v131 then
            v131 = v131.RightArmColor3;
        end;

        return v130, v132, v131;
    end;
end;

function u3.TimeFormat(p133, p134) -- Line: 471
    local math_floor_ret = math.floor(p134);
    local v135 = math_floor_ret % 60;

    return math.floor(math_floor_ret / 60) .. ":" .. (v135 < 10 and "0" or "") .. v135;
end;

function u3.TimeFormat2(p136, p137, p138, p139) -- Line: 480
    if not p139 and p137 <= 0 then
        return "0s";
    end;

    if p139 and p137 < 60 then
        return "0m";
    end;

    local v140 = p137 % 60;
    local v141 = p137 - v140;
    local v142 = v141 / 60 % 60;
    local v143 = v141 - v142 * 60;
    local v144 = v143 / 60 / 60 % 24;
    local v145 = v143 - v144 * 60 * 60;
    local v146 = v145 / 60 / 60 / 24 % 365;
    local v147 = (v145 - v146 * 24 * 60 * 60) / 60 / 60 / 24 / 365;

    if not p138 then
        return (v147 > 0 and (v147 .. "y " or "") or "") .. ((v147 > 0 or v146 > 0) and (v146 .. "d " or "") or "") .. ((v147 > 0 or (v146 > 0 or v144 > 0)) and (v144 .. "h " or "") or "") .. ((v147 > 0 or (v146 > 0 or (v144 > 0 or v142 > 0))) and (v142 .. "m " or "") or "") .. ((v147 <= 0 and (v146 <= 0 and (v144 <= 0 and (v142 <= 0 and v140 <= 0))) or p139) and "" or (v140 .. "s" or ""));
    end;

    local v148 = typeof(p138) == "number" and p138 and p138 or 1;
    local v149 = 0;
    local v150 = "";

    for _, v in pairs({
        { v147, "y" },
        { v146, "d" },
        { v144, "h" },
        { v142, "m" },
        { v140, "s" }
    }) do
        if v[1] > 0 then
            v149 = v149 + 1;
            v150 = v150 .. (v149 > 1 and " " or "") .. v[1] .. v[2];

            if v148 <= v149 then
                break;
            end;
        end;
    end;

    return v150;
end;

function u3.ScaleParticleEmitter(p151, p152, p153) -- Line: 523
    local v154 = p152:IsA("ParticleEmitter") and {} or p152:GetDescendants();
    table.insert(v154, p152);

    for _, v in pairs(v154) do
        if v:IsA("ParticleEmitter") then
            local v155 = v;
            local v156 = {};

            for _, v2 in pairs(v.Size.Keypoints) do
                table.insert(v156, NumberSequenceKeypoint.new(v2.Time, v2.Value * p153, v2.Envelope * p153));
            end;

            v155.Size = NumberSequence.new(v156);
            v155.Speed = NumberRange.new(v155.Speed.Min * p153, v155.Speed.Max * p153);
            v155.Acceleration = v155.Acceleration * p153 ^ 2;
        end;
    end;
end;

function u3.EncodeCFrame(p157, p158) -- Line: 545
    local v159, v160, v161 = p158:ToOrientation();

    return {
        [utf8.char(0)] = p158.X,
        [utf8.char(1)] = p158.Y,
        [utf8.char(2)] = p158.Z,
        [utf8.char(3)] = v159,
        [utf8.char(4)] = v160,
        [utf8.char(5)] = v161
    };
end;

function u3.DecodeCFrame(p162, p163) -- Line: 558
    return CFrame.new(p163[utf8.char(0)], p163[utf8.char(1)], p163[utf8.char(2)]) * CFrame.fromOrientation(p163[utf8.char(3)], p163[utf8.char(4)], p163[utf8.char(5)]);
end;

function u3.FromXYToCameraRotation(p164, p165, p166) -- Line: 563
    return Vector2.new(p165, p166) * 3.141592653589793 * 2 / 256;
end;

function u3.DecodeCameraRotation(p167, p168) -- Line: 568
    local utf8_codepoint_ret, v169 = utf8.codepoint(p168, 1, #p168);

    return p167:FromXYToCameraRotation(utf8_codepoint_ret, v169);
end;

function u3.DecodeCameraRotationBulk(p170, p171) -- Line: 575
    local v172 = { utf8.codepoint(p171, 1, #p171) };
    local v173 = {};

    for i = 1, #p171, 3 do
        table.insert(v173, { v172[i], v172[i + 1], v172[i + 2] });
        local _ = i;
    end;

    return v173;
end;

function u3.EncodeCameraRotation(p174, p175) -- Line: 591
    if p175 ~= p175 then
        return utf8.char(0) .. utf8.char(0);
    end;

    local math_floor_ret = math.floor(p175.X % 6.283185307179586 / 3.141592653589793 / 2 * 256 + 0.5);
    local math_clamp_ret = math.clamp(math_floor_ret, 0, 255);
    local math_floor_ret2 = math.floor(p175.Y % 6.283185307179586 / 3.141592653589793 / 2 * 256 + 0.5);
    local math_clamp_ret2 = math.clamp(math_floor_ret2, 0, 255);

    return utf8.char(math_clamp_ret) .. utf8.char(math_clamp_ret2);
end;

function u3.AngleBetweenVectors(p176, p177, p178) -- Line: 602
    local v179 = p178:Dot(p177) / p178.Magnitude / p177.Magnitude;

    return math.acos(v179);
end;

function u3.PlayParticles(u180, u181) -- Line: 607
    if not u181 then
        return;
    end;

    local v182 = typeof(u181) == "Instance" and true or typeof(u181) == "table";
    assert(v182, "Argument 1 invalid, expected an Instance or table");
    local u183 = typeof(u181) == "Instance";
    local v184;

    if u183 then
        v184 = not u181:IsDescendantOf(workspace);
    else
        v184 = u183;
    end;

    local u185;

    if u183 and not v184 then
        if not u180._particle_hashes[u181] then
            u180._particle_hashes[u181] = 0;
            local u186 = nil;
            u186 = u181.AncestryChanged:Connect(function() -- Line: 625
                -- upvalues: u181 (copy), u186 (ref), u180 (copy)
                if not u181:IsDescendantOf(workspace) then
                    u186:Disconnect();
                    u180._particle_hashes[u181] = nil;
                end;
            end);
        end;

        local _particle_hashes = u180._particle_hashes;
        _particle_hashes[u181] = _particle_hashes[u181] + 1;
        u185 = u180._particle_hashes[u181];
    else
        u185 = nil;
    end;

    local v187;

    if u183 then
        v187 = u181:GetDescendants();
        table.insert(v187, u181);
    else
        v187 = {};

        for _, v in pairs(u181) do
            table.insert(v187, v);

            for _, descendant in pairs(v:GetDescendants()) do
                table.insert(v187, descendant);
            end;
        end;
    end;

    for _, v in pairs(v187) do
        if v:IsA("ParticleEmitter") then
            local v188 = v:GetAttribute("EmitCount") or 0;
            local v189 = v:GetAttribute("EmitDelay") or 0;
            local u190 = v:GetAttribute("EmitDuration") or 0;

            if v189 > 0 then
                task.delay(v189, v.Emit, v, v188);
            else
                task.spawn(v.Emit, v, v188);
            end;

            if u190 > 0 then
                task.defer(function() -- Line: 667
                    -- upvalues: v (copy), u190 (copy)
                    v.Enabled = true;
                    task.wait(u190);
                    v.Enabled = false;
                end);
            end;
        elseif v:IsA("Light") then
            local u191 = v:GetAttribute("Brightness") or 0;
            local u192 = v:GetAttribute("DecaySpeed") or 1;

            if not v184 then
                task.spawn(function() -- Line: 678
                    -- upvalues: v (copy), u191 (copy), u180 (copy), u192 (copy), u183 (copy), u181 (copy), u185 (ref)
                    v.Brightness = u191;
                    v.Enabled = true;
                    u180:RenderstepForLoop(0, 100, 10 * u192, function(p193) -- Line: 682
                        -- upvalues: u183 (ref), u180 (ref), u181 (ref), u185 (ref), v (ref), u191 (ref)
                        if u183 and u180._particle_hashes[u181] ~= u185 then
                            return true;
                        end;

                        v.Brightness = u191 * (1 - p193 / 100);
                    end);

                    if not u180._particle_hashes[u181] then
                        v.Brightness = 0;
                        v.Enabled = false;
                    end;
                end);
            end;
        end;
    end;
end;

function u3.StringLessThan(p194, p195, p196) -- Line: 701
    if p195 == p196 then
        return false;
    end;

    for i = 1, math.min(#p195, #p196) do
        local string_sub_ret = string.sub(p195, i, i);
        local string_byte_ret = string.byte(string_sub_ret);
        local string_sub_ret2 = string.sub(p196, i, i);
        local string_byte_ret2 = string.byte(string_sub_ret2);

        if string_byte_ret ~= string_byte_ret2 then
            return string_byte_ret < string_byte_ret2;
        end;

        local _ = i;
    end;

    return #p195 < #p196;
end;

function u3.CloneTable(p197, p198, p199) -- Line: 720
    local v200 = {};

    for i, v in pairs(p198) do
        if p199 or typeof(v) ~= "table" then
            v200[i] = v;
        else
            v200[i] = p197:CloneTable(v);
        end;
    end;

    return v200;
end;

function u3.PrettyNumber(p201, p202) -- Line: 735
    local v203 = tonumber(p202);

    if typeof(v203) ~= "number" then
        local v204 = "Argument 1 invalid, expected a number or string, got " .. tostring(p202);
        assert(false, v204);
    end;

    if tostring(p202) == "inf" then
        return "inf";
    end;

    local string_match_ret, v205, v206 = string.match(v203, "^([^%d]*%d)(%d*)(.-)$");

    return string_match_ret .. v205:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v206;
end;

function u3.Raycast(p207, p208, p209, p210, p211, p212, p213) -- Line: 757
    -- upvalues: BetterDebris (copy)
    local v214 = typeof(p208) == "Vector3";
    assert(v214, "Argument 1 invalid, expected a Vector3");
    local v215 = typeof(p209) == "Vector3";
    assert(v215, "Argument 2 invalid, expected a Vector3");
    local v216 = typeof(p210) == "number";
    assert(v216, "Argument 3 invalid, expected a number");
    local v217 = not p211 or typeof(p211) == "table";
    assert(v217, "Argument 4 invalid, expected a table or nil");
    local v218 = not p212 or typeof(p212) == "EnumItem";
    assert(v218, "Argument 5 invalid, expected a RaycastFilterType");
    local v219 = not p213 or typeof(p213) == "boolean";
    assert(v219, "Argument 6 invalid, expected a boolean or nil");
    local v220 = p212 or Enum.RaycastFilterType.Exclude;
    local v221 = (p209 - p208).Unit * p210;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterDescendantsInstances = p211 or {};
    RaycastParams_new_ret.FilterType = v220;
    RaycastParams_new_ret.IgnoreWater = true;
    local v222 = workspace:Raycast(p208, v221, RaycastParams_new_ret);
    local v223 = {
        Position = v222 and v222.Position or p208 + (p209 - p208).Unit * p210
    };

    if v222 then
        p210 = v222.Distance or p210;
    end;

    v223.Distance = p210;
    local v224;

    if v222 then
        v224 = v222.Instance or nil;
    else
        v224 = nil;
    end;

    v223.Instance = v224;
    local v225;

    if v222 then
        v225 = v222.Material or nil;
    else
        v225 = nil;
    end;

    v223.Material = v225;
    v223.Normal = v222 and v222.Normal or nil;

    if p213 then
        local Magnitude = (p208 - v223.Position).Magnitude;
        local Part = Instance.new("Part");
        Part.Color = Color3.fromHSV(math.random(), 1, 1);
        Part.Material = Enum.Material.Neon;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.Size = Vector3.new(0.01, 0.01, Magnitude);
        Part.CFrame = CFrame.new(p208, v223.Position) * CFrame.new(0, 0, -Magnitude / 2);
        Part.Parent = workspace;
        BetterDebris:AddItem(Part, 10);
    end;

    return v223;
end;

function u3.WaitForChildWhichIsA(p226, p227, p228, p229) -- Line: 803
    local v230 = typeof(p227) == "Instance";
    local v231 = "Argument 1 invalid, expected an Instance, got " .. tostring(p227);
    assert(v230, v231);
    local v232 = typeof(p228) == "string";
    local v233 = "Argument 2 invalid, expected a string, got " .. tostring(p228);
    assert(v232, v233);
    local v234 = not p229 or typeof(p229) == "boolean";
    local v235 = "Argument 3 invalid, expected a boolean or nil, got " .. tostring(p229);
    assert(v234, v235);
    local v236;

    while true do
        v236 = p227:FindFirstChildWhichIsA(p228, p229);

        if v236 then
            break;
        end;

        if p229 then
            p227.DescendantAdded:Wait();
        else
            p227.ChildAdded:Wait();
        end;
    end;

    return v236;
end;

function u3.CreateSound(p237, p238, p239, p240, p241, p242, p243, p244, p245, p246, p247) -- Line: 827
    -- upvalues: CONSTANTS (copy), ReplicatedStorage (copy), EnumLibrary (copy), BetterDebris (copy)
    local v248 = typeof(p238) == "string";
    assert(v248, p238);
    local v249 = not p239 or typeof(p239) == "number";
    assert(v249, p239);
    local v250 = not p240 or typeof(p240) == "number";
    assert(v250, p240);
    local v251 = not p241 or ((p241 == "script" or typeof(p241) == "Instance") and true or typeof(p241) == "Vector3");
    assert(v251, p241);
    local v252 = not p242 or typeof(p242) == "boolean";
    assert(v252, "Argument 5 invalid, expected a boolean", p242);
    local v253 = not p243 or typeof(p243) == "number";
    assert(v253, "Argument 6 invalid, expected a number or nil", p243);
    local v254 = not p244 or typeof(p244) == "number";
    assert(v254, "Argument 7 invalid, expected a number or nil", p244);
    local v255 = not p245 or typeof(p245) == "number";
    assert(v255, "Argument 8 invalid, expected a number or nil", p245);
    local v256 = not p246 or typeof(p246) == "string";
    assert(v256, "Argument 9 invalid, expected a string or nil", p246);
    local v257 = not p247 or typeof(p247) == "table";
    assert(v257, "Argument 10 invalid, expected a table or nil", p247);

    if not CONSTANTS.IS_SERVER then
        if typeof(p241) == "Vector3" then
            local Part = Instance.new("Part");
            Part.CFrame = CFrame.new(p241);
            Part.Size = Vector3.new(1, 1, 1);
            Part.Transparency = 1;
            Part.CastShadow = false;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.CanQuery = false;
            Part.Anchored = true;
            Part.Parent = workspace;
            BetterDebris:AddItem(Part, p243 or 60);
            p241 = Part;
        elseif p241 == "script" then
            p241 = script;
        end;

        local Sound = Instance.new("Sound");
        -- The place owner's replacements (ServerStorage.SoundOverrides).
        Sound.SoundId = require(ReplicatedStorage.Modules.SoundOverrides).Get(p238);
        Sound.Volume = p239 or 1;
        Sound.PlaybackSpeed = p240 or 1;
        Sound.RollOffMinDistance = p244 or 50;
        Sound.RollOffMaxDistance = p245 or 400;
        Sound.RollOffMode = Enum.RollOffMode.Inverse;
        Sound.SoundGroup = p237:_GetSoundGroup(p246);
        Sound:AddTag("AudioVisualizer");

        for i, v in pairs(p247 or {}) do
            Sound[i] = v;
        end;

        Sound.Parent = p241;

        if p242 then
            Sound:Play();
        end;

        if p243 then
            BetterDebris:AddItem(Sound, p243);
        end;

        return Sound;
    end;

    ReplicatedStorage.Remotes.Misc.FunctionsUnreliable:FireAllClients(EnumLibrary:ToEnum("CreateSound"), p238, p239, p240, p241, p242, p243, p244, p245, p246, p247);
end;

function u3.WaitForChild(p258, p259, ...) -- Line: 892
    local v260 = typeof(p259) == "Instance";
    local v261 = "Argument 1 invalid, expected an Instance, got " .. tostring(p259);
    assert(v260, v261);

    for i, v in pairs({ ... }) do
        local v262 = typeof(v) == "string";
        local v263 = "Argument " .. i + 1 .. " invalid, expected a string, got " .. tostring(v);
        assert(v262, v263);
        p259 = p259:WaitForChild(v);
    end;

    return p259;
end;

function u3.RenderstepForLoop(p264, ...) -- Line: 906
    -- upvalues: RenderstepForLoop (copy)
    RenderstepForLoop(...);
end;

function u3._GetSoundGroup(p265, p266) -- Line: 914
    -- upvalues: SoundService (copy)
    local v267 = p266 or "Other";

    if not p265._cached_sound_groups[v267] then
        p265._cached_sound_groups[v267] = SoundService:FindFirstChild(v267, true);
    end;

    return p265._cached_sound_groups[v267];
end;

function u3._RecursiveIsUIElementVisible(p268, p269) -- Line: 924
    if p269:IsA("ScreenGui") or (p269:IsA("SurfaceGui") or p269:IsA("BillboardGui")) then
        return p269.Enabled;
    end;

    local v270 = p269.Visible and p268:_RecursiveIsUIElementVisible(p269.Parent);

    return v270;
end;

function u3._SetupTranslator(p271) -- Line: 928
    -- upvalues: CONSTANTS (copy), LocalizationService (copy), Players (copy)
    if not CONSTANTS.IS_CLIENT then
        return;
    end;

    local success, result = pcall(LocalizationService.GetTranslatorForPlayerAsync, LocalizationService, Players.LocalPlayer);

    if success then
        p271._search_translator = result;

        return;
    end;

    warn("Failed to fetch translator, error:", result);
end;

function u3._Init(p272) -- Line: 943
    task.defer(p272._SetupTranslator, p272);
end;

return u3._new();