-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_CurrentRoundClient_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("CurrentRoundClient"));
local l_AtomicBinding_0 = require(script:WaitForChild("AtomicBinding"));
local function _(v4)
    local l_status_0, l_result_0 = pcall(function()
        return UserSettings():IsUserFeatureEnabled(v4);
    end);
    return l_status_0 and l_result_0;
end;
local l_pcall_0 = pcall;
local v9 = "UserSoundsUseRelativeVelocity2";
local l_v9_0 = v9 --[[ copy: 8 -> 23 ]];
local v11;
l_pcall_0, v11 = l_pcall_0(function()
    return UserSettings():IsUserFeatureEnabled(l_v9_0);
end);
local v12 = l_pcall_0 and v11;
l_pcall_0 = {
    Climbing = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", 
        Looped = true
    }, 
    Died = {
        SoundId = "rbxasset://sounds/uuhhh.mp3"
    }, 
    FreeFalling = {
        SoundId = "rbxasset://sounds/action_falling.mp3", 
        Looped = true
    }, 
    GettingUp = {
        SoundId = "rbxasset://sounds/action_get_up.mp3"
    }, 
    Jumping = {
        SoundId = "rbxasset://sounds/action_jump.mp3"
    }, 
    Landing = {
        SoundId = "rbxasset://sounds/action_jump_land.mp3"
    }, 
    Running = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", 
        Looped = true, 
        Pitch = 1.85
    }, 
    Splash = {
        SoundId = "rbxasset://sounds/impact_water.mp3"
    }, 
    Swimming = {
        SoundId = "rbxasset://sounds/action_swim.mp3", 
        Looped = true, 
        Pitch = 1.6
    }
};
v11 = function(v13, v14, v15, v16, v17)
    return (v13 - v14) * (v17 - v16) / (v15 - v14) + v16;
end;
v9 = function(v18, v19)
    if not v18 then
        return v19;
    else
        local v20 = v18.ActiveController and (v18.ActiveController:IsA("GroundController") and v18.GroundSensor or v18.ActiveController:IsA("ClimbController") and v18.ClimbSensor);
        if v20 and v20.SensedPart then
            return v19 - v20.SensedPart:GetVelocityAtPosition(v18.RootPart.Position);
        else
            return v19;
        end;
    end;
end;
local function _(v21)
    v21.TimePosition = 0;
    v21.Playing = true;
end;
local function _(v23)
    local v24 = {};
    for v25, v26 in pairs(v23) do
        v24[v25] = v26;
    end;
    return v24;
