-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-05-10 23:53:20
-- Luau version 6, Types version 3
-- Time taken: 0.001904 seconds

return {
	DisplayName = "Pretty Princess";
	Description = "prettiest of them all";
	RenderImage = "rbxassetid://116021222073783";
	Price = 1001;
	PizzaDeliveryRig = script.PizzaDeliveryRig;
	Projectile = script.Teapot;
	Animations = {
		Execution007n7 = false;
	}; 
	Emotes = {
		Animations = {
			prettydanc = {
				DisplayName = "pretty dance";
				Description = "yayyy wahooo weeeeee";
				AssetID = "rbxassetid://85315044663872";
				SFX = "rbxassetid://119720647959535";
				SFXProperties = {
					Looped = true;
					Volume = 0.2;
				};
			};
		};
	};
	Sounds = {
		TerrorRadiusThemes = {
			[60] = {
				ID = "rbxassetid://117856353909500", 
				BPM = 178, 
				Volume = 0.4
			}, 
			[40] = {
				ID = "rbxassetid://132063624319296", 
				BPM = 178, 
				Volume = 0.45
			}, 
			[20] = {
				ID = "rbxassetid://86535007716389", 
				BPM = 178, 
				Volume = 0.5
			}, 
			[6] = {
				ID = "rbxassetid://114852233968189", 
				BPM = 178, 
				Chase = true, 
				Volume = 0.5
			}
		}
	},
	Voicelines = {
		Idle = {"rbxassetid://119566147938938", "rbxassetid://114754149115028", "rbxassetid://85760501886569", "rbxassetid://128976610892858", "rbxassetid://106146643236525"};
		LastSurvivor = {"rbxassetid://87659837387922"};
		LastSurvivorTwoTime = {"rbxassetid://122178864655009"};
		Kill = {"rbxassetid://97181985015489", "rbxassetid://92631878729795"};
		KillBuilderman = {"rbxassetid://111356516301755"};
		KillNoob = {"rbxassetid://98289613312107", "rbxassetid://84793019671606"};
		KillElliot = {"rbxassetid://117949763472181"};
		KillGuest1337 = {"rbxassetid://104487657463044"};
		Kill007n7 = {"rbxassetid://100735910687735", "rbxassetid://115723886952811", "rbxassetid://111044456340321"};
		KillChance = {"rbxassetid://99165836191291"};
		KillShedletsky = {"rbxassetid://88167864351331"};
		KillTwoTime = {"rbxassetid://121052393332837"};
		KillDusekkar = {"rbxassetid://102875149704645"};
		KillPinkDayChance = {"rbxassetid://115589947972313"};
		Stunned = {"rbxassetid://87501174489341", "rbxassetid://70524380893771", "rbxassetid://79039702113827", "rbxassetid://88876390307676"};
		CorruptNature = {"rbxassetid://133114480778112", "rbxassetid://79840735613260"};
		CorruptNatureHit = {""};
		PizzaDelivery = {"rbxassetid://79617180928738", "rbxassetid://86223858556041"};
		PizzaDeliveryHit = {"rbxassetid://113230964717483", "rbxassetid://113310792535193"};
		WalkspeedOverride = {"rbxassetid://109654246612816", "rbxassetid://72383972044877", "rbxassetid://97865394058675"};
		WalkspeedOverrideHit = {"rbxassetid://140592285429928", "rbxassetid://117276884652493"};
		WalkspeedOverrideCollide = {"rbxassetid://107964260740381"};
		WalkspeedOverrideTimeout = {"rbxassetid://117057109754858", "rbxassetid://127245811999121"};
	};
}