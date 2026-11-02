-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local v4 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v5 = nil;
local v6 = nil;
local v7 = nil;
local v16 = {
    IsNight = function(_) --[[ Line: 23 ]] --[[ Name: IsNight ]]
        return workspace:GetServerTimeNow() % 1800 >= 900;
    end, 
    IsDay = function(_) --[[ Line: 28 ]] --[[ Name: IsDay ]]
        return workspace:GetServerTimeNow() % 1800 < 900;
    end, 
    Update = function(_) --[[ Line: 33 ]] --[[ Name: Update ]]
        -- upvalues: v5 (ref), v7 (ref), l_ReplicatedStorage_0 (copy), l_Lighting_0 (copy), v6 (ref), l_TweenService_0 (copy)
        v5 = os.clock();
        local v11 = true;
        local v12 = nil;
        if v7 then
            local v13 = v7:Get("Overrides")[1];
            v12 = if v13 then v13.state else nil;
        end;
        if l_ReplicatedStorage_0:GetAttribute("BloodmoonEvent") then
            v12 = 20;
        end;
        if l_ReplicatedStorage_0:GetAttribute("CandyEvent") then
            v12 = 14;
        end;
		if l_ReplicatedStorage_0:GetAttribute("GalaxyEvent") or l_ReplicatedStorage_0:GetAttribute("YinYangEvent") or l_ReplicatedStorage_0:GetAttribute("RadioactiveEvent") or l_ReplicatedStorage_0:GetAttribute("UFOEvent")  or l_ReplicatedStorage_0:GetAttribute("StrawberryEvent") or l_ReplicatedStorage_0:GetAttribute("WitchingHourEvent") or l_ReplicatedStorage_0:GetAttribute("WinterHourEvent") then
            v12 = 11;
            v11 = false;
        end;
        if l_ReplicatedStorage_0:GetAttribute("Effect_Space") or l_ReplicatedStorage_0:GetAttribute("NyanCatsEvent") or l_ReplicatedStorage_0:GetAttribute("4thOfJulyEvent") or l_ReplicatedStorage_0:GetAttribute("10BVisitsEvent") or l_ReplicatedStorage_0:GetAttribute("GlitchEvent") or l_ReplicatedStorage_0:GetAttribute("MoltenEvent") or l_ReplicatedStorage_0:GetAttribute("BombardiroCrocodiloEvent") or l_ReplicatedStorage_0:GetAttribute("Starfall") or l_ReplicatedStorage_0:GetAttribute("LosMatteosEventNightTime") or l_ReplicatedStorage_0:GetAttribute("SammyniSpyderiniEvent") then
            v12 = 0;
        end;
        if l_ReplicatedStorage_0:GetAttribute("ChicleteiraBicicleteiraEvent") then
            v12 = 6;
		end;
		if l_ReplicatedStorage_0:GetAttribute("TrickOrTreatEvent") or l_ReplicatedStorage_0:GetAttribute("GraveyardEvent") then
			v11 = false
			v12 = 5
		end
        if l_ReplicatedStorage_0:GetAttribute("WaterEvent") then
            v12 = 14.5;
        end;
        if l_ReplicatedStorage_0:GetAttribute("CrabRave") then
            v12 = 14;
        end;
        if l_ReplicatedStorage_0:GetAttribute("ConcertEvent") or l_ReplicatedStorage_0:GetAttribute("RapConcertEvent") or l_ReplicatedStorage_0:GetAttribute("BrazilEvent") then
            v12 = 0;
            v11 = false;
        end;
        local v14 = not v12;
        if not v12 then
            local v15 = workspace:GetServerTimeNow() % 1800;
            if v15 < 900 then
                v12 = 6 + v15 / 900 * 12;
            else
                v12 = 18 + (v15 - 900) / 900 * 12;
                if v12 >= 24 then
                    v12 = v12 - 24;
                end;
            end;
            if l_ReplicatedStorage_0:GetAttribute("ClockTimeOverride") then
                v12 = l_ReplicatedStorage_0:GetAttribute("ClockTimeOverride");
            end;
        end;
        if math.abs(v12 - l_Lighting_0.ClockTime) > 1 and v14 ~= v6 then
            l_TweenService_0:Create(l_Lighting_0, TweenInfo.new(5), {
                ClockTime = v12
            }):Play();
            l_TweenService_0:Create(l_Lighting_0.SunRays, TweenInfo.new(1), {
                Intensity = v11 and 0.071 or 0
            });
        else
            l_Lighting_0.ClockTime = v12;
            l_Lighting_0.SunRays.Intensity = v11 and 0.071 or 0;
        end;
        v6 = v14;
    end
};
v16.Start = function(_) --[[ Line: 125 ]] --[[ Name: Start ]]
    -- upvalues: v5 (ref), v16 (copy), v7 (ref), v4 (copy)
    task.spawn(function() --[[ Line: 126 ]]
        -- upvalues: v5 (ref), v16 (ref)
        while true do
            if not v5 or os.clock() - v5 >= 5 then
                v16:Update();
            end;
            task.wait(1);
        end;
    end);
    v7 = v4:Wait("Cycle");
    v7:OnArrayInserted("Overrides", function() --[[ Line: 138 ]]
        -- upvalues: v16 (ref)
        v16:Update();
    end);
    v7:OnArrayRemoved("Overrides", function() --[[ Line: 142 ]]
        -- upvalues: v16 (ref)
        v16:Update();
    end);
end;
return v16;