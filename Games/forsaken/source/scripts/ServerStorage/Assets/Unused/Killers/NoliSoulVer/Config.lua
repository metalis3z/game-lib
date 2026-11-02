-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Wed May 14 21:43:58 2025 ]]
return {
    DisplayName = "Noli (Soul Ver)", 
    Quote = "\"And so darkness decends.\"", 
    Credits = "By: c2o", 
    RenderImage = "rbxassetid://113686001078195", 
    Price = 1100, 
    Exclusive = true, 
    Health = 1111, 
    Speed = 10, 
    SprintSpeed = 28, 
    StaminaLoss = 10, 
    StaminaGain = 10, 
    MaxStamina = 60, 
    MinStamina = -30, 
    MovementAnimSpeed = 1.5, 
    StabCooldown = 2, 
    StabDamage = 28, 
    StardrivenCooldown = 16, 
    StardrivenChargeWindupTime = 1.5, 
    StardrivenCharge1Duration = 2, 
    StarrdivenCharge1Speed = 40, 
    StardrivenCursorTemplate = script.StardrivenCursor, 
    ImplantCooldown = 25, 
	HallucinationCooldown = 30, 
	StardrivenChargeTime = 1,
    Animations = {
		["Idle"] = "rbxassetid://87385694745960",
		["Walk"] = "rbxassetid://109145733080371",
		["Run"] = "rbxassetid://101869159216767",
		["Stab"] = "rbxassetid://125366970248054",
		["StardrivenTendrilStart"] = "rbxassetid://133800478556571",
		["StardrivenTendrilLoop"] = "rbxassetid://103787296279179",
		["StardrivenCharge1Start"] = "rbxassetid://110801329028991",
		["StardrivenCharge1Loop"] = "rbxassetid://98382042398332",
		["StardrivenCharge1Hit"] = "rbxassetid://128210940853180",
		["StardrivenCharge2Start"] = "rbxassetid://105616130787522",
		["StardrivenCharge2Loop"] = "rbxassetid://122850671552914",
		["StardrivenCharge2HitNoli"] = "rbxassetid://100223076509898",
		["StardrivenCharge2HitVictim"] = "rbxassetid://117146057250465",
		["StardrivenChargeMiss"] = "rbxassetid://136826760706318",
		["Implant"] = "rbxassetid://75804229273191",
		["ImplantThrowLoop"] = "rbxassetid://126537359308678",
		["ImplantThrow"] = "rbxassetid://101279251661133",
		ImplantDash = "rbxassetid://135910401315564",
		Victory = {
			KillerRig = "rbxassetid://127478539593759", 
			CameraRig = "rbxassetid://103641862730707"
		}, 
		["ImplantAttackNoli"] = "rbxassetid://100245105802625",
		["ImplantAttackVictim"] = "rbxassetid://134445088616874",
		["Hallucination"] = "rbxassetid://109691136064182",
		["Introduction"] = {
			["KillerRig"] = "rbxassetid://74680048632986",
			["CameraRig"] = "rbxassetid://83125021872492"
		},
		["Execution"] = {
			["KillerRig"] = "rbxassetid://139585837255283",
			["PlayerRig"] = "rbxassetid://124886877342530",
			["PlayerCFrameOffset"] = CFrame.new(0, 0, -6)
		},
		["Stunned"] = {
			["Start"] = "rbxassetid://85521749534266",
			["Loop"] = "rbxassetid://80254437937864",
			["End"] = "rbxassetid://98048416333542"
		}
    }, 
    Sounds = {
        Idle = "rbxassetid://73235255020546", 
        Footsteps = {
            "rbxassetid://99809965759734", 
            "rbxassetid://79222929114377"
        }, 
        Execution = "rbxassetid://91549814855829", 
        Swing = "rbxassetid://118208498013260", 
        Hit = "rbxassetid://110759725172567", 
        Implant = "rbxassetid://90768093259753", 
        ImplantInject = "rbxassetid://114767134633867", 
        Explosion = "rbxassetid://99558901806521", 
        Hallucination = "rbxassetid://113926551867193", 
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://137984398736588", 
                BPM = 81
            }, 
            [40] = {
                ID = "rbxassetid://101639399549593", 
                BPM = 81
            }, 
            [20] = {
                ID = "rbxassetid://139278573219074", 
                BPM = 81
            }, 
            [6] = {
                ID = "rbxassetid://79001697227075", 
                BPM = 81, 
                Chase = true
            }
        }, 
        Introduction = "rbxassetid://97041392946745"
    }
};