-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local l_Debris_0 = game:GetService("Debris");
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ServerScriptService_0 = game:GetService("ServerScriptService");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v5 = require(l_Packages_0.Net);
local v6 = require(l_Packages_0.Debounce);
local v7 = require(l_ReplicatedStorage_0.Packages.FFlags);
local v8 = {};
local v9 = 0;
l_RunService_0.Heartbeat:Connect(function(v10) --[[ Line: 18 ]]
    -- upvalues: v9 (ref), v8 (copy)
    debug.profilebegin("Items:UpdateHUE");
    v9 = v9 + v10 * 0.2;
    if v9 > 1 then
        v9 = v9 - 1;
    end;
    local v11 = Color3.fromHSV(v9, 1, 1);
    for _, v13 in v8 do
        if v13 and v13.Parent then
            v13.FillColor = v11;
        end;
    end;
    debug.profileend();
end);
local v14 = nil;
local v15 = nil;
local v16 = nil;
local v17 = nil;
if l_RunService_0:IsServer() then
    local l_Services_0 = l_ServerScriptService_0.Services;
    v17 = require(l_Services_0.StealService);
    local l_ToolsCode_0 = l_ServerScriptService_0.ToolsCode;
    v14 = l_ToolsCode_0.AdditionalItems;
    v15 = l_ToolsCode_0.AdditionalScripts;
    v16 = l_ToolsCode_0.AdditionalSounds;
