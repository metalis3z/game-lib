-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:07:58 2025 ]]
local v0 = os.date("!*t", os.time());
local v1 = false;
if v0.month == 3 then
    v1 = v0.day == 18;
end;
local v2 = {
    DisplayName = "Boomer Formula", 
    Description = "you're so old man", 
    Credits = "Made by: Ross & c2o", 
    RenderImage = v1 and "rbxassetid://131855624243843" or "rbxassetid://108463771811755", 
    Price = v1 and 5 or 1, 
    Exclusive = true, 
    Dev = true, 
    Health = v1 and 10000 or 1000, 
    Speed = 8, 
    IntroText = "They're all yours, Mr. Doe", 
    SprintSpeed = v1 and 38 or 27.5, 
    StaminaLoss = 10, 
    StaminaGain = 20, 
    MaxStamina = v1 and 25 or 110, 
    Relation = "JaneDoe", 
    SlashDamage = v1 and 60 or 30, 
    SlashCooldown = v1 and 6 or 2, 
    CorruptEnergyDamage = v1 and 18 or 12, 
    CorruptEnergyCooldown = v1 and 35 or 18, 
    SpikeAmount = v1 and 64 or 26, 
    SpikeLifetime = v1 and 28 or 14, 
    DistanceBetweenSpikes = 4, 
    DelayBetweenSpikeSummons = v1 and 0.025 or 0.075, 
    DigitalFootprintLifetime = 120, 
    DigitalFootprintCooldown = 8, 
    DigitalFootprintLimit = 3, 
    LastManStandingData = {
        ThemeID = "rbxassetid://116564900353263", 
        ThemeProperties = {
            Volume = 1
        }, 
        RoundTime = 74
    }, 
    ["404ErrorAuraRevealTime"] = v1 and 8 or 4, 
    ["404ErrorCooldown"] = 20, 
    Spike = script.Spike, 
    Shadow = script.Shadow, 
    Trail = script.Trail, 
    SpikeNumbersColor = Color3.fromRGB(255, 0, 0), 
    TrailLength = 32, 
    StunDuration = 2.175, 
    Animations = {
        Idle = "rbxassetid://119476920092153", 
        Walk = "rbxassetid://126503807007251", 
        Run = "rbxassetid://120511859936118", 
        Stunned = "rbxassetid://104164703748131", 
        Execution = {
            KillerRig = "rbxassetid://89879746801077", 
            PlayerRig = "rbxassetid://96572621226908", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 3)
        }, 
        Slash = "rbxassetid://99836694749527", 
        CorruptEnergy = "rbxassetid://129322972848046", 
        DigitalFootprint = "rbxassetid://77997185037882", 
        Introduction = {
            KillerRig = "rbxassetid://139117117227124", 
            CameraRig = "rbxassetid://95068817491339"
        }
    }, 
    Sounds = {
        Ambience = "rbxassetid://94207556272752", 
        Footsteps = {
            "rbxassetid://126872882914955", 
            "rbxassetid://81544212102472"
        }, 
        LayerThemes = {
            [60] = {
                ID = "rbxassetid://87108568049500", 
                BPM = 100
            }, 
            [40] = {
                ID = "rbxassetid://112183456126257", 
                BPM = 100
            }, 
            [20] = {
                ID = "rbxassetid://110315081858949", 
                BPM = 100
            }, 
            [6] = {
                ID = "rbxassetid://120518515334317", 
                BPM = 100, 
                Chase = true
            }
        }, 
        Execution = "rbxassetid://91088178573563", 
        StunEnded = "rbxassetid://121488248566083", 
        Swing = "rbxassetid://140242176732868", 
        Hit = "rbxassetid://90819435118493", 
        CorruptEnergy = "rbxassetid://109525294317144", 
        CorruptEnergySummon = "rbxassetid://111388466508150", 
        CorruptEnergyDesummon = "rbxassetid://112806895489970", 
        DigitalFootprint = "rbxassetid://114243439622992", 
        DigitalFootprintAmbience = "rbxassetid://73646387012084", 
        ["404Error"] = "rbxassetid://125897321587591", 
        ["404ErrorError"] = "rbxassetid://90307135163105", 
        Introduction = "rbxassetid://79031693606570", 
        LastManStandingData = {
            ThemeID = "rbxassetid://116564900353263", 
            ThemeProperties = {
                Volume = 1
            }, 
            RoundTime = 74
        }
    }
};
v2.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "JOHN DOE", 
        Text = "<font color=\"rgb(248,217,109)\">John Doe</font> is a guy or something.\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v2.Health) .. ("Regular Speed: %*\n"):format(v2.Speed) .. ("Sprinting Speed: %*\n"):format(v2.SprintSpeed) .. ("Max Stamina: %*\n"):format(v2.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v2.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v2.StaminaGain)
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "NATURAL MALEVOLENCE", 
        Quote = "\"We\226\128\153re dedicated to building a fun, safe environment where kids of all ages can power their imagination on Roblox.\" - Roblox", 
        Text = "For every step that <font color=\"rgb(248,217,109)\">John Doe</font> takes, a trail of corruption follows behind him.\nAny survivor that's unfortunate enough to step within the corruption is given <b>Corrupted II</b> for 3 seconds.\n"
    }, 
    {
        Header = "UNSTOPPABLE", 
        Quote = "\"Consider this myth busted.\" - Roblox", 
        Text = ("<font color=\"rgb(248,217,109)\">John Doe</font> cannot be stunned for any longer than %*s and gains <b>Speed II</b> whenever a stun ends.\n"):format(v2.StunDuration)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Header = "SLASH", 
        Quote = "\"For many years, there has been lore circulating around John Doe and \226\150\136\226\150\136\226\150\136\226\150\136 Doe within the community.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v2.SlashCooldown) .. ("Damage: %*\n"):format(v2.SlashDamage) .. "<font color=\"rgb(248,217,109)\">John Doe</font> slashes infront of him using his claws.\n"
    }, 
    {
        Header = "CORRUPT ENERGY", 
        Quote = "\"This year, we\226\128\153ve decided that it\226\128\153s time to shed some light about these accounts.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v2.CorruptEnergyCooldown) .. ("Damage: %*\n"):format(v2.CorruptEnergyDamage) .. ("<font color=\"rgb(248,217,109)\">John Doe</font> punches his corrupted arm into the ground and, when he pulls it out, %* giant spikes (that last for %*s) emerge infront of him, piercing through any survivor unfortunate enough to be caught within them.\n"):format(v2.SpikeAmount, v2.SpikeLifetime) .. "These spikes are best used as blockades to prevent survivors from accessing certain areas.\n"
    }, 
    {
        Header = "DIGITAL FOOTPRINT", 
        Quote = "\"John Doe and \226\150\136\226\150\136\226\150\136\226\150\136 Doe are two of Roblox\226\128\153s earliest accounts, as seen by their low user IDs here.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v2.DigitalFootprintCooldown) .. "<font color=\"rgb(248,217,109)\">John Doe</font> stomps on the ground three times, commanding a shadow to emerge underneath his footsteps as a trap for survivors to walk over.\n" .. "If a survivor steps over the false shadow, then <font color=\"rgb(248,217,109)\">John Doe</font> gets a <b>Speed II</b> buff for 15 seconds, the survivor gets a <b>Slowness I</b> debuff for 15 seconds, and the survivor's aura is revealed to <font color=\"rgb(248,217,109)\">John Doe</font> for 15 seconds.\n" .. "<font color=\"rgb(248,217,109)\">John Doe</font>'s aura is also revealed to the survivor for 15 seconds upon the trap being triggered.\n" .. ("The shadow despawns after %* seconds or after contact is made with it.\n"):format(v2.DigitalFootprintLifetime) .. ("There can only be <b>%*</b> shadows present at once.\n"):format(v2.DigitalFootprintLimit)
    }, 
    {
        Header = "404 ERROR", 
        Quote = "\"Authentic John Doe and \226\150\136\226\150\136\226\150\136\226\150\136 Doe accounts pose no danger to your Roblox account.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v2["404ErrorCooldown"]) .. ("<font color=\"rgb(248,217,109)\">John Doe</font>'s corrupted arm pulsates twice, revealing the auras of all living survivors to him for %* seconds.\n"):format(v2["404ErrorAuraRevealTime"])
    }
};
return v2;