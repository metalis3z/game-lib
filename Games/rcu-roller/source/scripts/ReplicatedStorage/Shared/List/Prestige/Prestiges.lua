-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:53
-- Luau version 6, Types version 3
-- Time taken: 0.004822 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {{
	title = 'I';
	required = 2500;
	icon = "rbxassetid://75530557642043";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 253, 219))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.potion("luck"):setAmount(1), Items.potion("clicks"):setAmount(1), Items.fruit("grape"):setAmount(1)};
}, {
	title = "II";
	required = 5000;
	icon = "rbxassetid://109826466940566";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 250, 219))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.mount("basicHoverboard"), Items.potion("gems"):setAmount(1), Items.potion("luck"):setAmount(1), Items.fruit("carrot"):setAmount(1)};
}, {
	title = "III";
	required = 10000;
	icon = "rbxassetid://93183319987833";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 247, 219))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.potion("luck"):setAmount(1), Items.potion("hatch"):setAmount(1), Items.box("fruitsBox"):setAmount(1), Items.upgrade("auraLuck"):setAmount(0.05)};
}, {
	title = "IV";
	required = 25000;
	icon = "rbxassetid://125376863099598";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 243, 220))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.auraDice("voidAuraDice"):setAmount(1), Items.box("potionsBox"):setAmount(1), Items.box("fruitsBox"):setAmount(1), Items.potion("luck"):setAmount(2), Items.fruit("strawberry"):setAmount(2)};
}, {
	title = 'V';
	required = 50000;
	icon = "rbxassetid://111724970654118";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 240, 220))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.box("potionsBox"):setAmount(1), Items.box("fruitsBox"):setAmount(1), Items.upgrade("gemsMultiplier"):setAmount(0.05), Items.potion("luck"):setAmount(3), Items.potion("hatch"):setAmount(3)};
}, {
	title = "VI";
	required = 100000;
	icon = "rbxassetid://113093629083498";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 237, 220))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.box("potionsBox"):setAmount(1), Items.box("fruitsBox"):setAmount(1), Items.auraDice("voidAuraDice"):setAmount(3), Items.potion("megaLuck"):setAmount(5), Items.potion("hatch"):setAmount(10), Items.upgrade("clicksMultiplier"):setAmount(0.05)};
}, {
	title = "VII";
	required = 250000;
	icon = "rbxassetid://129016240701268";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 234, 220))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.auraDice("voidAuraDice"):setAmount(10), Items.fruit("goldenCarrot"):setAmount(5), Items.box("potionsBox"):setAmount(3), Items.box("fruitsBox"):setAmount(3), Items.upgrade("luckMultiplier"):setAmount(0.05), Items.exclusive("epicLuck"):setAmount(1)};
}, {
	title = "VIII";
	required = 500000;
	icon = "rbxassetid://83716310287045";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 231, 220))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.exclusive("epicLuck"):setAmount(1), Items.exclusive("ancientTicket"):setAmount(30), Items.box("potionsChest"):setAmount(1), Items.box("fruitsChest"):setAmount(1), Items.booth("futureBooth"), Items.upgrade("luckMultiplier"):setAmount(0.05)};
}, {
	title = "IX";
	required = 1000000;
	icon = "rbxassetid://85885901051174";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 227, 221))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.auraDice("royalAuraDice"):setAmount(1), Items.box("potionsChest"):setAmount(3), Items.box("fruitsChest"):setAmount(3), Items.box("fruitsBox"):setAmount(10), Items.upgrade("luckMultiplier"):setAmount(0.05), Items.upgrade("hatchSpeed"):setAmount(0.05)};
}, {
	title = 'X';
	required = 2500000;
	icon = "rbxassetid://77185344530337";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 224, 221))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.auraDice("royalAuraDice"):setAmount(5), Items.box("potionsChest"):setAmount(5), Items.box("fruitsChest"):setAmount(5), Items.upgrade("petsEquipped"):setAmount(1), Items.upgrade("gemsMultiplier"):setAmount(0.05), Items.upgrade("goldenPetsLuck"):setAmount(0.5)};
}, {
	title = "XI";
	required = 5000000;
	icon = "rbxassetid://76292876047397";
	backgroundGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 221, 219))});
	textGradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255))});
	textStroke = Color3.fromRGB(34, 64, 102);
	rewards = {Items.auraDice("insaneAuraDice"):setAmount(3), Items.auraDice("royalAuraDice"):setAmount(10), Items.box("potionsChest"):setAmount(10), Items.box("fruitsChest"):setAmount(10), Items.upgrade("luckMultiplier"):setAmount(0.1), Items.upgrade("shinyPetsLuck"):setAmount(0.25)};
}}