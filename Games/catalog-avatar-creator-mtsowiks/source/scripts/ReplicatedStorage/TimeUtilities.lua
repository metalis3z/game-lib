-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    GetRelativeTimeString = function(p1) -- Line: 3, Name: GetRelativeTimeString
        local v2 = DateTime.now().UnixTimestamp - p1.UnixTimestamp;

        if v2 < 1 then
            return "Just now";
        end;

        for _, v in ipairs({ { 31536000, "year" }, { 2592000, "month" }, { 604800, "week" }, { 86400, "day" }, { 3600, "hour" }, { 60, "minute" }, { 1, "second" } }) do
            local v3 = v[1];
            local v4 = v[2];

            if v3 <= v2 then
                local v5 = math.floor(v2 / v3);

                if v5 ~= 1 then
                    v4 = v4 .. "s";
                end;

                return tostring(v5) .. " " .. v4 .. " ago";
            end;
        end;

        return "Just now";
    end,

    FormatCommentTime = function(p6) -- Line: 37, Name: FormatCommentTime
        local v7 = os.time() - p6;
        local v8 = math.max(0, v7);
        local v9 = os.date("*t", p6);
        local v10 = string.format("%s %d, %d", ({ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" })[v9.month], v9.day, v9.year);
        local v11 = DateTime.fromUnixTimestamp(p6):FormatLocalTime("hh:mm a", "en-us");
        local v12;

        if v8 == 0 then
            v12 = "Just now";
        elseif v8 < 60 then
            v12 = v8 .. " second" .. (v8 == 1 and "" or "s") .. " ago";
        elseif v8 < 3600 then
            local v13 = math.floor(v8 / 60);
            v12 = v13 .. " minute" .. (v13 == 1 and "" or "s") .. " ago";
        elseif v8 < 86400 then
            local v14 = math.floor(v8 / 3600);
            v12 = v14 .. " hour" .. (v14 == 1 and "" or "s") .. " ago";
        elseif v8 < 604800 then
            local v15 = math.floor(v8 / 86400);
            v12 = v15 .. " day" .. (v15 == 1 and "" or "s") .. " ago";
        elseif v8 < 2592000 then
            local v16 = math.floor(v8 / 604800);
            v12 = v16 .. " week" .. (v16 == 1 and "" or "s") .. " ago";
        elseif v8 < 31536000 then
            local v17 = math.floor(v8 / 2592000);
            v12 = v17 .. " month" .. (v17 == 1 and "" or "s") .. " ago";
        else
            local v18 = math.floor(v8 / 31536000);
            v12 = v18 .. " year" .. (v18 == 1 and "" or "s") .. " ago";
        end;

        return string.format("%s | %s · %s", v10, v11, v12);
    end
};