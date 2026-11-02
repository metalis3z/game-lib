

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__Players__4 = game:GetService("Players");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__Trove__6 = require(l__ReplicatedStorage__1.Packages.Trove);
local l__Gradients__7 = require(l__ReplicatedStorage__1.Packages.Gradients);
local l__Spring__8 = require(l__ReplicatedStorage__1.Packages.Spring);
local l__ReplicatorClient__9 = require(l__ReplicatedStorage__1.Packages.ReplicatorClient);
local Net = require(l__ReplicatedStorage__1.Packages.Net);
local l__UserGameSettings__10 = UserSettings():GetService("UserGameSettings");
require(l__ReplicatedStorage__1.Datas.ServerData);
local l__Animals__11 = require(l__ReplicatedStorage__1.Datas.Animals);
local l__Mutations__12 = require(l__ReplicatedStorage__1.Datas.Mutations);
local l__Index__13 = require(l__ReplicatedStorage__1.Datas.Index);
local l__Traits__14 = require(l__ReplicatedStorage__1.Datas.Traits);
require(l__ReplicatedStorage__1.Datas.Bases);
local l__Rarities__15 = require(l__ReplicatedStorage__1.Datas.Rarities);
local l__Animals__16 = require(l__ReplicatedStorage__1.Shared.Animals);
local l__Index__17 = require(l__ReplicatedStorage__1.Shared.Index);
local l__MutationStyle__18 = require(l__ReplicatedStorage__1.Shared.MutationStyle);
local l__BrainrotAssets__19 = require(l__ReplicatedStorage__1.Shared.BrainrotAssets);
local l__MutationText__20 = require(l__ReplicatedStorage__1.Shared.MutationText);
local l__AnimationSyncController__21 = require(l__ReplicatedStorage__1.Controllers.AnimationSyncController);
local l__SoundController__22 = require(l__ReplicatedStorage__1.Controllers.SoundController);
local l__HoverInfoController__23 = require(l__ReplicatedStorage__1.Controllers.HoverInfoController);
local l__FastOverheadController__24 = require(l__ReplicatedStorage__1.Controllers.FastOverheadController);
local l__AnimalOverheadController__25 = require(l__ReplicatedStorage__1.Controllers.AnimalOverheadController);
local l__NumberUtils__26 = require(l__ReplicatedStorage__1.Utils.NumberUtils);
local l__Animals__27 = l__ReplicatedStorage__1:WaitForChild("Animations").Animals;
local l__LocalPlayer__28 = l__Players__4.LocalPlayer;
local u1 = CFrame.new(20000, 10000, 0);
local u2 = Color3.fromRGB(0, 200, 65);
local u3 = Color3.fromRGB(0, 255, 80);
local u4 = {};
local u5 = nil;
local u6 = nil;
local u7 = {};
local u8 = false;
local u9 = false;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local l__identity__29 = CFrame.identity;
local u28 = 0;
local u29 = nil;
local u30 = nil;
local u31 = nil;
local u32 = Vector3.new(0, 0, 0);
local l__zero__30 = Vector2.zero;
local u33 = 16;
local u34 = 4;
local u35 = 50;
local u36 = nil;
local u37 = l__Spring__8.new(Vector2.zero);
local u38 = l__Spring__8.new(16);
local u39 = l__Spring__8.new(Vector3.new(0, 0, 0));
u37.Speed = 20;
u37.Damper = 0.85;
u38.Speed = 16;
u38.Damper = 1;
u39.Speed = 14;
u39.Damper = 1;
local u40 = false;
local l__zero__31 = Vector2.zero;
local u41 = 0.024;
local u42 = 1;
local l__zero__32 = Vector2.zero;
local u43 = 0;
local u44 = 0;
local u45 = 0;
local u46 = nil;
local u47 = nil;
local u48 = {};
local u49 = {};
local u50 = RaycastParams.new();
u50.FilterType = Enum.RaycastFilterType.Include;
u50.IgnoreWater = true;
local u51 = true;
local u52 = {};
local u53 = {};
local u54 = "";
local u55 = {};
local u56 = nil;
local u57 = {};
task.spawn(function() --[[ Name: refreshExistsData, Line 119 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u57 (ref)
    local u58 = l__ReplicatedStorage__1:FindFirstChild("GetAnimalExists");
    if u58 then
        local v59, v60 = pcall(function() --[[ Line: 122 ]]
            -- upvalues: u58 (copy)
            return u58:InvokeServer();
        end);
        if v59 and type(v60) == "table" then
            u57 = v60;
        end;
    end;
end);
task.spawn(function() --[[ Line: 131 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u57 (ref)
    while task.wait(60) do
        local u61 = l__ReplicatedStorage__1:FindFirstChild("GetAnimalExists");
        if u61 then
            local v62, v63 = pcall(function() --[[ Line: 122 ]]
                -- upvalues: u61 (copy)
                return u61:InvokeServer();
            end);
            if v62 and type(v63) == "table" then
                u57 = v63;
            end;
        end;
    end;
end);
local function u66() --[[ Line: 137 ]]
    -- upvalues: u56 (ref), l__LocalPlayer__28 (copy)
    if not u56 then
        local v64 = Instance.new("ScreenGui");
        v64.Name = "GlossaryFade";
        v64.IgnoreGuiInset = true;
        v64.DisplayOrder = 6000;
        v64.ResetOnSpawn = false;
        v64.Parent = l__LocalPlayer__28:WaitForChild("PlayerGui");
        local v65 = Instance.new("Frame");
        v65.Size = UDim2.fromScale(1, 1);
        v65.BackgroundColor3 = Color3.new(0, 0, 0);
        v65.BackgroundTransparency = 1;
        v65.Parent = v64;
        u56 = v65;
    end;
end;
local function u69(p67) --[[ Line: 157 ]]
    -- upvalues: u66 (copy), l__TweenService__3 (copy), u56 (ref)
    u66();
    local v68 = l__TweenService__3:Create(u56, TweenInfo.new(0.35), {
        BackgroundTransparency = p67 and 0 or 1
    });
    v68:Play();
    v68.Completed:Wait();
end;
local u70 = {
    Glossary = true,
    GlossaryFade = true,
    Index = true,
    TopNotification = true
};
local function u72() --[[ Line: 178 ]]
    -- upvalues: u55 (copy), l__LocalPlayer__28 (copy), u70 (copy)
    table.clear(u55);
    for _, v71 in l__LocalPlayer__28.PlayerGui:GetChildren() do
        if v71:IsA("LayerCollector") and (v71.Enabled and (not u70[v71.Name] and string.match(v71.Name, "^[%w _]+$"))) then
            v71.Enabled = false;
            table.insert(u55, v71);
        end;
    end;
end;
local function u79() --[[ Line: 199 ]]
    -- upvalues: u25 (ref), u26 (ref), u27 (ref), u7 (copy), l__Trove__6 (copy), l__Animals__16 (copy)
    if u25 then
        u25:Destroy();
        u25 = nil;
    end;
    local v73 = u26;
    local v74 = u27;
    if v73 and v74 then
        local v75 = {};
        for v76 in u7 do
            table.insert(v75, v76);
        end;
        if #v75 > 0 then
            local v77 = l__Trove__6.new();
            u25 = v77;
            for _, v78 in v75 do
                v77:Add(l__Animals__16:ApplyTraits(v73, v74, { v78 }));
            end;
        end;
    end;
end;
local u80 = Color3.fromRGB(166, 166, 166);
local u81 = l__ReplicatorClient__9.get("PublicExistCounts");
local u82 = l__ReplicatorClient__9.get("ExistCounts");
local function u90(p83, p84) --[[ Line: 234 ]]
    -- upvalues: u82 (copy), u81 (copy), l__ReplicatedStorage__1 (copy), l__Mutations__12 (copy)
    local v85 = u82:TryIndex({ "data", p83 }) or u81:TryIndex({ "data", p83 });
    if not v85 then
        local u86 = l__ReplicatedStorage__1:FindFirstChild("GetAnimalExists");
        if u86 then
            local v87, v88 = pcall(function() --[[ Line: 239 ]]
                -- upvalues: u86 (copy)
                return u86:InvokeServer();
            end);
            if v87 and (type(v88) == "table" and v88[p83]) then
                v85 = v88[p83];
            end;
        end;
        if not v85 then
            return 0;
        end;
    end;
    local v89 = "Default";
    if p84 == nil or (p84 == "Default" or p84 == "All") then
        p84 = v89;
    elseif l__Mutations__12[p84] == nil then
        p84 = v89;
    end;
    return v85.mutations and v85.mutations[p84] or 0;
end;
local function u101() --[[ Line: 257 ]]
    -- upvalues: u29 (ref), u27 (ref), l__Animals__11 (copy), u7 (copy), l__AnimalOverheadController__25 (copy), u30 (ref), l__NumberUtils__26 (copy), l__Animals__16 (copy), u6 (ref), u31 (ref), u90 (copy), l__Mutations__12 (copy), l__MutationStyle__18 (copy), u80 (copy)
    local v91 = u29;
    local v92 = u27;
    if v91 and (v91.Parent and v92) then
        local v93 = l__Animals__11[v92];
        local v94 = {};
        for v95 in u7 do
            table.insert(v94, v95);
        end;
        v91.Text = l__AnimalOverheadController__25:ResolveDisplayName(v92, v94);
        if u30 then
            u30.Text = `${l__NumberUtils__26:ToString((l__Animals__16:GetGeneration(v92, u6, v94, nil)))}/s`;
            local v96 = u30;
            if v93 then
                v93 = v93.HideGeneration;
            end;
            v96.Visible = not v93;
        end;
        if u31 then
            local v97 = u90(v92, u6);
            if v97 and v97 > 0 then
                local v98 = u31;
                local v99 = "%* Exist";
                local v100;
                if v97 > 999999 then
                    v100 = l__NumberUtils__26:ToString(v97);
                else
                    v100 = l__NumberUtils__26:Comma(v97);
                end;
                v98.Text = v99:format(v100);
                u31.Visible = true;
            else
                u31.Text = "0 Exist";
                u31.Visible = true;
            end;
            if u6 == nil or (u6 == "Default" or (u6 == "All" or l__Mutations__12[u6] == nil)) then
                u31.TextColor3 = u80;
            else
                l__MutationStyle__18.ApplyToLabel(u31, u6);
            end;
        end;
    end;
end;
local function u114(p102, p103, p104) --[[ Line: 293 ]]
    -- upvalues: l__Animals__11 (copy), l__FastOverheadController__24 (copy), u80 (copy), u6 (ref), l__Mutations__12 (copy), l__MutationText__20 (copy), l__MutationStyle__18 (copy), u29 (ref), u30 (ref), u31 (ref), u101 (copy)
    local l__PrimaryPart__33 = p103.PrimaryPart;
    if l__PrimaryPart__33 then
        local v105 = l__Animals__11[p104];
        local v106 = p103:GetExtentsSize();
        local v107 = p103:FindFirstChild("OVERHEAD_ATTACHMENT", true);
        if not (v107 and v107:IsA("Attachment")) then
            v107 = Instance.new("Attachment");
            v107.Parent = l__PrimaryPart__33;
            v107.WorldCFrame = p103:GetPivot() * CFrame.new(0, v106.Y * 0.75 * (v105 and v105.OverheadYOffsetModifier or 1), 0);
        end;
        local v108, v109 = l__FastOverheadController__24.createFastOverhead({
            adornee = v107,
            guiTemplate = l__FastOverheadController__24.GuiTemplates.AnimalOverhead
        });
        p102:Add(v109);
        v108.MaxDistance = (1 / 0);
        v108.Price.Visible = false;
        v108.Rarity.Visible = false;
        v108.Mutation.Visible = false;
        if v108:FindFirstChild("Stolen") then
            v108.Stolen.Visible = false;
        end;
        if v108:FindFirstChild("Traits") then
            v108.Traits.Visible = false;
        end;
        local u110 = v108.Generation:Clone();
        u110.Name = "Exists";
        u110.LayoutOrder = (v108.Generation.LayoutOrder or 3) + 2;
        u110.TextColor3 = u80;
        u110.Visible = true;
        u110.Parent = v108;
        local v111 = u6;
        local v112;
        if v111 == nil or (v111 == "Default" or (v111 == "All" or l__Mutations__12[v111] == nil)) then
            v112 = nil;
        else
            v112 = u6;
        end;
        local v113;
        if l__MutationText__20 and l__MutationText__20.apply then
            v113 = l__MutationText__20.apply(u110, v112);
        else
            v113 = nil;
        end;
        if v113 then
            p102:Add(v113);
        end;
        if v112 and l__Mutations__12[v112] then
            l__MutationStyle__18.ApplyToLabel(u110, v112);
        end;
        u29 = v108.DisplayName;
        u30 = v108.Generation;
        u31 = u110;
        p102:Add(function() --[[ Line: 355 ]]
            -- upvalues: u31 (ref), u110 (copy), u29 (ref), u30 (ref)
            if u31 == u110 then
                u29 = nil;
                u30 = nil;
                u31 = nil;
            end;
        end);
        u101();
    end;
end;
local function u138() --[[ Line: 366 ]]
    -- upvalues: u28 (ref), u25 (ref), u24 (ref), u26 (ref), u27 (ref), u5 (ref), l__BrainrotAssets__19 (copy), u8 (ref), l__Trove__6 (copy), u6 (ref), l__Animals__16 (copy), l__identity__29 (ref), u32 (ref), u34 (ref), u35 (ref), u36 (ref), u33 (ref), u79 (copy), l__Animals__27 (copy), l__AnimationSyncController__21 (copy), u114 (copy)
    u28 = u28 + 1;
    local u115 = u28;
    if u25 then
        u25:Destroy();
        u25 = nil;
    end;
    if u24 then
        u24:Destroy();
        u24 = nil;
    end;
    u26 = nil;
    u27 = nil;
    local u116 = u5;
    if u116 then
        task.spawn(function() --[[ Line: 381 ]]
            -- upvalues: l__BrainrotAssets__19 (ref), u116 (copy), u115 (copy), u28 (ref), u8 (ref), l__Trove__6 (ref), u24 (ref), u6 (ref), l__Animals__16 (ref), l__identity__29 (ref), u32 (ref), u34 (ref), u35 (ref), u36 (ref), u33 (ref), u26 (ref), u27 (ref), u79 (ref), l__Animals__27 (ref), l__AnimationSyncController__21 (ref), u114 (ref)
            local v117 = l__BrainrotAssets__19.getModel(u116);
            if u115 == u28 and (u8 and v117) then
                local v118 = l__Trove__6.new();
                u24 = v118;
                local v119 = v118:Clone(v117);
                if v119.PrimaryPart then
                    for _, v120 in v119:GetDescendants() do
                        if v120:IsA("BasePart") then
                            v120.CanCollide = false;
                            v120.CanQuery = false;
                            v120.CanTouch = false;
                            v120.Massless = true;
                            v120.CastShadow = false;
                        end;
                    end;
                    v119.PrimaryPart.Anchored = true;
                    v119.Parent = workspace.CurrentCamera;
                    if u6 then
                        v118:Add(l__Animals__16:ApplyMutation(v119, u116, u6));
                    end;
                    v119:PivotTo(l__identity__29);
                    if u115 == u28 and u8 then
                        local v121 = v119:GetPivot();
                        local v122 = v119:GetExtentsSize();
                        local v123 = v119:GetPivot();
                        local v124 = v123.Position.Y - v122.Y * 0.5;
                        local v125 = v123.Position.Y + v122.Y * 0.5;
                        for _, v126 in v119:GetDescendants() do
                            if v126:IsA("Bone") then
                                local l__Y__34 = v126.WorldPosition.Y;
                                v124 = math.min(v124, l__Y__34);
                                v125 = math.max(v125, l__Y__34);
                            end;
                        end;
                        local v127 = v125 - v124;
                        local l__CurrentCamera__35 = workspace.CurrentCamera;
                        local v128 = not l__CurrentCamera__35 and 1.7777777777777777 or l__CurrentCamera__35.ViewportSize.X / math.max(l__CurrentCamera__35.ViewportSize.Y, 1);
                        local v129 = math.max(v122.X, v122.Z) / math.max(v128, 0.0001);
                        local v130 = math.max(v129, v127) * 0.5 / 0.34432761328966527 * 2.1;
                        local v131 = math.max(v130, 6);
                        local l__X__36 = v121.Position.X;
                        local v132 = math.max((v124 + v125) * 0.5, l__identity__29.Position.Y + 3);
                        u32 = Vector3.new(l__X__36, v132, v121.Position.Z);
                        local v133 = math.max(v122.X, v127, v122.Z) * 0.5;
                        u34 = math.max(v133, 8);
                        u35 = math.max(v131 * 3.5, u34 * 3);
                        if u36 ~= u116 then
                            u36 = u116;
                            u33 = math.clamp(v131, u34, u35);
                        end;
                        u26 = v119;
                        u27 = u116;
                        u79();
                        local v134 = v119:FindFirstChild("AnimationController");
                        if v134 then
                            v134 = v134:FindFirstChildOfClass("Animator");
                        end;
                        local v135 = l__Animals__27:FindFirstChild(u116);
                        if v135 then
                            v135 = v135:FindFirstChild("Idle");
                        end;
                        if v135 and v134 then
                            local u136 = v134:LoadAnimation(v135);
                            u136.Looped = true;
                            u136:Play();
                            local u137 = l__AnimationSyncController__21:Add(u136);
                            v118:Add(function() --[[ Line: 446 ]]
                                -- upvalues: u137 (copy), u136 (copy)
                                u137();
                                u136:Stop(0);
                                u136:Destroy();
                            end);
                        end;
                        u114(v118, v119, u116);
                    end;
                else
                    v119:Destroy();
                end;
            end;
        end);
    end;
end;
local function u145() --[[ Line: 457 ]]
    -- upvalues: l__Animals__11 (copy), l__Index__17 (copy)
    local v139 = {};
    for v140 in l__Animals__11 do
        if l__Index__17:CanShowInIndex(v140) then
            table.insert(v139, v140);
        end;
    end;
    table.sort(v139, function(p141, p142) --[[ Line: 466 ]]
        -- upvalues: l__Animals__11 (ref)
        local v143 = l__Animals__11[p141].Generation or 0;
        local v144 = l__Animals__11[p142].Generation or 0;
        if v143 == v144 then
            return p141 < p142;
        else
            return v144 < v143;
        end;
    end);
    return v139;
end;
local function u173() --[[ Line: 559 ]]
    -- upvalues: u11 (ref), u145 (copy), l__Animals__11 (copy), u12 (ref), u54 (ref), l__Rarities__15 (copy), l__Gradients__7 (copy), u53 (copy), u5 (ref), u2 (copy), u3 (copy), l__SoundController__22 (copy), u138 (copy), l__HoverInfoController__23 (copy), u6 (ref), l__Animals__16 (copy)
    for _, v146 in u11:GetChildren() do
        if v146.Name == "Template" then
            v146.Visible = false;
        end;
    end;
    u11.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    for _, u147 in u145() do
        local v148 = l__Animals__11[u147];
        local v149 = u12:Clone();
        v149.Name = u147;
        local v150;
        if u54 == "" then
            v150 = true;
        else
            local v151 = l__Animals__11[u147];
            local l__find__37 = string.find;
            local l__lower__38 = string.lower;
            local v152;
            if v151 then
                v152 = v151.DisplayName or u147;
            else
                v152 = u147;
            end;
            v150 = l__find__37(l__lower__38(v152), u54, 1, true) ~= nil;
        end;
        v149.Visible = v150;
        local l__NameLabel__39 = v149.NameLabel;
        local v153;
        if v148 then
            v153 = v148.DisplayName or u147;
        else
            v153 = u147;
        end;
        l__NameLabel__39.Text = v153;
        v149.RarityLabel.Text = v148 and (v148.Rarity or "") or "";
        if v149:FindFirstChild("MutationLabel") then
            v149.MutationLabel.Text = "";
        end;
        if v148 then
            v148 = l__Rarities__15[v148.Rarity];
        end;
        if v148 then
            if v148.GradientPreset then
                v149.RarityLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
                l__Gradients__7.apply(v149.RarityLabel, v148.GradientPreset);
            elseif v148.Color then
                v149.RarityLabel.TextColor3 = v148.Color;
            end;
            local v154 = v149.RarityLabel:FindFirstChildWhichIsA("UIStroke");
            if v154 and v148.StrokeColor then
                v154.Color = v148.StrokeColor;
            end;
        end;
        local l__ViewportFrame__40 = v149.ViewportFrame;
        local v155 = v149:FindFirstChildWhichIsA("UIStroke");
        u53[u147] = {
            Attached = nil,
            State = false,
            Card = v149,
            Viewport = l__ViewportFrame__40,
            BaseColor = v149.BackgroundColor3,
            BaseStroke = v155 and v155.Color or Color3.new(0, 0, 0)
        };
        local v156 = u53[u147];
        if v156 then
            local v157 = u147 == u5;
            local l__Card__41 = v156.Card;
            local v158;
            if v157 then
                v158 = u2;
            else
                v158 = v156.BaseColor;
            end;
            l__Card__41.BackgroundColor3 = v158;
            local v159 = v156.Card:FindFirstChildWhichIsA("UIStroke");
            if v159 then
                local v160;
                if v157 then
                    v160 = u3;
                else
                    v160 = v156.BaseStroke;
                end;
                v159.Color = v160;
            end;
        end;
        v149.Activated:Connect(function() --[[ Line: 636 ]]
            -- upvalues: l__SoundController__22 (ref), u147 (copy), u5 (ref), u53 (ref), u2 (ref), u3 (ref), u138 (ref)
            l__SoundController__22:PlaySound("Sounds.Sfx.Activated");
            local v161 = u147;
            if u5 == v161 then
            else
                local v162 = u5;
                u5 = v161;
                local v163 = v162 and u53[v162];
                if v163 then
                    local v164 = v162 == v161;
                    local l__Card__42 = v163.Card;
                    local v165;
                    if v164 then
                        v165 = u2;
                    else
                        v165 = v163.BaseColor;
                    end;
                    l__Card__42.BackgroundColor3 = v165;
                    local v166 = v163.Card:FindFirstChildWhichIsA("UIStroke");
                    if v166 then
                        local v167;
                        if v164 then
                            v167 = u3;
                        else
                            v167 = v163.BaseStroke;
                        end;
                        v166.Color = v167;
                    end;
                end;
                local v168 = u53[v161];
                if v168 then
                    local v169 = v161 == v161;
                    local l__Card__43 = v168.Card;
                    local v170;
                    if v169 then
                        v170 = u2;
                    else
                        v170 = v168.BaseColor;
                    end;
                    l__Card__43.BackgroundColor3 = v170;
                    local v171 = v168.Card:FindFirstChildWhichIsA("UIStroke");
                    if v171 then
                        local v172;
                        if v169 then
                            v172 = u3;
                        else
                            v172 = v168.BaseStroke;
                        end;
                        v171.Color = v172;
                        u138();
                    else
                        u138();
                    end;
                else
                    u138();
                end;
            end;
        end);
        l__HoverInfoController__23:Add(v149, function() --[[ Line: 688 ]]
            -- upvalues: u147 (copy), u6 (ref)
            return u147, u6 or "Default";
        end);
        v149.Parent = u11;
        u53[u147].Attached = l__Animals__16:AttachOnViewportWithOptimizations(u147, l__ViewportFrame__40, nil, nil);
        l__ViewportFrame__40.Parent = nil;
    end;
end;
local function u188() --[[ Line: 757 ]]
    -- upvalues: u19 (ref), l__Trove__6 (copy), u16 (ref), u15 (ref), u3 (copy), u6 (ref), l__SoundController__22 (copy), l__MutationText__20 (copy), u21 (ref), l__Index__13 (copy), l__Mutations__12 (copy), l__Index__17 (copy)
    if u19 then
        u19:Destroy();
    end;
    local u174 = l__Trove__6.new();
    u19 = u174;
    u16.Visible = false;
    u15.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    local function v181(p175, p176, p177, u178) --[[ Line: 765 ]]
        -- upvalues: u174 (copy), u16 (ref), u3 (ref), u6 (ref), l__SoundController__22 (ref), u15 (ref)
        local v179 = u174:Clone(u16);
        v179.Name = p175;
        v179.LayoutOrder = p176;
        v179.Visible = true;
        local l__Button__44 = v179.Button;
        if l__Button__44:FindFirstChild("Timer") then
            l__Button__44.Timer.Visible = false;
        end;
        p177(l__Button__44);
        local v180 = Instance.new("UIStroke");
        v180.Name = "SelectionStroke";
        v180.Thickness = 2.5;
        v180.Color = u3;
        v180.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        v180.Enabled = p175 == (u6 or "Default");
        v180.Parent = l__Button__44;
        u174:Add(l__Button__44.Activated:Connect(function() --[[ Line: 782 ]]
            -- upvalues: l__SoundController__22 (ref), u178 (copy)
            l__SoundController__22:PlaySound("Sounds.Sfx.Activated");
            u178();
        end));
        v179.Parent = u15;
    end;
    v181("Default", -1, function(p182) --[[ Line: 788 ]]
        -- upvalues: l__MutationText__20 (ref)
        if l__MutationText__20 and l__MutationText__20.clear then
            l__MutationText__20.clear(p182.TextLabel);
        end;
        p182.TextLabel.RichText = false;
        p182.TextLabel.Text = "Normal";
        p182.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
        if p182:FindFirstChild("ImageLabel") then
            p182.ImageLabel.Image = "rbxassetid://139326264265904";
        end;
    end, function() --[[ Line: 799 ]]
        -- upvalues: u21 (ref)
        u21(nil);
    end);
    for u183, v184 in l__Index__13 do
        if l__Mutations__12[u183] and (l__Index__17:CanProgressIndex(u183) and not (v184.DisableIndex or v184.HideButton)) then
            local v185 = l__Index__17:GetIndexLimitedTime(u183) or v184.LimitedMutation;
            local v186;
            if v185 then
                v186 = 2000000000 - v185;
            else
                v186 = v184.Order or 1;
            end;
            v181(u183, v186, function(p187) --[[ Line: 805 ]]
                -- upvalues: l__MutationText__20 (ref), u183 (copy), l__Mutations__12 (ref)
                if l__MutationText__20 and l__MutationText__20.apply then
                    l__MutationText__20.apply(p187.TextLabel, u183, "Auto");
                else
                    p187.TextLabel.Text = u183;
                end;
                if p187:FindFirstChild("ImageLabel") then
                    p187.ImageLabel.Image = l__Mutations__12[u183].Icon or "rbxassetid://139326264265904";
                end;
            end, function() --[[ Line: 815 ]]
                -- upvalues: u21 (ref), u183 (copy)
                u21(u183);
            end);
        end;
    end;
end;
local function u198() --[[ Line: 822 ]]
    -- upvalues: u20 (ref), l__Trove__6 (copy), u18 (ref), u17 (ref), l__Traits__14 (copy), l__MutationText__20 (copy), u7 (copy), u3 (copy), l__SoundController__22 (copy), u22 (ref)
    if u20 then
        u20:Destroy();
    end;
    local v189 = l__Trove__6.new();
    u20 = v189;
    u18.Visible = false;
    u17.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    local v190 = {};
    for v191 in l__Traits__14 do
        table.insert(v190, v191);
    end;
    table.sort(v190);
    for v192, u193 in v190 do
        local v194 = l__Traits__14[u193];
        local v195 = v189:Clone(u18);
        v195.Name = u193;
        v195.LayoutOrder = v192;
        v195.Visible = true;
        local l__Button__45 = v195.Button;
        if l__MutationText__20 and l__MutationText__20.clear then
            l__MutationText__20.clear(l__Button__45.TextLabel);
        end;
        l__Button__45.TextLabel.RichText = false;
        l__Button__45.TextLabel.Text = v194.Display or u193;
        l__Button__45.TextLabel.TextColor3 = v194.Color or Color3.fromRGB(255, 255, 255);
        if l__Button__45:FindFirstChild("ImageLabel") then
            l__Button__45.ImageLabel.Image = v194.Icon;
        end;
        if l__Button__45:FindFirstChild("Timer") then
            l__Button__45.Timer.Visible = false;
        end;
        local v196 = u7[u193] == true;
        local v197 = Instance.new("UIStroke");
        v197.Name = "SelectionStroke";
        v197.Thickness = 2.5;
        v197.Color = u3;
        v197.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        v197.Enabled = v196;
        v197.Parent = l__Button__45;
        v189:Add(l__Button__45.Activated:Connect(function() --[[ Line: 862 ]]
            -- upvalues: l__SoundController__22 (ref), u22 (ref), u193 (copy)
            l__SoundController__22:PlaySound("Sounds.Sfx.Activated");
            u22(u193);
        end));
        v195.Parent = u17;
    end;
end;
u22 = function(p199) --[[ Line: 870 ]]
    -- upvalues: u7 (copy), u17 (ref), u79 (copy), u101 (copy)
    if u7[p199] then
        u7[p199] = nil;
    else
        u7[p199] = true;
    end;
    local v200 = u17:FindFirstChild(p199);
    if v200 then
        v200 = v200:FindFirstChild("Button");
    end;
    if v200 then
        v200 = v200:FindFirstChild("SelectionStroke");
    end;
    if v200 then
        v200.Enabled = u7[p199] == true;
        u79();
        u101();
    else
        u79();
        u101();
    end;
end;
local function u204() --[[ Line: 893 ]]
    -- upvalues: u15 (ref), u6 (ref)
    if u15 then
        local v201 = u6 or "Default";
        for _, v202 in u15:GetChildren() do
            local v203 = v202:IsA("GuiObject");
            if v203 then
                v203 = v202:FindFirstChild("Button");
            end;
            if v203 then
                v203 = v203:FindFirstChild("SelectionStroke");
            end;
            if v203 and v203:IsA("UIStroke") then
                v203.Enabled = v202.Name == v201;
            end;
        end;
    end;
end;
u21 = function(p205) --[[ Line: 910 ]]
    -- upvalues: u6 (ref), u138 (copy), u204 (copy)
    if u6 ~= p205 then
        u6 = p205;
        u138();
    end;
    u204();
end;
local function u213(p206) --[[ Line: 953 ]]
    -- upvalues: u39 (copy), u52 (ref), u48 (copy), u51 (ref), u50 (copy), u49 (ref)
    local l__Position__46 = u39.Position;
    local l__Position__47 = p206.CFrame.Position;
    local v207 = l__Position__46 - l__Position__47;
    local l__Magnitude__48 = v207.Magnitude;
    local v208 = u52;
    table.clear(v208);
    if l__Magnitude__48 > 0.1 and #u48 > 0 then
        local l__Unit__49 = v207.Unit;
        if u51 then
            u50.FilterDescendantsInstances = u48;
            u51 = false;
        end;
        local v209 = 0;
        for _ = 1, 10 do
            local v210 = l__Magnitude__48 - v209;
            if v210 <= 0.1 then
                break;
            end;
            local v211 = workspace:Blockcast(CFrame.lookAt(l__Position__47 + l__Unit__49 * v209, l__Position__46), Vector3.new(5, 5, 1), l__Unit__49 * v210, u50);
            if not v211 then
                break;
            end;
            if v211.Instance and v211.Instance:IsA("BasePart") then
                v211.Instance.LocalTransparencyModifier = 0.75;
                v208[v211.Instance] = true;
            end;
            v209 = v209 + (v211.Distance + 0.2);
        end;
    end;
    for v212 in u49 do
        if not v208[v212] and v212.Parent then
            v212.LocalTransparencyModifier = 0;
        end;
    end;
    u52 = u49;
    u49 = v208;
end;
local function u227(p214) --[[ Line: 1004 ]]
    -- upvalues: u40 (ref), l__zero__31 (ref), l__UserInputService__5 (copy), u41 (ref), l__UserGameSettings__10 (copy), u42 (ref), u46 (ref), u43 (ref), u44 (ref), u33 (ref), u34 (ref), u35 (ref), l__zero__32 (ref)
    p214:Add(l__UserInputService__5.InputBegan:Connect(function(p215, p216) --[[ Line: 1016 ]]
        -- upvalues: u40 (ref), l__zero__31 (ref), l__UserInputService__5 (ref), u41 (ref), l__UserGameSettings__10 (ref), u42 (ref), u46 (ref), u43 (ref), u44 (ref)
        if p216 then
        else
            local l__UserInputType__50 = p215.UserInputType;
            if l__UserInputType__50 == Enum.UserInputType.MouseButton1 and true or l__UserInputType__50 == Enum.UserInputType.MouseButton2 then
                u40 = true;
                l__zero__31 = l__UserInputService__5:GetMouseLocation();
                u41 = 0.024 * l__UserGameSettings__10.MouseSensitivity;
                u42 = 1;
            elseif p215.UserInputType == Enum.UserInputType.Touch and u46 == nil then
                u40 = true;
                l__zero__31 = l__UserInputService__5:GetMouseLocation();
                u41 = 0.012;
                u42 = 0.55;
            elseif p215.KeyCode == Enum.KeyCode.ButtonR1 then
                u43 = 1;
            elseif p215.KeyCode == Enum.KeyCode.ButtonL1 then
                u43 = -1;
            elseif p215.KeyCode == Enum.KeyCode.E then
                u44 = 1;
            elseif p215.KeyCode == Enum.KeyCode.Q then
                u44 = -1;
            end;
        end;
    end));
    p214:Add(l__UserInputService__5.InputEnded:Connect(function(p217) --[[ Line: 1065 ]]
        -- upvalues: u40 (ref), u43 (ref), u44 (ref)
        local l__UserInputType__51 = p217.UserInputType;
        if l__UserInputType__51 == Enum.UserInputType.MouseButton1 and true or l__UserInputType__51 == Enum.UserInputType.MouseButton2 or p217.UserInputType == Enum.UserInputType.Touch then
            u40 = false;
        elseif p217.KeyCode == Enum.KeyCode.ButtonR1 and u43 == 1 then
            u43 = 0;
        elseif p217.KeyCode == Enum.KeyCode.ButtonL1 and u43 == -1 then
            u43 = 0;
        elseif p217.KeyCode == Enum.KeyCode.E and u44 == 1 then
            u44 = 0;
        elseif p217.KeyCode == Enum.KeyCode.Q and u44 == -1 then
            u44 = 0;
        end;
    end));
    p214:Add(l__UserInputService__5.InputChanged:Connect(function(p218, p219) --[[ Line: 1098 ]]
        -- upvalues: u33 (ref), u34 (ref), u35 (ref), l__zero__32 (ref)
        if p218.UserInputType == Enum.UserInputType.MouseWheel then
            if not p219 then
                u33 = math.clamp(u33 * (1 - p218.Position.Z * 0.12), u34, u35);
            end;
        else
            if p218.KeyCode ~= Enum.KeyCode.Thumbstick2 then
                return;
            end;
            local v220;
            if p219 then
                v220 = Vector2.zero;
            else
                local l__new__52 = Vector2.new;
                local l__X__53 = p218.Position.X;
                local v221;
                if math.abs(l__X__53) < 0.16 then
                    v221 = 0;
                else
                    local v222 = (math.abs(l__X__53) - 0.16) / 0.84;
                    v221 = (l__X__53 < 0 and -1 or 1) * v222 * v222;
                end;
                local l__Y__54 = p218.Position.Y;
                local v223;
                if math.abs(l__Y__54) < 0.16 then
                    v223 = 0;
                else
                    local v224 = (math.abs(l__Y__54) - 0.16) / 0.84;
                    v223 = (l__Y__54 < 0 and -1 or 1) * v224 * v224;
                end;
                v220 = l__new__52(v221, v223);
            end;
            l__zero__32 = v220;
        end;
    end));
    p214:Add(l__UserInputService__5.TouchPinch:Connect(function(_, p225, _, p226) --[[ Line: 1142 ]]
        -- upvalues: u40 (ref), u46 (ref), u33 (ref), u34 (ref), u35 (ref)
        u40 = false;
        if p226 == Enum.UserInputState.End or p226 == Enum.UserInputState.Cancel then
            u46 = nil;
        else
            if u46 and (u46 > 0 and p225 > 0) then
                u33 = math.clamp(u33 * (1 - (1 - u46 / p225) * 1), u34, u35);
            end;
            u46 = p225;
        end;
    end));
end;
function u4.Open(_) --[[ Line: 1159 ]]
    -- upvalues: u8 (ref), u9 (ref), u173 (copy), l__RunService__2 (copy), u11 (ref), u53 (copy), u69 (copy), u72 (copy), u10 (ref), l__LocalPlayer__28 (copy), u54 (ref), u13 (ref), u5 (ref), u6 (ref), u7 (copy), u2 (copy), u3 (copy), l__Animals__11 (copy), u188 (copy), u198 (copy), l__Trove__6 (copy), u23 (ref), u48 (copy), u49 (ref), u52 (ref), u51 (ref), l__identity__29 (ref), u1 (copy), l__ReplicatedStorage__1 (copy), l__zero__30 (ref), u33 (ref), u32 (ref), u36 (ref), u40 (ref), l__zero__32 (ref), u43 (ref), u44 (ref), u45 (ref), u46 (ref), u37 (copy), u38 (copy), u39 (copy), u47 (ref), u227 (copy), l__UserInputService__5 (copy), l__zero__31 (ref), u41 (ref), u42 (ref), l__UserGameSettings__10 (copy), u34 (ref), u35 (ref), u213 (copy), u138 (copy)
    if u8 then
    else
        u8 = true;
        if not u9 then
            u9 = true;
            u173();
            l__RunService__2.Heartbeat:Connect(function() --[[ Line: 1169 ]]
                -- upvalues: u8 (ref), u11 (ref), u53 (ref)
                if u8 then
                    local l__Y__55 = u11.AbsolutePosition.Y;
                    local v228 = l__Y__55 + u11.AbsoluteSize.Y;
                    local v229 = u11.AbsoluteSize.Y * 0.5;
                    for _, v230 in u53 do
                        local l__Card__56 = v230.Card;
                        local l__Visible__57 = l__Card__56.Visible;
                        if l__Visible__57 then
                            if l__Card__56.AbsoluteSize.Y > 0 and l__Y__55 - v229 <= l__Card__56.AbsolutePosition.Y + l__Card__56.AbsoluteSize.Y then
                                l__Visible__57 = l__Card__56.AbsolutePosition.Y <= v228 + v229;
                            else
                                l__Visible__57 = false;
                            end;
                        end;
                        if v230.State ~= l__Visible__57 and v230.State ~= l__Visible__57 then
                            v230.State = l__Visible__57;
                            local l__Viewport__58 = v230.Viewport;
                            local v231;
                            if l__Visible__57 then
                                v231 = v230.Card;
                            else
                                v231 = nil;
                            end;
                            l__Viewport__58.Parent = v231;
                        end;
                    end;
                end;
            end);
        end;
        u69(true);
        u72();
        u10.Enabled = true;
        for _, v232 in l__LocalPlayer__28.PlayerGui:GetChildren() do
            if v232:IsA("ScreenGui") and v232.Name == "HoverInfo" then
                v232.DisplayOrder = 9999;
            end;
        end;
        u54 = "";
        if u13 then
            u13.Text = "";
        end;
        u5 = "Noobini Pizzanini";
        u6 = nil;
        table.clear(u7);
        for v242, v234 in u53 do
            local v235 = u53[v242];
            if v235 then
                local v236 = v242 == u5;
                local l__Card__59 = v235.Card;
                local v237;
                if v236 then
                    v237 = u2;
                else
                    v237 = v235.BaseColor;
                end;
                l__Card__59.BackgroundColor3 = v237;
                local v238 = v235.Card:FindFirstChildWhichIsA("UIStroke");
                if v238 then
                    local v239;
                    if v236 then
                        v239 = u3;
                    else
                        v239 = v235.BaseStroke;
                    end;
                    v238.Color = v239;
                end;
            end;
            local v240;
            if u54 == "" then
                v240 = true;
            else
                local v241 = l__Animals__11[v242];
                local l__find__60 = string.find;
                local l__lower__61 = string.lower;
                if v241 then
                    local v242 = v241.DisplayName or v242;
                end;
                v240 = l__find__60(l__lower__61(v242), u54, 1, true) ~= nil;
            end;
            v234.Card.Visible = v240;
        end;
        u188();
        u198();
        l__LocalPlayer__28:SetAttribute("FreezeLocalMovement", true);
        l__LocalPlayer__28:Move(Vector3.new(0, 0, 0));
        local l__CurrentCamera__62 = workspace.CurrentCamera;
        l__CurrentCamera__62.CameraType = Enum.CameraType.Scriptable;
        l__CurrentCamera__62.FieldOfView = 38;
        local v243 = l__Trove__6.new();
        u23 = v243;
        table.clear(u48);
        table.clear(u49);
        table.clear(u52);
        u51 = true;
        l__identity__29 = u1;
        local v244 = l__ReplicatedStorage__1:FindFirstChild("GlossaryBackground");
        if v244 then
            local v245 = v243:Clone(v244);
            for _, v246 in v245:GetDescendants() do
                if v246:IsA("BasePart") then
                    v246.Anchored = true;
                    v246.CanCollide = false;
                    v246.CanQuery = true;
                    v246.CanTouch = false;
                end;
            end;
            if v245:IsA("Model") then
                v245:PivotTo(u1);
            end;
            v245.Parent = workspace;
            table.insert(u48, v245);
        end;
        local l__LookVector__63 = u1.LookVector;
        l__zero__30 = Vector2.new(math.atan2(l__LookVector__63.X, l__LookVector__63.Z), 0.12);
        u33 = 16;
        u32 = u1.Position + Vector3.new(0, 3, 0);
        u36 = nil;
        u40 = false;
        l__zero__32 = Vector2.zero;
        u43 = 0;
        u44 = 0;
        u45 = 0;
        u46 = nil;
        u37:SetTarget(l__zero__30, true);
        u38:SetTarget(u33, true);
        u39:SetTarget(u32, true);
        local l__Position__64 = u37.Position;
        local l__Position__65 = u38.Position;
        local l__Position__66 = u39.Position;
        local v247 = math.cos(l__Position__64.Y);
        local l__lookAt__67 = CFrame.lookAt;
        local v248 = math.sin(l__Position__64.X) * v247;
        local v249 = math.sin(l__Position__64.Y);
        local v250 = math.cos(l__Position__64.X) * v247;
        l__CurrentCamera__62.CFrame = l__lookAt__67(l__Position__66 + Vector3.new(v248, v249, v250) * l__Position__65, l__Position__66);
        if u47 then
            u47.Enabled = false;
        end;
        u227(v243);
        v243:Add(l__RunService__2.PreRender:Connect(function(p251) --[[ Line: 1305 ]]
            -- upvalues: u40 (ref), l__UserInputService__5 (ref), l__zero__31 (ref), l__zero__30 (ref), u41 (ref), u42 (ref), l__UserGameSettings__10 (ref), l__zero__32 (ref), u43 (ref), u33 (ref), u34 (ref), u35 (ref), u44 (ref), u45 (ref), u37 (ref), u38 (ref), u39 (ref), u32 (ref), u213 (ref)
            if u40 then
                local v252 = l__UserInputService__5:GetMouseLocation();
                local v253 = v252 - l__zero__31;
                l__zero__31 = v252;
                local l__new__68 = Vector2.new;
                local v254 = l__zero__30.X - v253.X * u41;
                local v255 = l__zero__30.Y - v253.Y * u41 * u42 * l__UserGameSettings__10:GetCameraYInvertValue();
                l__zero__30 = l__new__68(v254, (math.clamp(v255, -1.35, 1.35)));
            end;
            if l__zero__32.X ~= 0 or l__zero__32.Y ~= 0 then
                local v256 = 4 * l__UserGameSettings__10.GamepadCameraSensitivity * p251;
                l__zero__30 = Vector2.new(l__zero__30.X - l__zero__32.X * v256, (math.clamp(l__zero__30.Y - -l__zero__32.Y * v256, -1.35, 1.35)));
            end;
            if u43 ~= 0 then
                u33 = math.clamp(u33 * (1 - u43 * 1.4 * p251), u34, u35);
            end;
            if u44 ~= 0 then
                u45 = math.clamp(u45 + u44 * 16 * p251, -5, 5);
            end;
            u37.Target = l__zero__30;
            u38.Target = u33;
            u39.Target = u32 + Vector3.new(0, u45, 0);
            local l__CurrentCamera__69 = workspace.CurrentCamera;
            if l__CurrentCamera__69 then
                local l__Position__70 = u37.Position;
                local l__Position__71 = u39.Position;
                local v257 = math.cos(l__Position__70.Y);
                local l__lookAt__72 = CFrame.lookAt;
                local v258 = math.sin(l__Position__70.X) * v257;
                local v259 = math.sin(l__Position__70.Y);
                local v260 = math.cos(l__Position__70.X) * v257;
                l__CurrentCamera__69.CFrame = l__lookAt__72(l__Position__71 + Vector3.new(v258, v259, v260) * u38.Position, l__Position__71);
                u213(l__CurrentCamera__69);
            end;
        end));
        u138();
        task.wait(0.1);
        u69(false);
    end;
end;
function u4.Close(_) --[[ Line: 1349 ]]
    -- upvalues: u8 (ref), u69 (copy), u10 (ref), l__LocalPlayer__28 (copy), u19 (ref), u20 (ref), u53 (copy), u25 (ref), u24 (ref), u26 (ref), u27 (ref), u48 (copy), u49 (ref), u52 (ref), u51 (ref), u23 (ref), u47 (ref), u55 (copy)
    if u8 then
        u8 = false;
        u69(true);
        u10.Enabled = false;
        for _, v261 in l__LocalPlayer__28.PlayerGui:GetChildren() do
            if v261:IsA("ScreenGui") and v261.Name == "HoverInfo" then
                v261.DisplayOrder = 0;
            end;
        end;
        if u19 then
            u19:Destroy();
            u19 = nil;
        end;
        if u20 then
            u20:Destroy();
            u20 = nil;
        end;
        for _, v262 in u53 do
            if v262.State ~= false then
                v262.State = false;
                v262.Viewport.Parent = nil;
            end;
        end;
        if u25 then
            u25:Destroy();
            u25 = nil;
        end;
        if u24 then
            u24:Destroy();
            u24 = nil;
        end;
        u26 = nil;
        u27 = nil;
        table.clear(u48);
        table.clear(u49);
        table.clear(u52);
        u51 = true;
        if u23 then
            u23:Destroy();
            u23 = nil;
        end;
        local l__CurrentCamera__73 = workspace.CurrentCamera;
        if l__CurrentCamera__73 then
            l__CurrentCamera__73.CameraType = Enum.CameraType.Custom;
            local l__Character__74 = l__LocalPlayer__28.Character;
            if l__Character__74 then
                l__CurrentCamera__73.CameraSubject = l__Character__74:FindFirstChildWhichIsA("Humanoid");
            end;
            l__CurrentCamera__73.FieldOfView = 70;
        end;
        l__LocalPlayer__28:SetAttribute("FreezeLocalMovement", false);
        if u47 then
            u47.Enabled = true;
        end;
        for _, v263 in u55 do
            if v263 and v263.Parent then
                v263.Enabled = true;
            end;
        end;
        table.clear(u55);
        task.wait(0.05);
        u69(false);
    end;
end;
function u4.Start(_) --[[ Line: 1433 ]]
    -- upvalues: u10 (ref), l__LocalPlayer__28 (copy), u13 (ref), u14 (ref), u11 (ref), u12 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), l__SoundController__22 (copy), u4 (copy), u54 (ref), u53 (copy), l__Animals__11 (copy), u47 (ref), u8 (ref)
    u10 = l__LocalPlayer__28:WaitForChild("PlayerGui"):WaitForChild("Glossary", 30);
    if u10 then
        u10.Enabled = false;
        local l__Left = u10:WaitForChild("Left");
        l__Left.Visible = true;
        local l__Main__75 = l__Left:WaitForChild("Main");
        local l__Header__76 = l__Main__75:WaitForChild("Header");
        u13 = l__Header__76.SearchFrame.SearchBox;
        u14 = l__Header__76.Close;
        u11 = l__Main__75.Content.Holder.List;
        u12 = u11.Template;
        local l__Right__77 = u10:WaitForChild("Right");
        local l__Mutations__78 = l__Right__77:WaitForChild("Mutations");
        local l__Traits__79 = l__Right__77:WaitForChild("Traits");
        u15 = l__Mutations__78.Content.Holder.Mutations;
        u16 = u15.Template;
        u17 = l__Traits__79.Content.Holder.Mutations;
        u18 = u17.Template;
        l__Mutations__78.Header.Txt1.Text = "Mutations";
        l__Traits__79.Header.Txt1.Text = "Traits";
        l__Right__77.Visible = true;
        l__Mutations__78.Visible = true;
        l__Traits__79.Visible = true;
        u14.Activated:Connect(function() --[[ Line: 1460 ]]
            -- upvalues: l__SoundController__22 (ref), u4 (ref)
            l__SoundController__22:PlaySound("Sounds.Sfx.Activated");
            u4:Close();
        end);
        u13:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 1464 ]]
            -- upvalues: u54 (ref), u13 (ref), u53 (ref), l__Animals__11 (ref)
            u54 = string.lower(u13.Text);
            for v268, v265 in u53 do
                local v266;
                if u54 == "" then
                    v266 = true;
                else
                    local v267 = l__Animals__11[v268];
                    local l__find__80 = string.find;
                    local l__lower__81 = string.lower;
                    if v267 then
                        local v268 = v267.DisplayName or v268;
                    end;
                    v266 = l__find__80(l__lower__81(v268), u54, 1, true) ~= nil;
                end;
                v265.Card.Visible = v266;
            end;
        end);
        -- Connect to server remote events for opening/closing glossary
        Net:RemoteEvent("GlossaryService/Open").OnClientEvent:Connect(function()
            u4:Open();
        end);
        Net:RemoteEvent("GlossaryService/Close").OnClientEvent:Connect(function()
            u4:Close();
        end);
    else
        warn("[GlossaryController] PlayerGui.Glossary not found");
    end;
    task.spawn(function() --[[ Line: 1486 ]]
        -- upvalues: u47 (ref), u8 (ref), u4 (ref)
        local v269 = workspace:WaitForChild("Glossary", 60);
        if v269 then
            local l__Animated__83 = v269:WaitForChild("Animated", 60);
            local v270 = l__Animated__83 and l__Animated__83:WaitForChild("RootPart", 60);
            if v270 then
                local v271 = v270:FindFirstChildOfClass("ProximityPrompt");
                if not v271 then
                    v271 = Instance.new("ProximityPrompt");
                    v271.Name = "GlossaryPrompt";
                    v271.Parent = v270;
                end;
                v271.ActionText = "Open";
                v271.ObjectText = "Brainrot Glossary";
                v271.KeyboardKeyCode = Enum.KeyCode.E;
                v271.Style = Enum.ProximityPromptStyle.Custom;
                v271.HoldDuration = 0;
                v271.RequiresLineOfSight = false;
                v271.MaxActivationDistance = 12;
                u47 = v271;
                local toggleDebounce = false;
                v271.Triggered:Connect(function() --[[ Line: 1505 ]]
                    -- upvalues: u8 (ref), u4 (ref)
                    if toggleDebounce then return end;
                    toggleDebounce = true;
                    if u8 then
                        u4:Close();
                    else
                        u4:Open();
                    end;
                    task.wait(0.5);
                    toggleDebounce = false;
                end);
            end;
        end;
    end);
end;
return u4;