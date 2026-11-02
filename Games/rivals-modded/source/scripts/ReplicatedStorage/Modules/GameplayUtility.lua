-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local ServerStorage = game:GetService("ServerStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Maps = ReplicatedStorage.Assets.Temp.Maps;
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 20
    -- upvalues: u1 (copy), Maps (copy)
    local v2 = setmetatable({}, u1);
    v2.TEMP_MAPS_FOLDER = Maps;
    v2.OOB_DEFAULT_WARN_DELAY = 1;
    v2.OOB_DEFAULT_KILL_DELAY = 4;
    v2:_Init();

    return v2;
end;

function u1.IsThingInWorkspace(p3, p4) -- Line: 36
    -- upvalues: Maps (copy)
    return p4:IsDescendantOf(workspace) or p4:IsDescendantOf(Maps);
end;

function u1.IsEntity(p5, p6) -- Line: 41
    -- upvalues: CollectionService (copy)
    while p6 and p6 ~= workspace do
        if CollectionService:HasTag(p6, "Entity") then
            return p6;
        end;

        p6 = p6.Parent;
    end;

    return false;
end;

function u1.GetEnvironmentID(p7, p8) -- Line: 53
    while p8 and p8:IsDescendantOf(workspace) do
        local Attribute = p8:GetAttribute("EnvironmentID");

        if Attribute then
            return Attribute;
        end;

        p8 = p8.Parent;
    end;

    return nil;
end;

function u1.GetSmokeCloudBetweenPoints(p9, p10, p11) -- Line: 67
    -- upvalues: CollectionService (copy), Utility (copy)
    for _, v in pairs(CollectionService:GetTagged("SmokeCloud")) do
        if Utility:SphereLineIntersection(v.Position, v.Size.X / 2, p10, p11) then
            return v;
        end;
    end;
end;

function u1.GetSmokeCloudsInSphere(p12, p13, p14, p15, p16) -- Line: 75
    -- upvalues: CollectionService (copy), Utility (copy)
    local v17 = p14 or 0;
    local v18 = {};

    for _, v in pairs(CollectionService:GetTagged("SmokeCloud")) do
        if (p13 - v.Position).Magnitude <= v.Size.X / 2 + v17 and not (p15 and (p16 and p16 < Utility:AngleBetweenVectors(p15, v.Position - p13))) then
            table.insert(v18, v);
        end;
    end;

    return v18;
end;

function u1.GetEquippedItems(p19, p20, p21, p22) -- Line: 94
    if not p20 then
        return {};
    end;

    local v23 = nil;
    local v24 = nil;

    for i, v in pairs(p21) do
        if v:Get("ObjectID") == p20 then
            v24 = i;
            v23 = v;
            break;
        end;
    end;

    if not v23 then
        return {};
    end;

    local v25 = {};

    for i = v24, v24 + (p22 or 0) do
        v25[p21[(i - 1) % #p21 + 1]] = true;
        local _ = i;
    end;

    return v25;
end;

function u1.KnockbackTaggedParts(p26, p27, p28, p29, p30, p31, p32, p33) -- Line: 125
    -- upvalues: CollectionService (copy), Utility (copy)
    local v34 = "RaycastWhitelist" .. (p27 or "");
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    OverlapParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged("Knockbackable");

    for _, v in pairs(workspace:GetPartBoundsInRadius(p28, p29, OverlapParams_new_ret)) do
        if not (v.Anchored or (v.Position:FuzzyEq(p28) or p32 and (p33 and p33 < Utility:AngleBetweenVectors(p32, v.Position - p28)))) and v:HasTag(v34) then
            if v:HasTag("TrowelBrick") then
                v.CustomPhysicalProperties = PhysicalProperties.new(0.1, v.CurrentPhysicalProperties.Friction, v.CurrentPhysicalProperties.Elasticity);
            end;

            v.Velocity = p31 or (v.Position - p28).Unit * p30 * (1 - (v.Position - p28).Magnitude / p29);
        end;
    end;
end;

function u1.GetRaycastRedirection(p35, p36, p37, u38, u39, p40) -- Line: 149
    -- upvalues: Utility (copy)
    if p40 <= 0 then
        return u38;
    end;

    local u41 = {};
    p35:GetEntitiesWithinSphere(p36, p37, u39, 128, false, nil, nil, nil, function(p42) -- Line: 156
        -- upvalues: u39 (copy), Utility (ref), u38 (copy), u41 (copy)
        local LookVector = CFrame.new(u39, p42.RootPart.Position).LookVector;
        local v43 = {
            Entity = p42,
            LookDir = LookVector,
            Angle = Utility:AngleBetweenVectors(u38, LookVector)
        };
        table.insert(u41, v43);
    end);
    table.sort(u41, function(p44, p45) -- Line: 167
        return p44.Angle < p45.Angle;
    end);

    if u41[1] and u41[1].Angle < p40 then
        u38 = u41[1].LookDir or u38;
    end;

    return u38;
end;

function u1.SwitchingWeaponsMakesSense(p46, p47, p48) -- Line: 174
    -- upvalues: ItemLibrary (copy), ShopLibrary (copy), CONSTANTS (copy)
    local v49 = {};

    for i, _ in pairs(ItemLibrary.Classes) do
        v49[i] = {};
    end;

    for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET)) do
        local _ = ItemLibrary.Items[v].Class;
        local v50 = v;

        for i, v2 in pairs(ItemLibrary.Classes) do
            if p46:CanUseWeapon(p47, p48, v50, v2.Slot) then
                table.insert(v49[i], v50);

                if #v49[i] > 1 then
                    return true;
                end;
            end;
        end;
    end;

    return false;
end;

function u1.CanUseWeapon(p51, p52, p53, p54, p55) -- Line: 198
    -- upvalues: ShopLibrary (copy), CONSTANTS (copy), ItemLibrary (copy)
    if not (p54 and (p52 and p53)) then
        return false;
    end;

    local v56 = p52:Get("WeaponPool");
    local v57 = p52:Get("WeaponPoolFilterType");
    local v58;

    if v56 then
        if v57 == "Whitelist" then
            v58 = table.find(v56, p54);
        else
            v58 = false;
        end;
    else
        v58 = v56;
    end;

    if not (table.find(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET), p54) or v58) then
        return false;
    end;

    if not (p53:GetWeaponData(p54) or (p52:Get("IsInShootingRange") or p52:Get("CanUseLockedWeapons") or (p51:_CanUseWeaponFromFFlag(p54) or table.find(p52:Get("FreeWeaponTrials") or {}, p54)))) then
        return false;
    end;

    if v56 then
        if v57 == "Whitelist" and not table.find(v56, p54) then
            return false;
        end;

        if v57 == "Blacklist" and table.find(v56, p54) then
            return false;
        end;
    end;

    return not (p55 and (ItemLibrary.SlotToClass[p55].Name ~= ItemLibrary.Items[p54].Class and not p52:Get("WeaponClassRestrictionDisabled")));
