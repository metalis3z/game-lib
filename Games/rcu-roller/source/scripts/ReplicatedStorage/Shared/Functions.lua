-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:54
-- Luau version 6, Types version 3
-- Time taken: 0.001809 seconds

local module_2 = {
	suffixes = require(script.Suffixes);
	id = require(script.Id);
	print = require(script.Print);
	deepCopy = require(script.DeepCopy);
	toCamel = require(script.ToCamel);
	toPascal = require(script.ToPascal);
	getAmountInTable = require(script.GetAmountInTable);
	comma = require(script.Comma);
	bezierTweens = require(script.BezierTweens);
	floatingPoint = require(script.FloatingPoint);
	aOrAn = require(script.AorAn);
	getHRP = require(script.GetHRP);
	getHumanoid = require(script.GetHumanoid);
	evalColorSequence = require(script.EvalColorSequence);
	getUserHeadshot = require(script.GetUserHeadshot);
	toHMS = require(script.ToHMS);
	getRandom = require(script.GetRandom);
	formatTime = require(script.FormatTime);
	formatTime2 = require(script.FormatTime2);
	getParentUntilModel = require(script.GetParentUntilModel);
	getParentUntilFolder = require(script.GetParentUntilFolder);
	anonymizeNumberString = require(script.AnonymizeNumberString);
	formatUnix = require(script.FormatUnix);
	filterText = require(script.FilterText);
	compressValue = require(script.CompressValue);
	decompressValue = require(script.DecompressValue);
	getWeekNumber = require(script.GetWeekNumber);
	getWeekOs = require(script.GetWeekOs);
	getPriceInRobux = require(script.GetPriceInRobux);
	getProductInfo = require(script.GetProductInfo);
	tweens = require(script.Tweens);
	lerp = require(script.Lerp);
	isInGroup = require(script.IsInGroup);
	suffixToNumber = require(script.SuffixToNumber);
	getRankInGroup = require(script.GetRankInGroup);
}
for _, v in script:GetDescendants() do
	if v:IsA("ModuleScript") then
		local var14 = string.sub(v.Name, 1, 1):lower()..string.sub(v.Name, 2, -1)
		if not module_2[var14] then
			module_2[var14] = require(v)
		end
	end
end
return module_2