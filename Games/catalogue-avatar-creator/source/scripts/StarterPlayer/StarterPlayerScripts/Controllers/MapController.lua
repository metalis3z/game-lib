-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Lighting = game:GetService("Lighting");
local _ = game:GetService("Players").LocalPlayer;
local Events = script.Parent.Parent:WaitForChild("Events");
local Maps = script:WaitForChild("Maps");
local u1 = {};
local u2 = {};
local u3 = nil;
local u4 = nil;
local u5 = nil;

local function serializeMaps() -- Line: 17
    -- upvalues: Maps (copy), u2 (copy)
    for _, child in Maps:GetChildren() do
        if child:IsA("ModuleScript") then
            local v6 = require(child);
            u2[child.Name] = {
                Name = v6.Name,
                DisplayName = v6.DisplayName,
                Image = v6.Image,
                LayoutOrder = v6.LayoutOrder,
                Color = v6.Color,
                Terrain = v6.Terrain,
                LightingFolder = child:FindFirstChild("Lighting"),
                WorkspaceFolder = child:FindFirstChild("Workspace")
            };
        end;
    end;
end;

local function clearCurrentMap() -- Line: 36
    -- upvalues: u5 (ref), u4 (ref), Lighting (copy)
    if u5 then
        pcall(task.cancel, u5);
        u5 = nil;
    end;

    local function deferDestroy(u7) -- Line: 42
        task.spawn(function() -- Line: 43
            -- upvalues: u7 (copy)
            for _, child in u7:GetChildren() do
                if child:IsA("Folder") then
                    local v8 = child:GetChildren();

                    for i = 1, #v8 do
                        v8[i]:Destroy();

                        if i % 20 == 0 then
                            task.wait();
                        end;
                    end;
                end;

                child:Destroy();
                task.wait();
            end;

            u7:Destroy();
        end);
    end;

    local oldMap = u4;
    u4 = nil;

    if oldMap then
        -- Remove it from Workspace immediately so the replacement never overlaps it.
        oldMap.Name = "_RetiredMap";
        oldMap.Parent = nil;
        deferDestroy(oldMap);
    end;

    local Map = workspace:FindFirstChild("Map");

    if Map and Map ~= oldMap then
        Map.Name = "_RetiredMap";
        Map.Parent = nil;
        deferDestroy(Map);
    end;

    workspace.Terrain:Clear();

    for _, child in Lighting:GetChildren() do
        if child:GetAttribute("MapEffect") then
            child:Destroy();
        end;
    end;
end;

local function applyLighting(p12) -- Line: 81
    -- upvalues: Lighting (copy)
    if not p12 then
        return;
    end;

    local LightingSnapshot = p12:FindFirstChild("LightingSnapshot");

    if LightingSnapshot then
        for _, child in LightingSnapshot:GetChildren() do
            if not pcall(function() -- Line: 87
                -- upvalues: Lighting (ref), child (copy)
                Lighting[child.Name] = child.Value;
            end) then
                warn("[MapController] Failed to apply lighting property:", child.Name);
            end;
        end;
    end;

    local v13 = {
        BloomEffect = true,
        ColorCorrectionEffect = true,
        DepthOfFieldEffect = true,
        BlurEffect = true
    };

    for _, child in p12:GetChildren() do
        if not (child:IsA("Configuration") or v13[child.ClassName]) then
            for _, child2 in Lighting:GetChildren() do
                if child2.ClassName == child.ClassName then
                    child2:Destroy();
                end;
            end;

            local v14 = child:Clone();
            v14:SetAttribute("MapEffect", true);
            v14.Parent = Lighting;
        end;
    end;
end;

