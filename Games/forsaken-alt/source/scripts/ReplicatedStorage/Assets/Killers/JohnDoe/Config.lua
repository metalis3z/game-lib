-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_workspace_Attribute_0 = workspace:GetAttribute("JohnDoeSpecialDay");
local v1 = {
    DisplayName = "John Doe", 
    Quote = l_workspace_Attribute_0 and "dude i told you not to play on march 18th" or "DON'T PLAY ROBLOX ON MARCH 18TH?!?!", 
    Credits = "Made by: c2o", 
    RenderImage = l_workspace_Attribute_0 and "rbxassetid://131855624243843" or "rbxassetid://108463771811755", 
    Price = l_workspace_Attribute_0 and 318 or 1000, 
    Health = l_workspace_Attribute_0 and 3182025 or 1500, 
    Speed = l_workspace_Attribute_0 and 11.3182025 or 9, 
    IntroText = "They're all yours, Mr. Doe", 
    SprintSpeed = l_workspace_Attribute_0 and 27.53182025 or 27.25, 
    StaminaLoss = 9.5, 
    StaminaGain = 21, 
    MaxStamina = l_workspace_Attribute_0 and 115.3182025 or 110, 
    SlashDamage = l_workspace_Attribute_0 and 45.3182025 or 28, 
    SlashCooldown = l_workspace_Attribute_0 and 2.3182025 or 1.75, 
    CorruptEnergyDamage = l_workspace_Attribute_0 and 16.3182025 or 12, 
    CorruptEnergyCooldown = l_workspace_Attribute_0 and 40.3182025 or 18, 
    SpikeAmount = l_workspace_Attribute_0 and 256 or 26, 
    SpikeLifetime = l_workspace_Attribute_0 and 18.3182025 or 14, 
    SpikeHitCap = l_workspace_Attribute_0 and 3182025 or 4, 
    DelayBetweenSpikeSummons = l_workspace_Attribute_0 and 0.02 or 0.075, 
    DistanceBetweenSpikes = 4, 
    DigitalFootprintLifetime = 165, 
    DigitalFootprintCooldown = 8, 
    DigitalFootprintLimit = l_workspace_Attribute_0 and 4 or 3, 
    ["404ErrorAuraRevealTime"] = l_workspace_Attribute_0 and 10.3182025 or 4, 
    ["404ErrorCooldown"] = 20, 
    Spike = script.Spike, 
    Shadow = script.Shadow, 
    Trail = script.Trail, 
    IntroLighting = script.IntroLighting, 
    SpikeNumbersColor = Color3.fromRGB(255, 0, 0), 
    TrailLength = l_workspace_Attribute_0 and 356 or 48, 
    StunDuration = 2.175, 
    Animations = {
		Idle = "rbxassetid://140455242251704", 
		Walk = "rbxassetid://105157385959740", 
		Run = "rbxassetid://104635155502153", 
		Stunned = "rbxassetid://94181985874962", 
        Execution = {
			KillerRig = "rbxassetid://78852862499600", 
			PlayerRig = "rbxassetid://75310729457621", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 3)
        }, 
		Slash = "rbxassetid://97626634623172", 
		CorruptEnergy = "rbxassetid://136225871590582", 
		DigitalFootprint = "rbxassetid://124685809955853", 
        Introduction = {
			KillerRig = "rbxassetid://120868327854068", 
			CameraRig = "rbxassetid://71103075375068"
        }
    }, 
    Sounds = {
        Ambience = "rbxassetid://94207556272752", 
        Footsteps = {
            "rbxassetid://126872882914955", 
            "rbxassetid://81544212102472"
        }, 
        TerrorRadiusThemes = {
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
        Introduction = "rbxassetid://79031693606570"
    }
};
v1.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "JOHN DOE", 
        Text = "The defunct code of the early days of Roblox courses through their body, consuming his mind as he now only focuses on one thing: to kill everyone in his path. An unstoppable force entering the round with a strategical mindset, he's able to set traps, summon walls to back survivors into a corner, and leave behind a faint trail that damages those who step on it.\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*\n"):format(v1.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain)
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "NATURAL MALEVOLENCE", 
        Quote = "\"We\226\128\153re dedicated to building a fun, safe environment where kids of all ages can power their imagination on Roblox.\" - Roblox", 
        Text = ("For every step that %* takes, a trail of corruption follows behind him.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. "Any survivor that's unfortunate enough to step within the corruption is given <b>Corrupted II</b> for 3 seconds.\n"
    }, 
    {
        Header = "UNSTOPPABLE", 
        Quote = "\"Consider this myth busted.\" - Roblox", 
        Text = ("%* can only be stunned for %*s.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>", v1.StunDuration)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Header = "SLASH", 
        Image = "rbxassetid://92362553672440", 
        Quote = "\"For many years, there has been lore circulating around John Doe and \226\150\136\226\150\136\226\150\136\226\150\136 Doe within the community.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v1.SlashCooldown) .. ("Damage: %*\n"):format(v1.SlashDamage) .. ("%* slashes infront of him using his claws.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>")
    }, 
    {
        Header = "CORRUPT ENERGY", 
        Icon = "rbxassetid://83849304758564", 
        Quote = "\"This year, we\226\128\153ve decided that it\226\128\153s time to shed some light about these accounts.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v1.CorruptEnergyCooldown) .. ("Damage: %*\n"):format(v1.CorruptEnergyDamage) .. ("%* punches his corrupted arm into the ground and, when he pulls it out, %* giant spikes (that last for %*s) emerge infront of him, piercing through any survivor unfortunate enough to be caught within them.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>", v1.SpikeAmount, v1.SpikeLifetime) .. ("Hitting a player with a spike gives %* Speed I for 7 seconds.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. ("Summoned spikes cannot damage the same target more than %* times.\n"):format(v1.SpikeHitCap) .. "These spikes can be used as blockades to prevent survivors from accessing certain areas.\n"
    }, 
    {
        Header = "DIGITAL FOOTPRINT", 
        Image = "rbxassetid://83206360003394", 
        Quote = "\"John Doe and \226\150\136\226\150\136\226\150\136\226\150\136 Doe are two of Roblox\226\128\153s earliest accounts, as seen by their low user IDs here.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v1.DigitalFootprintCooldown) .. ("%* stomps on the ground three times, commanding a shadow to emerge underneath his footsteps as a trap for survivors to walk over.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. ("If a survivor steps over the false shadow, then %* gets a <b>Speed I</b> buff for 10 seconds and the survivor gets a <b>Corrupted I</b> & <b>Slowness II</b> debuff for 10 seconds.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. ("Upon the trap being triggered, %* and the survivor who activated it have their auras revealed to each other for 10 seconds.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>") .. ("The shadow despawns after %* seconds or after contact is made with it.\n"):format(v1.DigitalFootprintLifetime) .. ("There can only be <b>%*</b> shadows present at once.\n"):format(v1.DigitalFootprintLimit)
    }, 
    {
        Header = "404 ERROR", 
        Icon = "rbxassetid://131116145215571", 
        Quote = "\"Authentic John Doe and \226\150\136\226\150\136\226\150\136\226\150\136 Doe accounts pose no danger to your Roblox account.\" - Roblox", 
        Text = ("Cooldown: %*s\n"):format(v1["404ErrorCooldown"]) .. ("%*'s corrupted arm pulsates twice, revealing the auras of all living survivors to him for %* seconds.\n"):format("<font color=\"rgb(248,217,109)\">John Doe</font>", v1["404ErrorAuraRevealTime"])
    }
};
return v1;