-----[GROUP ONLY]-----
--If you want to restrict the GUI to a group or groups with a minimum associated rank, use the table below:
local groups = {
	-- FORMAT:
	-- {GROUP ID, MINIMUM GROUP RANK ID},
}

--[[ Example:
local groups = {
	{758071, 1}, -- Group is NUSA, minimum rank is 1, meaning they simply have to at least be in the group (0 means not in group)
	{2750566, 150}, -- Group is NUSM, minimum rank is whichever rank is associated with the role ID of 150
}
]]

-----[TEAM ONLY]-----
--If you want to restrict the GUI to a team, use the table below:
local teams = {}

--[[ Example:
local teams = {"United States Military","Joint Chiefs of Staff","Department of Defense"}
]]

-----[NOTES]-----
--[[ 
	You can combine the group and team restrictions if you'd like to only allow people on a specific team that are a certain rank in a group to have the GUI. 
	I recommend not to edit anything below unless you know what you're doing :)
	Contact me if you need help (if i still play) or find an experienced scripter
]]

------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----[REFERENCE VARIABLES]-----
local sp = script.Parent
local open = sp.OpenButton
local main = sp.Mainframe
local branch = main.Branch
local uni = main.Uniform
local rank = main.Ranks
local cover = main.CoverOnly
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local plrInfo = main.Parent.PlayerInfo
hats = game.ReplicatedStorage.Hats

-----[VALUE VARIABLES]-----
userBranch = ""
uniformChoice = ""
userPaygrade = ""
override = false

-----[TEAM/GROUP ONLY CHECK]-----
if #teams > 0  and #groups == 0 then
	for i,v in pairs(teams) do
		if game.Teams[v].TeamColor == plr.TeamColor then
			open.Visible = true
		end
	end
elseif #groups > 0 and #teams == 0 then
	for i,v in pairs(groups) do
		if plr:GetRankInGroup(v[1]) >= v[2] then
			open.Visible = true
		end
	end
elseif #groups > 0 and #teams > 0 then
	for i,v in pairs(teams) do
		if game.Teams[v].TeamColor == plr.TeamColor then
			open.Visible = true
		end
	end
	if open.Visible == true then
		open.Visible = false
		for i,v in pairs(groups) do
			if plr:GetRankInGroup(v[1]) >= v[2] then
				open.Visible = true
			end
		end
	end
elseif #teams == 0 and #groups == 0 then
	open.Visible = true
end

if open.Visible == false then
	sp:Destroy()
end

