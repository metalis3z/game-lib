-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:10:54 2025 ]]
local _ = require(game.ReplicatedStorage.GlobalTypes);
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v4 = l_RunService_0:IsClient();
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_DeathDisplay_0 = script.DeathDisplay;
local function v12() --[[ Line: 17 ]] --[[ Name: __onDied ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_DeathDisplay_0 (copy)
    local l_TemporaryUI_0 = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
    local l_DeathDisplay_1 = l_TemporaryUI_0:FindFirstChild("DeathDisplay");
    if l_DeathDisplay_1 then
        l_DeathDisplay_1:Destroy();
    end;
    local v9 = l_DeathDisplay_0:Clone();
    local function v11(_) --[[ Line: 27 ]] --[[ Name: ____onVideoFinished ]]
        -- upvalues: v9 (copy)
        v9:Destroy();
    end;
    v9.Parent = l_TemporaryUI_0;
    v9.VideoFrame.Ended:Connect(v11);
    v9.VideoFrame:Play();
end;
return {
    CreatedPost = function(_, v14) --[[ Line: 38 ]] --[[ Name: CreatedPost ]]
        -- upvalues: v4 (copy), l_LocalPlayer_0 (copy), l_ContentProvider_0 (copy), v12 (copy)
        if not v4 or v14.Player ~= l_LocalPlayer_0 then
            return;
        else
            local l_Humanoid_0 = v14.Rig:FindFirstChildOfClass("Humanoid");
            if not l_Humanoid_0 then
                return;
            else
                l_ContentProvider_0:PreloadAsync({
                    script.DeathDisplay.VideoFrame
                });
                l_Humanoid_0.Died:Connect(v12);
                return;
            end;
        end;
    end
};