end;
local v151 = l_AtomicBinding_0.new({
    humanoid = "Humanoid", 
    rootPart = "HumanoidRootPart"
}, function(v28)
    local _ = v28.player;
    local l_humanoid_0 = v28.humanoid;
    local l_rootPart_0 = v28.rootPart;
    local v32 = nil;
    if v12 then
        v32 = l_humanoid_0.Parent:FindFirstChild("ControllerManager");
    end;
    local v33 = {};
    for v34, v35 in pairs(l_pcall_0) do
        local l_Sound_0 = Instance.new("Sound");
        l_Sound_0.Name = v34;
        l_Sound_0.Archivable = false;
        l_Sound_0.RollOffMinDistance = 5;
        l_Sound_0.RollOffMaxDistance = 150;
        l_Sound_0.Volume = 0.65;
        for v37, v38 in pairs(v35) do
            l_Sound_0[v37] = v38;
        end;
        l_Sound_0.Parent = l_rootPart_0;
        v33[v34] = l_Sound_0;
    end;
    local v39 = {};
    local function _(v40)
        local l_pairs_0 = pairs;
        local l_v39_0 = v39;
        local v43 = {};
        for v44, v45 in pairs(l_v39_0) do
            v43[v44] = v45;
        end;
        for v46 in l_pairs_0(v43) do
            if v46 ~= v40 then
                v46.Playing = false;
                v39[v46] = nil;
            end;
        end;
    end;
    local v122 = {
        [Enum.HumanoidStateType.FallingDown] = function()
            local l_pairs_1 = pairs;
            local l_v39_1 = v39;
            local v50 = {};
            for v51, v52 in pairs(l_v39_1) do
                v50[v51] = v52;
            end;
            for v53 in l_pairs_1(v50) do
                if v53 ~= nil then
                    v53.Playing = false;
                    v39[v53] = nil;
                end;
            end;
        end, 
        [Enum.HumanoidStateType.GettingUp] = function()
            local l_pairs_2 = pairs;
            local l_v39_2 = v39;
            local v56 = {};
            for v57, v58 in pairs(l_v39_2) do
                v56[v57] = v58;
            end;
            for v59 in l_pairs_2(v56) do
                if v59 ~= nil then
                    v59.Playing = false;
                    v39[v59] = nil;
                end;
            end;
            l_pairs_2 = v33.GettingUp;
            l_pairs_2.TimePosition = 0;
            l_pairs_2.Playing = true;
        end, 
        [Enum.HumanoidStateType.Jumping] = function()
            local l_pairs_3 = pairs;
            local l_v39_3 = v39;
            local v62 = {};
            for v63, v64 in pairs(l_v39_3) do
                v62[v63] = v64;
            end;
            for v65 in l_pairs_3(v62) do
                if v65 ~= nil then
                    v65.Playing = false;
                    v39[v65] = nil;
                end;
            end;
            l_pairs_3 = v33.Jumping;
            l_pairs_3.TimePosition = 0;
            l_pairs_3.Playing = true;
        end, 
        [Enum.HumanoidStateType.Swimming] = function()
            local v66 = math.abs(l_rootPart_0.AssemblyLinearVelocity.Y);
            if v66 > 0.1 then
                v33.Splash.Volume = math.clamp((v66 - 100) * 0.72 / 250 + 0.28, 0, 1);
                local l_Splash_0 = v33.Splash;
                l_Splash_0.TimePosition = 0;
                l_Splash_0.Playing = true;
            end;
            local l_Swimming_0 = v33.Swimming;
            local l_pairs_4 = pairs;
            local l_v39_4 = v39;
            local v71 = {};
            for v72, v73 in pairs(l_v39_4) do
                v71[v72] = v73;
            end;
            for v74 in l_pairs_4(v71) do
                if v74 ~= l_Swimming_0 then
                    v74.Playing = false;
                    v39[v74] = nil;
                end;
            end;
            v33.Swimming.Playing = true;
            v39[v33.Swimming] = true;
        end, 
        [Enum.HumanoidStateType.Freefall] = function()
            v33.FreeFalling.Volume = 0;
            local l_FreeFalling_0 = v33.FreeFalling;
            local l_pairs_5 = pairs;
            local l_v39_5 = v39;
            local v78 = {};
            for v79, v80 in pairs(l_v39_5) do
                v78[v79] = v80;
            end;
            for v81 in l_pairs_5(v78) do
                if v81 ~= l_FreeFalling_0 then
                    v81.Playing = false;
                    v39[v81] = nil;
                end;
            end;
            v39[v33.FreeFalling] = true;
        end, 
        [Enum.HumanoidStateType.Landed] = function()
            local l_pairs_6 = pairs;
            local l_v39_6 = v39;
            local v84 = {};
            for v85, v86 in pairs(l_v39_6) do
                v84[v85] = v86;
            end;
            for v87 in l_pairs_6(v84) do
                if v87 ~= nil then
                    v87.Playing = false;
                    v39[v87] = nil;
                end;
            end;
            l_pairs_6 = math.abs(l_rootPart_0.AssemblyLinearVelocity.Y);
            if l_pairs_6 > 75 then
                v33.Landing.Volume = math.clamp((l_pairs_6 - 50) * 1 / 50 + 0, 0, 1);
                local l_Landing_0 = v33.Landing;
                l_Landing_0.TimePosition = 0;
                l_Landing_0.Playing = true;
            end;
        end, 
        [Enum.HumanoidStateType.Running] = function()
            local l_Running_0 = v33.Running;
            local l_pairs_7 = pairs;
            local l_v39_7 = v39;
            local v92 = {};
            for v93, v94 in pairs(l_v39_7) do
                v92[v93] = v94;
            end;
            for v95 in l_pairs_7(v92) do
                if v95 ~= l_Running_0 then
                    v95.Playing = false;
                    v39[v95] = nil;
                end;
            end;
            v33.Running.Playing = true;
            v39[v33.Running] = true;
        end, 
        [Enum.HumanoidStateType.Climbing] = function()
            local l_Climbing_0 = v33.Climbing;
            local l_AssemblyLinearVelocity_0 = l_rootPart_0.AssemblyLinearVelocity;
            if math.abs((if v12 then v9(v32, l_AssemblyLinearVelocity_0) else l_AssemblyLinearVelocity_0).Y) > 0.1 then
                l_Climbing_0.Playing = true;
                local l_pairs_8 = pairs;
                local l_v39_8 = v39;
                local v100 = {};
                for v101, v102 in pairs(l_v39_8) do
                    v100[v101] = v102;
                end;
                for v103 in l_pairs_8(v100) do
                    if v103 ~= l_Climbing_0 then
                        v103.Playing = false;
                        v39[v103] = nil;
                    end;
                end;
            else
                local l_pairs_9 = pairs;
                local l_v39_9 = v39;
                local v106 = {};
                for v107, v108 in pairs(l_v39_9) do
                    v106[v107] = v108;
                end;
                for v109 in l_pairs_9(v106) do
                    if v109 ~= nil then
                        v109.Playing = false;
                        v39[v109] = nil;
                    end;
                end;
            end;
            v39[l_Climbing_0] = true;
        end, 
        [Enum.HumanoidStateType.Seated] = function()
            local l_pairs_10 = pairs;
            local l_v39_10 = v39;
            local v112 = {};
            for v113, v114 in pairs(l_v39_10) do
                v112[v113] = v114;
            end;
            for v115 in l_pairs_10(v112) do
                if v115 ~= nil then
                    v115.Playing = false;
                    v39[v115] = nil;
                end;
            end;
        end, 
        [Enum.HumanoidStateType.Dead] = function()
            local l_pairs_11 = pairs;
            local l_v39_11 = v39;
            local v118 = {};
            for v119, v120 in pairs(l_v39_11) do
                v118[v119] = v120;
            end;
            for v121 in l_pairs_11(v118) do
                if v121 ~= nil then
                    v121.Playing = false;
                    v39[v121] = nil;
                end;
            end;
            if l_CurrentRoundClient_0.GetMurdererPerk() ~= "Ninja" then
                l_pairs_11 = v33.Died;
                l_pairs_11.TimePosition = 0;
                l_pairs_11.Playing = true;
            end;
        end
    };
    local v133 = {
        [v33.Climbing] = function(_, v124, v125)
            v124.Playing = (if v12 then v9(v32, v125) else v125).Magnitude > 0.1;
        end, 
        [v33.FreeFalling] = function(v126, v127, v128)
            if v128.Magnitude > 75 then
                v127.Volume = math.clamp(v127.Volume + 0.9 * v126, 0, 1);
                return;
            else
                v127.Volume = 0;
                return;
            end;
        end, 
        [v33.Running] = function(_, v130, v131)
            local v132 = false;
            if v131.Magnitude > 0.5 then
                v132 = l_humanoid_0.MoveDirection.Magnitude > 0.5;
            end;
            v130.Playing = v132;
        end
    };
    local v134 = {
        [Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
    };
    local v135 = v134[l_humanoid_0:GetState()] or l_humanoid_0:GetState();
    local function _(v136)
        local v137 = v122[v136];
        if v137 then
            v137();
        end;
        v135 = v136;
    end;
    local l_v135_0 = v135;
    local v140 = v122[l_v135_0];
    if v140 then
        v140();
    end;
    v135 = l_v135_0;
    l_v135_0 = l_humanoid_0.StateChanged:Connect(function(_, v142)
        v142 = v134[v142] or v142;
        if v142 ~= v135 then
            local l_v142_0 = v142;
            local v144 = v122[l_v142_0];
            if v144 then
                v144();
            end;
            v135 = l_v142_0;
        end;
    end);
    v140 = l_RunService_0.Stepped:Connect(function(_, v146)
        for v147 in pairs(v39) do
            local v148 = v133[v147];
            if v148 then
                v148(v146, v147, l_rootPart_0.AssemblyLinearVelocity);
            end;
        end;
    end);
    return function()
        l_v135_0:Disconnect();
        v140:Disconnect();
        for _, v150 in pairs(v33) do
            v150:Destroy();
        end;
        table.clear(v33);
    end;
end);
local v152 = {};
local function v154(v153)
    v151:bindRoot(v153);
end;
local function v156(v155)
    v151:unbindRoot(v155);
end;
local function v160(v157)
    local v158 = v152[v157];
    if not v158 then
        v158 = {};
        v152[v157] = v158;
    end;
    if v157.Character then
        local l_Character_0 = v157.Character;
        v151:bindRoot(l_Character_0);
    end;
    table.insert(v158, v157.CharacterAdded:Connect(v154));
    table.insert(v158, v157.CharacterRemoving:Connect(v156));
end;
local function v166(v161)
    local v162 = v152[v161];
    if v162 then
        for _, v164 in ipairs(v162) do
            v164:Disconnect();
        end;
        v152[v161] = nil;
    end;
    if v161.Character then
        local l_Character_1 = v161.Character;
        v151:unbindRoot(l_Character_1);
    end;
end;
for _, v168 in ipairs(l_Players_0:GetPlayers()) do
    task.spawn(v160, v168);
end;
l_Players_0.PlayerAdded:Connect(v160);
l_Players_0.PlayerRemoving:Connect(v166);