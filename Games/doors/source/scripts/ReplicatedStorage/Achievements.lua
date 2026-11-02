-- Created and Supported by LSPLASH

local v1 = {};
v1.__index = v1;
local l__BadgeService__2 = game:GetService("BadgeService");
function v1.GetInfo(p3)
	if p3.Image ~= nil then
		return p3;
	end;
	local l__BadgeService__4 = game:GetService("BadgeService");
	local v5 = {
		IconImageId = 10411081432
	};
	if p3.BadgeId ~= 0 then
		local u1 = v5;
		local v6, v7 = pcall(function()
			u1 = l__BadgeService__4:GetBadgeInfoAsync(p3.BadgeId)
		end);
	end;
	p3.Image = "rbxassetid://" .. v5.IconImageId;
	if p3.Name == "SpecialQATester" then
		p3.Image = "rbxassetid://12309073114";
	end;
	return p3;
end;
function v1.Print(p4, p5)
	if not p5 then
		print(p4.Title);
		print(p4.Desc);
		print(p4.Reason);
		return;
	end;
	print("*** Achievement " .. p4.Name .. " Title");
	print("Achievement " .. p4.Name .. " Description");
	print("Achievement " .. p4.Name .. " Reason");
end;
({}).__index = v1;
local function v8(p6)
	return setmetatable({
		Hidden = p6.Hidden or false, 
		Title = p6.Title or "", 
		Desc = p6.Desc or "", 
		Reason = p6.Reason or "", 
		BadgeId = p6.BadgeId or 0, 
		Category = p6.Category or 10, 
		Theme = p6.Theme or "Default", 
		ShowHidden = p6.ShowHidden or nil
	}, v1);
