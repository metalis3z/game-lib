-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local TracerEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("TracerEffect");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 81, 0));
local ColorSequence_new_ret2 = ColorSequence.new(Color3.fromRGB(255, 8, 0));

return {
    VerifyTracerData = function(p1, p2, p3, p4) -- Line: 15, Name: VerifyTracerData
        -- upvalues: ColorSequence_new_ret (copy)
        local v5 = p2 or {};
        v5.RaycastResults = v5.RaycastResults or {};
        v5.IsLocal = v5.IsLocal or false;
        v5.IsEnemy = v5.IsEnemy or false;
        local v6 = p3 or {};
        v6.EnemyColor = v6.EnemyColor or nil;
        v6.Color = v6.Color or nil;
        v6.BeamProperties = v6.BeamProperties or nil;
        v6.MaxLengthFirstPerson = v6.MaxLengthFirstPerson or nil;
        v6.MaxLength = v6.MaxLength or nil;
        v6.NoDistanceDelay = v6.NoDistanceDelay or nil;
        v6.Template = v6.Template or nil;
        v6.InitCallback = v6.InitCallback or nil;
        v6.UpdateSpeed = v6.UpdateSpeed or nil;
        v6.CustomUpdate = v6.CustomUpdate or nil;
        v6.PlayFlyBySound = v6.PlayFlyBySound or nil;
        local v7 = p4 or {};
        v7.FriendlyTracerColor = v7.FriendlyTracerColor or ColorSequence_new_ret;
        v7.ActuallyFirstPerson = v7.ActuallyFirstPerson or false;
        v7.MuzzlePosition = v7.MuzzlePosition or nil;

        return v5, v6, v7;
    end,

    Play = function(p8, p9, p10, p11) -- Line: 42, Name: Play
        -- upvalues: CONSTANTS (copy), Utility (copy), TracerEffect (copy), BetterDebris (copy), ColorSequence_new_ret2 (copy)
        local u12, u13, u14 = p8:VerifyTracerData(p9, p10, p11);

        if not u14.MuzzlePosition then
            return;
        end;

        local v15 = {};

        for _, v in pairs(u12.RaycastResults) do
            if not u12.IsLocal then
                local v16 = v;
                local v17 = v16;
                local v18 = v16;
                v16 = v17;
                v18 = v17;

                while v17.LastRaycastResult do
                    v17 = v17.LastRaycastResult;
                end;

                v15[v17] = v15[v17] or {};
                table.insert(v15[v17], v16);
            end;
        end;

        for _, v in pairs(v15) do
            local v19 = nil;
            local v20 = nil;

            for _, v2 in pairs(v) do
                local v21 = v2.StartPosition or u14.MuzzlePosition;
                local v22 = Ray.new(v21, (v2.Position - v21).Unit):ClosestPoint(workspace.CurrentCamera.CFrame.Position);

                if not v19 or (v22 - workspace.CurrentCamera.CFrame.Position).Magnitude < (v19 - workspace.CurrentCamera.CFrame.Position).Magnitude then
                    v20 = v21;
                    v19 = v22;
                end;
            end;

            if v19 then
                local Magnitude = (v19 - v20).Magnitude;

                if Magnitude > 1 and Magnitude < CONSTANTS.RENDER_DISTANCE then
                    local v23 = 1 - ((v19 - workspace.CurrentCamera.CFrame.Position).Magnitude / 50) ^ 3;

                    if u13.PlayFlyBySound then
                        u13.PlayFlyBySound(v19, v23, 50);
                    else
                        Utility:CreateSound("rbxassetid://14767954026", 1 * v23, 1.4 + 0.2 * math.random(), v19, true, 10, 50, 50);
                    end;
                end;
            end;
        end;

        local u24;

        if u14.ActuallyFirstPerson then
            u24 = u13.MaxLengthFirstPerson or 75;
        else
            u24 = u13.MaxLength or 15;
        end;

        for i, v in pairs(u12.RaycastResults) do
            task.defer(function() -- Line: 102
                -- upvalues: v (copy), u13 (copy), u14 (copy), TracerEffect (ref), BetterDebris (ref), i (copy), u12 (copy), ColorSequence_new_ret2 (ref), Utility (ref), u24 (copy)
                local v25 = v;
                local v26 = 0;

                while v25 and (v25.LastRaycastResult and not u13.NoDistanceDelay) do
                    v26 = v26 + ((v25.StartPosition or u14.MuzzlePosition) - v.Position).Magnitude;
                    v25 = v25.LastRaycastResult;
                end;

                if v26 > 0 then
                    wait(1.6666666666666667 / (800 / v26));
                end;

                local u27 = v.StartPosition or u14.MuzzlePosition;
                local Magnitude = (u27 - v.Position).Magnitude;
                local u28 = (u13.Template or TracerEffect):Clone();
                u28.CFrame = CFrame.identity;
                u28.Parent = workspace;
                BetterDebris:AddItem(u28, 10);

                if u13.InitCallback then
                    u13.InitCallback(u28, i);
                else
                    local v29;

                    if u12.IsEnemy then
                        v29 = u13.EnemyColor or ColorSequence_new_ret2;
                    else
                        v29 = u13.Color or u14.FriendlyTracerColor;
                    end;

                    u28.Beam.Color = v29;
                    u28.Attachment1.PointLight.Color = u28.Beam.Color.Keypoints[1].Value;

                    for i2, v2 in pairs(u13.BeamProperties or {}) do
                        u28.Beam[i2] = v2;
                    end;
                end;

                local Attachment0 = u28.Attachment0;
                local Attachment1 = u28.Attachment1;
                Utility:RenderstepForLoop(0, 100, u13.UpdateSpeed or 800 / Magnitude, function(p30) -- Line: 137
                    -- upvalues: u13 (ref), u28 (copy), Attachment0 (copy), Attachment1 (copy), u27 (copy), v (ref), u24 (ref)
                    local v31 = p30 / 100;

                    if u13.CustomUpdate then
                        u13.CustomUpdate(u28, Attachment0, Attachment1, v31, u27, v.Position);

                        return;
                    end;

                    Attachment1.WorldPosition = u27:Lerp(v.Position, v31);
                    Attachment0.WorldPosition = Attachment1.WorldPosition + (v.Position - u27).Unit * math.min((Attachment1.WorldPosition - v.Position).Magnitude, u24);
                end);
                u28:Destroy();
            end);
        end;
    end
};