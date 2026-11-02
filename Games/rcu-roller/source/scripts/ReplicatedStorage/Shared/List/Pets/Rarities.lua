-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:36
-- Luau version 6, Types version 3
-- Time taken: 0.005310 seconds

return {{
	name = "Common";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))});
	stroke = Color3.fromRGB(0, 32, 54);
	strokeGradient = false;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))});
		stroke = Color3.fromRGB(141, 141, 141);
		strokeGradient = false;
		gradientRotation = 90;
	};
}, {
	name = "Uncommon";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(206, 255, 210)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(234, 255, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(171, 255, 174))});
	stroke = Color3.fromRGB(0, 32, 54);
	strokeGradient = false;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 255, 41)), ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 190, 23))});
		stroke = Color3.fromRGB(7, 127, 11);
		strokeGradient = false;
		gradientRotation = 90;
	};
}, {
	name = "Rare";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 225, 226)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 242, 242)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 199, 199))});
	stroke = Color3.fromRGB(0, 32, 54);
	strokeGradient = false;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 126, 154)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 39, 125))});
		stroke = Color3.fromRGB(115, 11, 22);
		strokeGradient = false;
		gradientRotation = 90;
	};
}, {
	name = "Epic";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 235, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(247, 233, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(227, 188, 255))});
	stroke = Color3.fromRGB(0, 32, 54);
	strokeGradient = false;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(244, 97, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 35, 244))});
		stroke = Color3.fromRGB(98, 19, 118);
		strokeGradient = false;
		gradientRotation = 90;
	};
}, {
	name = "Legendary";
	exists = true;
	announce = "once";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(198, 255, 250)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(246, 255, 254)), ColorSequenceKeypoint.new(1, Color3.fromRGB(165, 234, 255))});
	stroke = Color3.fromRGB(0, 32, 54);
	strokeGradient = false;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 238)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 144, 255))});
		stroke = Color3.fromRGB(14, 76, 118);
		strokeGradient = false;
		gradientRotation = 90;
	};
	hatchColor = Color3.fromRGB(14, 191, 255);
	hatchPrefix = "Nice!";
}, {
	name = "Mythical";
	exists = true;
	hatchAnimation = true;
	announce = "always";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 182, 79)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(243, 255, 106)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 182, 79))});
	stroke = Color3.fromRGB(91, 56, 31);
	strokeGradient = true;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 64, 16))});
		stroke = Color3.fromRGB(99, 46, 29);
		strokeGradient = false;
		gradientRotation = 90;
	};
	hatchColor = Color3.fromRGB(255, 130, 58);
	hatchPrefix = "Wow!";
}, {
	name = "Eternal";
	exists = true;
	hatchAnimation = true;
	announce = "always";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(87, 253, 239)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(124, 170, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(187, 95, 253))});
	stroke = Color3.fromRGB(69, 43, 91);
	strokeGradient = true;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(1, 239, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(195, 61, 253))});
		stroke = Color3.fromRGB(20, 36, 131);
		strokeGradient = true;
		gradientRotation = 70;
	};
	hatchColor = Color3.fromRGB(136, 97, 253);
	hatchPrefix = "Lucky!";
}, {
	name = "Secret";
	exists = true;
	hatchAnimation = true;
	webhook = true;
	serial = true;
	announce = "always";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(253, 70, 73)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 143, 145)), ColorSequenceKeypoint.new(1, Color3.fromRGB(253, 44, 89))});
	stroke = Color3.fromRGB(91, 14, 25);
	strokeGradient = true;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 53, 114)), ColorSequenceKeypoint.new(1, Color3.fromRGB(231, 56, 79))});
		stroke = Color3.fromRGB(95, 9, 35);
		strokeGradient = false;
		gradientRotation = 90;
	};
	hatchColor = Color3.fromRGB(253, 70, 73);
	hatchPrefix = "😲 Amazing!";
	webhookColor = 16598601;
}, {
	name = "Exclusive";
	exists = true;
	announce = "always";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(253, 82, 199)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(253, 189, 241)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 64, 253))});
	stroke = Color3.fromRGB(62, 34, 91);
	strokeGradient = true;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 107, 198)), ColorSequenceKeypoint.new(1, Color3.fromRGB(223, 42, 255))});
		stroke = Color3.fromRGB(107, 31, 101);
		strokeGradient = false;
		gradientRotation = 90;
	};
	hatchColor = Color3.fromRGB(223, 42, 255);
	hatchPrefix = "Whoa!";
}, {
	name = "Supreme";
	exists = true;
	webhook = true;
	serial = true;
	announce = "always";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 248, 49)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 205, 172)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 112, 114))});
	stroke = Color3.fromRGB(115, 53, 34);
	strokeGradient = true;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 234, 73)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 78, 134))});
		stroke = Color3.fromRGB(122, 16, 23);
		strokeGradient = false;
		gradientRotation = 90;
	};
	hatchColor = Color3.fromRGB(255, 55, 152);
	hatchPrefix = "🤩 INCREDIBLE!";
	webhookColor = 16737792;
}, {
	name = "Ultimate";
	exists = true;
	webhook = true;
	serial = true;
	announce = "always";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 84, 87)), ColorSequenceKeypoint.new(0.166, Color3.fromRGB(255, 163, 57)), ColorSequenceKeypoint.new(0.332, Color3.fromRGB(255, 250, 102)), ColorSequenceKeypoint.new(0.499, Color3.fromRGB(90, 255, 90)), ColorSequenceKeypoint.new(0.665, Color3.fromRGB(88, 255, 244)), ColorSequenceKeypoint.new(0.831, Color3.fromRGB(113, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 121, 237))});
	stroke = Color3.fromRGB(62, 62, 62);
	strokeGradient = true;
	textColor = {
		gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 44, 90)), ColorSequenceKeypoint.new(0.15, Color3.fromRGB(255, 166, 42)), ColorSequenceKeypoint.new(0.296, Color3.fromRGB(251, 255, 42)), ColorSequenceKeypoint.new(0.458, Color3.fromRGB(71, 255, 61)), ColorSequenceKeypoint.new(0.587, Color3.fromRGB(66, 214, 255)), ColorSequenceKeypoint.new(0.739, Color3.fromRGB(64, 163, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 57, 245))});
		stroke = Color3.fromRGB(61, 61, 61);
		strokeGradient = true;
		gradientRotation = 82;
	};
	hatchColor = Color3.fromRGB(71, 255, 61);
	hatchPrefix = "UNBELIEVABLE!";
	webhookColor = 655104;
}}