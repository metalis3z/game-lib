-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZATAEbWF0aAVmbG9vcgh0b3N0cmluZwNsb2cDcG93BnN0cmluZwZmb3JtYXQEJS4xZgQlLjAkAARnc3ViAj8/BkZvcm1hdAFrAU0BQgFUAnFkAlFuAnN4AlNwAU8BTgJkZQACCgEBAAAGAwAABQECNisAAgBvAQAAggECALsMAANSAgAApAEDAAAIEICfAQICUgABAIwB6ANgAAcAAQAAALs/AANSAgAApAEFAAAAQECfAQICggECAIERAAUGAAAAUgMAAG8EBgCkAggAABwQgJ8CAwK7DAICpAEDAAAIEICfAQICjAMKAFsEAQmeFQMDBAAAAKQCCwAAKBCAnwIDAuwDAAKkBA4AADTAgG8FDwBSBgMAnwQDAm8HEABvCBEAvAUEzBIAAACfBQQCUgQFAFIGBAD7CQAAhwgJAZAHCBNzBQYHggUCABQDAQMCAwMEAAgQgAMEBAAAQEACAAAAAABAj0ADBQQAHBCAAgAAAAAAAAhAAwYEACgQgAMHAwgEADTAgAMJAwoDCwMMAw0ACA4BGAAAAAEAAAAAAAIAAAEAAAAAAAQAAAAAAAAAAAAAAwAAAAAAAAEDAAAAAAMAAAAAAAQAAAAAAAkAAAAADQAAAQIAF6MAAAD/AAEAAAAAAP8BAAALAAAAbwIAAG8DAQBvBAIAbwUDAG8GBABvBwUAbwgGAG8JBwBvCggAbwsJAG8MCgDFAQIMAQAAAMACCwASAAEAMAIArQwAAACCAAIADQMPAxADEQMSAxMDFAMVAxYDFwMYAxkGAAMOAQABAAEYAAMAAgAAAAAAAAAAAAAAAAAAAgAAABoBAAAAAAFzsPYJZpsgT0mFP4ERmrojA6jhfUF0nAg=

-- decompilation:
local v0 = {};
local v1 = {
    "k", 
    "M", 
    "B", 
    "T", 
    "qd", 
    "Qn", 
    "sx", 
    "Sp", 
    "O", 
    "N", 
    "de"
};
v0.Format = function(v2) --[[ Line: 8 ]] --[[ Name: Format ]]
    -- upvalues: v1 (copy)
    if not v2 then
        return "0";
    else
        v2 = math.floor(v2);
        if v2 < 1000 then
            return (tostring(v2));
        else
            local v3 = math.floor((math.log(v2, 1000)));
            local v4 = v2 / math.pow(10, v3 * 3);
            return string.format("%.1f", v4):gsub("%.0$", "") .. (v1[v3] or "??");
        end;
    end;
end;
return v0;
