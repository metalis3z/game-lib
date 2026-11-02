--!strict
-- LOCAL
local Credits = {}


-- TYPES
export type ContributorMember = {
	UserId: number,
	Name: string,
}
export type ContributorGroup = {
	Name: string,
	Members: { ContributorMember },
}
export type Library = {
	Name: string,
	Image: string,
	Link: string,
}


-- CONTRIBUTORS
Credits.Contributors = {
	{
		Name = "Creator",
		Members = {
			{ UserId = 82347291,  Name = "ForeverHD" },
		},
	},
	{
		Name = "UI",
		Members = {
			{ UserId = 144146784, Name = "ImAvafe" },
		},
	},
	{
		Name = "Lead",
		Members = {
			{ UserId = 46138509,   Name = "ObliviousHD" },
			{ UserId = 14398127,   Name = "H_mzah" },
		},
	},
	{
		Name = "Team",
		Members = {
			{ UserId = 75323,      Name = "1waffle1" },
			{ UserId = 1884609078, Name = "RazaT_D" },
			{ UserId = 421194271,  Name = "haash_im" },
			{ UserId = 195261420,  Name = "OptimisticSide" },
			{ UserId = 14943069,   Name = "Alvin_Blox" },
			{ UserId = 126451147,  Name = "Lucke0051" },
			{ UserId = 127522050,  Name = "taycrius" },
			{ UserId = 2718647678, Name = "Mavreis" },
			{ UserId = 13683770,   Name = "Naperin" },
			{ UserId = 6121439357, Name = "AdamStarrLawyer" },
		},
	},
	{
		Name = "Contributors",
		Members = {
			{ UserId = 2243026817, Name = "do_small" },
			{ UserId = 954868167,  Name = "iscreator" },
			{ UserId = 5420068,    Name = "hiddodev" },
			{ UserId = 1041190634, Name = "iM1GHTB3DANI" },
			{ UserId = 30255387,   Name = "dirtywheel" },
			{ UserId = 68136726,   Name = "JohnnyMorganz" },
			{ UserId = 484140,     Name = "GigsD4X" },
		},
	},
	{
		Name = "Inspiration",
		Members = {
			{ UserId = 44391621,   Name = "Scripth" },
			{ UserId = 698712377,  Name = "Davey_Bones" },
			{ UserId = 214258,     Name = "Person299" },
			{ UserId = 1670764,    Name = "elttob" },
			{ UserId = 2155311,    Name = "EgoMoose" },
			{ UserId = 2312310,    Name = "loleris" },
			{ UserId = 308165,     Name = "sleitnick" },
			{ UserId = 4397833,    Name = "quenty" },
			{ UserId = 671440392,  Name = "BitwiseAndrea" },
			{ UserId = 13953438,   Name = "NewFissy" },
			{ UserId = 25691148,   Name = "TheNexusAvenger" },
			{ UserId = 1718501381, Name = "luckydroz" },
			{ UserId = 92658764,   Name = "evaera" },
			{ UserId = 379082633,  Name = "ZEDDxR" },
		},
	},
} :: { ContributorGroup }


-- LIBRARIES
Credits.Libraries = {
	{
		Name = "OnyxUI",
		Image = "rbxassetid://117638619043810",
		Link = "https://create.roblox.com/store/asset/119264982349837/OnyxUI",
	},
	{
		Name = "Fusion",
		Image = "rbxassetid://138940190831315",
		Link = "Fusion By Elttob",
	},
	{
		Name = "TopbarPlus",
		Image = "rbxassetid://78061770654469",
		Link = "https://create.roblox.com/store/asset/92368439343389/TopbarPlus",
	},
} :: { Library }


return Credits
