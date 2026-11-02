-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_workspace_Attribute_0 = workspace:GetAttribute("JasonSpecialDay");
local v1 = {
    DisplayName = "Jason", 
    Quote = l_workspace_Attribute_0 and "\"... :)\"" or "\"...\"", 
    Credits = "Made By: HowsLifeJosh", 
    RenderImage = "rbxassetid://91312909125316", 
    Price = 0, 
    Health = l_workspace_Attribute_0 and 3000 or 1250, 
    Speed = l_workspace_Attribute_0 and 10 or 9, 
    SprintSpeed = l_workspace_Attribute_0 and 34 or 28, 
    StaminaLoss = 9.5, 
    StaminaGain = 21, 
    MaxStamina = l_workspace_Attribute_0 and 40 or 110, 
    SlashDamage = l_workspace_Attribute_0 and 40 or 20, 
    SlashCooldown = l_workspace_Attribute_0 and 3.5 or 1.9, 
    EnragedSlashDamage = l_workspace_Attribute_0 and 50 or 25, 
    EnragedSlashCooldown = l_workspace_Attribute_0 and 1.5 or 0.8, 
    EnragedSlashLungeForce = l_workspace_Attribute_0 and 85 or 65, 
    BeheadDamage = l_workspace_Attribute_0 and 50 or 20, 
    BeheadCooldown = l_workspace_Attribute_0 and 24 or 18.5, 
    BeheadLunge = l_workspace_Attribute_0 and 1.7 or 1.3, 
    EnragedBeheadDamage = l_workspace_Attribute_0 and 75 or 35, 
    EnragedBeheadLunge = l_workspace_Attribute_0 and 2.2 or 2, 
    EnragedBeheadCooldown = l_workspace_Attribute_0 and 18 or 12, 
    GashingWoundDamage = l_workspace_Attribute_0 and 100 or 50, 
    GashingWoundCooldown = l_workspace_Attribute_0 and 60 or 40, 
    EnragedGashingWoundDamage = l_workspace_Attribute_0 and 200 or 70, 
    EnragedGashingWoundCooldown = l_workspace_Attribute_0 and 50 or 32, 
    RagingPaceCooldown = l_workspace_Attribute_0 and 55 or 30, 
    EnragedSpeed = l_workspace_Attribute_0 and 26 or 19.5, 
    EnragedTime = l_workspace_Attribute_0 and 8 or 14, 
    EnragedAuraLingerTime = l_workspace_Attribute_0 and 10 or 2, 
    EnragedStaminaCap = l_workspace_Attribute_0 and 15 or 70, 
    EnragedStaminaCapLerpTime = 6.5, 
    Animations = {
		Idle = "rbxassetid://94735871998827", 
		Walk = "rbxassetid://109089424735715", 
		Run = "rbxassetid://91241849043766", 
		EnragedStart = "rbxassetid://97841738305885", 
		EnragedIdle = "rbxassetid://110353644319842", 
		EnragedWalk = "rbxassetid://103203729239590", 
		EnragedRun = "rbxassetid://72915018324522", 
        Introduction = {
			KillerRig = "rbxassetid://93656812432934", 
			CameraRig = "rbxassetid://107218820664659"
        }, 
        Execution = {
			KillerRig = "rbxassetid://91403428949038", 
			PlayerRig = "rbxassetid://105084865540205"
        }, 
        Stunned = {
			Start = "rbxassetid://107024186931555", 
			Loop = "rbxassetid://125029811487205", 
			End = "rbxassetid://119884995323871"
        }, 
		Slash = "rbxassetid://89558425910966", 
		Behead = "rbxassetid://105763747107032", 
		GashingWoundStart = "rbxassetid://120955506475515", 
        GashingWound = {
			KillerRig = "rbxassetid://128598542580087", 
			PlayerRig = "rbxassetid://115612699482066"
        }
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://72457886454761", 
            "rbxassetid://98852761114513"
        }, 
        TerrorRadiusThemes = {
            [45] = {
                ID = "rbxassetid://121292620130330", 
                BPM = 72
            }, 
            [30] = {
                ID = "rbxassetid://85477377169399", 
                BPM = 72
            }, 
            [15] = {
                ID = "rbxassetid://114692287462245", 
                BPM = 72
            }, 
            [6] = {
                ID = "rbxassetid://125611325245826", 
                BPM = 72, 
                Chase = true
            }
        }, 
        Execution = "rbxassetid://80903632607907", 
        Stunned = "rbxassetid://136281175461752", 
        Introduction = "rbxassetid://70658180298709", 
        Swing = "rbxassetid://112809109188560", 
        Hit = "rbxassetid://101633163910404", 
        EnragedStart = "rbxassetid://112390922764994", 
        GashingWoundSwing = "rbxassetid://102228729296384", 
        GashingWoundMiss = "rbxassetid://84353899757208", 
        GashingWoundHit = "rbxassetid://127648610882555"
    }
};
v1.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "JASON", 
        Text = "A man who's identity is covered by a crude hockey mask. Wielding several tools at his disposal, along with his thirst for the cat-and-mouse chase, his hands and/or tools are always seen bloody. He enters his damnation wielding his infamous machete & a chainsaw he found in a cabin.\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\134\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*\n"):format(v1.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain)
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Image = nil, 
        Header = "MUTE", 
        Quote = "\"Make them remember!\" - Mother", 
        Text = "<font color=\"rgb(200,150,20)\">Jason's</font> terror radius is smaller as opposed to other Killers.\n"
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://96590285148227", 
        Header = "SLASH", 
        Quote = "\"Make them remember!\" - Mother", 
        Text = ("Cooldown: %*s (%*s if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v1.SlashCooldown, v1.EnragedSlashCooldown) .. ("Damage: %* (%* if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v1.SlashDamage, v1.EnragedSlashDamage) .. "<font color=\"rgb(200,150,20)\">Jason</font> does a basic slash with his machete; inflicts <b>Bleeding I</b> for 5 seconds.\n" .. "A lunge is added to this attack if it's used while <font color=\"rgb(200,150,20)\">Jason's</font> <font color=\"rgb(255,50,50)\">ENRAGED</font>.\n"
    }, 
    {
        Image = "rbxassetid://83553911625628", 
        Header = "BEHEAD", 
        Quote = "\"No place to hide.\" - Mother", 
        Text = ("Cooldown: %*s (%*s if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v1.BeheadCooldown, v1.EnragedBeheadCooldown) .. ("Damage: %* (%* if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v1.BeheadDamage, v1.EnragedBeheadDamage) .. "<font color=\"rgb(200,150,20)\">Jason</font> winds up a strong horizontal swing to the head of his target.\n" .. "BEHEAD inflicts <b>Helpless I</b> for 14 seconds.\n" .. "After this attack, <font color=\"rgb(200,150,20)\">Jason</font>, regardless if it hit, gains <b>Slowness I</b> for 2 seconds.\n"
    }, 
    {
        Image = "rbxassetid://132724488499212", 
        Header = "GASHING WOUND", 
        Quote = "\"It'll be easier for you than it was for him.\" - Mother", 
        Text = ("Cooldown: %*s (%*s if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v1.GashingWoundCooldown, v1.EnragedGashingWoundCooldown) .. ("Damage: %* (%* if used while <font color=\"rgb(255,50,50)\">ENRAGED</font>)\n"):format(v1.GashingWoundDamage, v1.EnragedGashingWoundDamage) .. "<font color=\"rgb(200,150,20)\">Jason</font> does a combination of slashes, starting with 2 hits from his machete, then quickly jams his chainsaw into the victim.\n" .. ("Each slash deals around 1/5 of the attack's total damage, but they all add up to either %* or %* depending on if <font color=\"rgb(200,150,20)\">Jason's</font> <font color=\"rgb(255,50,50)\">ENRAGED</font>.\n"):format(v1.GashingWoundDamage, v1.EnragedGashingWoundDamage)
    }, 
    {
        Image = "rbxassetid://112952508748158", 
        Header = "RAGING PACE", 
        Quote = "\"Kill them!\" - Mother", 
        Text = ("Cooldown: %*s\n"):format(v1.RagingPaceCooldown) .. "<font color=\"rgb(200,150,20)\">Jason</font> becomes <font color=\"rgb(255,0,0)\">ENRAGED.</font>\n" .. ("On activation, <font color=\"rgb(200,150,20)\">Jason</font>'s speed becomes %* for %* seconds, and the aura of the nearest survivor is revealed to him. The aura remains revealed until his <font color=\"rgb(255,0,0)\">ENRAGED.</font> state ends, in which it'll linger for an additional %*s.\n"):format(v1.EnragedSpeed, v1.EnragedTime, v1.EnragedAuraLingerTime) .. ("While in effect, <font color=\"rgb(200,150,20)\">Jason</font> becomes immune to stuns, has his sprinting disabled, and has his stamina slowly become capped at %* over the span of %*s. The cap is removed once he leaves his <font color=\"rgb(255,0,0)\">ENRAGED.</font> state.\n"):format(v1.EnragedStaminaCap, v1.EnragedStaminaCapLerpTime)
    }
};
return v1;