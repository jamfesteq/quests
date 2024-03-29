local cash = {
    [1] = {1, 500},
    [2] = {1, 500},
    [3] = {1, 500},
    [4] = {1, 500},
    [5] = {1, 500},
    [6] = {1, 600},
    [7] = {1, 700},
    [8] = {1, 800},
    [9] = {1, 900},
    [10] = {1, 1000},
    [11] = {1, 1200},
    [12] = {1, 1400},
    [13] = {1, 1600},
    [14] = {1, 1800},
    [15] = {1, 2000},
    [16] = {1, 2200},
    [17] = {1, 2400},
    [18] = {1, 2600},
    [19] = {1, 2800},
    [20] = {1, 5000},
    [21] = {1, 5000},
    [22] = {1, 5000},
    [23] = {1, 5000},
    [24] = {1, 5000},
    [25] = {1, 5000},
    [26] = {1, 5000},
    [27] = {1, 5000},
    [28] = {1, 5000},
    [29] = {1, 5000},
    [30] = {1, 10000},
    [31] = {1, 10000},
    [32] = {1, 10000},
    [33] = {1, 10000},
    [34] = {1, 10000},
    [35] = {1, 10000},
    [36] = {1, 10000},
    [37] = {1, 10000},
    [38] = {1, 10000},
    [39] = {1, 10000},
    [40] = {1, 30000},
    [41] = {1, 30000},
    [42] = {1, 30000},
    [43] = {1, 30000},
    [44] = {1, 30000},
    [45] = {1, 30000},
    [46] = {1, 30000},
    [47] = {1, 30000},
    [48] = {1, 30000},
    [49] = {1, 30000},
    [50] = {1, 50000},
    [51] = {1, 50000},
    [52] = {1, 50000},
    [53] = {1, 50000},
    [54] = {1, 50000},
    [55] = {1, 50000},
    [56] = {1, 50000},
    [57] = {1, 50000},
    [58] = {1, 50000},
    [59] = {1, 50000},
    [60] = {1, 80000},
    [61] = {1, 80000},
    [62] = {1, 80000},
    [63] = {1, 80000},
    [64] = {1, 80000},
    [65] = {1, 80000},
    [66] = {1, 80000},
    [67] = {1, 80000},
    [68] = {1, 80000},
    [69] = {1, 80000},
    [70] = {1, 150000},
    [71] = {1, 150000},
    [72] = {1, 150000},
    [73] = {1, 150000},
    [74] = {1, 150000},
    [75] = {1, 150000},
    [76] = {1, 150000},
    [77] = {1, 150000},
    [78] = {1, 150000},
    [79] = {1, 150000},
    [80] = {1, 180000},
    [81] = {1, 180000},
    [82] = {1, 180000},
    [83] = {1, 180000},
    [84] = {1, 180000},
    [85] = {1, 180000},
    [86] = {1, 180000},
    [87] = {1, 180000},
    [88] = {1, 180000},
    [89] = {1, 180000},
    [90] = {1, 200000},
    [91] = {1, 200000},
    [92] = {1, 200000},
    [93] = {1, 200000},
    [94] = {1, 200000},
    [95] = {1, 200000},
    [96] = {1, 200000},
    [97] = {1, 200000},
    [98] = {1, 200000},
    [99] = {1, 200000},
    [100] = {1, 200000},
}

---@param e NPCEventSay
function event_say(e)
    local guildmaster = require("guildmaster");
    guildmaster.do_buffs_and_ports(e);
end

---@param e NPCEventSpawn
function event_spawn(e)

    local level = e.self:GetLevel();
    local cash_info = cash[level];
    if level > 100 then
        cash_info = cash[100];
    end
    if level < 1 then
        cash_info = cash[1];
    end
    if (cash_info and not e.self:IsPet()) then
        local min = cash_info[1];
        local max = cash_info[2];
        local cash = math.random(min, max);

        if e.self:IsRareSpawn() then
            cash = cash * 10;
        end

        local plat = math.floor(cash / 1000);
        local gold = math.floor((cash - plat * 1000) / 100);
        local silver = math.floor((cash - plat * 1000 - gold * 100) / 10);
        local copper = cash - plat * 1000 - gold * 100 - silver * 10;
        ---e.self:Say(string.format("Rolled %d cash, %d plat, %d gold, %d silver, %d copper", cash, plat, gold, silver, copper))

        e.self:AddCash(copper, silver, gold, plat);
    end

    -- peq_halloween
    if (eq.is_content_flag_enabled("peq_halloween")) then
        -- exclude mounts and pets
        if (e.self:GetCleanName():findi("mount") or e.self:IsPet()) then
            return;
        end

        -- soulbinders
        -- priest of discord
        if (e.self:GetCleanName():findi("soulbinder") or e.self:GetCleanName():findi("priest of discord")) then
            e.self:ChangeRace(eq.ChooseRandom(14,60,82,85));
            e.self:ChangeSize(6);
            e.self:ChangeTexture(1);
            e.self:ChangeGender(2);
        end

        -- Shadow Haven
        -- The Bazaar
        -- The Plane of Knowledge
        -- Guild Lobby
        local halloween_zones = eq.Set { 202, 150, 151, 344 }
        local not_allowed_bodytypes = eq.Set { 11, 60, 66, 67 }
        if (halloween_zones[eq.get_zone_id()] and not_allowed_bodytypes[e.self:GetBodyType()] == nil) then
            e.self:ChangeRace(eq.ChooseRandom(14,60,82,85));
            e.self:ChangeSize(6);
            e.self:ChangeTexture(1);
            e.self:ChangeGender(2);
        end
    end
end