end;

function u1.GetSpread(p59, p60, p61, p62, p63, p64, p65, p66) -- Line: 242
    local math_min_ret = math.min(p62 and p61 and p61 or 1, p63 and 0.75 or 1);
    local v67 = math.rad(p60) * math_min_ret;

    if p66 and (p65 and (p65 > 1 and p64 == 1)) then
        return CFrame.identity;
    end;

    if not (p66 and (p65 and (p65 > 1 and p64 ~= nil))) then
        return CFrame.Angles(0, 0, 6.283185307179586 * math.random()) * CFrame.Angles(v67 * math.random(), 0, 0);
    end;

    local v68 = v67 / 0.75;

    if p64 % 2 == 0 then
        return CFrame.Angles(0, 0, 6.283185307179586 / (p65 - 1) * p64) * CFrame.Angles(v68 / 2 / 2, 0, 0);
    end;

    return CFrame.Angles(0, 0, 6.283185307179586 / (p65 - 1) * p64) * CFrame.Angles(v68 / 2, 0, 0);
end;

function u1.IsInWhitelist(p69, p70, p71) -- Line: 266
    for _, v in pairs(p71) do
        if p70 == v or v:IsA("Instance") and p70:IsDescendantOf(v) then
            return true;
        end;
    end;

    return false;
end;