--[ALL USM UNIFORMS]--
USM = {
	["Navy"] = {
		["Physical Training"] = {
			{"E1","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.E1},
			{"E2","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.E2},
			{"E3","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.E3},
			{"E4","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.E4},
			{"E5","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.E5},
			{"E6","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.E6},
			{"E7","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.E7},
			{"E8","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.E8},
			{"E9","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.E9},
			{"O1","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O1},
			{"O2","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O2},
			{"O3","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O3},
			{"O4","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O4},
			{"O5","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O5},
			{"O6","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O6},
			{"O7","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O7},			
			{"O8","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O8},
			{"O9","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O9},
			{"O10","rbxassetid://189288065","rbxassetid://189288466",hats.Navy.Utility.O10}
		},
		["Mess Dress"] = {
			{"E7","rbxassetid://413376682","rbxassetid://413377008",hats.Navy.Formals.E7E9},
			{"E8","rbxassetid://413377610","rbxassetid://413377008",hats.Navy.Formals.E7E9},
			{"E9a","rbxassetid://413376725","rbxassetid://413377008",hats.Navy.Formals.E7E9},
			{"E9b","rbxassetid://413376761","rbxassetid://413377008",hats.Navy.Formals.E7E9},
			{"E9c","rbxassetid://413376785","rbxassetid://413377008",hats.Navy.Formals.E7E9},
			{"O1","rbxassetid://413376801","rbxassetid://413377008",hats.Navy.Formals.O1O4},
			{"O2","rbxassetid://413376815","rbxassetid://413377008",hats.Navy.Formals.O1O4},
			{"O3","rbxassetid://413376848","rbxassetid://413377008",hats.Navy.Formals.O1O4},
			{"O4","rbxassetid://413376869","rbxassetid://413377008",hats.Navy.Formals.O1O4},
			{"O5","rbxassetid://413376888","rbxassetid://413377008",hats.Navy.Formals.O5O6},
			{"O6","rbxassetid://413376909","rbxassetid://413377008",hats.Navy.Formals.O5O6},
			{"O7","rbxassetid://413376937","rbxassetid://413377008",hats.Navy.Formals.O7O10},			
			{"O8","rbxassetid://413376966","rbxassetid://413377008",hats.Navy.Formals.O7O10},
			{"O9","rbxassetid://413376976","rbxassetid://413377008",hats.Navy.Formals.O7O10},
			{"O10","rbxassetid://413376994","rbxassetid://413377008",hats.Navy.Formals.O7O10},
		},
		["NWU Type IIIs"] = {
			{"E1","rbxassetid://5956937356","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"E2","rbxassetid://5956937356","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"E3","rbxassetid://5956937356","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"E4","rbxassetid://5956937791","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"E5","rbxassetid://5956939900","rbxassetid://189288466",hats.Navy.NWUIIICap},
			{"E6","rbxassetid://5956940480","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"E7","rbxassetid://5957068003","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"E8","rbxassetid://6133227490","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"E9","rbxassetid://5957069817","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"O1","rbxassetid://5957070226","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"O2","rbxassetid://5957070609","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"O3","rbxassetid://5957071073","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"O4","rbxassetid://5957096128","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"O5","rbxassetid://5957096128","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"O6","rbxassetid://5957150507","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"O7","rbxassetid://5957188092","rbxassetid://5957283794",hats.Navy.NWUIIICap},			
			{"O8","rbxassetid://5957188092","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"O9","rbxassetid://5957189083","rbxassetid://5957283794",hats.Navy.NWUIIICap},
			{"O10","rbxassetid://6138559855","rbxassetid://5957283794",hats.Navy.NWUIIICap}
		},
		["Combats"] = {
			{"E1-O10","rbxassetid://6133276644","rbxassetid://5957283794",hats.Navy.NWUIIICap},
		},
		["Khakis"] = {
			{"E1","rbxassetid://5659662924","rbxassetid://5659657150",hats.Navy.Khakis.E1E6},
			{"E2","rbxassetid://5659662924","rbxassetid://5659657150",hats.Navy.Khakis.E1E6},
			{"E3","rbxassetid://5659666477","rbxassetid://5659657150",hats.Navy.Khakis.E1E6},
			{"E4","rbxassetid://5659667868","rbxassetid://5659657150",hats.Navy.Khakis.E1E6},
			{"E5","rbxassetid://5659669768","rbxassetid://5659657150",hats.Navy.Khakis.E1E6},
			{"E6","rbxassetid://5659671038","rbxassetid://5659657150",hats.Navy.Khakis.E1E6},
			{"E7","rbxassetid://5659794279","rbxassetid://5659789344",hats.Navy.Khakis.E7E9},
			{"E8","rbxassetid://5659795166","rbxassetid://5659789344",hats.Navy.Khakis.E7E9},
			{"E9a-E9b","rbxassetid://5659796317","rbxassetid://5659789344",hats.Navy.Khakis.E7E9},
			{"E9c","rbxassetid://5659797912","rbxassetid://5659789344",hats.Navy.Khakis.E7E9},
			{"O1","rbxassetid://5659848920","rbxassetid://5659789344",hats.Navy.Khakis.O1O4},
			{"O2","rbxassetid://5660041521","rbxassetid://5659789344",hats.Navy.Khakis.O1O4},
			{"O3","rbxassetid://566013242","rbxassetid://5659789344",hats.Navy.Khakis.O1O4},
			{"O4","rbxassetid://5660597413","rbxassetid://5659789344",hats.Navy.Khakis.O1O4},
			{"O5","rbxassetid://5663620125","rbxassetid://5659789344",hats.Navy.Khakis.O5O6},
			{"O6","rbxassetid://5663698094","rbxassetid://5659789344",hats.Navy.Khakis.O5O6},
			{"O7","rbxassetid://5663698980","rbxassetid://5659789344",hats.Navy.Khakis.O7O10},			
			{"O8","rbxassetid://5663700426","rbxassetid://5659789344",hats.Navy.Khakis.O7O10},
			{"O9","rbxassetid://5663701446","rbxassetid://5659789344",hats.Navy.Khakis.O7O10},
			{"O10","rbxassetid://5663702497","rbxassetid://5659789344",hats.Navy.Khakis.O7O10}
		},
		["Summer Whites"] = {
			{"E1","rbxassetid://272309400","rbxassetid://272309674",hats.Navy.Formals.E1E6},
			{"E2","rbxassetid://272309202","rbxassetid://272309674",hats.Navy.Formals.E1E6},
			{"E3","rbxassetid://272308893","rbxassetid://272309674",hats.Navy.Formals.E1E6},
			{"E4","rbxassetid://272308484","rbxassetid://272309674",hats.Navy.Formals.E1E6},
			{"E5","rbxassetid://272308237","rbxassetid://272309674",hats.Navy.Formals.E1E6},
			{"E6","rbxassetid://272307773","rbxassetid://272309674",hats.Navy.Formals.E1E6},
			{"E7","rbxassetid://405902351","rbxassetid://405905473",hats.Navy.Formals.E7E9},
			{"E8","rbxassetid://405902375","rbxassetid://405905473",hats.Navy.Formals.E7E9},
			{"E9a","rbxassetid://405902436","rbxassetid://405905473",hats.Navy.Formals.E7E9},
			{"E9b/c","rbxassetid://405902514","rbxassetid://405905473",hats.Navy.Formals.E7E9},
			{"O1","rbxassetid://405902567","rbxassetid://405905473",hats.Navy.Formals.O1O4},
			{"O2","rbxassetid://405902601","rbxassetid://405905473",hats.Navy.Formals.O1O4},
			{"O3","rbxassetid://405902631","rbxassetid://405905473",hats.Navy.Formals.O1O4},
			{"O4","rbxassetid://405902658","rbxassetid://405905473",hats.Navy.Formals.O1O4},
			{"O5","rbxassetid://405902689","rbxassetid://405905473",hats.Navy.Formals.O5O6},
			{"O6","rbxassetid://405902714","rbxassetid://405905473",hats.Navy.Formals.O5O6},
			{"O7","rbxassetid://405902734","rbxassetid://405905473",hats.Navy.Formals.O7O10},			
			{"O8","rbxassetid://405902754","rbxassetid://405905473",hats.Navy.Formals.O7O10},
			{"O9","rbxassetid://405902777","rbxassetid://405905473",hats.Navy.Formals.O7O10},
			{"O10","rbxassetid://405902798","rbxassetid://405905473",hats.Navy.Formals.O7O10}
		},
		["Dress Whites"] = {
			{"E1","rbxassetid://405561712","rbxassetid://405562104",hats.Navy.Formals.E1E6},
			{"E2","rbxassetid://405561773","rbxassetid://405562104",hats.Navy.Formals.E1E6},
			{"E3","rbxassetid://405561843","rbxassetid://405562104",hats.Navy.Formals.E1E6},
			{"E4","rbxassetid://405561900","rbxassetid://405562104",hats.Navy.Formals.E1E6},
			{"E5","rbxassetid://405561966","rbxassetid://405562104",hats.Navy.Formals.E1E6},
			{"E6","rbxassetid://405562022","rbxassetid://405562104",hats.Navy.Formals.E1E6},
			{"E7","rbxassetid://405839851","rbxassetid://405840175",hats.Navy.Formals.E7E9},
			{"E8","rbxassetid://405839875","rbxassetid://405840175",hats.Navy.Formals.E7E9},
			{"E9a","rbxassetid://405839890","rbxassetid://405840175",hats.Navy.Formals.E7E9},
			{"E9b/c","rbxassetid://405839914","rbxassetid://405840175",hats.Navy.Formals.E7E9},
			{"O1","rbxassetid://405839933","rbxassetid://405840175",hats.Navy.Formals.O1O4},
			{"O2","rbxassetid://405839956","rbxassetid://405840175",hats.Navy.Formals.O1O4},
			{"O3","rbxassetid://405839977","rbxassetid://405840175",hats.Navy.Formals.O1O4},
			{"O4","rbxassetid://405839992","rbxassetid://405840175",hats.Navy.Formals.O1O4},
			{"O5","rbxassetid://405840010","rbxassetid://405840175",hats.Navy.Formals.O5O6},
			{"O6","rbxassetid://405840034","rbxassetid://405840175",hats.Navy.Formals.O5O6},
			{"O7","rbxassetid://405840051","rbxassetid://405840175",hats.Navy.Formals.O7O10},			
			{"O8","rbxassetid://405840066","rbxassetid://405840175",hats.Navy.Formals.O7O10},
			{"O9","rbxassetid://405840138","rbxassetid://405840175",hats.Navy.Formals.O7O10},
			{"O10","rbxassetid://405840156","rbxassetid://405840175",hats.Navy.Formals.O7O10}
		},
		["Dress Blues"] = {
			{"E1","rbxassetid://405084431","rbxassetid://405084599",hats.Navy.Formals.E1E6},
			{"E2","rbxassetid://405084457","rbxassetid://405084599",hats.Navy.Formals.E1E6},
			{"E3","rbxassetid://405084477","rbxassetid://405084599",hats.Navy.Formals.E1E6},
			{"E4","rbxassetid://405084507","rbxassetid://405084599",hats.Navy.Formals.E1E6},
			{"E5","rbxassetid://405084542","rbxassetid://405084599",hats.Navy.Formals.E1E6},
			{"E6","rbxassetid://405084562","rbxassetid://405084599",hats.Navy.Formals.E1E6},
			{"E7","rbxassetid://405354983","rbxassetid://405355145",hats.Navy.Formals.E7E9},
			{"E8","rbxassetid://405355000","rbxassetid://405355145",hats.Navy.Formals.E7E9},
			{"E9a","rbxassetid://405355004","rbxassetid://405355145",hats.Navy.Formals.E7E9},
			{"E9b","rbxassetid://405355004","rbxassetid://405355145",hats.Navy.Formals.E7E9},
			{"E9c","rbxassetid://405355018","rbxassetid://405355145",hats.Navy.Formals.E7E9},
			{"O1","rbxassetid://405355028","rbxassetid://405355145",hats.Navy.Formals.O1O4},
			{"O2","rbxassetid://405355038","rbxassetid://405355145",hats.Navy.Formals.O1O4},
			{"O3","rbxassetid://405355053","rbxassetid://405355145",hats.Navy.Formals.O1O4},
			{"O4","rbxassetid://405355065","rbxassetid://405355145",hats.Navy.Formals.O1O4},
			{"O5","rbxassetid://405355075","rbxassetid://405355145",hats.Navy.Formals.O5O6},
			{"O6","rbxassetid://405355087","rbxassetid://405355145",hats.Navy.Formals.O5O6},
			{"O7","rbxassetid://405355099","rbxassetid://405355145",hats.Navy.Formals.O7O10},			
			{"O8","rbxassetid://405355108","rbxassetid://405355145",hats.Navy.Formals.O7O10},
			{"O9","rbxassetid://405355116","rbxassetid://405355145",hats.Navy.Formals.O7O10},
			{"O10","rbxassetid://405355128","rbxassetid://405355145",hats.Navy.Formals.O7O10}
		}
	},
	["Marines"] = {
		["Alphas"] = {
			{"E1","rbxassetid://4334625742","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E2","rbxassetid://4334620834","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E3","rbxassetid://4334627572","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E4","rbxassetid://4334629069","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E5","rbxassetid://4334630506","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E6","rbxassetid://4334632097","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E7","rbxassetid://4334634027","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E8a","rbxassetid://4334635741","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E8b","rbxassetid://4334637231","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E9a","rbxassetid://4334639908","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E9b","rbxassetid://4334641393","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"E9c","rbxassetid://4334642941","rbxassetid://4334618789",hats.Marines.Alphas.Enlisted},
			{"WO","rbxassetid://4334645653","rbxassetid://4334618789",hats.Marines.Alphas.CompanyGrade},
			{"CWO2","rbxassetid://4334647334","rbxassetid://4334618789",hats.Marines.Alphas.CompanyGrade},
			{"CWO3","rbxassetid://4334649081","rbxassetid://4334618789",hats.Marines.Alphas.CompanyGrade},
			{"CWO4","rbxassetid://4334650920","rbxassetid://4334618789",hats.Marines.Alphas.CompanyGrade},
			{"CWO5","rbxassetid://4334652531","rbxassetid://4334618789",hats.Marines.Alphas.CompanyGrade},
			{"O1","rbxassetid://4334653994","rbxassetid://4334618789",hats.Marines.Alphas.CompanyGrade},
			{"O2","rbxassetid://4334655379","rbxassetid://4334618789",hats.Marines.Alphas.CompanyGrade},
			{"O3","rbxassetid://4334657385","rbxassetid://4334618789",hats.Marines.Alphas.CompanyGrade},
			{"O4","rbxassetid://4334659081","rbxassetid://4334618789",hats.Marines.Alphas.GeneralGrade},
			{"O5","rbxassetid://4334661072","rbxassetid://4334618789",hats.Marines.Alphas.GeneralGrade},
			{"O6","rbxassetid://4334662692","rbxassetid://4334618789",hats.Marines.Alphas.GeneralGrade},
			{"O7","rbxassetid://4334664157","rbxassetid://4334618789",hats.Marines.Alphas.GeneralGrade},			
			{"O8","rbxassetid://4334665527","rbxassetid://4334618789",hats.Marines.Alphas.GeneralGrade},
			{"O9","rbxassetid://4334667095","rbxassetid://4334618789",hats.Marines.Alphas.GeneralGrade},
			{"O10","rbxassetid://4334668768","rbxassetid://4334618789",hats.Marines.Alphas.GeneralGrade}
		},
		["Blues"] = {
			{"E1","rbxassetid://4334689222","rbxassetid://4334678273",hats.Marines.DBs.Enlisted},
			{"E2","rbxassetid://4334691144","rbxassetid://4334678273",hats.Marines.DBs.Enlisted},
			{"E3","rbxassetid://4334692732","rbxassetid://4334678273",hats.Marines.DBs.Enlisted},
			{"E4","rbxassetid://4334694197","rbxassetid://4334679898",hats.Marines.DBs.Enlisted},
			{"E5","rbxassetid://4334695890","rbxassetid://4334679898",hats.Marines.DBs.Enlisted},
			{"E6","rbxassetid://4334697299","rbxassetid://4334679898",hats.Marines.DBs.Enlisted},
			{"E7","rbxassetid://4334698862","rbxassetid://4334679898",hats.Marines.DBs.Enlisted},
			{"E8a","rbxassetid://4334701904","rbxassetid://4334679898",hats.Marines.DBs.Enlisted},
			{"E8b","rbxassetid://4334703599","rbxassetid://4334679898",hats.Marines.DBs.Enlisted},
			{"E9a","rbxassetid://4334705181","rbxassetid://4334679898",hats.Marines.DBs.Enlisted},
			{"E9b","rbxassetid://4334706843","rbxassetid://4334679898",hats.Marines.DBs.Enlisted},
			{"E9c","rbxassetid://4334708297","rbxassetid://4334679898",hats.Marines.DBs.Enlisted},
			{"WO","rbxassetid://4334710455","rbxassetid://4334682581",hats.Marines.DBs.W1O3},
			{"CWO2","rbxassetid://4334712546","rbxassetid://4334682581",hats.Marines.DBs.W1O3},
			{"CWO3","rbxassetid://4334714004","rbxassetid://4334682581",hats.Marines.DBs.W1O3},
			{"CWO4","rbxassetid://4334715265","rbxassetid://4334682581",hats.Marines.DBs.W1O3},
			{"CWO5","rbxassetid://4334716806","rbxassetid://4334682581",hats.Marines.DBs.W1O3},
			{"O1","rbxassetid://4334718590","rbxassetid://4334682581",hats.Marines.DBs.W1O3},
			{"O2","rbxassetid://4334720073","rbxassetid://4334682581",hats.Marines.DBs.W1O3},
			{"O3","rbxassetid://4334721483","rbxassetid://4334682581",hats.Marines.DBs.W1O3},
			{"O4","rbxassetid://4334722969","rbxassetid://4334682581",hats.Marines.DBs.CompanyGrade},
			{"O5","rbxassetid://4334724651","rbxassetid://4334682581",hats.Marines.DBs.CompanyGrade},
			{"O6","rbxassetid://4334726405","rbxassetid://4334682581",hats.Marines.DBs.CompanyGrade},
			{"O7","rbxassetid://4334728663","rbxassetid://4334685475",hats.Marines.DBs.GeneralGrade},			
			{"O8","rbxassetid://4334730592","rbxassetid://4334685475",hats.Marines.DBs.GeneralGrade},
			{"O9","rbxassetid://4334732332","rbxassetid://4334685475",hats.Marines.DBs.GeneralGrade},
			{"O10","rbxassetid://4334733807","rbxassetid://4334685475",hats.Marines.DBs.GeneralGrade}
		},
		["Charlies"] = {
			{"E1","rbxassetid://4334746510","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E2","rbxassetid://4334748169","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E3","rbxassetid://4334749461","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E4","rbxassetid://4334750745","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E5","rbxassetid://4334752492","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E6","rbxassetid://4334753828","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E7","rbxassetid://4334757655","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E8a","rbxassetid://4334759329","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E8b","rbxassetid://4334760771","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E9a","rbxassetid://4334762234","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E9b","rbxassetid://4334763549","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"E9c","rbxassetid://4334764875","rbxassetid://4334742366",hats.Marines.Garrison.Enlisted},
			{"WO","rbxassetid://4334767512","rbxassetid://4334742366",hats.Marines.Garrison.WO1},
			{"CWO2","rbxassetid://4334769331","rbxassetid://4334742366",hats.Marines.Garrison.CWO2},
			{"CWO3","rbxassetid://4334770509","rbxassetid://4334742366",hats.Marines.Garrison.CWO3},
			{"CWO4","rbxassetid://4334771805","rbxassetid://4334742366",hats.Marines.Garrison.CWO4},
			{"CWO5","rbxassetid://4334773980","rbxassetid://4334742366",hats.Marines.Garrison.CWO5},
			{"O1","rbxassetid://4334775675","rbxassetid://4334742366",hats.Marines.Garrison.O1},
			{"O2","rbxassetid://4334777241","rbxassetid://4334742366",hats.Marines.Garrison.O2},
			{"O3","rbxassetid://4334779319","rbxassetid://4334742366",hats.Marines.Garrison.O3},
			{"O4","rbxassetid://4334783227","rbxassetid://4334742366",hats.Marines.Garrison.O4},
			{"O5","rbxassetid://4334784742","rbxassetid://4334742366",hats.Marines.Garrison.O5},
			{"O6","rbxassetid://4334786177","rbxassetid://4334742366",hats.Marines.Garrison.O6},
			{"O7","rbxassetid://4334788534","rbxassetid://4334742366",hats.Marines.Garrison.O7},			
			{"O8","rbxassetid://4334789973","rbxassetid://4334742366",hats.Marines.Garrison.O8},
			{"O9","rbxassetid://4334792378","rbxassetid://4334742366",hats.Marines.Garrison.O9},
			{"O10","rbxassetid://4334794012","rbxassetid://4334742366",hats.Marines.Garrison.O10}
			},
		["Deltas"] = {
			{"E1","rbxassetid://4334805007","rbxassetid://4334798810",hats.Marines.DBs.Enlisted},
			{"E2","rbxassetid://4334806540","rbxassetid://4334798810",hats.Marines.DBs.Enlisted},
			{"E3","rbxassetid://4334808530","rbxassetid://4334798810",hats.Marines.DBs.Enlisted},
			{"E4","rbxassetid://4334809932","rbxassetid://4334800299",hats.Marines.DBs.Enlisted},
			{"E5","rbxassetid://4334812638","rbxassetid://4334800299",hats.Marines.DBs.Enlisted},
			{"E6","rbxassetid://4334816967","rbxassetid://4334800299",hats.Marines.DBs.Enlisted},
			{"E7","rbxassetid://4334822706","rbxassetid://4334800299",hats.Marines.DBs.Enlisted},
			{"E8a","rbxassetid://4334823936","rbxassetid://4334800299",hats.Marines.DBs.Enlisted},
			{"E8b","rbxassetid://4334825351","rbxassetid://4334800299",hats.Marines.DBs.Enlisted},
			{"E9a","rbxassetid://4334826629","rbxassetid://4334800299",hats.Marines.DBs.Enlisted},
			{"E9b","rbxassetid://4334828222","rbxassetid://4334800299",hats.Marines.DBs.Enlisted},
			{"E9c","rbxassetid://4334829615","rbxassetid://4334800299",hats.Marines.DBs.Enlisted},
			{"WO","rbxassetid://4334832245","rbxassetid://4334800299",hats.Marines.DBs.W1O3},
			{"CWO2","rbxassetid://4334834211","rbxassetid://4334800299",hats.Marines.DBs.W1O3},
			{"CWO3","rbxassetid://4334835508","rbxassetid://4334800299",hats.Marines.DBs.W1O3},
			{"CWO4","rbxassetid://4334836680","rbxassetid://4334800299",hats.Marines.DBs.W1O3},
			{"CWO5","rbxassetid://4334837813","rbxassetid://4334800299",hats.Marines.DBs.W1O3},
			{"O1","rbxassetid://4334839715","rbxassetid://4334800299",hats.Marines.DBs.W1O3},
			{"O2","rbxassetid://4334841218","rbxassetid://4334800299",hats.Marines.DBs.W1O3},
			{"O3","rbxassetid://4334842758","rbxassetid://4334800299",hats.Marines.DBs.W1O3},
			{"O4","rbxassetid://4334844279","rbxassetid://4334800299",hats.Marines.DBs.CompanyGrade},
			{"O5","rbxassetid://4334846299","rbxassetid://4334800299",hats.Marines.DBs.CompanyGrade},
			{"O6","rbxassetid://4334848076","rbxassetid://4334800299",hats.Marines.DBs.CompanyGrade},
			{"O7","rbxassetid://4334851378","rbxassetid://4334801639",hats.Marines.DBs.GeneralGrade},			
			{"O8","rbxassetid://4334852774","rbxassetid://4334801639",hats.Marines.DBs.GeneralGrade},
			{"O9","rbxassetid://4334854187","rbxassetid://4334801639",hats.Marines.DBs.GeneralGrade},
			{"O10","rbxassetid://4334857645","rbxassetid://4334801639",hats.Marines.DBs.GeneralGrade}
			},
		["Whites"] = {
			{"E1","rbxassetid://4334689222","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E2","rbxassetid://4334691144","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E3","rbxassetid://4334692732","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E4","rbxassetid://4334694197","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E5","rbxassetid://4334695890","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E6","rbxassetid://4334697299","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E7","rbxassetid://4334698862","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E8a","rbxassetid://4334701904","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E8b","rbxassetid://4334703599","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E9a","rbxassetid://4334705181","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E9b","rbxassetid://4334706843","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"E9c","rbxassetid://4334708297","rbxassetid://4334861309",hats.Marines.DBs.Enlisted},
			{"WO","rbxassetid://4334710455","rbxassetid://4334862959",hats.Marines.DBs.W1O3},
			{"CWO2","rbxassetid://4334712546","rbxassetid://4334862959",hats.Marines.DBs.W1O3},
			{"CWO3","rbxassetid://4334714004","rbxassetid://4334862959",hats.Marines.DBs.W1O3},
			{"CWO4","rbxassetid://4334715265","rbxassetid://4334862959",hats.Marines.DBs.W1O3},
			{"CWO5","rbxassetid://4334716806","rbxassetid://4334862959",hats.Marines.DBs.W1O3},
			{"O1","rbxassetid://4334718590","rbxassetid://4334862959",hats.Marines.DBs.W1O3},
			{"O2","rbxassetid://4334720073","rbxassetid://4334862959",hats.Marines.DBs.W1O3},
			{"O3","rbxassetid://4334721483","rbxassetid://4334862959",hats.Marines.DBs.W1O3},
			{"O4","rbxassetid://4334722969","rbxassetid://4334862959",hats.Marines.DBs.CompanyGrade},
			{"O5","rbxassetid://4334724651","rbxassetid://4334862959",hats.Marines.DBs.CompanyGrade},
			{"O6","rbxassetid://4334726405","rbxassetid://4334862959",hats.Marines.DBs.CompanyGrade},
			{"O7","rbxassetid://4334728663","rbxassetid://4334862959",hats.Marines.DBs.GeneralGrade},			
			{"O8","rbxassetid://4334730592","rbxassetid://4334862959",hats.Marines.DBs.GeneralGrade},
			{"O9","rbxassetid://4334732332","rbxassetid://4334862959",hats.Marines.DBs.GeneralGrade},
			{"O10","rbxassetid://4334733807","rbxassetid://4334862959",hats.Marines.DBs.GeneralGrade}
		},
		["Woodlands"] = {
			{"MCCUU Unrolled","rbxassetid://4334900340","rbxassetid://4334897384",hats.Marines.WoodlandCover},
			{"MCCUU Rolled","rbxassetid://4334903511","rbxassetid://4334897384",hats.Marines.WoodlandCover},
			{"Drill Instructor Unrolled","rbxassetid://4334901858","rbxassetid://4334897384",hats.Marines.DICover},
			{"Drill Instructor Rolled","rbxassetid://4334904861","rbxassetid://4334897384",hats.Marines.DICover},
			{"Combats","rbxassetid://4334900340","rbxassetid://4334897384",hats.Marines.Helmets.Woodland},
			{"Phsyical Training","rbxassetid://4334906837","rbxassetid://4334897384",hats.Marines.WoodlandCover}
		},
		["Deserts"] = {
			{"MCCUU Unrolled","rbxassetid://4334869081","rbxassetid://4334866154",hats.Marines.DesertCover},
			{"MCCUU Rolled","rbxassetid://4334892351","rbxassetid://4334866154",hats.Marines.DesertCover},
			{"Drill Instructor Unrolled","rbxassetid://4334870659","rbxassetid://4334866154",hats.Marines.DICover},
			{"Drill Instructor Rolled","rbxassetid://4334894540","rbxassetid://4334866154",hats.Marines.DICover},
			{"Combats","rbxassetid://4334869081","rbxassetid://4334866154",hats.Marines.Helmets.Desert},
			{"Phsyical Training","rbxassetid://4334906837","rbxassetid://4334866154",hats.Marines.DesertCover}
		},
	},
	["Army"] = {
		["Standard Class A"] = {
			{"E1","rbxassetid://1037871096","rbxassetid://1037886034",hats.Army.Formals.Enlisted},
			{"E2","rbxassetid://1037872421","rbxassetid://1037886034",hats.Army.Formals.Enlisted},
			{"E3","rbxassetid://1037873077","rbxassetid://1037886034",hats.Army.Formals.Enlisted},
			{"E4","rbxassetid://1037873463","rbxassetid://1037886723",hats.Army.Formals.Enlisted},
			{"E5","rbxassetid://1037875737","rbxassetid://1037886723",hats.Army.Formals.Enlisted},
			{"E6","rbxassetid://1037876566","rbxassetid://1037886723",hats.Army.Formals.Enlisted},
			{"E7","rbxassetid://1037877210","rbxassetid://1037886723",hats.Army.Formals.E7E9B},
			{"E8a","rbxassetid://1037877812","rbxassetid://1037886723",hats.Army.Formals.E7E9B},
			{"E8b","rbxassetid://1037878365","rbxassetid://1037886723",hats.Army.Formals.E7E9B},
			{"E9a","rbxassetid://1037878965","rbxassetid://1037886723",hats.Army.Formals.E7E9B},
			{"E9b","rbxassetid://1037879646","rbxassetid://1037886723",hats.Army.Formals.E7E9B},
			{"E9c","rbxassetid://1037880024","rbxassetid://1037886723",hats.Army.Formals.E9C},
			{"O1","rbxassetid://1037880339","rbxassetid://1037886723",hats.Army.Formals.O1O3},
			{"O2","rbxassetid://1037880955","rbxassetid://1037886723",hats.Army.Formals.O1O3},
			{"O3","rbxassetid://1037881275","rbxassetid://1037886723",hats.Army.Formals.O1O3},
			{"O4","rbxassetid://1037881632","rbxassetid://1037886723",hats.Army.Formals.O4O6},
			{"O5","rbxassetid://1037882436","rbxassetid://1037886723",hats.Army.Formals.O4O6},
			{"O6","rbxassetid://1037882756","rbxassetid://1037886723",hats.Army.Formals.O4O6},
			{"O7","rbxassetid://1037883069","rbxassetid://1037887436",hats.Army.Formals.O7O10},			
			{"O8","rbxassetid://1037883742","rbxassetid://1037887436",hats.Army.Formals.O7O10},
			{"O9","rbxassetid://1037884619","rbxassetid://1037887436",hats.Army.Formals.O7O10},
			{"O10","rbxassetid://1037884875","rbxassetid://1037887436",hats.Army.Formals.O7O10}
		},
		["Army Greens"] = {
			{"E1","rbxassetid://4528636326","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E2","rbxassetid://4528636326","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E3","rbxassetid://4528638696","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E4","rbxassetid://4528640078","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E5","rbxassetid://4528641120","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E6","rbxassetid://4528642875","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E7","rbxassetid://4528649634","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E8a","rbxassetid://4528650669","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E8b","rbxassetid://4528651354","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E9a","rbxassetid://4528652322","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E9b","rbxassetid://4528665549","rbxassetid://4528518686",hats.Army.PGs.Enlisted},
			{"E9c","rbxassetid://1037872421","rbxassetid://4528518686",hats.Army.PGs.SMA},
			{"W1-CW5","rbxassetid://4528668744","rbxassetid://4528518686",hats.Army.PGs.JuniorOfficer},
			{"O1","rbxassetid://4528670850","rbxassetid://4528518686",hats.Army.PGs.JuniorOfficer},
			{"O2","rbxassetid://4528668744","rbxassetid://4528518686",hats.Army.PGs.JuniorOfficer},
			{"O3","rbxassetid://4528671624","rbxassetid://4528518686",hats.Army.PGs.JuniorOfficer},
			{"O4","rbxassetid://4528673653","rbxassetid://4528518686",hats.Army.PGs.JuniorOfficer},
			{"O5","rbxassetid://4528689464","rbxassetid://4528518686",hats.Army.PGs.SeniorOfficer},
			{"O6","rbxassetid://4528688694","rbxassetid://4528518686",hats.Army.PGs.SeniorOfficer},
			{"O7","rbxassetid://4528691779","rbxassetid://4528518686",hats.Army.PGs.FlagOfficer},
			{"O8","rbxassetid://4528692689","rbxassetid://4528518686",hats.Army.PGs.FlagOfficer},
			{"O9","rbxassetid://4740647488","rbxassetid://4528518686",hats.Army.PGs.FlagOfficer},
			{"O10","rbxassetid://4740648142","rbxassetid://4528518686",hats.Army.PGs.FlagOfficer},
		},
		["Special Forces Class A"] = {
			{"E1","rbxassetid://1037871096","rbxassetid://1037886034",hats.Army.GreenBerets.Enlisted},
			{"E2","rbxassetid://1037872421","rbxassetid://1037886034",hats.Army.GreenBerets.Enlisted},
			{"E3","rbxassetid://1037873077","rbxassetid://1037886034",hats.Army.GreenBerets.Enlisted},
			{"E4","rbxassetid://1037873463","rbxassetid://1037886723",hats.Army.GreenBerets.Enlisted},
			{"E5","rbxassetid://1037875737","rbxassetid://1037886723",hats.Army.GreenBerets.Enlisted},
			{"E6","rbxassetid://1037876566","rbxassetid://1037886723",hats.Army.GreenBerets.Enlisted},
			{"E7","rbxassetid://1037877210","rbxassetid://1037886723",hats.Army.GreenBerets.Enlisted},
			{"E8a","rbxassetid://1037877812","rbxassetid://1037886723",hats.Army.GreenBerets.Enlisted},
			{"E8b","rbxassetid://1037878365","rbxassetid://1037886723",hats.Army.GreenBerets.Enlisted},
			{"E9a","rbxassetid://1037878965","rbxassetid://1037886723",hats.Army.GreenBerets.Enlisted},
			{"E9b","rbxassetid://1037879646","rbxassetid://1037886723",hats.Army.GreenBerets.Enlisted},
			{"E9c","rbxassetid://1037880024","rbxassetid://1037886723",hats.Army.GreenBerets.Enlisted},
			{"O1","rbxassetid://1037880339","rbxassetid://1037886723",hats.Army.GreenBerets.O1},
			{"O2","rbxassetid://1037880955","rbxassetid://1037886723",hats.Army.GreenBerets.O2},
			{"O3","rbxassetid://1037881275","rbxassetid://1037886723",hats.Army.GreenBerets.O3},
			{"O4","rbxassetid://1037881632","rbxassetid://1037886723",hats.Army.GreenBerets.O4},
			{"O5","rbxassetid://1037882436","rbxassetid://1037886723",hats.Army.GreenBerets.O5},
			{"O6","rbxassetid://1037882756","rbxassetid://1037886723",hats.Army.GreenBerets.O6},
			{"O7","rbxassetid://1037883069","rbxassetid://1037887436",hats.Army.GreenBerets.O7},			
			{"O8","rbxassetid://1037883742","rbxassetid://1037887436",hats.Army.GreenBerets.O8},
			{"O9","rbxassetid://1037884619","rbxassetid://1037887436",hats.Army.GreenBerets.O9},
			{"O10","rbxassetid://1037884875","rbxassetid://1037887436",hats.Army.GreenBerets.O10}
		},
		["4ID Class A"] = {
			{"E1","rbxassetid://1037871096","rbxassetid://1037886034",hats.Army.Infantry.Enlisted},
			{"E2","rbxassetid://1037872421","rbxassetid://1037886034",hats.Army.Infantry.Enlisted},
			{"E3","rbxassetid://1037873077","rbxassetid://1037886034",hats.Army.Infantry.Enlisted},
			{"E4","rbxassetid://1037873463","rbxassetid://1037886723",hats.Army.Infantry.Enlisted},
			{"E5","rbxassetid://1037875737","rbxassetid://1037886723",hats.Army.Infantry.Enlisted},
			{"E6","rbxassetid://1037876566","rbxassetid://1037886723",hats.Army.Infantry.Enlisted},
			{"E7","rbxassetid://1037877210","rbxassetid://1037886723",hats.Army.Infantry.Enlisted},
			{"E8a","rbxassetid://1037877812","rbxassetid://1037886723",hats.Army.Infantry.Enlisted},
			{"E8b","rbxassetid://1037878365","rbxassetid://1037886723",hats.Army.Infantry.Enlisted},
			{"E9a","rbxassetid://1037878965","rbxassetid://1037886723",hats.Army.Infantry.Enlisted},
			{"E9b","rbxassetid://1037879646","rbxassetid://1037886723",hats.Army.Infantry.Enlisted},
			{"E9c","rbxassetid://1037880024","rbxassetid://1037886723",hats.Army.Infantry.Enlisted},
			{"O1","rbxassetid://1037880339","rbxassetid://1037886723",hats.Army.Infantry.O1},
			{"O2","rbxassetid://1037880955","rbxassetid://1037886723",hats.Army.Infantry.O2},
			{"O3","rbxassetid://1037881275","rbxassetid://1037886723",hats.Army.Infantry.O3},
			{"O4","rbxassetid://1037881632","rbxassetid://1037886723",hats.Army.Infantry.O4},
			{"O5","rbxassetid://1037882436","rbxassetid://1037886723",hats.Army.Infantry.O5},
			{"O6","rbxassetid://1037882756","rbxassetid://1037886723",hats.Army.Infantry.O6},
			{"O7","rbxassetid://1037883069","rbxassetid://1037887436",hats.Army.Infantry.O7},			
			{"O8","rbxassetid://1037883742","rbxassetid://1037887436",hats.Army.Infantry.O8},
			{"O9","rbxassetid://1037884619","rbxassetid://1037887436",hats.Army.Infantry.O9},
			{"O10","rbxassetid://1037884875","rbxassetid://1037887436",hats.Army.Infantry.O10}
		},
		["Rangers Class A"] = {
			{"E1","rbxassetid://1037871096","rbxassetid://1037886034",hats.Army.Rangers.Enlisted},
			{"E2","rbxassetid://1037872421","rbxassetid://1037886034",hats.Army.Rangers.Enlisted},
			{"E3","rbxassetid://1037873077","rbxassetid://1037886034",hats.Army.Rangers.Enlisted},
			{"E4","rbxassetid://1037873463","rbxassetid://1037886723",hats.Army.Rangers.Enlisted},
			{"E5","rbxassetid://1037875737","rbxassetid://1037886723",hats.Army.Rangers.Enlisted},
			{"E6","rbxassetid://1037876566","rbxassetid://1037886723",hats.Army.Rangers.Enlisted},
			{"E7","rbxassetid://1037877210","rbxassetid://1037886723",hats.Army.Rangers.Enlisted},
			{"E8a","rbxassetid://1037877812","rbxassetid://1037886723",hats.Army.Rangers.Enlisted},
			{"E8b","rbxassetid://1037878365","rbxassetid://1037886723",hats.Army.Rangers.Enlisted},
			{"E9a","rbxassetid://1037878965","rbxassetid://1037886723",hats.Army.Rangers.Enlisted},
			{"E9b","rbxassetid://1037879646","rbxassetid://1037886723",hats.Army.Rangers.Enlisted},
			{"E9c","rbxassetid://1037880024","rbxassetid://1037886723",hats.Army.Rangers.Enlisted},
			{"O1","rbxassetid://1037880339","rbxassetid://1037886723",hats.Army.Rangers.O1},
			{"O2","rbxassetid://1037880955","rbxassetid://1037886723",hats.Army.Rangers.O2},
			{"O3","rbxassetid://1037881275","rbxassetid://1037886723",hats.Army.Rangers.O3},
			{"O4","rbxassetid://1037881632","rbxassetid://1037886723",hats.Army.Rangers.O4},
			{"O5","rbxassetid://1037882436","rbxassetid://1037886723",hats.Army.Rangers.O5},
			{"O6","rbxassetid://1037882756","rbxassetid://1037886723",hats.Army.Rangers.O6},
			{"O7","rbxassetid://1037883069","rbxassetid://1037887436",hats.Army.Rangers.O7},			
			{"O8","rbxassetid://1037883742","rbxassetid://1037887436",hats.Army.Rangers.O8},
			{"O9","rbxassetid://1037884619","rbxassetid://1037887436",hats.Army.Rangers.O9},
			{"O10","rbxassetid://1037884875","rbxassetid://1037887436",hats.Army.Rangers.O10}
		},
		["Airborne Class A"] = {
			{"E1","rbxassetid://1037871096","rbxassetid://1037886034",hats.Army.Airborne.Enlisted},
			{"E2","rbxassetid://1037872421","rbxassetid://1037886034",hats.Army.Airborne.Enlisted},
			{"E3","rbxassetid://1037873077","rbxassetid://1037886034",hats.Army.Airborne.Enlisted},
			{"E4","rbxassetid://1037873463","rbxassetid://1037886723",hats.Army.Airborne.Enlisted},
			{"E5","rbxassetid://1037875737","rbxassetid://1037886723",hats.Army.Airborne.Enlisted},
			{"E6","rbxassetid://1037876566","rbxassetid://1037886723",hats.Army.Airborne.Enlisted},
			{"E7","rbxassetid://1037877210","rbxassetid://1037886723",hats.Army.Airborne.Enlisted},
			{"E8a","rbxassetid://1037877812","rbxassetid://1037886723",hats.Army.Airborne.Enlisted},
			{"E8b","rbxassetid://1037878365","rbxassetid://1037886723",hats.Army.Airborne.Enlisted},
			{"E9a","rbxassetid://1037878965","rbxassetid://1037886723",hats.Army.Airborne.Enlisted},
			{"E9b","rbxassetid://1037879646","rbxassetid://1037886723",hats.Army.Airborne.Enlisted},
			{"E9c","rbxassetid://1037880024","rbxassetid://1037886723",hats.Army.Airborne.Enlisted},
			{"O1","rbxassetid://1037880339","rbxassetid://1037886723",hats.Army.Airborne.O1},
			{"O2","rbxassetid://1037880955","rbxassetid://1037886723",hats.Army.Airborne.O2},
			{"O3","rbxassetid://1037881275","rbxassetid://1037886723",hats.Army.Airborne.O3},
			{"O4","rbxassetid://1037881632","rbxassetid://1037886723",hats.Army.Airborne.O4},
			{"O5","rbxassetid://1037882436","rbxassetid://1037886723",hats.Army.Airborne.O5},
			{"O6","rbxassetid://1037882756","rbxassetid://1037886723",hats.Army.Airborne.O6},
			{"O7","rbxassetid://1037883069","rbxassetid://1037887436",hats.Army.Airborne.O7},			
			{"O8","rbxassetid://1037883742","rbxassetid://1037887436",hats.Army.Airborne.O8},
			{"O9","rbxassetid://1037884619","rbxassetid://1037887436",hats.Army.Airborne.O9},
			{"O10","rbxassetid://1037884875","rbxassetid://1037887436",hats.Army.Airborne.O10}
		},
		["3ID ACU OCP"] = {
			{"E1","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E1},
			{"E2","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E2},
			{"E3","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E3},
			{"E4a","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E4a},
			{"E4b","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E4b},
			{"E5","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E5},
			{"E6","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E6},
			{"E7","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E7},
			{"E8a","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E8ab},
			{"E8b","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E8ab},
			{"E9a","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E9ab},
			{"E9b","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E9ab},
			{"E9c","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.E9c},
			{"O1","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O1},
			{"O2","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O2},
			{"O3","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O3},
			{"O4","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O4},
			{"O5","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O5},
			{"O6","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O6},
			{"O7","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O7},			
			{"O8","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O8},
			{"O9","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O9},
			{"O10","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O10},
			{"O11","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O11},
			{"O12","rbxassetid://3612402658","rbxassetid://3499595529",hats.Army.PatrolCaps.O12}
		},
		["TRADOC ACU OCP"] = {
			{"Infantry Drill Sgt","rbxassetid://3499589725","rbxassetid://3499595529",hats.Army.DI},
			{"Standard Drill Sgt","rbxassetid://3499589725","rbxassetid://3499595529",hats.Army.InfantryDS},
			{"E2","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E2},
			{"E3","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E3},
			{"E4a","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E4a},
			{"E4b","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E4b},
			{"E5","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E5},
			{"E6","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E6},
			{"E7","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E7},
			{"E8a","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E8ab},
			{"E8b","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E8ab},
			{"E9a","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E9ab},
			{"E9b","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E9ab},
			{"E9c","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.E9c},
			{"O1","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O1},
			{"O2","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O2},
			{"O3","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O3},
			{"O4","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O4},
			{"O5","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O5},
			{"O6","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O6},
			{"O7","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O7},			
			{"O8","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O8},
			{"O9","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O9},
			{"O10","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O10},
			{"O11","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O11},
			{"O12","rbxassetid://3499591028","rbxassetid://3499595529",hats.Army.PatrolCaps.O12}
		},
		["Combats"] = {
			{"3ID V1","rbxassetid://3612405160","rbxassetid://3499595529",hats.Army.PatrolCaps.E1},
			{"3ID V2","rbxassetid://3612406199","rbxassetid://3499595529",hats.Army.PatrolCaps.E1},
			{"3ID V3","rbxassetid://3612407112","rbxassetid://3499595529",hats.Army.PatrolCaps.E1},
			{"Standard","rbxassetid://3499592633","rbxassetid://3499595529",hats.Army.PatrolCaps.E1},
			{"TRADOC","rbxassetid://3499591576","rbxassetid://3499595529",hats.Army.PatrolCaps.E1},
			{"DOD","rbxassetid://3499600117","rbxassetid://3499595529",hats.Army.PatrolCaps.E1},
		},
		["1st SFAB ACU OCP"] = {
			{"E1","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E2","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E3","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E4","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E5","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E6","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E7","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E8a","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E8b","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E9a","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E9b","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"E9c","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.Enlisted},
			{"O1","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O1},
			{"O2","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O2},
			{"O3","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O3},
			{"O4","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O4},
			{"O5","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O5},
			{"O6","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O6},
			{"O7","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O7},			
			{"O8","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O8},
			{"O9","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O9},
			{"O10","rbxassetid://1280014889","rbxassetid://1275047229",hats.Army.Infantry.O10}
		},
		["Standard ACU OCP"] = {
			{"E1","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E1},
			{"E2","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E2},
			{"E3","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E3},
			{"E4a","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E4a},
			{"E4b","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E4b},
			{"E5","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E5},
			{"E6","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E6},
			{"E7","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E7},
			{"E8a","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E8ab},
			{"E8b","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E8ab},
			{"E9a","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E9ab},
			{"E9b","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E9ab},
			{"E9c","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.E9c},
			{"O1","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O1},
			{"O2","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O2},
			{"O3","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O3},
			{"O4","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O4},
			{"O5","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O5},
			{"O6","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O6},
			{"O7","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O7},			
			{"O8","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O8},
			{"O9","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O9},
			{"O10","rbxassetid://1320186657","rbxassetid://1275047229",hats.Army.PatrolCaps.O10}
		},
		["Standard Class B"] = {
			{"E1","rbxassetid://1049880392","rbxassetid://1049904134",hats.Army.Formals.Enlisted},
			{"E2","rbxassetid://1049881360","rbxassetid://1049904134",hats.Army.Formals.Enlisted},
			{"E3","rbxassetid://1049885840","rbxassetid://1049904134",hats.Army.Formals.Enlisted},
			{"E4a","rbxassetid://1049886806","rbxassetid://1049904883",hats.Army.Formals.Enlisted},
			{"E4b","rbxassetid://1049888240","rrbxassetid://1049904883",hats.Army.Formals.Enlisted},
			{"E5","rbxassetid://1049889209","rbxassetid://1049904883",hats.Army.Formals.Enlisted},
			{"E6","rbxassetid://1049890109","rbxassetid://1049904883",hats.Army.Formals.Enlisted},
			{"E7","rbxassetid://1049891204","rbxassetid://1049904883",hats.Army.Formals.E7E9B},
			{"E8a","rbxassetid://1049892896","rbxassetid://1049904883",hats.Army.Formals.E7E9B},
			{"E8b","rbxassetid://1049893781","rbxassetid://1049904883",hats.Army.Formals.E7E9B},
			{"E9a","rbxassetid://1049894366","rbxassetid://1049904883",hats.Army.Formals.E7E9B},
			{"E9b","rbxassetid://1049895079","rbxassetid://1049904883",hats.Army.Formals.E7E9B},
			{"E9c","rbxassetid://1049895800","rrbxassetid://1049904883",hats.Army.Formals.E9C},
			{"O1","rbxassetid://1049896790","rbxassetid://1049904883",hats.Army.Formals.O1O3},
			{"O2","rbxassetid://1049898050","rbxassetid://1049904883",hats.Army.Formals.O1O3},
			{"O3","rbxassetid://1049899104","rbxassetid://1049904883",hats.Army.Formals.O1O3},
			{"O4","rbxassetid://1049899641","rbxassetid://1049904883",hats.Army.Formals.O4O6},
			{"O5","rbxassetid://1049900723","rbxassetid://1049904883",hats.Army.Formals.O4O6},
			{"O6","rbxassetid://1049901079","rbxassetid://1049904883",hats.Army.Formals.O4O6},
			{"O7","rbxassetid://1049901722","rbxassetid://1049905375",hats.Army.Formals.O7O10},			
			{"O8","rbxassetid://1049902105","rbxassetid://1049905375",hats.Army.Formals.O7O10},
			{"O9","rbxassetid://1049902478","rbxassetid://1049905375",hats.Army.Formals.O7O10},
			{"O10","rbxassetid://1049902856","rbxassetid://1049905375",hats.Army.Formals.O7O10}
		},
		["Special Forces Class B"] = {
			{"E1","rbxassetid://1049880392","rbxassetid://1049904134",hats.Army.GreenBerets.Enlisted},
			{"E2","rbxassetid://1049881360","rbxassetid://1049904134",hats.Army.GreenBerets.Enlisted},
			{"E3","rbxassetid://1049885840","rbxassetid://1049904134",hats.Army.GreenBerets.Enlisted},
			{"E4a","rbxassetid://1049886806","rbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"E4b","rbxassetid://1049888240","rrbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"E5","rbxassetid://1049889209","rbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"E6","rbxassetid://1049890109","rbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"E7","rbxassetid://1049891204","rbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"E8a","rbxassetid://1049892896","rbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"E8b","rbxassetid://1049893781","rbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"E9a","rbxassetid://1049894366","rbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"E9b","rbxassetid://1049895079","rbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"E9c","rbxassetid://1049895800","rrbxassetid://1049904883",hats.Army.GreenBerets.Enlisted},
			{"O1","rbxassetid://1049896790","rbxassetid://1049904883",hats.Army.GreenBerets.O1},
			{"O2","rbxassetid://1049898050","rbxassetid://1049904883",hats.Army.GreenBerets.O2},
			{"O3","rbxassetid://1049899104","rbxassetid://1049904883",hats.Army.GreenBerets.O3},
			{"O4","rbxassetid://1049899641","rbxassetid://1049904883",hats.Army.GreenBerets.O4},
			{"O5","rbxassetid://1049900723","rbxassetid://1049904883",hats.Army.GreenBerets.O5},
			{"O6","rbxassetid://1049901079","rbxassetid://1049904883",hats.Army.GreenBerets.O6},
			{"O7","rbxassetid://1049901722","rbxassetid://1049905375",hats.Army.GreenBerets.O7},			
			{"O8","rbxassetid://1049902105","rbxassetid://1049905375",hats.Army.GreenBerets.O8},
			{"O9","rbxassetid://1049902478","rbxassetid://1049905375",hats.Army.GreenBerets.O9},
			{"O10","rbxassetid://1049902856","rbxassetid://1049905375",hats.Army.GreenBerets.O10}
		},
		["4ID Class B"] = {
			{"E1","rbxassetid://1049880392","rbxassetid://1049904134",hats.Army.Infantry.Enlisted},
			{"E2","rbxassetid://1049881360","rbxassetid://1049904134",hats.Army.Infantry.Enlisted},
			{"E3","rbxassetid://1049885840","rbxassetid://1049904134",hats.Army.Infantry.Enlisted},
			{"E4a","rbxassetid://1049886806","rbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"E4b","rbxassetid://1049888240","rrbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"E5","rbxassetid://1049889209","rbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"E6","rbxassetid://1049890109","rbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"E7","rbxassetid://1049891204","rbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"E8a","rbxassetid://1049892896","rbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"E8b","rbxassetid://1049893781","rbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"E9a","rbxassetid://1049894366","rbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"E9b","rbxassetid://1049895079","rbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"E9c","rbxassetid://1049895800","rrbxassetid://1049904883",hats.Army.Infantry.Enlisted},
			{"O1","rbxassetid://1049896790","rbxassetid://1049904883",hats.Army.Infantry.O1},
			{"O2","rbxassetid://1049898050","rbxassetid://1049904883",hats.Army.Infantry.O2},
			{"O3","rbxassetid://1049899104","rbxassetid://1049904883",hats.Army.Infantry.O3},
			{"O4","rbxassetid://1049899641","rbxassetid://1049904883",hats.Army.Infantry.O4},
			{"O5","rbxassetid://1049900723","rbxassetid://1049904883",hats.Army.Infantry.O5},
			{"O6","rbxassetid://1049901079","rbxassetid://1049904883",hats.Army.Infantry.O6},
			{"O7","rbxassetid://1049901722","rbxassetid://1049905375",hats.Army.Infantry.O7},			
			{"O8","rbxassetid://1049902105","rbxassetid://1049905375",hats.Army.Infantry.O8},
			{"O9","rbxassetid://1049902478","rbxassetid://1049905375",hats.Army.Infantry.O9},
			{"O10","rbxassetid://1049902856","rbxassetid://1049905375",hats.Army.Infantry.O10}
		},
		["Rangers Class B"] = {
			{"E1","rbxassetid://1049880392","rbxassetid://1049904134",hats.Army.Rangers.Enlisted},
			{"E2","rbxassetid://1049881360","rbxassetid://1049904134",hats.Army.Rangers.Enlisted},
			{"E3","rbxassetid://1049885840","rbxassetid://1049904134",hats.Army.Rangers.Enlisted},
			{"E4a","rbxassetid://1049886806","rbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"E4b","rbxassetid://1049888240","rrbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"E5","rbxassetid://1049889209","rbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"E6","rbxassetid://1049890109","rbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"E7","rbxassetid://1049891204","rbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"E8a","rbxassetid://1049892896","rbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"E8b","rbxassetid://1049893781","rbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"E9a","rbxassetid://1049894366","rbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"E9b","rbxassetid://1049895079","rbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"E9c","rbxassetid://1049895800","rrbxassetid://1049904883",hats.Army.Rangers.Enlisted},
			{"O1","rbxassetid://1049896790","rbxassetid://1049904883",hats.Army.Rangers.O1},
			{"O2","rbxassetid://1049898050","rbxassetid://1049904883",hats.Army.Rangers.O2},
			{"O3","rbxassetid://1049899104","rbxassetid://1049904883",hats.Army.Rangers.O3},
			{"O4","rbxassetid://1049899641","rbxassetid://1049904883",hats.Army.Rangers.O4},
			{"O5","rbxassetid://1049900723","rbxassetid://1049904883",hats.Army.Rangers.O5},
			{"O6","rbxassetid://1049901079","rbxassetid://1049904883",hats.Army.Rangers.O6},
			{"O7","rbxassetid://1049901722","rbxassetid://1049905375",hats.Army.Rangers.O7},			
			{"O8","rbxassetid://1049902105","rbxassetid://1049905375",hats.Army.Rangers.O8},
			{"O9","rbxassetid://1049902478","rbxassetid://1049905375",hats.Army.Rangers.O9},
			{"O10","rbxassetid://1049902856","rbxassetid://1049905375",hats.Army.Rangers.O10}
		},
		["Airborne Class B"] = {
			{"E1","rbxassetid://1049880392","rbxassetid://1049904134",hats.Army.Airborne.Enlisted},
			{"E2","rbxassetid://1049881360","rbxassetid://1049904134",hats.Army.Airborne.Enlisted},
			{"E3","rbxassetid://1049885840","rbxassetid://1049904134",hats.Army.Airborne.Enlisted},
			{"E4a","rbxassetid://1049886806","rbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"E4b","rbxassetid://1049888240","rrbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"E5","rbxassetid://1049889209","rbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"E6","rbxassetid://1049890109","rbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"E7","rbxassetid://1049891204","rbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"E8a","rbxassetid://1049892896","rbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"E8b","rbxassetid://1049893781","rbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"E9a","rbxassetid://1049894366","rbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"E9b","rbxassetid://1049895079","rbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"E9c","rbxassetid://1049895800","rrbxassetid://1049904883",hats.Army.Airborne.Enlisted},
			{"O1","rbxassetid://1049896790","rbxassetid://1049904883",hats.Army.Airborne.O1},
			{"O2","rbxassetid://1049898050","rbxassetid://1049904883",hats.Army.Airborne.O2},
			{"O3","rbxassetid://1049899104","rbxassetid://1049904883",hats.Army.Airborne.O3},
			{"O4","rbxassetid://1049899641","rbxassetid://1049904883",hats.Army.Airborne.O4},
			{"O5","rbxassetid://1049900723","rbxassetid://1049904883",hats.Army.Airborne.O5},
			{"O6","rbxassetid://1049901079","rbxassetid://1049904883",hats.Army.Airborne.O6},
			{"O7","rbxassetid://1049901722","rbxassetid://1049905375",hats.Army.Airborne.O7},			
			{"O8","rbxassetid://1049902105","rbxassetid://1049905375",hats.Army.Airborne.O8},
			{"O9","rbxassetid://1049902478","rbxassetid://1049905375",hats.Army.Airborne.O9},
			{"O10","rbxassetid://1049902856","rbxassetid://1049905375",hats.Army.Airborne.O10}
		},
	},
	["Air Force"] = {
		["Standard ABUs"] = {
			{"E1-O10","rbxassetid://577585621","rbxassetid://577462948",hats.AirForce.ABUCap},
		},
		["MTI ABUs"] = {
			{"E1-E9d","rbxassetid://577585621","rbxassetid://577462948",hats.AirForce.MTI},
		},
		["Combat (Type I) ABUs"] = {
			{"E1-O10","rbxassetid://623452575","rbxassetid://623452755",hats.AirForce.Helmet},
		},
		["Combat (Type II) ABUs"] = {
			{"E1-O10","rbxassetid://695114272","rbxassetid://623452755",hats.AirForce.Helmet},
		},
		["Physical Training"] = {
			{"E1-E9d","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.Enlisted},
			{"O1","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O1},
			{"O2","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O2},
			{"O3","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O3},
			{"O4","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O4},
			{"O5","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O5},
			{"O6","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O6},
			{"O7","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O7},
			{"O8","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O8},
			{"O9","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O9},
			{"O10","rbxassetid://197076770","rbxassetid://197076814",hats.AirForce.Garrison.O10},
		},
		["Flight Suit"] = {
			{"E1-O10","rbxassetid://340024871","rbxassetid://340027082",hats.AirForce.FlightHelmet},
		},
		["OCP"] = {
			{"E1-O10","rbxassetid://3482272982","rbxassetid://3482274766",hats.AirForce.OCPCap},
		},
		["Dress Blues"] = {
			{"E1","rbxassetid://6323958515","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E2","rbxassetid://6323958515","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E3","rbxassetid://6323957911","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E4","rbxassetid://6323956903","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E5","rbxassetid://6323955770","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E6","rbxassetid://6323954460","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E7","rbxassetid://6323953293","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E8","rbxassetid://6309957844","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E9a","rbxassetid://6309952194","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E9b","rbxassetid://6309950209","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"E9c","rbxassetid://6309949687","rbxassetid://6309746686",hats.AirForce.Formals.Enlisted},
			{"O1","rbxassetid://6309943272","rbxassetid://6309746686",hats.AirForce.Formals.O1O3},
			{"O2","rbxassetid://6309737528","rbxassetid://6309746686",hats.AirForce.Formals.O1O3},
			{"O3","rbxassetid://6309736891","rbxassetid://6309746686",hats.AirForce.Formals.O1O3},
			{"O4","rbxassetid://6309736251","rbxassetid://6309746686",hats.AirForce.Formals.O4O6},
			{"O5","rbxassetid://6309734944","rbxassetid://6309746686",hats.AirForce.Formals.O4O6},
			{"O6","rbxassetid://6309734311","rbxassetid://6309746686",hats.AirForce.Formals.O4O6},
			{"O7","rbxassetid://6309733481","rbxassetid://6309746686",hats.AirForce.Formals.O7O10},
			{"O8","rbxassetid://6309732865","rbxassetid://6309746686",hats.AirForce.Formals.O7O10},
			{"O9","rbxassetid://6309732207","rbxassetid://6309746686",hats.AirForce.Formals.O7O10},
			{"O10","rbxassetid://6309731567","rbxassetid://6309746686",hats.AirForce.Formals.O7O10},
		},
		["Class B"] = {
			{"E1","rbxassetid://955550151","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E2","rbxassetid://612217814","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E3","rbxassetid://612218043","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E4","rbxassetid://612219995","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E5","rbxassetid://612220323","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E6","rbxassetid://612220706","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E7","rbxassetid://612221152","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E8","rbxassetid://612221475","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E9a","rbxassetid://954491907","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E9b","rbxassetid://612222122","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"E9c","rbxassetid://612222354","rbxassetid://612214495",hats.AirForce.Garrison.Enlisted},
			{"O1","rbxassetid://612223414","rbxassetid://612214495",hats.AirForce.Garrison.O1},
			{"O2","rbxassetid://612223600","rbxassetid://612214495",hats.AirForce.Garrison.O2},
			{"O3","rbxassetid://612223778","rbxassetid://612214495",hats.AirForce.Garrison.O3},
			{"O4","rbxassetid://612224063","rbxassetid://612214495",hats.AirForce.Garrison.O4},
			{"O5","rbxassetid://612224328","rbxassetid://612214495",hats.AirForce.Garrison.O5},
			{"O6","rbxassetid://612224674","rbxassetid://612214495",hats.AirForce.Garrison.O6},
			{"O7","rbxassetid://612224965","rbxassetid://612214495",hats.AirForce.Garrison.O7},
			{"O8","rbxassetid://612225323","rbxassetid://612214495",hats.AirForce.Garrison.O8},
			{"O9","rbxassetid://612225609","rbxassetid://612214495",hats.AirForce.Garrison.O9},
			{"O10","rbxassetid://612226077","rbxassetid://612214495",hats.AirForce.Garrison.O10},
		},
	},
	["Coast Guard"] = {
		["Dress Blues"] = {
			{"E1","rbxassetid://3404246051","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E2","rbxassetid://3404258185","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E3","rbxassetid://3404260121","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E4","rbxassetid://3404260974","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E5","rbxassetid://3404261767","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E6","rbxassetid://3511792008","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E7","rbxassetid://3404274567","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E8","rbxassetid://3404275371","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E9a","rbxassetid://3404276172","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E9b","rbxassetid://3404277013","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"E9c","rbxassetid://3404277911","rbxassetid://3404318760",hats.CoastGuard.DressBlues.Enlisted},
			{"O1","rbxassetid://3404296154","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O1O3},
			{"O2","rbxassetid://3404297012","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O1O3},
			{"O3","rbxassetid://3404297778","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O1O3},
			{"O4","rbxassetid://3404298520","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O4O6},
			{"O5","rbxassetid://3404300124","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O4O6},
			{"O6","rbxassetid://3404301039","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O4O6},
			{"O7","rbxassetid://3404308745","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O7O10},
			{"O8","rbxassetid://3404309541","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O7O10},
			{"O9","rbxassetid://3404310563","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O7O10},
			{"O10","rbxassetid://3404311480","rbxassetid://3404318760",hats.CoastGuard.DressBlues.O7O10}
		},
	},
	["Space Force"] = {
		["Class A"] = {
			{"E1","rbxassetid://6560445608","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"E2","rbxassetid://6560445608","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"E3","rbxassetid://6560445288","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"E4","rbxassetid://6560445043","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"E5","rbxassetid://6560444808","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"E6","rbxassetid://6560444559","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"E7","rbxassetid://6560444309","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"E8","rbxassetid://6560444084","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"E9a","rbxassetid://6560443805","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"E9b","rbxassetid://6560443628","rbxassetid://6560448662",hats.SpaceForce.Formals.Enlisted},
			{"O1","rbxassetid://6560443448","rbxassetid://6560448662",hats.SpaceForce.Formals.O1O3},
			{"O2","rbxassetid://6560443063","rbxassetid://6560448662",hats.SpaceForce.Formals.O1O3},
			{"O3","rbxassetid://6560442801","rbxassetid://6560448662",hats.SpaceForce.Formals.O1O3},
			{"O4","rbxassetid://6560442593","rbxassetid://6560448662",hats.SpaceForce.Formals.O4O6},
			{"O5","rbxassetid://6560442346","rbxassetid://6560448662",hats.SpaceForce.Formals.O4O6},
			{"O6","rbxassetid://6560442065","rbxassetid://6560448662",hats.SpaceForce.Formals.O4O6},
			{"O7","rbxassetid://6560441842","rbxassetid://6560448662",hats.SpaceForce.Formals.O7O10},
			{"O8","rbxassetid://6560441579","rbxassetid://6560448662",hats.SpaceForce.Formals.O7O10},
			{"O9","rbxassetid://6560441288","rbxassetid://6560448662",hats.SpaceForce.Formals.O7O10},
			{"O10","rbxassetid://6560441049","rbxassetid://6560448662",hats.SpaceForce.Formals.O7O10},
		},
		["Class B"] = {
			{"E1-O10","rbxassetid://6560446573","rbxassetid://6560449140",hats.SpaceForce.Formals.Enlisted},
		},
		["Class C"] = {
			{"E1-E9B","rbxassetid://6560446931","rbxassetid://6560449140",hats.SpaceForce.Garrison.E1E9B},
			{"O1-O3","rbxassetid://6560446931","rbxassetid://6560449140",hats.SpaceForce.Formals.O1O3},
			{"O4-O6","rbxassetid://6560446931","rbxassetid://6560449140",hats.SpaceForce.Formals.O4O6},
			{"O7-O10","rbxassetid://6560446931","rbxassetid://6560449140",hats.SpaceForce.Formals.O7O10},
		},
	},
}

-----[FUNCTIONS]-----
function closeGui()
	override = true
	
	main:TweenPosition(UDim2.new(.25,0,1.2,0),"Out","Quad",.15,true)
	wait(.15)
	open:TweenPosition(UDim2.new(0,0,.94,0),"Out","Bounce",.1,true)
	
	visible(false)
	main.Selection.Text = ""
	uni.Visible = false
	rank.Visible = false
	cover.Visible = false
	branch.Visible = true
	rank.CanvasPosition = Vector2.new()
	uni.CanvasPosition = Vector2.new()
	for i,v in pairs(uni:GetChildren()) do
		if v.Name ~= "Template" then
			v:Destroy()
		end
	end
	for i,v in pairs(rank:GetChildren()) do
		if v.Name ~= "Template" then
			v:Destroy()
		end
	end
	plrInfo.Branch.Value = ""
	plrInfo.Type.Value = ""
	plrInfo.Paygrade.Value = ""
	plrInfo.CoverOnly.Value = ""
end

function dictLength(dict)
	local x = 0
	table.foreach(dict, function()x=x+1 end)
	return x
end

function displayOptions(branchName)
	local j = 0
	local numUniTypes = dictLength(USM[branchName])
	uni.CanvasSize = UDim2.new(0,0,(0.075*numUniTypes),0)
	
	for i,v in pairs(USM[branchName]) do
		if not override then
			j = j+1
			local newUniform = uni.Template:clone()
			newUniform.Parent = uni
			newUniform.Visible = true
			newUniform.TextLabel.Text = i
			newUniform.Name = i
			if uni.CanvasSize.Y.Scale > 0.7 then
				newUniform.Size = UDim2.new(0.8,0,(1/numUniTypes)-0.005,0)
				newUniform:TweenPosition(UDim2.new(.1,0,((1/numUniTypes)*(j-1)),0),"Out","Quad",.1,true)
			else
				newUniform.Size = UDim2.new(0.8,0,0.085,0)
				newUniform:TweenPosition(UDim2.new(.1,0,(.09 * (j-1)),0),"Out","Quad",.1,true)
			end
			wait()
		else
			break
		end
	end
end

function displayRanks()
	local branchName = plrInfo.Branch.Value
	local typeChoice = plrInfo.Type.Value
	local numRanks = dictLength(USM[branchName][typeChoice])
	rank.CanvasSize = UDim2.new(0,0,(0.075*numRanks),0)
	
	for i = 1,dictLength(USM[branchName][typeChoice]) do
		if not override then
			local newUniform = rank.Template:clone()
			newUniform.Parent = rank
			newUniform.Visible = true
			newUniform.TextLabel.Text = USM[branchName][typeChoice][i][1]
			newUniform.Name = USM[branchName][typeChoice][i][1]
			if rank.CanvasSize.Y.Scale > 0.7 then
				newUniform.Size = UDim2.new(0.8,0,(1/numRanks)-0.005,0)
				newUniform:TweenPosition(UDim2.new(.1,0,((1/numRanks)*(i-1)),0),"Out","Quad",.1,true)
			else
				newUniform.Size = UDim2.new(0.8,0,0.085,0)
				newUniform:TweenPosition(UDim2.new(.1,0,(.09 * (i-1)),0),"Out","Quad",.1,true)
			end
			--newUniform:TweenPosition(UDim2.new(.05,0,.005 + (.035 * (i-1)),0),"Out","Quad",.1,true)
			wait()
		else
			break
		end
	end
end

function fadeInLogos()
	for i = 1,0,-.1 do
		if not override then
			branch.Navy.ImageTransparency = i
			branch.AirForce.ImageTransparency = i
			branch.Army.ImageTransparency = i
			branch.Marines.ImageTransparency = i
			branch.CoastGuard.ImageTransparency = i
			branch.SpaceForce.ImageTransparency = i
			wait()
		else
			break
		end
	end
end

function fadeOutLogos()
	for i = 0,1,.1 do
		if not override then
			branch.Navy.ImageTransparency = i
			branch.AirForce.ImageTransparency = i
			branch.Army.ImageTransparency = i
			branch.Marines.ImageTransparency = i
			branch.CoastGuard.ImageTransparency = i
			branch.SpaceForce.ImageTransparency = i
			wait()
		else
			break
		end
	end
end

function writeText(text,gui)
	for i = 1,#text do
		if not override then
			if i > 1 and gui.Text == "" then break end
			gui.Text = gui.Text..string.sub(text,i,i)
			wait(.025)
		else
			break
		end
	end
end

function visible(bool)
	branch.Navy.Visible = bool
	branch.AirForce.Visible = bool
	branch.Army.Visible = bool
	branch.Marines.Visible = bool
	branch.CoastGuard.Visible = bool
	branch.SpaceForce.Visible = bool
end

function trans(num)
	branch.Navy.ImageTransparency = num
	branch.AirForce.ImageTransparency = num
	branch.Army.ImageTransparency = num
	branch.Marines.ImageTransparency = num
	branch.CoastGuard.ImageTransparency = num
	branch.SpaceForce.ImageTransparency = num
end

function wearUniform()
	for i,v in pairs(USM) do
		if i == plrInfo.Branch.Value then
			for j,k in pairs(USM[i]) do
				if j == plrInfo.Type.Value then
					for o = 1,dictLength(USM[plrInfo.Branch.Value][plrInfo.Type.Value]) do
						if USM[plrInfo.Branch.Value][plrInfo.Type.Value][o][1] == plrInfo.Paygrade.Value then
							game.ReplicatedStorage.ExchangeServerScript.Wear:FireServer(USM[i][j][o],plrInfo.CoverOnly.Value)
							break
						end
					end
					break
				end
			end
			break
		end
	end
end

-----[EVENTS]-----
open.Activated:connect(function()
	override = false
	
	rank.Visible = false
	uni.Visible = false
	branch.Visible = true
	cover.Visible = false
	
	--Open mainframe & close open button
	open:TweenPosition(UDim2.new(-0.1,0,.94,0),"Out","Quad",.15,true)
	main:TweenPosition(UDim2.new(.25,0,.275,0),"Out","Quad",.25,true)
	
	--Reset the guis to the starting position
	trans(1)
	main.Selection.Text = ""
	
	writeText("Select your branch",main.Selection)
	visible(true)
	fadeInLogos()
end)

main.Close.Activated:connect(function()
	closeGui()
end)

branch.Navy.Activated:connect(function()
	fadeOutLogos()
	
	plrInfo.Branch.Value = "Navy"
	
	--Switch to the uniform selection gui
	branch.Visible = false
	uni.Visible = true
	main.Selection.Text = ""
	
	writeText("Select your uniform",main.Selection)	
	displayOptions("Navy")
end)

branch.Marines.Activated:connect(function()
	fadeOutLogos()
	
	plrInfo.Branch.Value = "Marines"
	
	branch.Visible = false
	uni.Visible = true
	main.Selection.Text = ""
	
	writeText("Select your uniform",main.Selection)	
	displayOptions("Marines")
end)

branch.Army.Activated:connect(function()
	fadeOutLogos()
	
	plrInfo.Branch.Value = "Army"
	
	branch.Visible = false
	uni.Visible = true
	main.Selection.Text = ""
	
	writeText("Select your uniform",main.Selection)	
	displayOptions("Army")
end)

branch.AirForce.Activated:connect(function()
	fadeOutLogos()
	
	plrInfo.Branch.Value = "Air Force"
	
	branch.Visible = false
	uni.Visible = true
	main.Selection.Text = ""
	
	writeText("Select your uniform",main.Selection)	
	displayOptions("Air Force")
end)

branch.CoastGuard.Activated:connect(function()
	fadeOutLogos()

	plrInfo.Branch.Value = "Coast Guard"

	branch.Visible = false
	uni.Visible = true
	main.Selection.Text = ""

	writeText("Select your uniform",main.Selection)	
	displayOptions("Coast Guard")
end)

branch.SpaceForce.Activated:connect(function()
	fadeOutLogos()

	plrInfo.Branch.Value = "Space Force"

	branch.Visible = false
	uni.Visible = true
	main.Selection.Text = ""

	writeText("Select your uniform",main.Selection)	
	displayOptions("Space Force")
end)

plrInfo:WaitForChild("Type").Changed:connect(function()
	if plrInfo.Type.Value ~= "" then
		--Remove the uniform types
		for i,v in pairs(uni:GetChildren()) do
			if v.Name ~= "Template" then
				v:Destroy()
			end
		end
		uni.Visible = false
		rank.Visible = true
		main.Selection.Text = ""
		writeText("Select your paygrade",main.Selection)
		displayRanks()
	end
end)

plrInfo:WaitForChild("Paygrade").Changed:connect(function()
	if plrInfo.Paygrade.Value ~= "" then
		cover.Full.ImageTransparency = 1
		cover.Cover.ImageTransparency = 1
		for i,v in pairs(rank:GetChildren()) do
			if v.Name ~= "Template" then
				v:Destroy()
			end
		end
		rank.Visible = false
		cover.Visible = true
		main.Selection.Text = ""
		writeText("Do you need the full uniform or only the cover?",main.Selection)
		for i = 1,0,-.05 do
			cover.Full.ImageTransparency = i
			cover.Cover.ImageTransparency = i
			wait()
		end
	end
end)

plrInfo:WaitForChild("CoverOnly").Changed:connect(function()
	if plrInfo.CoverOnly.Value ~= "" then
		wearUniform()
		closeGui()
	end
end)

--Created by devTools for NUSM