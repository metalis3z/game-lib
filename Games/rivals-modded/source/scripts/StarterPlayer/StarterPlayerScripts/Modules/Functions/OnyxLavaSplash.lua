-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local OnyxLavaSplash = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("OnyxLavaSplash");

return function(p1, p2, p3) -- Line: 9
    -- upvalues: Utility (copy), OnyxLavaSplash (copy), BetterDebris (copy)
    local v4 = Utility:Raycast(p2, p2 - Vector3.new(0, 1, 0), 500, { p1 }, Enum.RaycastFilterType.Include);

    if v4.Instance then
        p2 = v4.Position;
    end;

    local v5 = OnyxLavaSplash:Clone();
    v5.Size = Vector3.new(1, 1, 1);
    v5.CanCollide = true;
    v5.CollisionGroup = "IgnoreEntities";
    v5.CFrame = CFrame.new(p2);
    v5.Parent = workspace;
    v5.Attachment.LavaDroplets.Color = ColorSequence.new(p1.Color);
    v5.Attachment.LavaDroplets:Emit(25);
    BetterDebris:AddItem(v5, 5);
    Utility:CreateSound(p3 or "rbxassetid://12100798607", 1, 1 + 0.25 * math.random(), v5, true, 5);
end;