function u1.GetMousePositionFromCameraData(p72, p73, p74, p75, p76, p77, p78, p79) -- Line: 276
    -- upvalues: CONSTANTS (copy)
    if p77 then
        p77 = p77.CFrame * (p78 or CFrame.identity);
    end;

    if p77 then
        p76 = CFrame.new(p76.Position, p77.Position) or p76;
    end;

    local v80 = p76 * (p79 or CFrame.identity);
    local _, v81 = p72:GetEntitiesFromRaycast(p73, p74, v80.Position, v80.LookVector, CONSTANTS.MAX_RAYCAST_DISTANCE);

    return v81.Position;
end;

function u1.GetMouseLocationFromCameraData(p82, p83, p84, p85, p86, p87, p88, p89) -- Line: 285
    -- upvalues: u1 (copy), Utility (copy)
    local RaycastWhitelist = u1:GetRaycastWhitelist(p87, p89);

    if p85 then
        p85 = p85.CFrame * (p86 or CFrame.identity);
    end;

    if p85 then
        p84 = CFrame.new(p84.Position, p85.Position) or p84;
    end;

    local v90 = nil;

    for i = 1, 10 do
        local v91 = Utility:Raycast(p84.Position, p84.Position + p84.LookVector, p88, RaycastWhitelist, Enum.RaycastFilterType.Include);
        v90 = Utility:Raycast(p83.Position, v91.Position, p88, RaycastWhitelist, Enum.RaycastFilterType.Include);

        if not v90.Instance or v90.Instance.Transparency < 0.99 then
            break;
        end;

        table.insert(RaycastWhitelist, v90.Instance);
        local _ = i;
    end;

    return v90;
end;

function u1.GetRaycastWhitelist(p92, p93, p94, p95, p96) -- Line: 307
    -- upvalues: CollectionService (copy)
    local v97 = p96 and {} or CollectionService:GetTagged("RaycastWhitelist" .. (p93 or ""));

    if not p94 then
        return v97;
    end;

    local v98 = {};
    local v99 = p95 or {};

    for _, v in pairs(CollectionService:GetTagged("Entity")) do
        local EntityFromModel = p92:GetEntityFromModel(v);

        if not (v99[EntityFromModel] or (not p94:IsValidTarget(EntityFromModel) or EntityFromModel:Get("EnvironmentID") ~= p93)) then
            for _, v2 in pairs(EntityFromModel:GetHitboxes(p94.GrabSmallHitboxes)) do
                table.insert(v97, v2);
                v98[v2] = EntityFromModel;
            end;
        end;
    end;

    return v97, v98;
end;

function u1.GetEntityFromModel(p100, p101) -- Line: 333
    -- upvalues: CONSTANTS (copy), ServerStorage (copy), Players (copy)
    if CONSTANTS.IS_SERVER then
        local FighterService = require(ServerStorage.Services.FighterService);
        local EnemyService = require(ServerStorage.Services.EnemyService);
        local Fighter = FighterService:GetFighter(p101);

        return Fighter and Fighter.Entity or EnemyService:GetEnemy(p101);
    end;

    if CONSTANTS.IS_CLIENT then
        local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
        local EnemyController = require(Players.LocalPlayer.PlayerScripts.Controllers.EnemyController);
        local Fighter = FighterController:GetFighter(p101);

        return Fighter and Fighter.Entity or EnemyController:GetEnemy(p101);
    end;
end;

function u1.GetEntityFromTouch(p102, p103, p104, p105) -- Line: 350
    local EntityFromModel = p102:GetEntityFromModel((p102:IsEntity(p105)));

    if EntityFromModel and (EntityFromModel:Get("EnvironmentID") == p103 and p104:IsValidTarget(EntityFromModel)) then
        return EntityFromModel;
    end;
end;

