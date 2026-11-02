-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.AnimationLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
require(ReplicatedStorage.Modules.Utility);

return {
    { "Equip Cooldown", { "EquipCooldown" }, "Time" },
    {
        "Move Speed",
        { "WalkSpeedMultiplier" },
        "Custom",

        function(p1, p2) -- Line: 10
            return p2 == 1 and "Normal" or (p2 > 1 and "+" or "") .. math.floor((p2 - 1) * 100 + 0.5) .. "%";
        end
    },
    { "Double Jumps", { "MaxDoubleJumps" } },
    {
        "Damage",
        { "ShootDamage", "BurnDamage", "AttackDamage", "Damage", "DirectHitDamage" },
        "Custom",

        function(p3, p4) -- Line: 15
            -- upvalues: ItemLibrary (copy)
            if p4 ~= 0 then
                local v5 = ItemLibrary.Items[p3];
                local v6;

                if v5.ShootPellets and v5.ShootPellets > 1 then
                    v6 = string.format("%.1fx%s", p4 / v5.ShootPellets, v5.ShootPellets) or p4;
                else
                    v6 = p4;
                end;

                local v7 = v5.RaycastDamageDropoffMultiplier and (v5.ShootPellets and v5.ShootPellets > 1 and string.format("%.1fx%s", p4 / v5.ShootPellets * v5.RaycastDamageDropoffMultiplier, v5.ShootPellets) or (string.format("%.1f", p4 * v5.RaycastDamageDropoffMultiplier) or "")) or "";

                return v6 .. (v7 == "" and v7 and v7 or " → " .. v7);
            end;
        end
    },
    {
        "Damage Dropoff Range",
        { "RaycastDamageDropoffStartDistance" },
        "Custom",

        function(p8, p9) -- Line: 26
            -- upvalues: ItemLibrary (copy)
            return p9 .. "<font weight=\"600\" size=\"6\">studs</font> → " .. ItemLibrary.Items[p8].RaycastDamageDropoffEndDistance .. "<font weight=\"600\" size=\"6\">studs</font>";
        end
    },
    {
        "Splash Radius",
        { "ShootExplosionRadius" },
        "Custom",

        function(p10, p11) -- Line: 29
            if p11 > 0 then
                return p11;
            end;
        end
    },
    { "Damage Per Second", { "DamagePerSecond" } },
    { "Afterburn Damage", { "AfterburnDamage" } },
    { "Splash Damage", { "SplashDamage" } },
    { "Explosion Damage", { "ExplosionDamage" } },
    { "Critical Damage", { "CriticalExplosionDamage" } },
    { "Explosion Radius", { "ExplosionRadius" } },
    { "Cooldown", { "ShootCooldown", "AttackCooldown", "Cooldown" }, "Time" },
    {
        "Spread",
        { "ShootSpread" },
        "Custom",

        function(p12, p13) -- Line: 41
            if p13 > 0 then
                return string.format("%.1f°", p13);
            end;
        end
    },
    {
        "Aim Spread",
        { "AimSpreadMultiplier" },
        "Custom",

        function(p14, p15) -- Line: 46
            -- upvalues: ItemLibrary (copy)
            if p15 > 0 then
                return string.format("%.1f°", ItemLibrary.Items[p14].ShootSpread * p15);
            end;
        end
    },
    {
        "Dynamic Spread",
        { "ShootSpreadPerVelocityUnit" },
        "Custom",

        function(p16, p17) -- Line: 51
            if p17 > 0 then
                return string.format("%0.2f°", p17) .. "/studs/s";
            end;
        end
    },
    {
        "Recoil",
        { "ShootCameraDisplacementRecoil" },
        "Custom",

        function(p18, p19) -- Line: 56
            if p19.Magnitude > 0 then
                return string.format("%.0f%%", p19.X / 25 * 100);
            end;
        end
    },
    {
        "Aim Recoil",
        { "ShootCameraDisplacementRecoilWhileAiming" },
        "Custom",

        function(p20, p21) -- Line: 61
            if p21.Magnitude > 0 then
                return string.format("%.0f%%", p21.X / 25 * 100);
            end;
        end
    },
    {
        "Bounces",
        { "RaycastBounceCount" },
        "Custom",

        function(p22, p23) -- Line: 66
            if p23 > 0 then
                return p23;
            end;
        end
    },
    {
        "Burst",
        { "BurstCount" },
        "Custom",

        function(p24, p25) -- Line: 71
            if p25 > 1 then
                return p25;
            end;
        end
    },
    {
        "Burst Delay",
        { "BurstCooldown" },
        "Custom",

        function(p26, p27) -- Line: 76
            if p27 > 0 then
                return string.format("%.2f", p27) .. "s";
            end;
        end
    },
    { "Fan Cooldown", { "QuickShotCooldown" }, "Time" },
    {
        "Attack Delay",
        { "AttackDelay" },
        "Custom",

        function(p28, p29) -- Line: 94
            if p29 > 0 then
                return string.format("%.2f", p29) .. "s";
            end;
        end
    },
    { "Reach", { "Reach" } },
    { "Attack Reach", { "AttackReach" } },
    { "Heavy Damage", { "HeavyAttackDamage" } },
    { "Heavy Cooldown", { "HeavyAttackCooldown" }, "Time" },
    { "Heavy Reach", { "HeavyAttackReach" } },
    {
        "Critical Damage",
        { "CriticalDamage" },
        "Custom",

        function(p30, p31) -- Line: 105
            -- upvalues: ItemLibrary (copy)
            if p31 ~= 0 then
                local v32 = ItemLibrary.Items[p30];
                local v33;

                if v32.ShootPellets and v32.ShootPellets > 1 then
                    v33 = string.format("%.1fx%s", p31 / v32.ShootPellets, v32.ShootPellets) or p31;
                else
                    v33 = p31;
                end;

                local v34 = v32.RaycastDamageDropoffMultiplier and (v32.ShootPellets and v32.ShootPellets > 1 and string.format("%.1fx%s", p31 / v32.ShootPellets * v32.RaycastDamageDropoffMultiplier, v32.ShootPellets) or (string.format("%.1f", p31 * v32.RaycastDamageDropoffMultiplier) or "")) or "";

                return v33 .. (v34 == "" and v34 and v34 or " → " .. v34);
            end;
        end
    },
    {
        "Ammo",
        { "MaxAmmo" },
        "Custom",

        function(p35, p36) -- Line: 117
            -- upvalues: ItemLibrary (copy)
            local v37 = (p35 == "Chainsaw" or p35 == "Flamethrower") and "∞" or ((ItemLibrary.Items[p35].MaxAmmoReserve or 0) > 0 and ItemLibrary.Items[p35].MaxAmmoReserve or nil);

            return (p36 >= (1 / 0) and "∞" or p36) .. (not v37 and "" or " <font weight=\"600\" size=\"9\">" .. v37 .. "</font>");
        end
    },
    { "Reload", { "ReloadActionTimestamp" }, "Time" },
    {
        "Empty Reload",
        { "EmptyReloadActionTimestamp" },
        "Custom",

        function(p38, p39) -- Line: 125
            -- upvalues: ItemLibrary (copy)
            if math.abs(p39 - (ItemLibrary.Items[p38].ReloadActionTimestamp or 0)) > 0.001 then
                return string.format("%.2fs", p39);
            end;
        end
    },
    {
        "Reload",
        { "ReloadType" },
        "Custom",

        function(p40, p41) -- Line: 130
            if p41 == "Segmented" then
                return p41;
            end;
        end
    },
    {
        "Ability Speed Boost",
        { "HoldSpeedBoostMax" },
        "Custom",

        function(p42, p43) -- Line: 136
            return "+" .. math.floor(p43 * 100 + 0.5) .. "%";
        end
    },
    {
        "Ability Damage Per Second",
        { "HoldDamageMultiplier" },
        "Custom",

        function(p44, p45) -- Line: 137
            -- upvalues: ItemLibrary (copy)
            return ItemLibrary.Items[p44].AttackDamage * ItemLibrary.Items[p44].HoldDamageMultiplier;
        end
    },
    { "Airblast Cooldown", { "AirblastCooldown" }, "Time" },
    { "Long Heal", { "LongHeal", "Heal" } },
    { "Long Heal Time", { "LongActionTimestamp" }, "Time" },
    { "Quick Heal", { "QuickHeal" } },
    { "Quick Heal Time", { "QuickActionTimestamp" }, "Time" },
    { "Fire Radius", { "FireRadius" } },
    { "Fire Lifetime", { "FireDuration" }, "Time" },
    { "Blind Duration", { "BlindDuration" }, "Time" },
    { "Smoke Radius", { "SmokeRadius" } },
    { "Smoke Lifetime", { "SmokeDuration" }, "Time" },
    { "Deflect Cooldown", { "DeflectCooldown" }, "Time" },
    { "Deflect Duration", { "DeflectDuration" }, "Time" },
    { "Blade Cooldown", { "BladeCooldown" }, "Time" },
    { "Blade Reach", { "BladeReach" } },
    { "Blade Damage", { "BladeDamage" } },
    { "Blade Critical Damage", { "BladeCriticalDamage" } },
    { "Dash Cooldown", { "DashCooldown" }, "Time" },
    { "Build Cooldown", { "BuildCooldown" }, "Time" },
    { "Build Reach", { "BuildReach" } },
    { "Max Bricks", { "MaxBricks" } },
    { "Brick Lifetime", { "BrickLifetime" }, "Time" },
    {
        "Full Charge Time",
        { "ChargeLevelTimestamps" },
        "Custom",

        function(p46, p47) -- Line: 168
            return string.format("%.2fs", p47[#p47]);
        end
    },
    {
        "Full Charge Damage",
        { "ChargeLevelDamageMultipliers" },
        "Custom",

        function(p48, p49) -- Line: 172
            -- upvalues: ItemLibrary (copy)
            return string.format("%.0f", ItemLibrary.Items[p48].ShootDamage * p49[#p49]);
        end
    },
    { "Charge Damage", { "ChargeDamage" } },
    { "Charge Knockback", { "ChargeKnockbackForce" } },
    { "Charge Time", { "ChargeIntro" }, "Time" },
    { "Detonate Delay", { "DetonateDelay" }, "Time" },
    { "Splash Radius", { "SplashRadius" } },
    {
        "Speed Boost",
        { "SpeedBoost" },
        "Custom",

        function(p50, p51) -- Line: 184
            return "+" .. math.floor(p51 * 100 + 0.5) .. "%";
        end
    },
    { "Speed Duration", { "SpeedBoostDuration" }, "Time" },
    { "Spin Damage", { "SpinDamage" } },
    { "Spin Radius", { "SpinRadius" } },
    { "Spin Cooldown", { "SpinCooldown" }, "Time" },
    { "Charging Windup Time", { "ChargingWindUpLength" }, "Time" },
    {
        "Charging Move Speed",
        { "ChargingSpeedBoost" },
        "Custom",

        function(p52, p53) -- Line: 194
            return p53 == 0 and "Normal" or (p53 > 0 and "+" or "") .. math.floor(p53 * 100 + 0.5) .. "%";
        end
    },
    { "Vortex Cooldown", { "VortexCooldown" }, "Time" },
    { "Vortex Radius", { "VortexRadius" } },
    { "Vortex Lifetime", { "VortexLifetime" }, "Time" },
    { "Knockback", { "KnockbackForce" } },
    { "Slam Cooldown", { "SlamCooldown" }, "Time" },
    { "Slam Damage", { "SlamDamage" } },
    { "Slam Radius", { "SlamRadius" } },
    {
        "Minimum Slam Altitude",
        { "SlamFloorDistance" },
        "Custom",

        function(p54, p55) -- Line: 206
            return p55 .. "studs";
        end
    },
    { "Slow Duration", { "SlowDuration" }, "Time" },
    {
        "Slow",
        { "SlowBoost" },
        "Custom",

        function(p56, p57) -- Line: 211
            return math.floor(p57 * 100 + 0.5) .. "%";
        end
    },
    {
        "Max Slow",
        { "MaxSlowBoost" },
        "Custom",

        function(p58, p59) -- Line: 214
            return math.floor(p59 * 100 + 0.5) .. "%";
        end
    },
    { "Max Slow Stacks", { "MaxSlowStacks" } },
    { "Max Freeze Duration", { "MaxFreezeDuration" }, "Time" },
    { "Freeze Duration", { "FreezeDuration" }, "Time" },
    { "Miss Cooldown", { "MissedCooldown" }, "Time" },
    { "Hook Speed", { "HookSpeed" } },
    { "Hook Range", { "HookRange" } },
    { "Pull Speed", { "SelfPullForce" } },
    { "Enemy Pull Speed", { "EnemyPullForce" } },
    { "Throw Cooldown", { "ThrowCooldown" }, "Time" },
    { "Throw Damage", { "ThrowDamage" } },
    { "Critical Throw Damage", { "CriticalThrowDamage" } },
    { "Throw Knockback", { "ThrowKnockbackForce" } },
    { "Thrown Spear Length", { "ThrownSpearLength" } },
    { "Thrown Spear Lifetime", { "ThrownSpearLifetime" }, "Time" },
    { "Grenade Cooldown", { "GrenadeCooldown" }, "Time" },
    { "Grenade Explosion Radius", { "GrenadeExplosionRadius" } },
    { "Max Health", { "MaxAbsorption" } },
    {
        "Damage Reduction",
        { "AbsorptionPercent" },
        "Custom",

        function(p60, p61) -- Line: 238
            return math.floor(p61 * 100 + 0.5) .. "%";
        end
    },
    { "Lifetime", { "Lifetime" }, "Time" }
};