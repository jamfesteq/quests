local cash = {
    [1] = {100, 500},
    [2] = {100, 500},
    [3] = {100, 500},
    [4] = {100, 500},
    [5] = {100, 500},
    [6] = {100, 600},
    [7] = {100, 700},
    [8] = {100, 800},
    [9] = {100, 900},
    [10] = {200, 1000},
    [11] = {200, 1200},
    [12] = {200, 1400},
    [13] = {200, 1600},
    [14] = {200, 1800},
    [15] = {200, 2000},
    [16] = {200, 2200},
    [17] = {200, 2400},
    [18] = {200, 2600},
    [19] = {200, 2800},
    [20] = {500, 5000},
    [21] = {500, 5000},
    [22] = {500, 5000},
    [23] = {500, 5000},
    [24] = {500, 5000},
    [25] = {500, 5000},
    [26] = {500, 5000},
    [27] = {500, 5000},
    [28] = {500, 5000},
    [29] = {500, 5000},
    [30] = {1000, 10000},
    [31] = {1000, 10000},
    [32] = {1000, 10000},
    [33] = {1000, 10000},
    [34] = {1000, 10000},
    [35] = {1000, 10000},
    [36] = {1000, 10000},
    [37] = {1000, 10000},
    [38] = {1000, 10000},
    [39] = {1000, 10000},
    [40] = {5000, 30000},
    [41] = {5000, 30000},
    [42] = {5000, 30000},
    [43] = {5000, 30000},
    [44] = {5000, 30000},
    [45] = {5000, 30000},
    [46] = {5000, 30000},
    [47] = {5000, 30000},
    [48] = {5000, 30000},
    [49] = {5000, 30000},
    [50] = {10000, 50000},
    [51] = {10000, 50000},
    [52] = {10000, 50000},
    [53] = {10000, 50000},
    [54] = {10000, 50000},
    [55] = {10000, 50000},
    [56] = {10000, 50000},
    [57] = {10000, 50000},
    [58] = {10000, 50000},
    [59] = {10000, 50000},
    [60] = {10000, 80000},
    [61] = {10000, 80000},
    [62] = {10000, 80000},
    [63] = {10000, 80000},
    [64] = {10000, 80000},
    [65] = {10000, 80000},
    [66] = {10000, 80000},
    [67] = {10000, 80000},
    [68] = {10000, 80000},
    [69] = {10000, 80000},
    [70] = {10000, 150000},
    [71] = {10000, 150000},
    [72] = {10000, 150000},
    [73] = {10000, 150000},
    [74] = {10000, 150000},
    [75] = {10000, 150000},
    [76] = {10000, 150000},
    [77] = {10000, 150000},
    [78] = {10000, 150000},
    [79] = {10000, 150000},
    [80] = {10000, 180000},
    [81] = {10000, 180000},
    [82] = {10000, 180000},
    [83] = {10000, 180000},
    [84] = {10000, 180000},
    [85] = {10000, 180000},
    [86] = {10000, 180000},
    [87] = {10000, 180000},
    [88] = {10000, 180000},
    [89] = {10000, 180000},
    [90] = {10000, 200000},
    [91] = {10000, 200000},
    [92] = {10000, 200000},
    [93] = {10000, 200000},
    [94] = {10000, 200000},
    [95] = {10000, 200000},
    [96] = {10000, 200000},
    [97] = {10000, 200000},
    [98] = {10000, 200000},
    [99] = {10000, 200000},
    [100] = {10000, 200000},
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