function u1.GetEntitiesWithinSphere(p106, p107, p108, p109, p110, p111, p112, p113, p114, p115, p116) -- Line: 365
    -- upvalues: BetterDebris (copy), Utility (copy)
    if p116 then
        local v117 = tonumber(p116) or (tonumber(false) or 30);
        local Part = Instance.new("Part");
        Part.Color = Color3.fromRGB(255, 0, 0);
        Part.Material = Enum.Material.ForceField;
        Part.CanTouch = false;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Anchored = true;
        Part.Shape = Enum.PartType.Ball;
        Part.Size = Vector3.new(1, 1, 1) * p110 * 2;
        Part.CFrame = CFrame.new(p109);
        Part.Parent = workspace;
        BetterDebris:AddItem(Part, v117);
        local Part2 = Instance.new("Part");
        Part2.Color = Color3.fromRGB(255, 0, 0);
        Part2.Material = Enum.Material.Neon;
        Part2.CanTouch = false;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CastShadow = false;
        Part2.Anchored = true;
        Part2.Shape = Enum.PartType.Ball;
        Part2.Size = Vector3.new(0.1, 0.1, 0.1);
        Part2.CFrame = CFrame.new(p109);
        Part2.Parent = workspace;
        BetterDebris:AddItem(Part2, v117);
    end;

    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    OverlapParams_new_ret.FilterDescendantsInstances = p106:GetRaycastWhitelist(p107, p108, nil, true);
    local v118 = not p111 and p106:GetRaycastWhitelist(p107);
    local v119 = not p111 and Enum.RaycastFilterType.Include;
    local v120 = {};

    for _, v in pairs(workspace:GetPartBoundsInRadius(p109, p110, OverlapParams_new_ret)) do
        local v121 = v:GetAttribute("IsAssemblyRootPart") and v and v or (v.AssemblyRootPart or v);

        if not (v120[v121] or p112 and (p113 and ((p114 or 3) < (v.Position - p109).Magnitude and p113 < Utility:AngleBetweenVectors(p112, v.Position - p109)))) then
            local EntityFromTouch = p106:GetEntityFromTouch(p107, p108, v);

            if EntityFromTouch and (not v120[EntityFromTouch] and (EntityFromTouch:IsAlive() and (p111 or not Utility:Raycast(p109, v.Position, (p109 - v.Position).Magnitude, v118, v119).Instance))) then
                v120[EntityFromTouch] = true;
                v120[v121] = true;
                task.spawn(p115, EntityFromTouch, v);
            end;
        end;
    end;
end;

function u1.GetEntitiesFromPoint(p122, p123, p124, p125, p126) -- Line: 436
    local u127 = {};
    p122:GetEntitiesWithinSphere(p123, p124, p125, p126 or 0, nil, nil, nil, nil, function(p128, p129) -- Line: 439
        -- upvalues: u127 (copy)
        table.insert(u127, {
            Entity = p128,
            Hitbox = p129
        });
    end);

    return u127;
end;

function u1.GetEntitiesFromRaycast(p130, p131, p132, p133, p134, p135, p136, p137, p138) -- Line: 450
    -- upvalues: Utility (copy), BetterDebris (copy)
    local v139 = p137 and Utility:CloneTable(p137, true) or {};
    local v140 = {};
    local v141 = p136 or 0;
    local v142 = 1;
    local v143 = nil;
    local v144 = nil;

    while v142 <= 1 + v141 do
        local RaycastWhitelist, v145 = p130:GetRaycastWhitelist(p131, p132, v139);
        v144 = Utility:Raycast(p133, p133 + p134, p135, RaycastWhitelist, Enum.RaycastFilterType.Include);
        local v146 = v145[v144.Instance];
        v143 = v143 or v144;

        if not v146 then
            break;
        end;

        table.insert(v140, {
            IsFromPoint = nil,
            Entity = v146,
            Hitbox = v144.Instance,
            RaycastResult = v144
        });
        v139[v146] = true;

        if v146.Model:GetAttribute("PierceThrough") then
            v141 = v141 + 1;
        end;

        v142 = v142 + 1;
    end;

    for _, v in pairs(p130:GetEntitiesFromPoint(p131, p132, p133)) do
        v.RaycastResult = v143;
        v.IsFromPoint = true;
        table.insert(v140, 1, v);
    end;

    if v144 and p138 then
        local Magnitude = (v144.Position - p133).Magnitude;
        local Part = Instance.new("Part");
        Part.Color = Color3.fromRGB(255, 0, 0);
        Part.Material = Enum.Material.ForceField;
        Part.CanTouch = false;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Anchored = true;
        Part.Size = Vector3.new(0.1, 0.1, Magnitude);
        Part.CFrame = CFrame.new(p133, v144.Position) * CFrame.new(0, 0, -Magnitude / 2);
        Part.Parent = workspace;
        BetterDebris:AddItem(Part, 10);
    end;

    return v140, v144;
end;