local function applyTerrain(p15) -- Line: 118
    if not p15 then
        return;
    end;

    local v16 = p15.Material or Enum.Material.Grass;
    local v17 = p15.Position or CFrame.new(0, -9, 0);
    workspace.Terrain:FillBlock(v17, p15.Size or Vector3.new(2048, 14, 2048), v16);

    if p15.Color then
        workspace.Terrain:SetMaterialColor(v16, p15.Color);
    end;

    if p15.Cutouts then
        for _, v in p15.Cutouts do
            if v.Shape == "Cylinder" then
                workspace.Terrain:FillCylinder(v.CFrame, v.Height, v.Radius, Enum.Material.Air);
            elseif v.Shape == "Block" then
                workspace.Terrain:FillBlock(v.CFrame, v.Size, Enum.Material.Air);
            elseif v.Shape == "Ball" then
                workspace.Terrain:FillBall(v.CFrame.Position, v.Radius, Enum.Material.Air);
            end;
        end;
    end;

    for _, v in { "WaterColor", "WaterReflectance", "WaterTransparency", "WaterWaveSize", "WaterWaveSpeed" } do
        if p15[v] ~= nil then
            workspace.Terrain[v] = p15[v];
        end;
    end;
end;

local function applyWorkspace(u18) -- Line: 151
    -- upvalues: u5 (ref), u4 (ref)
    if not u18 then
        return;
    end;

    if u5 then
        pcall(task.cancel, u5);
        u5 = nil;
    end;

    u4 = Instance.new("Folder");
    u4.Name = "Map";
    u4.Parent = workspace;
    local u19 = u4;
    local u20 = {
        Spawn = true,
        Baseplate = true
    };

    for _, child in u18:GetChildren() do
        if u20[child.Name] then
            child:Clone().Parent = u19;
        end;
    end;

    u5 = task.spawn(function() -- Line: 173
        -- upvalues: u18 (copy), u20 (copy), u19 (copy), u4 (ref), u5 (ref)
        local v21 = 0;

        for _, child in u18:GetChildren() do
            if not u20[child.Name] then
                if u19 ~= u4 then
                    return;
                end;

                if child:IsA("Folder") then
                    local Folder = Instance.new("Folder");
                    Folder.Name = child.Name;
                    Folder.Parent = u19;

                    for _, child2 in child:GetChildren() do
                        if u19 ~= u4 then
                            return;
                        end;

                        child2:Clone().Parent = Folder;
                        v21 = v21 + 1;

                        if v21 % 20 == 0 then
                            task.wait();
                        end;
                    end;
                else
                    child:Clone().Parent = u19;
                    v21 = v21 + 1;

                    if v21 % 20 == 0 then
                        task.wait();
                    end;
                end;
            end;
        end;

        u5 = nil;
    end);
end;

function u1.LoadMap(p22) -- Line: 209
    -- upvalues: u2 (copy), clearCurrentMap (copy), applyLighting (copy), applyTerrain (copy), applyWorkspace (copy), u3 (ref)
    local v23 = u2[p22];

    if not v23 then
        warn("[MapController] Map not found:", p22);

        return false;
    end;

    clearCurrentMap();
    applyLighting(v23.LightingFolder);
    applyTerrain(v23.Terrain);
    applyWorkspace(v23.WorkspaceFolder);
    u3 = p22;
    local SettingsController = require(script.Parent.SettingsController);

    if SettingsController.ApplyVisualSettings then
        SettingsController.ApplyVisualSettings();
    end;

    return true;
end;

function u1.GetMaps() -- Line: 232
    -- upvalues: u2 (copy)
    local v24 = {};

    for i, v in u2 do
        v24[i] = {
            Name = v.Name,
            DisplayName = v.DisplayName,
            Image = v.Image,
            LayoutOrder = v.LayoutOrder,
            Color = v.Color
        };
    end;

    return v24;
end;

function u1.GetCurrentMap() -- Line: 248
    -- upvalues: u3 (ref)
    return u3;
end;

task.spawn(function() -- Line: 252, Name: initialize
    -- upvalues: serializeMaps (copy), Events (copy), u2 (copy), u1 (copy)
    serializeMaps();
    local GetSetting = Events:WaitForChild("GetSetting");

    if not GetSetting:GetAttribute("bound") then
        GetSetting:GetAttributeChangedSignal("bound"):Wait();
    end;

    local v25 = GetSetting:Invoke({ "World", "Map" });

    if v25 and u2[v25] then
        u1.LoadMap(v25);

        return;
    end;

    u1.LoadMap("green_baseplate");
end);

return u1;