end;
local v9 = {
	Join = v8({
		Title = "Welcome", 
		Desc = "Enjoy your stay!", 
		Reason = "Join for the first time.", 
		BadgeId = 1705195241653203, 
		Category = 0,
		Theme = "Unique"
	}), 
	WelcomeBack = v8({
		Title = "Welcome Back", 
		Desc = "Are you enjoying your stay?", 
		Reason = "Join back the next day", 
		BadgeId = 275322436013964, 
		Category = 10, 
		Theme = "Unique"
	}), 
	JoinGroup = v8({
		Title = "Join The Group", 
		Desc = "You're one with the cool kids now!", 
		Reason = "Join the BUILDG group (and get a free revive)!", 
		BadgeId = 3839133822995742, 
		Category = 10, 
		Theme = "GroupMember"
	}), 
	SpecialQATester = v8({
		Title = "QA Tester", 
		Desc = "You're special! Not in a mean way.", 
		Reason = "Test stuff.", 
		BadgeId = 202806831770475, 
		Hidden = 5, 
		Category = 3, 
		Theme = "Special"
	}), 
	PlayFriend = v8({
		Title = "Buddy System", 
		Desc = "Everything's better with friends!", 
		Reason = "Play a run with a friend.", 
		BadgeId = 958798883199041, 
		Category = 10, 
		Theme = "Unique"
	}), 
	Revive = v8({
		Title = "Back From The Dead", 
		Desc = "I have unfinished business.", 
		Reason = "Revive yourself.", 
		BadgeId = 3020398341006602, 
		Category = 20, 
		Theme = "Unique"
	}), 
	UseCrucifix = v8({
		Title = "Evil Be Gone", 
		Desc = "I banish thee!", 
		Reason = "Use a Crucifix successfully.", 
		BadgeId = 1783062790950619, 
		Hidden = 1, 
		Category = 49, 
		Theme = "Unique"
	}), 
	DeathAmt1 = v8({
		Title = "One Of Many", 
		Desc = "You're just getting started.", 
		Reason = "Encounter your first death.", 
		BadgeId = 4262624687469683, 
		Category = 30
	}), 
	DeathAmt10 = v8({
		Title = "Ten Of Many", 
		Desc = "You'll get used to it.", 
		Reason = "Encounter your tenth death.", 
		BadgeId = 3109905209501227, 
		Category = 31
	}), 
	DeathAmt100 = v8({
		Title = "Hundred Of Many", 
		Desc = "That's more like it!", 
		Reason = "1296175928237543 your hundredth death.", 
		BadgeId = 1296175928237543, 
		Category = 32
	}), 
	SurviveRush = v8({
		Title = "Out Of My Way", 
		Desc = "I'm walkin' here!", 
		Reason = "Successfully survive Rush.", 
		BadgeId = 3370342900940179, 
		Category = 43, 
		Theme = "Survive"
	}), 
	SurviveSeek = v8({
		Title = "You Can Run", 
		Desc = "But you can't um... um... uhh...", 
		Reason = "Successfully run from Seek.", 
		BadgeId = 2888762968526813, 
		Category = 41, 
		Theme = "Survive"
	}), 
	SurviveHide = v8({
		Title = "Eviction Notice", 
		Desc = "And stay out!", 
		Reason = "Get pushed out of a hiding spot by Hide.", 
		BadgeId = 4010214457619097, 
		Category = 45, 
		Theme = "Survive"
	}),  
	SurviveAmbush = v8({
		Title = "Rebound", 
		Desc = "Coming back for seconds!", 
		Reason = "Survive Ambush.", 
		BadgeId = 4076456595849674, 
		Category = 43, 
		Theme = "Survive"
	}), 
	SurviveHalt = v8({
		Title = "Two Steps Forward", 
		Desc = "And one step back.", 
		Reason = "Survive Halt.", 
		BadgeId = 3487687378329928, 
		Category = 48, 
		Theme = "SurviveRare"
	}), 
	SurviveEyes = v8({
		Title = "Look At Me", 
		Desc = "Last chance to look at me.", 
		Reason = "Survive the Eyes.", 
		BadgeId = 1293451182357137, 
		Category = 44, 
		Theme = "Survive"
	}), 
	SurviveScreech = v8({
		Title = "I See You", 
		Desc = "Peek-a-boo!", 
		Reason = "Dodge Screech's attack.", 
		BadgeId = 3471105311554990, 
		Category = 42, 
		Theme = "Survive"
	}), 
	SurviveFigureLibrary = v8({
		Title = "Sshh!", 
		Desc = "Careful not to make a sound!", 
		Reason = "Escape from the Library in the Hotel.", 
		BadgeId = 854428041017595, 
		Category = 80
	}), 
	BreakerSpeedrun = v8({
		Title = "Expert Technician", 
		Desc = "I'm the one for the job.", 
		Reason = "Complete the Hotel's breaker puzzle in under a minute.", 
		BadgeId = 806619270478548, 
		Hidden = 1, 
		Category = 84, 
		Theme = "Unique", 
	}), 
	EncounterSpider = v8({
		Title = "Meet Timothy", 
		Desc = "Hello there little spider!", 
		Reason = "Encounter Timothy while looting.", 
		BadgeId = 1521582907598472, 
		Category = 69, 
		Theme = "RareEncounter"
	}), 
	EncounterMobble = v8({
		Title = "Meet Jack", 
		Desc = "Ooga booga!", 
		Reason = "Encounter Jack.", 
		BadgeId = 1180190268039394, 
		Category = 70, 
		Theme = "RareEncounter"
	}), 
	EncounterGlitch = v8({
		Title = "Error", 
		Desc = "Well that just happened.", 
		Reason = "Encounter the Glitch.", 
		BadgeId = 1913625424547012, 
		Hidden = 2, 
		Category = 70, 
		Theme = "RareEncounter"
	}), 
	SurviveDupe = v8({
		Title = "Wrong Room", 
		Desc = "Well this is awkward...", 
		Reason = "Get duped by Dupe.", 
		BadgeId = 3687422977742844, 
		Category = 43, 
		Theme = "Survive"
	}), 
	CrucifixRush = v8({
		Title = "Stay Out Of My Way", 
		Desc = "You're not that guy, pal.", 
		Reason = "Use a Crucifix against Rush.", 
		BadgeId = 1293517753880360, 
		Hidden = 2, 
		Category = 50, 
		Theme = "SurviveRare", 
		ShowHidden = {
			NeedAll = true, 
			Achievements = { "UseCrucifix", "SurviveRush" }
		}
	}), 
	CrucifixAmbush = v8({
		Title = "Unbound", 
		Desc = "Shut up, thanks.", 
		Reason = "Use a Crucifix against Ambush.", 
		BadgeId = 1753473077389367, 
		Hidden = 2, 
		Category = 51, 
		Theme = "SurviveRare", 
		ShowHidden = {
			NeedAll = true, 
			Achievements = { "UseCrucifix", "SurviveAmbush" }
		}
	}), 
	CrucifixSeek = v8({
		Title = "Take A Breather", 
		Desc = "Sit down for a moment.", 
		Reason = "Use a Crucifix against Seek.", 
		BadgeId = 907564690702904, 
		Hidden = 2, 
		Category = 52, 
		Theme = "SurviveRare", 
		ShowHidden = {
			NeedAll = true, 
			Achievements = { "UseCrucifix", "SurviveSeek" }
		}
	}), 
	CrucifixFigure = v8({
		Title = "All Figured Out", 
		Desc = "I figured that wouldn't work for long...", 
		Reason = "Use a Crucifix against Figure.", 
		BadgeId = 3337364095928818, 
		Hidden = 2, 
		Category = 53, 
		Theme = "SurviveRare", 
		ShowHidden = {
			NeedAll = true, 
			Achievements = { "UseCrucifix", "SurviveFigure" }
		}
	}), 
	CrucifixEyes = v8({
		Title = "You Can't See Me", 
		Desc = "That probably wasn't the best use of one of these.", 
		Reason = "Use a Crucifix against the Eyes.", 
		BadgeId = 3740967180349063, 
		Hidden = 1, 
		Category = 54, 
		Theme = "SurviveRare", 
		ShowHidden = {
			NeedAll = true, 
			Achievements = { "UseCrucifix", "SurviveEyes" }
		}
	}), 
	CrucifixScreech = v8({
		Title = "Didn't Back", 
		Desc = "Could you not be yourself for five minutes?!", 
		Reason = "Use a Crucifix against Screech.", 
		BadgeId = 1358740192417303, 
		Hidden = 2, 
		Category = 55, 
		Theme = "SurviveRare", 
		ShowHidden = {
			NeedAll = true, 
			Achievements = { "UseCrucifix", "SurviveScreech" }
		}
	}), 
	CrucifixDupe = v8({
		Title = "Outwitted", 
		Desc = "The duper becomes... the dupee.", 
		Reason = "Use a Crucifix against Dupe.", 
		BadgeId = 3355404552952844, 
		Hidden = 1, 
		Category = 57, 
		Theme = "SurviveRare", 
		ShowHidden = {
			NeedAll = true, 
			Achievements = { "UseCrucifix", "SurviveDupe" }
		}
	}), 
	SurviveWithoutHiding = v8({
		Title = "In Plain Sight", 
		Desc = "Quick, behind that conveniently shaped lamp!", 
		Reason = "Hide from an entity by staying out of sight.", 
		BadgeId = 959345841638170, 
		Hidden = 1, 
		Category = 49, 
		Theme = "Unique", 
		ShowHidden = {
			NeedAll = false, 
			Achievements = { "SurviveRush" }
		}
	}), 
	JeffShop = v8({
		Title = "Supporting Small Businesses", 
		Desc = "Thank you, come again!", 
		Reason = "Purchase an item from Jeff.", 
		BadgeId = 1631346945259573, 
		Hidden = 1, 
		Category = 81
	}), 
	JeffTipFull = v8({
		Title = "Pls Donate", 
		Desc = "Now I can go to college!", 
		Reason = "Fill Jeff's tip jar.", 
		BadgeId = 1129877897640630, 
		Hidden = 1, 
		Category = 82, 
		Theme = "Unique", 
		ShowHidden = {
			NeedAll = false, 
			Achievements = { "JeffShop" }
		}
	}), 
	UseHerbGreen = v8({
		Title = "Herb Of Viridis", 
		Desc = "My heart beats stronger...", 
		Reason = "Find and use a green herb.", 
		BadgeId = 1650006344895215, 
		Hidden = 1, 
		Category = 83, 
		Theme = "Unique"
	}), 
	EncounterVoid = v8({
		Title = "It Stares Back", 
		Desc = "Guys, wait up!!", 
		Reason = "Encounter the Void.", 
		BadgeId = 2877653086489624, 
		Hidden = 2, 
		Category = 69, 
		Theme = "RareEncounter"
	}), 
	UseRift = v8({
		Title = "Interconnected", 
		Desc = "Enjoy, future me!", 
		Reason = "Preserve an item in a Rift.", 
		BadgeId = 416861056528477, 
		Hidden = 2, 
		Category = 70, 
		Theme = "RareEncounter"
	}), 
	EscapeHotel = v8({
		Title = "Rock Bottom", 
		Desc = "This is just the beginning.", 
		Reason = "Escape The Hotel.", 
		BadgeId = 1231261301495666, 
		Category = 100, 
		Theme = "Escape"
	}), 
};
for v10, v11 in pairs(v9) do
	v11.Name = v10;
end;
return v9;
