-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("LootboxCollectParticles"):WaitForChild("Attachment");
local UnboxEffect = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("UnboxEffect");
local Lootboxes = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Lootboxes");
local u1 = {
    Common = { "rbxassetid://18182950485", 0.5 },
    Rare = { "rbxassetid://18182950836", 0.375 },
    Legendary = { "rbxassetid://18182950182", 0.375 },
    Mythical = { "rbxassetid://115151712865765", 0.5 },
    Standard = { "rbxassetid://18182950485", 0.5 },
    Prime = { "rbxassetid://18182950182", 0.375 }
};
local u2 = 0;

return function(p3, u4, p5, p6, u7, p8, p9, p10) -- Line: 28
    -- upvalues: CosmeticLibrary (copy), u2 (ref), Lootboxes (copy), BetterDebris (copy), Utility (copy), CONSTANTS (copy), UnboxEffect (copy), Players (copy), RewardSlot (copy), ItemLibrary (copy), u1 (copy), TweenService (copy), Attachment (copy)
    local v11 = p5[1] and CosmeticLibrary.Cosmetics[p5[1].RewardData.Name];
    local v12 = p5[1] and CosmeticLibrary.Rewards[p5[1].RewardData.Name];

    if p6 and p6 > 0 then
        wait(p6);
    end;

    u2 = u2 + 1;
    local v13 = u2 * 3.141592653589793 * 2 / 8 + math.floor((u2 - 1) / 8) * 3.141592653589793 / 8;
    local v14 = math.floor(u2 - 1) * 5;
    local v15 = v13 + math.rad(v14);
    local v16 = math.floor((u2 % 64 - 1) / 8) * 1;
    local u17 = Lootboxes[u4]:Clone();
    local v18 = u17:FindFirstChild("HumanoidRootPart") or u17:FindFirstChild("RootPart");

    for _, descendant in pairs(u17:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Anchored = false;
        end;
    end;

    if u4 == "Prize Wheel" then
        if not v11 or v11.Type ~= "Skin" then
            u17.wheel.Slices:PivotTo(u17.wheel.Slices:GetPivot() * CFrame.Angles(0, 0, 1.0471975511965976 * Random.new(p10):NextInteger(1, 5)));
        end;

        for _, child in pairs(u17.wheel.Slices:GetChildren()) do
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = child;
            WeldConstraint.Part1 = u17.wheel;
            WeldConstraint.Parent = child;
        end;
    end;

    v18.Anchored = true;
    u17.Parent = workspace;
    BetterDebris:AddItem(u17, 15);
    Utility:CreateSound("rbxassetid://18183233381", 0.5, 1 + 0.25 * math.random(), v18, true);
    local u19 = CFrame.new(p3) * CFrame.Angles(0, v15, 0);
    local u20 = CFrame.new(p3) * CFrame.Angles(0, v15, 0) * CFrame.new(0, -3, v16 + 7);
    Utility:RenderstepForLoop(0, 100, 2, function(p21) -- Line: 75
        -- upvalues: u19 (copy), u20 (copy), u17 (copy)
        local v22 = p21 / 100;
        local v23 = math.cos(9.42477796076938 * (v22 + 0.25)) * (v22 - 1) / 0.707;
        local math_abs_ret = math.abs(v23);
        local v24 = u19:Lerp(u20, 1 - (1 - v22) ^ 5);
        u17:PivotTo(CFrame.new(v24.X, u20.Y + (u19.Y - u20.Y) * math_abs_ret, v24.Z) * v24.Rotation);
    end);
    BetterDebris:AddItem(u17, u17.Animation:GetAttribute("Duration"));
    task.spawn(CONSTANTS.IS_STUDIO and task.defer or pcall, function() -- Line: 87
        -- upvalues: u17 (copy), CosmeticLibrary (ref), u4 (copy)
        u17.AnimationController:LoadAnimation(u17.Animation):Play();
        require(script[CosmeticLibrary.Rewards[u4].SoundProfile])(u17);
    end);
    wait(u17.Animation:GetAttribute("RevealDelay"));
    local u25 = UnboxEffect:Clone();
    u25.CFrame = u20 + Vector3.new(0, 8, 0);
    u25.Parent = workspace;
    BetterDebris:AddItem(u25, 15);
    local BillboardGui = u25.BillboardGui;
    BillboardGui.Adornee = u25;
    BillboardGui.Parent = Players.LocalPlayer.PlayerGui;
    BetterDebris:AddItem(BillboardGui, 15);

    for _, v in pairs(p5) do
        local v26 = RewardSlot.new(v.RewardData, true);
        v26:SetInteractable(false);
        v26:SetParent(BillboardGui.Container);
    end;

    BillboardGui.Container.Size = UDim2.new(0.25, 0, 0.25, 0);
    BillboardGui.Container.Position = UDim2.new(0.5, 0, 0.75, 0);
    BillboardGui.Container:TweenSizeAndPosition(UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.5, true);
    local v27 = nil;
    local v28 = nil;

    if v11 then
        v27 = v11.Rarity;
        v28 = CosmeticLibrary.Rarities[v11.Rarity].Color;
    elseif v12 then
        local v29 = ItemLibrary.Items[v12.Name];
        v27 = v29 and v29.Status or "Standard";
        v28 = ItemLibrary.Statuses[v27].Color;
    end;

    if v27 and v28 then
        u25.Trail.Color = ColorSequence.new(v28);
        local v30 = u1[v27];

        if v30 then
            Utility:CreateSound(v30[1], v30[2] * (p8 == Players.LocalPlayer and 1 or 0.5), 1, u25, true);
        end;
    end;

    local Container = BillboardGui.Container;
    wait(4);

    if Container:IsDescendantOf(workspace) then
        Container:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Back", 1, true);
    end;

    if not u7 then
        return;
    end;

    local CFrame2 = u25.CFrame;
    Utility:RenderstepForLoop(0, 100, 1.9, function(p31) -- Line: 152
        -- upvalues: TweenService (ref), u25 (copy), CFrame2 (copy), u7 (copy)
        local Value = TweenService:GetValue(p31 / 100, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
        u25.CFrame = CFrame2:Lerp(u7.CFrame, Value);
    end);
    local v32 = Attachment:Clone();
    v32.Parent = u7;

    for _, child in pairs(v32:GetChildren()) do
        child:SetAttribute("IgnoreVisibilityCheck", true);
        child.Color = v28 and ColorSequence.new(v28) or child.Color;
    end;

    Utility:PlayParticles(v32);
    Utility:CreateSound("rbxassetid://109954155299965", 0.75, 1 + 0.25 * math.random(), u7, true);
    u25:Destroy();
    BillboardGui:Destroy();
end;