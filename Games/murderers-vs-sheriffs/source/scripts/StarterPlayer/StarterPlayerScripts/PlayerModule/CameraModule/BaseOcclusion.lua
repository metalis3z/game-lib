-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
setmetatable(v0, {
    __call = function(_, ...)
        return v0.new(...);
    end
});
v0.new = function()
    return (setmetatable({}, v0));
end;
v0.CharacterAdded = function(_, _, _)

end;
v0.CharacterRemoving = function(_, _, _)

end;
v0.OnCameraSubjectChanged = function(_, _)

end;
v0.GetOcclusionMode = function(_)
    warn("BaseOcclusion GetOcclusionMode must be overridden by derived classes");
    return nil;
end;
v0.Enable = function(_, _)
    warn("BaseOcclusion Enable must be overridden by derived classes");
end;
v0.Update = function(_, _, v15, v16)
    warn("BaseOcclusion Update must be overridden by derived classes");
    return v15, v16;
end;
return v0;