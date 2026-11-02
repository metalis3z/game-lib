-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Fx = require(game:GetService("ReplicatedStorage"):WaitForChild("UIC"):WaitForChild("Fx"));
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");

local function try(p1) -- Line: 11
    -- upvalues: CollectionService (copy), Fx (copy)
    if p1:IsA("ScreenGui") and CollectionService:HasTag(p1, "UICFx") then
        task.spawn(Fx.Bind, p1);
    end;
end;

for _, child in ipairs(PlayerGui:GetChildren()) do
    if child:IsA("ScreenGui") and CollectionService:HasTag(child, "UICFx") then
        task.spawn(Fx.Bind, child);
    end;
end;

PlayerGui.ChildAdded:Connect(try);
CollectionService:GetInstanceAddedSignal("UICFx"):Connect(function(p2) -- Line: 21
    -- upvalues: PlayerGui (copy), CollectionService (copy), Fx (copy)
    if p2:IsDescendantOf(PlayerGui) and (p2:IsA("ScreenGui") and CollectionService:HasTag(p2, "UICFx")) then
        task.spawn(Fx.Bind, p2);
    end;
end);