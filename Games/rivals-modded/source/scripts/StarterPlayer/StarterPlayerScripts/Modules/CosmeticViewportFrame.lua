-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PlayerDataUtility = require(ReplicatedStorage.Modules.PlayerDataUtility);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("StaticModel"):WaitForChild("StaticViewModel"));
local ViewportCameras = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ViewportCameras"));
local CosmeticViewportFrame = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CosmeticViewportFrame");
local Wrap = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("Wrap");
local Charms = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Charms");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 19
    -- upvalues: u1 (copy), CosmeticLibrary (copy), CosmeticViewportFrame (copy)
    local v4 = setmetatable({}, u1);
    v4.Name = p2;
    v4.Info = CosmeticLibrary.Cosmetics[v4.Name];
    v4.IsLocked = p3;
    v4.Frame = CosmeticViewportFrame:Clone();
    v4:_Init();

    return v4;
end;

function u1.ZoomOut(p5) -- Line: 36
    -- upvalues: ViewportCameras (copy)
    p5.Frame.Size = UDim2.new(p5.Frame.Size.X.Scale * ViewportCameras.ZOOM_OUT_FACTOR, p5.Frame.Size.X.Offset * ViewportCameras.ZOOM_OUT_FACTOR, p5.Frame.Size.Y.Scale * ViewportCameras.ZOOM_OUT_FACTOR, p5.Frame.Size.Y.Offset * ViewportCameras.ZOOM_OUT_FACTOR);
    local v6;

    if p5.Info.Type == "Charm" then
        v6 = ViewportCameras.CharmZoomedOut;
    elseif p5.Info.Type == "Wrap" then
        v6 = ViewportCameras.WrapZoomedOut;
    else
        v6 = p5.Frame.CurrentCamera;
    end;

    p5.Frame.CurrentCamera = v6;
end;

function u1.Destroy(p7) -- Line: 43
    p7.Frame:Destroy();
end;

function u1._SetupSeasonRankCharm(p8, p9) -- Line: 51
    -- upvalues: SeasonLibrary (copy), PlayerDataUtility (copy), PlayerDataController (copy)
    if #p8.Name < 8 or string.sub(p8.Name, 1, 7) ~= "Season " then
        return;
    end;

    local string_sub_ret = string.sub(p8.Name, 8);
    local v10 = tonumber(string_sub_ret);

    if not v10 then
        return;
    end;

    local Name = SeasonLibrary.SeasonsByVersion[v10].Name;
    local SeasonInfo, v11 = PlayerDataUtility:GetSeasonInfo(PlayerDataController, Name);
    SeasonLibrary:FormatSeasonRankCharm(p9, Name, SeasonInfo, v11);
end;

function u1._Setup(p12) -- Line: 68
    -- upvalues: Charms (copy), ViewportCameras (copy), Wrap (copy), WrapController (copy)
    p12.Frame.ImageColor3 = p12.IsLocked and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    p12.Frame.ImageTransparency = p12.IsLocked and 0.5 or 0;

    if p12.Name ~= "NONE_COSMETIC" and p12.Name ~= "RANDOM_COSMETIC" then
        if p12.Info.Type == "Charm" then
            local v13 = Charms[p12.Name]:Clone();
            v13.PrimaryPart = v13.Primary;
            v13:PivotTo(CFrame.identity);
            v13.Hook:Destroy();
            v13.Parent = p12.Frame;
            task.defer(p12._SetupSeasonRankCharm, p12, v13);
            p12.Frame.CurrentCamera = ViewportCameras.Charm;

            return;
        end;

        if p12.Info.Type == "Wrap" then
            local v14 = Wrap:Clone();
            v14:PivotTo(CFrame.identity);
            v14.Parent = p12.Frame;
            WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v14), {
                Name = p12.Name
            });
            p12.Frame.CurrentCamera = ViewportCameras.Wrap;
        end;
    end;
end;

function u1._Init(p15) -- Line: 93
    p15:_Setup();
end;

return u1;