function u1.GetJumpPadPlacement(p147, p148, p149, p150, p151, p152, p153) -- Line: 515
    -- upvalues: Utility (copy), CONSTANTS (copy), u1 (copy)
    local RaycastWhitelist = p147:GetRaycastWhitelist(p148);

    if p152 then
        p152 = p152.CFrame * (p153 or CFrame.identity);
    end;

    local v154;

    if p152 then
        v154 = CFrame.new(p151.Position, p152.Position) or p151;
    else
        v154 = p151;
    end;

    if v154 ~= v154 then
        v154 = CFrame.new(p151.Position);
    end;

    local v155 = Utility:Raycast(v154.Position, v154.Position + v154.LookVector * CONSTANTS.MAX_RAYCAST_DISTANCE, CONSTANTS.MAX_RAYCAST_DISTANCE, RaycastWhitelist, Enum.RaycastFilterType.Include);
    local v156 = Utility:Raycast(p150.Position, p150.Position + (v155.Position - p150.Position).Unit * p149, p149, RaycastWhitelist, Enum.RaycastFilterType.Include);

    if v156.Instance and not (v156.Instance:HasTag("Barrier") or (Utility:IsWithinTaggedParts("Barrier", v156.Position) or u1:IsWithinOOBPart(v156.Position))) then
        return v156, CFrame.new(v156.Position, v156.Position + v156.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(p150.Position * Vector3.new(1, 0, 1), v156.Position * Vector3.new(1, 0, 1)).Rotation * CFrame.Angles(1.5707963267948966, 0, 0);
    end;

    return v156, nil;
end;

function u1.GetSubspaceTripminePlacement(p157, p158, p159, p160) -- Line: 538
    local v161 = p159:FuzzyEq(p160) and p159 and p159 or p160 + (p159 - p160).Unit * math.min(p158, (p159 - p160).Magnitude);
    local v162 = v161:FuzzyEq(p160) and CFrame.identity or CFrame.new(v161 * Vector3.new(1, 0, 1), p160 * Vector3.new(1, 0, 1));

    return CFrame.new(v161) * v162.Rotation;
end;

function u1.GetOOBWarnDelay(p163, p164) -- Line: 546
    local v165 = p164 or p163.OOB_DEFAULT_WARN_DELAY;

    return v165 == -1 and (1 / 0) or v165;
end;

function u1.GetOOBKillDelay(p166, p167) -- Line: 551
    local v168 = p167 or p166.OOB_DEFAULT_KILL_DELAY;

    return v168 == -1 and (1 / 0) or v168;
end;

function u1.IsWithinOOBPart(u169, p170, p171) -- Line: 556
    -- upvalues: Utility (copy)
    if Utility:IsWithinTaggedParts("OutOfBoundsSafePart", p170) then
        return nil;
    end;

    local v172 = Utility:IsWithinTaggedParts("OutOfBoundsPart", p170, p171, true);
    table.sort(v172, function(p173, p174) -- Line: 565
        -- upvalues: u169 (copy)
        return u169:GetOOBWarnDelay(p173:GetAttribute("WarnDelay")) + u169:GetOOBKillDelay(p173:GetAttribute("KillDelay")) < u169:GetOOBWarnDelay(p174:GetAttribute("WarnDelay")) + u169:GetOOBKillDelay(p174:GetAttribute("KillDelay"));
    end);

    return v172[1];
end;

function u1._CanUseWeaponFromFFlag(p175, u176) -- Line: 579
    -- upvalues: CONSTANTS (copy), ServerStorage (copy), Players (copy), ItemLibrary (copy)
    local success, result = pcall(function() -- Line: 581
        -- upvalues: CONSTANTS (ref), ServerStorage (ref), Players (ref), ItemLibrary (ref), u176 (copy)
        local v177;

        if CONSTANTS.IS_SERVER then
            v177 = require(ServerStorage.Services.FFlagService);
        else
            v177 = require(Players.LocalPlayer.PlayerScripts.Controllers.FFlagController);
        end;

        return v177:GetFFlag("FreeToUse" .. ItemLibrary.Items[u176].Status .. "Weapons");
    end);

    if not success then
        warn("Failed to fetch FreeWeapons FFlag");
    end;

    return success and result;
end;

function u1._Init(p178) -- Line: 595
end;

return u1._new();