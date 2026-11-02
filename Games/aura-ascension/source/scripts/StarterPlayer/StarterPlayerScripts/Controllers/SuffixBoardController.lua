-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_SuffixBoardFrame_0 = require(script.Parent.Parent:WaitForChild("Handlers"):WaitForChild("SuffixBoardFrame"));
local v3 = l_Knit_0.CreateController({
    Name = "UIController"
});
v3.KnitStart = function(_) --[[ Line: 10 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_SuffixBoardFrame_0 (copy)
    l_SuffixBoardFrame_0:Init({
        MaxGroup = 601
    });
end;
return v3;