end;
return {
    Slap = {
        Name = "Slap", 
        Icon = "rbxassetid://111744314864127", 
        Cooldown = 0.7, 
        Force = 550, 
        RagdollDuration = 3
    }, 
    ["Iron Slap"] = {
        Name = "Iron Slap", 
        Icon = "rbxassetid://126416331206871", 
        Cooldown = 0.7, 
        Force = 600, 
        RagdollDuration = 3
    }, 
    ["Gold Slap"] = {
        Name = "Gold Slap", 
        Icon = "rbxassetid://73587459668895", 
        Cooldown = 0.7, 
        Force = 650, 
        RagdollDuration = 3
    }, 
    ["Diamond Slap"] = {
        Name = "Diamond Slap", 
        Icon = "rbxassetid://103400414014905", 
        Cooldown = 0.7, 
        Force = 700, 
        RagdollDuration = 3
    }, 
    ["Emerald Slap"] = {
        Name = "Emerald Slap", 
        Icon = "rbxassetid://125486072175077", 
        Cooldown = 0.7, 
        Force = 750, 
        RagdollDuration = 3
    }, 
    ["Ruby Slap"] = {
        Name = "Ruby Slap", 
        Icon = "rbxassetid://135484448648993", 
        Cooldown = 0.7, 
        Force = 800, 
        RagdollDuration = 3
    }, 
    ["Blackhole Slap"] = {
        Name = "Blackhole Slap", 
        Icon = "rbxassetid://105133618369836", 
        Cooldown = 0.7, 
        Force = 850, 
        RagdollDuration = 3, 
        HasHighlight = true, 
        HighlightConfig = {
            FillColor = Color3.fromRGB(255, 0, 0), 
            FillTransparency = 0.5
        }
    }, 
    ["Flame Slap"] = {
        Name = "Flame Slap", 
        Icon = "rbxassetid://107751993012682", 
        Cooldown = 0.7, 
        Force = 850, 
        RagdollDuration = 3, 
        HasHighlight = true, 
        HighlightConfig = {
            OutlineColor = Color3.fromRGB(), 
            OutlineTransparency = 0
        }
    }, 
    ["Dark Matter Slap"] = {
        Name = "Dark Matter Slap", 
        Icon = "rbxassetid://116359699709899", 
        Cooldown = 0.7, 
        Force = 900, 
        RagdollDuration = 3, 
        HasHighlight = true, 
        HighlightConfig = {
            FillTransparency = 0.9, 
            OutlineTransparency = 0
        }
    }, 
    ["Nuclear Slap"] = {
        Name = "Nuclear Slap", 
        Icon = "rbxassetid://94800671695541", 
        Cooldown = 0.7, 
        Force = 950, 
        RagdollDuration = 3, 
        HasHighlight = true, 
        HighlightConfig = {
            OutlineColor = Color3.fromRGB(234, 255, 0), 
            OutilineTransparency = 0
        }
    }, 
	["Radioactive Slap"] = {
		Name = "Radioactive Slap";
		Icon = "rbxassetid://94800671695541";
		Cooldown = 0.7;
		Force = 1000;
		RagdollDuration = 3;
		HasHighlight = true;
		HighlightConfig = {
			OutlineColor = Color3.fromRGB(85, 255, 0);
			OutilineTransparency = 0;
		}
	},
    ["Galaxy Slap"] = {
        Name = "Galaxy Slap", 
        Icon = "rbxassetid://79582982176990", 
        Cooldown = 0.7, 
        Force = 1050, 
        RagdollDuration = 3, 
        HasHighlight = true
    }, 
    ["Bloodmoon Slap"] = {
        Name = "Bloodmoon Slap", 
        Icon = "rbxassetid://105241258528205", 
        Cooldown = 0.7, 
        Force = 1050, 
        RagdollDuration = 3, 
        HasHighlight = true, 
        HighlightConfig = {
            FillTransparency = 0.9, 
            OutlineTransparency = 0
        }
    }, 
    ["Glitched Slap"] = {
        Name = "Glitched Slap", 
        Icon = "rbxassetid://87821905406599", 
        Cooldown = 0.7, 
        Force = 1150, 
        RagdollDuration = 3, 
        HasHighlight = true
    }, 
    ["Rainbow Slap"] = {
        Name = "Rainbow Slap", 
        Icon = "rbxassetid://76888105480836", 
        Cooldown = 0.7, 
        Force = 1150, 
        RagdollDuration = 3, 
        HasHighlight = true
    }, 
    ["Candy Slap"] = {
        Name = "Candy Slap", 
        Icon = "rbxassetid://116411677446062", 
        Cooldown = 0.7, 
        Force = 1200, 
        RagdollDuration = 3, 
        HasHighlight = true
    }, 
    ["Lava Slap"] = {
        Name = "Lava Slap", 
        Icon = "rbxassetid://80560167115825", 
        Cooldown = 0.7, 
        Force = 1200, 
        RagdollDuration = 3, 
        HasHighlight = true
    }, 
    ["Splatter Slap"] = {
        Name = "Splatter Slap", 
        Icon = "rbxassetid://88294870214352", 
        Cooldown = 0.7, 
        Force = 1200, 
        RagdollDuration = 3, 
        HasHighlight = true, 
        OnHit = function(v20) --[[ Line: 241 ]] --[[ Name: OnHit ]]
            -- upvalues: l_RunService_0 (copy), v5 (copy)
            if l_RunService_0:IsServer() then
                v5:RemoteEvent("UseItem"):FireClient(v20, "PaintballHitted", 9);
            end;
        end
    }, 
    ["Alien Slap"] = {
        Name = "Alien Slap", 
        Icon = "rbxassetid://89070555394271", 
        Cooldown = 0.7, 
        Force = 1250, 
        RagdollDuration = 5, 
        HasHighlight = true, 
        OnHit = function(v21, v22) --[[ Line: 255 ]] --[[ Name: OnHit ]]
            -- upvalues: v16 (ref)
            local l_AlienSlap_0 = script:FindFirstChild("AlienSlap");
            if not l_AlienSlap_0 then
                return;
            else
                local l_HumanoidRootPart_0 = v22:FindFirstChild("HumanoidRootPart");
                local v25 = l_HumanoidRootPart_0 and l_HumanoidRootPart_0:FindFirstChild("RootAttachment");
                local l_Humanoid_0 = v22:FindFirstChildOfClass("Humanoid");
                if not l_HumanoidRootPart_0 or not l_Humanoid_0 or not v25 then
                    return;
                else
                    task.wait(1);
                    local function v31(v27) --[[ Line: 277 ]] --[[ Name: GetGround ]]
                        -- upvalues: v22 (copy)
                        local v28 = RaycastParams.new();
                        v28.FilterType = Enum.RaycastFilterType.Exclude;
                        v28.FilterDescendantsInstances = {
                            v22
                        };
                        local v29 = v27 + Vector3.new(0, 3, 0, 0);
                        local v30 = workspace:Raycast(v29, Vector3.new(0, -20, 0, 0), v28);
                        if v30 then
                            return v30.Position;
                        else
                            return v27 - Vector3.new(0, 3, 0, 0);
                        end;
                    end;
                    local function _() --[[ Line: 293 ]] --[[ Name: IsOnGround ]]
                        -- upvalues: l_HumanoidRootPart_0 (copy)
                        return math.abs(l_HumanoidRootPart_0.AssemblyLinearVelocity.Y) < 1.5;
                    end;
                    local function _() --[[ Line: 297 ]] --[[ Name: IsStandingStill ]]
                        -- upvalues: l_HumanoidRootPart_0 (copy)
                        local l_AssemblyLinearVelocity_0 = l_HumanoidRootPart_0.AssemblyLinearVelocity;
                        local l_Magnitude_0 = Vector3.new(l_AssemblyLinearVelocity_0.X, 0, l_AssemblyLinearVelocity_0.Z).Magnitude;
                        local v35 = false;
                        if l_Magnitude_0 < 1 then
                            v35 = math.abs(l_HumanoidRootPart_0.AssemblyLinearVelocity.Y) < 1.5;
                        end;
                        return v35;
                    end;
                    local v37 = 0;
                    local v38 = os.clock();
                    while os.clock() - v38 < 5 do
                        if math.abs(l_HumanoidRootPart_0.AssemblyLinearVelocity.Y) < 1.5 then
                            local l_AssemblyLinearVelocity_1 = l_HumanoidRootPart_0.AssemblyLinearVelocity;
                            local l_Magnitude_1 = Vector3.new(l_AssemblyLinearVelocity_1.X, 0, l_AssemblyLinearVelocity_1.Z).Magnitude;
                            local v41 = false;
                            if l_Magnitude_1 < 1 then
                                v41 = math.abs(l_HumanoidRootPart_0.AssemblyLinearVelocity.Y) < 1.5;
                            end;
                            if v41 then
                                v37 = v37 + task.wait(0.05);
                                if v37 < 0.3 then
                                    continue;
                                else
                                    break;
                                end;
                            end;
                        end;
                        v37 = 0;
                        task.wait(0.05);
                    end;
                    if v37 < 0.3 then
                        return;
                    else
                        local v42 = {};
                        for v43 = 1, 4 do
                            local v44 = v43 / 4 * 3.141592653589793 * 2;
                            local v45 = Vector3.new(math.cos(v44), 0, (math.sin(v44))) * 5;
                            local v46 = v31(l_HumanoidRootPart_0.Position + v45);
                            local l_florPart_0 = l_AlienSlap_0:FindFirstChild("florPart");
                            if l_florPart_0 then
                                local v48 = l_florPart_0:Clone();
                                v48.Anchored = true;
                                v48.CFrame = CFrame.new(v46);
                                v48.Parent = workspace;
                                table.insert(v42, v48);
                            end;
                        end;
                        local _ = v31(l_HumanoidRootPart_0.Position);
                        local l_Part_0 = l_AlienSlap_0:FindFirstChild("Part");
                        local v51 = nil;
                        if l_Part_0 then
                            v51 = l_Part_0["002"]:Clone();
                            v51.WorldCFrame = v25.WorldCFrame;
                            v51.CFrame = v25.CFrame;
                            v51.Parent = v25;
                            for _, v53 in v42 do
                                for _, v55 in v53["001"]:GetChildren() do
                                    if v55:IsA("Beam") then
                                        v55.Attachment0 = v53["001"];
                                        v55.Attachment1 = v51;
                                    end;
                                end;
                            end;
                        end;
                        local v56 = v16["Alien slap"]:Clone();
                        v56.Parent = l_HumanoidRootPart_0;
                        v56:Play();
                        v21:SetAttribute("Freeze", true);
                        task.delay(3, function() --[[ Line: 364 ]]
                            -- upvalues: v51 (ref), v42 (copy), v21 (copy)
                            if v51 and v51.Parent then
                                v51:Destroy();
                            end;
                            for _, v58 in v42 do
                                if v58 and v58.Parent then
                                    v58:Destroy();
                                end;
                            end;
                            v21:SetAttribute("Freeze", false);
                        end);
                        return;
                    end;
                end;
            end;
        end
    }, 
    ["Yin Yang Slap"] = {
        Name = "Yin Yang Slap", 
        Icon = "rbxassetid://72523518394942", 
        Cooldown = 0.7, 
        Force = 1260, 
        RagdollDuration = 6, 
        HasHighlight = true, 
        HighlightConfig = {
            FillTransparency = 1, 
            OutlineTransparency = 0, 
            OutlineColor = Color3.fromRGB(255, 0, 0)
        }, 
        OnHit = function(_, v60) --[[ Line: 390 ]] --[[ Name: OnHit ]]
            -- upvalues: l_Debris_0 (copy)
            local l_YinYangSlap_0 = script.YinYangSlap;
            local l_HumanoidRootPart_1 = v60:FindFirstChild("HumanoidRootPart");
            local v63 = l_HumanoidRootPart_1 and l_HumanoidRootPart_1:FindFirstChild("RootAttachment");
            local l_Humanoid_1 = v60:FindFirstChildOfClass("Humanoid");
            if not l_HumanoidRootPart_1 or not l_Humanoid_1 or not v63 then
                return;
            else
                local function _(v65) --[[ Line: 404 ]] --[[ Name: isColorable ]]
                    if v65:IsA("Accessory") or v65:IsA("Tool") then
                        return false;
                    elseif v65:IsA("BasePart") and v65.Name ~= "HumanoidRootPart" then
                        return true;
                    else
                        return false;
                    end;
                end;
                local function v71(v67) --[[ Line: 414 ]] --[[ Name: GetGround ]]
                    -- upvalues: v60 (copy)
                    local v68 = RaycastParams.new();
                    v68.FilterType = Enum.RaycastFilterType.Exclude;
                    v68.FilterDescendantsInstances = {
                        v60
                    };
                    local v69 = v67 + Vector3.new(0, 3, 0, 0);
                    local v70 = workspace:Raycast(v69, Vector3.new(0, -20, 0, 0), v68);
                    if v70 then
                        return v70.Position;
                    else
                        return v67 - Vector3.new(0, 3, 0, 0);
                    end;
                end;
                local function _() --[[ Line: 430 ]] --[[ Name: IsOnGround ]]
                    -- upvalues: l_HumanoidRootPart_1 (copy)
                    return math.abs(l_HumanoidRootPart_1.AssemblyLinearVelocity.Y) < 1.5;
                end;
                local function _() --[[ Line: 434 ]] --[[ Name: IsStandingStill ]]
                    -- upvalues: l_HumanoidRootPart_1 (copy)
                    local l_AssemblyLinearVelocity_2 = l_HumanoidRootPart_1.AssemblyLinearVelocity;
                    local l_Magnitude_2 = Vector3.new(l_AssemblyLinearVelocity_2.X, 0, l_AssemblyLinearVelocity_2.Z).Magnitude;
                    local v75 = false;
                    if l_Magnitude_2 < 1 then
                        v75 = math.abs(l_HumanoidRootPart_1.AssemblyLinearVelocity.Y) < 1.5;
                    end;
                    return v75;
                end;
                task.wait(1);
                local l_Shirt_0 = v60:FindFirstChildOfClass("Shirt");
                if l_Shirt_0 then
                    l_Shirt_0.Parent = nil;
                end;
                local l_Pants_0 = v60:FindFirstChildOfClass("Pants");
                if l_Pants_0 then
                    l_Pants_0.Parent = nil;
                end;
                local v79 = {};
                local v80 = {};
                for _, v82 in v60:GetChildren() do
                    if not v82:IsA("Accessory") and not v82:IsA("Tool") and if v82:IsA("BasePart") then v82.Name ~= "HumanoidRootPart" else false then
                        table.insert(v79, v82);
                        table.insert(v80, {
                            part = v82, 
                            color = v82.Color
                        });
                    end;
                end;
                for _, v84 in v79 do
                    v84.Color = math.random(1, 2) == 1 and Color3.fromRGB() or Color3.fromRGB(255, 255, 255);
                end;
                local l_Head_0 = v60:FindFirstChild("Head");
                if l_Head_0 then
                    local v86 = l_YinYangSlap_0.SleepVFX.SLEEPY_VFX_ATTACHMENT:Clone();
                    v86.Parent = l_Head_0;
                    l_Debris_0:AddItem(v86, 6);
                end;
                local v87 = 0;
                local v88 = os.clock();
                while os.clock() - v88 < 5 do
                    if math.abs(l_HumanoidRootPart_1.AssemblyLinearVelocity.Y) < 1.5 then
                        local l_AssemblyLinearVelocity_3 = l_HumanoidRootPart_1.AssemblyLinearVelocity;
                        local l_Magnitude_3 = Vector3.new(l_AssemblyLinearVelocity_3.X, 0, l_AssemblyLinearVelocity_3.Z).Magnitude;
                        local v91 = false;
                        if l_Magnitude_3 < 1 then
                            v91 = math.abs(l_HumanoidRootPart_1.AssemblyLinearVelocity.Y) < 1.5;
                        end;
                        if v91 then
                            v87 = v87 + task.wait(0.05);
                            if v87 < 0.3 then
                                continue;
                            else
                                break;
                            end;
                        end;
                    end;
                    v87 = 0;
                    task.wait(0.05);
                end;
                if v87 < 0.3 then
                    return;
                else
                    local v92 = v71(l_HumanoidRootPart_1.Position);
                    local l_yinyang_0 = l_YinYangSlap_0:FindFirstChild("yinyang");
                    if l_yinyang_0 then
                        local v94 = l_yinyang_0:Clone();
                        v94.CFrame = CFrame.new(v92);
                        v94.Parent = workspace;
                        l_Debris_0:AddItem(v94, 4);
                    end;
                    task.delay(4, function() --[[ Line: 499 ]]
                        -- upvalues: v80 (copy), l_Shirt_0 (copy), v60 (copy), l_Pants_0 (copy)
                        for _, v96 in v80 do
                            if v96.part and v96.part.Parent then
                                v96.part.Color = v96.color;
                            end;
                        end;
                        if l_Shirt_0 then
                            l_Shirt_0.Parent = v60;
                        end;
                        if l_Pants_0 then
                            l_Pants_0.Parent = v60;
                        end;
                    end);
                    return;
                end;
            end;
        end
    }, 
    ["Fire Hand"] = {
        Name = "Fire Hand", 
        Icon = "http://www.roblox.com/asset/?id=37241858", 
        Cooldown = 0.5, 
        Force = 1000, 
        RagdollDuration = 4, 
        OnHit = function(_, v98) --[[ Line: 523 ]] --[[ Name: OnHit ]]
            -- upvalues: l_RunService_0 (copy)
            if l_RunService_0:IsServer() then
                local l_HumanoidRootPart_2 = v98:FindFirstChild("HumanoidRootPart");
                if l_HumanoidRootPart_2 then
                    local v100 = script.Fire.fireOnStep:Clone();
                    v100.Parent = l_HumanoidRootPart_2;
                    task.delay(4, function() --[[ Line: 529 ]]
                        -- upvalues: v100 (copy)
                        v100:Destroy();
                    end);
                end;
            end;
        end
    }, 
    ["Steampunk Glove"] = {
        Name = "Steampunk Glove", 
        Icon = "rbxassetid://243184138", 
        Cooldown = 0.7, 
        Force = 1500, 
        RagdollDuration = 3
    }, 
    ["Ban Hammer"] = {
        Name = "Ban Hammer", 
        Icon = "rbxassetid://102903994473061", 
        Cooldown = 0.7, 
        Force = 900, 
        RagdollDuration = 3, 
        HasParticles = function(v101, v102) --[[ Line: 553 ]] --[[ Name: HasParticles ]]
            local l_Part_1 = Instance.new("Part");
            l_Part_1.CanCollide = false;
            l_Part_1.Size = Vector3.new(1, 1, 1, 0);
            l_Part_1.Anchored = false;
            l_Part_1.Transparency = 1;
            l_Part_1.CFrame = v101.CFrame * CFrame.new(0, 0.4, -3);
            l_Part_1.Parent = workspace;
            local l_WeldConstraint_0 = Instance.new("WeldConstraint");
            l_WeldConstraint_0.Part0 = v101;
            l_WeldConstraint_0.Part1 = l_Part_1;
            l_WeldConstraint_0.Parent = l_Part_1;
            local v105 = v102.Handle.Attachment:Clone();
            v105.Parent = l_Part_1;
            v105.ParticleEmitter:Emit(2);
            task.delay(1, function() --[[ Line: 571 ]]
                -- upvalues: l_Part_1 (copy), l_WeldConstraint_0 (copy), v105 (copy)
                if l_Part_1 then
                    l_Part_1:Destroy();
                end;
                if l_WeldConstraint_0 then
                    l_WeldConstraint_0:Destroy();
                end;
                if v105 then
                    v105:Destroy();
                end;
            end);
        end
    }, 
    ["Bloodmoon Hammer"] = {
        Name = "Bloodmoon Hammer", 
        Icon = "rbxassetid://96284196754755", 
        Cooldown = 0.7, 
        Force = 900, 
        RagdollDuration = 6, 
        HasParticles = function(v106, v107) --[[ Line: 592 ]] --[[ Name: HasParticles ]]
            local l_Part_2 = Instance.new("Part");
            l_Part_2.CanCollide = false;
            l_Part_2.Size = Vector3.new(1, 1, 1, 0);
            l_Part_2.Anchored = false;
            l_Part_2.Transparency = 1;
            l_Part_2.CFrame = v106.CFrame * CFrame.new(0, 0.4, -3);
            l_Part_2.Parent = workspace;
            local l_WeldConstraint_1 = Instance.new("WeldConstraint");
            l_WeldConstraint_1.Part0 = v106;
            l_WeldConstraint_1.Part1 = l_Part_2;
            l_WeldConstraint_1.Parent = l_Part_2;
            local v110 = v107.Handle.Attachment:Clone();
            v110.Parent = l_Part_2;
            v110.ParticleEmitter:Emit(2);
            task.delay(1, function() --[[ Line: 610 ]]
                -- upvalues: l_Part_2 (copy), l_WeldConstraint_1 (copy), v110 (copy)
                if l_Part_2 then
                    l_Part_2:Destroy();
                end;
                if l_WeldConstraint_1 then
                    l_WeldConstraint_1:Destroy();
                end;
                if v110 then
                    v110:Destroy();
                end;
            end);
        end, 
        OnHit = function(_, v112) --[[ Line: 623 ]] --[[ Name: OnHit ]]
            local l_Highlight_0 = Instance.new("Highlight");
            l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_0.FillColor = Color3.fromRGB(255, 0, 0);
            l_Highlight_0.FillTransparency = 0.5;
            l_Highlight_0.OutlineTransparency = 1;
            l_Highlight_0.Adornee = v112;
            l_Highlight_0.Parent = v112;
            task.delay(2.5, function() --[[ Line: 632 ]]
                -- upvalues: l_Highlight_0 (copy)
                l_Highlight_0:Destroy();
            end);
        end
    }, 
    ["Rainbow Hammer"] = {
        Name = "Rainbow Hammer", 
        Icon = "rbxassetid://139876541578910", 
        Cooldown = 0.7, 
        Force = 1000, 
        RagdollDuration = 6, 
        HasParticles = function(v114, v115) --[[ Line: 645 ]] --[[ Name: HasParticles ]]
            local l_Part_3 = Instance.new("Part");
            l_Part_3.CanCollide = false;
            l_Part_3.Size = Vector3.new(1, 1, 1, 0);
            l_Part_3.Anchored = false;
            l_Part_3.Transparency = 1;
            l_Part_3.CFrame = v114.CFrame * CFrame.new(0, 0.4, -3);
            l_Part_3.Parent = workspace;
            local l_WeldConstraint_2 = Instance.new("WeldConstraint");
            l_WeldConstraint_2.Part0 = v114;
            l_WeldConstraint_2.Part1 = l_Part_3;
            l_WeldConstraint_2.Parent = l_Part_3;
            local v118 = v115.Handle.Attachment:Clone();
            v118.Parent = l_Part_3;
            v118.ParticleEmitter:Emit(2);
            task.delay(1, function() --[[ Line: 663 ]]
                -- upvalues: l_Part_3 (copy), l_WeldConstraint_2 (copy), v118 (copy)
                if l_Part_3 then
                    l_Part_3:Destroy();
                end;
                if l_WeldConstraint_2 then
                    l_WeldConstraint_2:Destroy();
                end;
                if v118 then
                    v118:Destroy();
                end;
            end);
        end, 
        OnHit = function(_, v120) --[[ Line: 676 ]] --[[ Name: OnHit ]]
            -- upvalues: v8 (copy)
            local l_Highlight_1 = Instance.new("Highlight");
            l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
            l_Highlight_1.OutlineTransparency = 0;
            l_Highlight_1.FillTransparency = 0.5;
            l_Highlight_1.Adornee = v120;
            l_Highlight_1.Parent = v120;
            table.insert(v8, l_Highlight_1);
            task.delay(2.5, function() --[[ Line: 686 ]]
                -- upvalues: v8 (ref), l_Highlight_1 (copy)
                table.remove(v8, table.find(v8, l_Highlight_1));
                l_Highlight_1:Destroy();
            end);
        end
    }, 
    ["Delete Hammer"] = {
        Name = "Delete Hammer", 
        Icon = "rbxassetid://102903994473061", 
        Cooldown = 0, 
        Force = 3000, 
        RagdollDuration = 5, 
        HasParticles = function(v122, v123) --[[ Line: 700 ]] --[[ Name: HasParticles ]]
            local l_Part_4 = Instance.new("Part");
            l_Part_4.CanCollide = false;
            l_Part_4.Size = Vector3.new(1, 1, 1, 0);
            l_Part_4.Anchored = false;
            l_Part_4.Transparency = 1;
            l_Part_4.CFrame = v122.CFrame * CFrame.new(0, 0.4, -3);
            l_Part_4.Parent = workspace;
            local l_WeldConstraint_3 = Instance.new("WeldConstraint");
            l_WeldConstraint_3.Part0 = v122;
            l_WeldConstraint_3.Part1 = l_Part_4;
            l_WeldConstraint_3.Parent = l_Part_4;
            local v126 = v123.Handle.Attachment:Clone();
            v126.Parent = l_Part_4;
            v126.ParticleEmitter:Emit(2);
            task.delay(1, function() --[[ Line: 718 ]]
                -- upvalues: l_Part_4 (copy), l_WeldConstraint_3 (copy), v126 (copy)
                if l_Part_4 then
                    l_Part_4:Destroy();
                end;
                if l_WeldConstraint_3 then
                    l_WeldConstraint_3:Destroy();
                end;
                if v126 then
                    v126:Destroy();
                end;
            end);
        end
    }, 
    ["Small Tree"] = {
        Name = "Small Tree", 
        Icon = "rbxassetid://70956898840223", 
        Cooldown = 0.7, 
        Force = 1000, 
        Range = Vector3.new(12, 12, 12, 0), 
        RagdollDuration = 3
    }, 
    ["Medium Tree"] = {
        Name = "Medium Tree", 
        Icon = "rbxassetid://117374249944925", 
        Cooldown = 0.7, 
        Force = 1100, 
        Range = Vector3.new(14, 14, 14, 0), 
        RagdollDuration = 3
    }, 
    ["Huge Tree"] = {
        Name = "Huge Tree", 
        Icon = "rbxassetid://114915257709192", 
        Cooldown = 0.7, 
        Force = 1200, 
        Range = Vector3.new(16, 16, 16, 0), 
        RagdollDuration = 3
    }, 
    ["Rainbow Small Tree"] = {
        Name = "Rainbow Small Tree", 
        Icon = "rbxassetid://136011850681459", 
        Cooldown = 0.7, 
        Force = 1200, 
        Range = Vector3.new(12, 12, 12, 0), 
        RagdollDuration = 3
    }, 
    ["Rainbow Medium Tree"] = {
        Name = "Rainbow Medium Tree", 
        Icon = "rbxassetid://83546641619026", 
        Cooldown = 0.7, 
        Force = 1300, 
        Range = Vector3.new(14, 14, 14, 0), 
        RagdollDuration = 3
    }, 
    ["Rainbow Huge Tree"] = {
        Name = "Rainbow Huge Tree", 
        Icon = "rbxassetid://119257172353286", 
        Cooldown = 0.7, 
        Force = 1400, 
        Range = Vector3.new(16, 16, 16, 0), 
        RagdollDuration = 3
	}, 
	["Giant Potion"] = { -- <--- ADD THIS ENTRY
		Name = "Giant Potion",
		Icon = "rbxassetid://140570879781957",
		Cooldown = 0,
		Force = 0,
		RagdollDuration = 0,
		HasHighlight = true,
		HighlightConfig = {
			FillTransparency = 0.9,
			OutlineTransparency = 0
			},
		HasParticles = function(characterRoot, tool)
			 local Attachment = Instance.new("Attachment", characterRoot)
			 local Particle = Instance.new("ParticleEmitter", Attachment)
			 Particle.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
			 Particle.Rate = 50
			 task.delay(30, function() Particle:Destroy() end)
			 end,  OnUse = function(player, character) 
			 end
		 },
    Bat = {
        Name = "Bat", 
        Icon = "rbxassetid://86735158693802", 
        Cooldown = 0.7, 
        Force = 500, 
        RagdollDuration = 3
    }, 
    Lollipop = {
        Name = "Lollipop", 
        Icon = "rbxassetid://95336128645462", 
        Cooldown = 0.7, 
        Force = 800, 
        RagdollDuration = 3, 
        OnHit = function(v127, v128) --[[ Line: 803 ]] --[[ Name: OnHit ]]
            -- upvalues: v5 (copy)
            local function v135(v129) --[[ Line: 804 ]] --[[ Name: ApplyCandyEffect ]]
                for _, v131 in v129:GetChildren() do
                    if v131:IsA("BasePart") then
                        for _, v133 in script.Effect:GetChildren() do
                            local v134 = v133:Clone();
                            v134.Parent = v131;
                            task.delay(5, function() --[[ Line: 813 ]]
                                -- upvalues: v134 (copy)
                                v134:Destroy();
                            end);
                        end;
                    end;
                end;
            end;
            local l_Humanoid_2 = v128:FindFirstChildOfClass("Humanoid");
            local l_HumanoidRootPart_3 = v128:FindFirstChild("HumanoidRootPart");
            if not l_Humanoid_2 or not l_HumanoidRootPart_3 then
                return;
            else
                local v138 = script.BillboardPart.BillboardGui:Clone();
                v138.Parent = l_HumanoidRootPart_3;
                v135(v128);
                v127:SetAttribute("DivideSpeed", true);
                task.delay(5, function() --[[ Line: 832 ]]
                    -- upvalues: v127 (copy), v138 (copy)
                    v127:SetAttribute("DivideSpeed", nil);
                    v138:Destroy();
                end);
                v5:RemoteEvent("UseItem"):FireClient(v127, "CandyEffect", 5);
                return;
            end;
        end
    }, 
    ["Candy Cane"] = {
        Name = "Candy Cane", 
        Icon = "rbxassetid://19250774", 
        Cooldown = 0.4, 
        Force = 500, 
        RagdollDuration = 3
    }, 
    ["Gummy Bear"] = {
        Name = "Gummy Bear", 
        Icon = "rbxassetid://81350787786383", 
        Cooldown = 0.7, 
        Force = 750, 
        RagdollDuration = 3, 
        OnHit = function(v139, v140) --[[ Line: 858 ]] --[[ Name: OnHit ]]
            -- upvalues: v6 (copy), v7 (copy), v14 (ref), v15 (ref), v16 (ref), v17 (ref)
            if v6(("TurnedToGummy/%*/Server"):format(v139.Name), v7:GetInstant("GummyBearStickCooldown", 6.5)) then
                return;
            else
                local l_GummyBear_0 = v14:FindFirstChild("GummyBear");
                if not l_GummyBear_0 then
                    return;
                elseif not v15:FindFirstChild("GummyController") then
                    return;
                elseif v139:GetAttribute("Web") then
                    return;
                else
                    local l_HumanoidRootPart_4 = v140:FindFirstChild("HumanoidRootPart");
                    if not l_HumanoidRootPart_4 then
                        return;
                    else
                        local l_Humanoid_3 = v140:FindFirstChildWhichIsA("Humanoid");
                        if not l_Humanoid_3 then
                            return;
                        else
                            v140:PivotTo(CFrame.new(v140:GetPivot().Position + Vector3.new(0, 2, 0, 0)));
                            v140:SetAttribute("SpeedAllowance", v7:GetInstant("GummyBearSpeedAllowance", 120));
                            task.wait(v7:GetInstant("GummyBearHitWaitTime", 0.65));
                            v139:SetAttribute("RagdollEndTime", 0);
                            local v144 = v16.GummyBear:Clone();
                            v144.Parent = l_HumanoidRootPart_4;
                            v144:Play();
                            local l_Tool_0 = v140:FindFirstChildOfClass("Tool");
                            v139:SetAttribute("Web", true);
                            v139:SetAttribute("BlockTools", true);
                            v17:CancelSteal(v139);
                            l_Humanoid_3.PlatformStand = true;
                            l_Humanoid_3:UnequipTools();
                            local l_WeldConstraint_4 = Instance.new("WeldConstraint");
                            l_WeldConstraint_4.Part0 = l_HumanoidRootPart_4;
                            local v147 = l_GummyBear_0:Clone();
                            v147:PivotTo(v140:GetPivot());
                            v147.Color = BrickColor.random().Color;
                            v147.Parent = workspace;
                            for _, v149 in v147:GetDescendants() do
                                if v149:IsA("BasePart") then
                                    v149:SetNetworkOwner(v139);
                                end;
                            end;
                            l_WeldConstraint_4.Part1 = v147;
                            l_WeldConstraint_4.Parent = v147;
                            v140:SetAttribute("InGummy", true);
                            v139:SetAttribute("NoMouseLockOffset", true);
                            task.delay(v7:GetInstant("GummyBearDuration", 3), function() --[[ Line: 931 ]]
                                -- upvalues: v144 (copy), v147 (copy), l_Humanoid_3 (copy), v139 (copy), v140 (copy), l_Tool_0 (copy), v17 (ref)
                                v144:Destroy();
                                v147:Destroy();
                                l_Humanoid_3.PlatformStand = false;
                                v139:SetAttribute("Web", nil);
                                v139:SetAttribute("BlockTools", nil);
                                v140:SetAttribute("SpeedAllowance", nil);
                                v140:SetAttribute("InGummy", nil);
                                v139:SetAttribute("NoMouseLockOffset", nil);
                                if l_Tool_0 and l_Tool_0.Parent == v139.Backpack and not v17:IsStealing(v139) and l_Humanoid_3.Health > 0 then
                                    l_Humanoid_3:EquipTool(l_Tool_0);
                                end;
                            end);
                            return;
                        end;
                    end;
                end;
            end;
        end
    }, 
    ["Dev Slap"] = {
        Name = "Dev Slap", 
        Icon = "", 
        Cooldown = 0.7, 
        Force = 5000, 
        Range = Vector3.new(25, 25, 25, 0), 
        RagdollDuration = 5, 
        HasHighlight = true
    }
};