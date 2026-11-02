-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FlashbangEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("FlashbangEffect");

local function default_flash_sound_callback(p1) -- Line: 11
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://14778230670", 1, 1, p1, true, 10);
end;

return function(p2, p3, p4, p5, p6, p7, p8) -- Line: 15
    -- upvalues: CONSTANTS (copy), FlashbangEffect (copy), BetterDebris (copy), Utility (copy), SpectateController (copy)
    if (workspace.CurrentCamera.CFrame.Position - p3).Magnitude > CONSTANTS.RENDER_DISTANCE then
        return;
    end;

    local v9 = FlashbangEffect:Clone();
    v9.CFrame = CFrame.new(p3);
    v9.Parent = workspace;
    v9.Attachment.Glow:Emit(5);
    BetterDebris:AddItem(v9, 5);
    local PointLight = v9.PointLight;
    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 4, function(p10) -- Line: 28
        -- upvalues: PointLight (copy)
        PointLight.Brightness = 40 * (1 - p10 / 100);
    end);

    if p7 then
        p7(p3);
    else
        Utility:CreateSound("rbxassetid://14778230670", 1, 1, p3, true, 10);
    end;

    if SpectateController.CurrentSubject and SpectateController.CurrentSubject.FighterInterface then
        SpectateController.CurrentSubject.FighterInterface.Flashed:AttemptToFlash(p2, p3, p4, p5, p6, p8);
    end;
end;