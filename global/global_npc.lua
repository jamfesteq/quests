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
    do_buffs_and_ports(e);
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

        --e.self:Say(string.format("Before: %d plat, %d gold, %d silver, %d copper", e.self:GetPlatinum(), e.self:GetGold(), e.self:GetSilver(), e.self:GetCopper()))

        e.self:AddCash(e.self:GetCopper()+copper, e.self:GetSilver()+silver, e.self:GetGold()+gold, e.self:GetPlatinum()+plat);
        --e.self:Say(string.format("After: %d plat, %d gold, %d silver, %d copper", e.self:GetPlatinum(), e.self:GetGold(), e.self:GetSilver(), e.self:GetCopper()))
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

-- Continents for teleporting dialogues
continents = {}
continents["Antonica"] = 0
continents["Faydwer"] = 0
continents["Odus"] = 0
continents["Planar"] = 0
if (eq.is_the_ruins_of_kunark_enabled()) then
    continents["Kunark"] = 0 -- Kunark Only
end
if (eq.is_the_scars_of_velious_enabled()) then
    continents["Velious"] = 0 -- Velious Only
end
if (eq.is_the_shadows_of_luclin_enabled) then
    continents["Luclin"] = 0 -- Luclin Only
end
if (eq.is_gates_of_discord_enabled()) then
    continents["Gates of Discord"] = 0 -- Gates of Discord Only
end
if (eq.is_omens_of_war_enabled()) then
    continents["Omens of War"] = 0 -- Omens of War Only
end
if (eq.is_depths_of_darkhollow_enabled()) then
    continents["Depths of Darkhollow"] = 0 -- Depths of Darkhollow Only
end
if (eq.is_prophecy_of_ro_enabled()) then
    continents["Prophecy of Ro"] = 0 -- Prophecy of Ro Only
end
if (eq.is_the_serpents_spine_enabled()) then
    continents["The Serpent's Spine"] = 0 -- The Serpent's Spine Only
end
if (eq.is_the_buried_sea_enabled()) then
    continents["The Buried Sea"] = 0 -- The Buried Sea Only
end
if (eq.is_secrets_of_faydwer_enabled()) then
    continents["Secrets of Faydwer"] = 0 -- Secrets of Faydwer Only
end
if (eq.is_house_of_thule_enabled()) then
    continents["House of Thule"] = 0 -- House of Thule Only
end
if (eq.is_underfoot_enabled()) then
    continents["Underfoot"] = 0 -- Underfoot Only
end
if (eq.is_veil_of_alaris_enabled()) then
    continents["Veil of Alaris"] = 0 -- Veil of Alaris Only
end

---@param e NPCEventSay
function do_buffs_and_ports(e)
    local mob_class = e.self:GetClass()

    if (e.self:GetCleanName() == "Priest of Discord") then wizard_ports(e)
    elseif (mob_class == 21) then cleric_buffs(e)
    elseif (mob_class == 25) then druid_ports_and_buffs(e)
    elseif (mob_class == 29) then shaman_buffs(e)
    elseif (mob_class == 31) then wizard_ports(e)
    elseif (mob_class == 33) then enchanter_buffs(e)
    end
end

---@param client Client
function get_money_amount(client)
    local level = client:GetLevel()
    -- If the player is less than or equal to level 10, don't charge the player anything
    if level <= 10 then
        return 0
    end

    -- Otherwise, charge the player 1pp per level. 11 = 1pp, 60 = 50pp
    return (level-10)
end

---@param client Client
function take_money(client)
    local plat = get_money_amount(client)
    local copper = 1000 * get_money_amount(client)

    local result = client:TakeMoneyFromPP(copper, true)
    if result then
        client:Message(15, plat .. " platinum pieces have been removed from your inventory")
    end

    return result
end

---@param e NPCEventSay
function cleric_buffs(e)
    if (e.message:findi("buffs")) then
        if (take_money(e.other) ~= true) then
            e.other:Message(MT.Say, "I'm sorry, I cannot buff you unless you have sufficient money.")
            return
        end
        -- HP
        --  1 - Courage [202]
        --  9 - Center [219]
        --  19 - Daring [89]
        --  24 - Bravery [244]
        --  34 - Valor [312]
        --  44 - Resolution [314]
        --  52 - Heroism [1533]
        --  60 - Aegolism [1447]
        if (eq.is_the_scars_of_velious_enabled() and e.other:GetLevel() >= 60) then -- Velious only
            eq.SelfCast(1447)
        elseif e.other:GetLevel() >= 52 then
            eq.SelfCast(1533)
        elseif e.other:GetLevel() >= 44 then
            eq.SelfCast(314)
        elseif e.other:GetLevel() >= 34 then
            eq.SelfCast(312)
        elseif e.other:GetLevel() >= 24 then
            eq.SelfCast(244)
        elseif e.other:GetLevel() >= 19 then
            eq.SelfCast(89)
        elseif e.other:GetLevel() >= 9 then
            eq.SelfCast(219)
        else
            eq.SelfCast(202)
        end
        -- AC
        --  5 - Holy Armor [11]
        --  19 - Spirit Armor [368]
        --  29 - Guard [18]
        --  39 - Armor of Faith [19]
        --  49 - Shield of Words [20]
        --  57 - Bulwark of Faith [1537]
        if e.other:GetLevel() >= 57 then
            eq.SelfCast(1537)
        elseif e.other:GetLevel() >= 49 then
            eq.SelfCast(20)
        elseif e.other:GetLevel() >= 39 then
            eq.SelfCast(19)
        elseif e.other:GetLevel() >= 29 then
            eq.SelfCast(18)
        elseif e.other:GetLevel() >= 19 then
            eq.SelfCast(368)
        elseif e.other:GetLevel() >= 5 then
            eq.SelfCast(11)
        end
        -- Symbol
        --  14 - Symbol of Transal [485]
        --  24 - Symbol of Ryltan [486]
        --  34 - Symbol of Pinzarn [487]
        --  44 - Symbol of Naltron [488]
        --  54 - Symbol of Marzin [1535]
        if e.other:GetLevel() >= 54 then
            eq.SelfCast(1535)
        elseif e.other:GetLevel() >= 44 then
            eq.SelfCast(488)
        elseif e.other:GetLevel() >= 34 then
            eq.SelfCast(487)
        elseif e.other:GetLevel() >= 24 then
            eq.SelfCast(486)
        elseif e.other:GetLevel() >= 14 then
            eq.SelfCast(485)
        end
        -- CR
        --  14 - Endure Cold [225]
        --  39 - Resist Cold [61]
        if e.other:GetLevel() >= 39 then
            eq.SelfCast(61)
        elseif e.other:GetLevel() >= 14 then
            eq.SelfCast(225)
        end
        -- FR
        --  9 - Endure Fire [224]
        --  34 - Resist Fire [60]
        if e.other:GetLevel() >= 34 then
            eq.SelfCast(60)
        elseif e.other:GetLevel() >= 9 then
            eq.SelfCast(224)
        end
        -- DR
        --  14 - Endure Disease [226]
        --  39 - Resist Disease [63]
        if e.other:GetLevel() >= 39 then
            eq.SelfCast(63)
        elseif e.other:GetLevel() >= 14 then
            eq.SelfCast(226)
        end
        -- PR
        --  9 - Endure Poison [227]
        --  34 - Resist Poison [62]
        if e.other:GetLevel() >= 34 then
            eq.SelfCast(62)
        elseif e.other:GetLevel() >= 9 then
            eq.SelfCast(227)
        end
        -- MR
        --  19 - Endure Magic [228]
        --  44 - Resist Magic [64]
        if e.other:GetLevel() >= 44 then
            eq.SelfCast(64)
        elseif e.other:GetLevel() >= 19 then
            eq.SelfCast(228)
        end
    elseif (e.message:findi("bind")) then
		e.other:Message(MT.Say, "Binding your soul. You will return here when you die.");
		e.self:CastSpell(2049,e.other:GetID(),0,1); -- Spell: Bind Affinity
    else
        local plat = get_money_amount(e.other)
        if plat > 0 then
            e.other:Message(MT.Say, "As a cleric guildmaster, for a fee of " .. plat .. " platinum pieces, I can provide you with [" .. eq.say_link("buffs", true) .. "] or [" .. eq.say_link("bind", true) .. "] to assist you in your adventures.")
        else
            e.other:Message(MT.Say, "As a cleric guildmaster, for no fee, I can provide you with [" .. eq.say_link("buffs", true) .. "] or [" .. eq.say_link("bind", true) .. "] to assist you in your adventures.")
        end
    end
end

---@param e NPCEventSay
function druid_ports_and_buffs(e)
    local antonica_zones = {}
    antonica_zones["Lavastorm Mountains"] = 534
    antonica_zones["Misty Thicket"] = 538
    antonica_zones["North Karana"] = 530
    antonica_zones["South Ro"] = 535
    if (eq.is_the_scars_of_velious_enabled()) then
        antonica_zones["Surefall Glade"] = 2021 -- Velious Only
    end
    antonica_zones["The Feerott"] = 536
    antonica_zones["Western Commonlands"] = 531
    local faydwer_zones = {}
    faydwer_zones["Butcherblock Mountains"] = 532
    faydwer_zones["Steamfont Mountains"] = 537
    faydwer_zones["Surefall Glade"] = 2021
    local odus_zones = {}
    odus_zones["Toxxulia Forest"] = 533
    local kunark_zones = {} -- Kunark Only
    local planar_zones = {}
    if (eq.is_the_ruins_of_kunark_enabled()) then
        kunark_zones["Dreadlands"] = 1326
        kunark_zones["Emerald Jungle"] = 1737
        kunark_zones["Skyfire Mountains"] = 1736
    end
    local velious_zones = {} -- Velious Only
    if (eq.is_the_scars_of_velious_enabled()) then
        velious_zones["Cobalt Scar"] = 2031
        velious_zones["Iceclad Ocean"] = 1433
        velious_zones["The Great Divide"] = 2029
        velious_zones["Wakening Lands"] = 2030
    end
    local luclin_zones = {} -- Luclin Only
    if (eq.is_the_shadows_of_luclin_enabled()) then
        luclin_zones["Grimling Forest"] = 2417
        luclin_zones["Twilight Sea"] = 2422
        luclin_zones["Dawnshroud Peaks"] = 2427
        luclin_zones["Nexus"] = 2433
    end
    if (eq.is_the_planes_of_power_enabled()) then
        planar_zones["Plane of Knowledge"] = 3182
    end
    local god_zones = {} -- Gates of Discord Only
    if (eq.is_gates_of_discord_enabled()) then
        god_zones["Natimbi"] = 4967
        god_zones["Barindu"] = 5733
    end
    local oow_zones = {} -- Omens of War Only
    if (eq.is_omens_of_war_enabled()) then
        oow_zones["Wall of Slaughter"] = 6180
        oow_zones["Bloodfields"] = 6185
    end

    local dodh_zones = {} -- Depths of Darkhollow Only
    if (eq.is_depths_of_darkhollow_enabled()) then
        dodh_zones["Undershore"] = 8237
    end

    local por_zones = {} -- Prophecy of Ro Only
    if (eq.is_prophecy_of_ro_enabled()) then
        por_zones["Arcstone"] = 8967
    end

    local tss_zones = {} -- The Serpent's Spine Only
    if (eq.is_the_serpents_spine_enabled()) then
        tss_zones["Direwind"] = 9952
        tss_zones["Steppes"] = 9955
        tss_zones["Blightfire"] = 9958
    end

    local tbs_zones = {} -- The Buried Sea Only
    if (eq.is_the_buried_sea_enabled()) then
        tbs_zones["Buried Sea"] = 11982
    end

    local sof_zones = {} -- Secrets of Faydwer Only
    if (eq.is_secrets_of_faydwer_enabled()) then
        sof_zones["Loping Plains"] = 15888
    end

    local hot_zones = {} -- House of Thule Only
    if (eq.is_house_of_thule_enabled()) then
        hot_zones["The Grounds"] = 17882
    end

    local uf_zones = {} -- Underfoot Only
    if (eq.is_underfoot_enabled()) then
        uf_zones["Brell's Rest"] = 21986
    end

    local voa_zones = {} -- Veil of Alaris Only
    if (eq.is_veil_of_alaris_enabled()) then
        voa_zones["Beast's Domain"] = 28996
        voa_zones["Pillars of Alra"] = 28999
    end

    if (e.message:findi("buffs")) then
        if (take_money(e.other) ~= true) then
            e.other:Message(MT.Say, "I'm sorry, I cannot buff you unless you have sufficient money.")
            return
        end
        -- HP Type 1
        --  1 - Skin Like Wood  [26]
        --  14 - Skin Like Rock [263]
        --  24 - Skin Like Steel [421]
        --  39 - Skin Like Diamond [422]
        --  49 - Skin Like Nature [423]
        --  57 - Natureskin [1559]
        --  60 - Protection of the Glades [1442] -- Velious Only
        if (eq.is_the_scars_of_velious_enabled() and e.other:GetLevel() >= 60) then -- Velious Only
            eq.SelfCast(1442)
        elseif e.other:GetLevel() >= 57 then
            eq.SelfCast(1559)
        elseif e.other:GetLevel() >= 49 then
            eq.SelfCast(423)
        elseif e.other:GetLevel() >= 39 then
            eq.SelfCast(422)
        elseif e.other:GetLevel() >= 24 then
            eq.SelfCast(421)
        elseif e.other:GetLevel() >= 14 then
            eq.SelfCast(263)
        else
            eq.SelfCast(26)
        end
        -- STR
        --  9 - Strength of Earth [268]
        --  34 - Strength of Stone [429]
        --  44 - Storm Strength [430]
        --  55 - Girdle of Karana [1557]
        if e.other:GetLevel() >= 55 then
            eq.SelfCast(1557)
        elseif e.other:GetLevel() >= 44 then
            eq.SelfCast(430)
        elseif e.other:GetLevel() >= 34 then
            eq.SelfCast(429)
        elseif e.other:GetLevel() >= 9 then
            eq.SelfCast(268)
        end
        -- Regen
        --  34 - Regeneration [144]
        --  44 - Chloroplast [145]
        --  54 - Regrowth [1568]
        if e.other:GetLevel() >= 54 then
            eq.SelfCast(1568)
        elseif e.other:GetLevel() >= 44 then
            eq.SelfCast(145)
        elseif e.other:GetLevel() >= 34 then
            eq.SelfCast(144)
        end
        -- Damage Shield
        --  9 - Shield of Thistles [256]
        --  19 - Shield of Barbs [273]
        --  29 - Shield of Brambles [129]
        --  39 - Shield of Spikes [432]
        --  49 - Shield of Thorns [356]
        --  58 - Shield of Blades [1560]
        if e.other:GetLevel() >= 58 then
            eq.SelfCast(1560)
        elseif e.other:GetLevel() >= 49 then
            eq.SelfCast(356)
        elseif e.other:GetLevel() >= 39 then
            eq.SelfCast(432)
        elseif e.other:GetLevel() >= 29 then
            eq.SelfCast(129)
        elseif e.other:GetLevel() >= 19 then
            eq.SelfCast(273)
        elseif e.other:GetLevel() >= 9 then
            eq.SelfCast(256)
        end
        -- SoW
        --  14 - Spirit of Wolf [278]
        if e.other:GetLevel() >= 14 then
            eq.SelfCast(278)
        -- CR
        --  9 - Endure Cold [225]
        --  34 - Resist Cold [61]
        if e.other:GetLevel() >= 34 then
            eq.SelfCast(61)
        elseif e.other:GetLevel() >= 9 then
            eq.SelfCast(225)
        end
        -- FR
        --  1 - Endure Fire [224]
        --  24 - Resist Fire [60]
        if e.other:GetLevel() >= 24 then
            eq.SelfCast(60)
        else
            eq.SelfCast(224)
        end
        -- DR
        --  19 - Endure Disease [226]
        --  44 - Resist Disease [63]
        if e.other:GetLevel() >= 44 then
            eq.SelfCast(63)
        elseif e.other:GetLevel() >= 19 then
            eq.SelfCast(226)
        end
        -- PR
        --  19 - Endure Poison [227]
        --  44 - Resist Poison [62]
        if e.other:GetLevel() >= 44 then
            eq.SelfCast(62)
        elseif e.other:GetLevel() >= 19 then
            eq.SelfCast(227)
        end
        -- MR
        --  34 - Endure Magic [228]
        --  49 - Resist Magic [64]
        if e.other:GetLevel() >= 49 then
            eq.SelfCast(64)
        elseif e.other:GetLevel() >= 34 then
            eq.SelfCast(228)
        end
    end
    elseif (e.message:findi("teleport")) then
        e.other:Message(MT.Say, "I can teleport you to the following continents: " .. build_say_links(continents))
    elseif (e.message:findi("antonica")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(antonica_zones))
    elseif (e.message:findi("faydwer")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(faydwer_zones))
    elseif (e.message:findi("odus")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(odus_zones))
    elseif (e.message:findi("planar")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(planar_zones))
    elseif (e.message:findi("kunark")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(kunark_zones))
    elseif (e.message:findi("velious")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(velious_zones))
    elseif (e.message:findi("luclin")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(luclin_zones))
    elseif (e.message:findi("gates")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(god_zones))
    elseif (e.message:findi("omens")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(oow_zones))
    elseif (e.message:findi("depths")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(dodh_zones))
    elseif (e.message:findi("prophecy")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(por_zones))
    elseif (e.message:findi("serpents")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(tss_zones))
    elseif (e.message:findi("buried")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(tbs_zones))
    elseif (e.message:findi("secret")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(sof_zones))
    elseif (e.message:findi("house")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(hot_zones))
    elseif (e.message:findi("underfoot")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(uf_zones))
    elseif (e.message:findi("veil")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(voa_zones))
    elseif (e.message:findi("bind")) then
		e.other:Message(MT.Say, "Binding your soul. You will return here when you die.");
		e.self:CastSpell(2049,e.other:GetID(),0,1); -- Spell: Bind Affinity
    else
        local all_zones = {}
        merge_tables(all_zones, antonica_zones, faydwer_zones, odus_zones, kunark_zones, velious_zones, luclin_zones, planar_zones, god_zones, oow_zones, dodh_zones, por_zones, tss_zones, tbs_zones, sof_zones, hot_zones, uf_zones, voa_zones)
        for k, v in pairs(all_zones) do
            if (e.message:findi(k)) then
                if (take_money(e.other)) then
                    eq.SelfCast(v)
                else
                    e.other:Message(MT.Say, "I'm sorry, I cannot teleport you unless you have sufficient money.")
                end
                return
            end
        end

        local plat = get_money_amount(e.other)
        if plat > 0 then
            e.other:Message(MT.Say, "As a druid guildmaster, for a fee of " .. plat .. " platinum pieces, I can provide you with [" .. eq.say_link("buffs", true) .. "] or [" .. eq.say_link("bind", true) .. "] to assist you in your adventures or [" .. eq.say_link("teleport", true) .. "] you somewhere else.")
        else
            e.other:Message(MT.Say, "As a druid guildmaster, for no fee, I can provide you with [" .. eq.say_link("buffs", true) .. "] or [" .. eq.say_link("bind", true) .. "] to assist you in your adventures or [" .. eq.say_link("teleport", true) .. "] you somewhere else.")
        end
    end
end

---@param e NPCEventSay
function enchanter_buffs(e)
    if (e.message:findi("buffs")) then
        if (take_money(e.other) ~= true) then
            e.other:Message(MT.Say, "I'm sorry, I cannot buff you unless you have sufficient money.")
            return
        end
        -- Haste
        --  16 - Quickness [39]
        --  24 - Alacrity [170]
        --  29 - Augmentation [10]
        --  39 - Celerity [171] (skip)
        --  49 - Swift Like The Wind [172] (skip)
        --  53 - Anya's Quickening [1708] (skip)
        --  56 - Augment [1729]
        --  57 - Wonderous Rapidity [1709] (skip)
        --  60 - Visions of Grandeur [1710]
        if e.other:GetLevel() >= 60 then
            eq.SelfCast(1710)
        elseif e.other:GetLevel() >= 56 then
            eq.SelfCast(1729)
        elseif e.other:GetLevel() >= 29 then
            eq.SelfCast(10)
        elseif e.other:GetLevel() >= 24 then
            eq.SelfCast(170)
        elseif e.other:GetLevel() >= 16 then
            eq.SelfCast(39)
        end
        -- Clarity
        --  16 - Breeze [697] -- Kunark Only
        --  29 - Clarity [174]
        --  54 - Clarity II [1693]
        if e.other:GetLevel() >= 54 then
            eq.SelfCast(1693)
        elseif e.other:GetLevel() >= 29 then
            eq.SelfCast(174)
        elseif (e.other:GetLevel() >= 16 and eq.is_the_ruins_of_kunark_enabled()) then -- Kunark Only
            eq.SelfCast(697)
        end
        -- INT/WIS
        --  39 - Insight [175]
        --  44 - Brilliance [33]
        --  57 - Enlightenment [1688]
        if e.other:GetLevel() >= 57 then
            eq.SelfCast(1688)
        else
            if e.other:GetLevel() >= 44 then
                eq.SelfCast(33)
            end
            if e.other:GetLevel() >= 39 then
                eq.SelfCast(175)
            end
        end
        -- Mana
        --  34 - Gift of Magic [1408] -- Velious Only
        --  55 - Gift of Insight [1409] -- Velious Only
        --  60 - Gift of Brilliance [1410] -- Velious Only
        if eq.is_the_scars_of_velious_enabled() then
            if e.other:GetLevel() >= 60 then -- Velious Only
                eq.SelfCast(1410)
            elseif e.other:GetLevel() >= 55 then -- Velious Only
                eq.SelfCast(1409)
            elseif e.other:GetLevel() >= 34 then -- Velious Only
                eq.SelfCast(1408)
            end
        end
    elseif (e.message:findi("bind")) then
		e.other:Message(MT.Say, "Binding your soul. You will return here when you die.");
		e.self:CastSpell(2049,e.other:GetID(),0,1); -- Spell: Bind Affinity
    else
        local plat = get_money_amount(e.other)
        if plat > 0 then
            e.other:Message(MT.Say, "As an enchanter guildmaster, for a fee of " .. plat .. " platinum pieces, I can provide you with [" .. eq.say_link("buffs", true) .. "] or [" .. eq.say_link("bind", true) .. "] to assist you in your adventures.")
        else
            e.other:Message(MT.Say, "As a enchanter guildmaster, for no fee, I can provide you with [" .. eq.say_link("buffs", true) .. "] or [" .. eq.say_link("bind", true) .. "] to assist you in your adventures.")
        end
    end
end

---@param e NPCEventSay
function shaman_buffs(e)
    if (e.message:findi("buffs")) then
        if (take_money(e.other) ~= true) then
            e.other:Message(MT.Say, "I'm sorry, I cannot buff you unless you have sufficient money.")
            return
        end
        -- Talisman
        --  34 - Talisman of Tnarg [167]
        --  44 - Talisman of Altuna [168]
        --  55 - Talisman of Kragg [1585]
        if e.other:GetLevel() >= 55 then
            eq.SelfCast(1585)
        elseif e.other:GetLevel() >= 44 then
            eq.SelfCast(168)
        elseif e.other:GetLevel() >= 34 then
            eq.SelfCast(167)
        end
        -- AC
        --  5 - Scale Skin [274]
        --  14 - Turtle Skin [283]
        --  24 - Protect [649]
        --  34 - Shifting Shield [431]
        --  44 - Guardian [389]
        --  54 - Shroud of the Spirits [1584]
        if e.other:GetLevel() >= 54 then
            eq.SelfCast(1584)
        elseif e.other:GetLevel() >= 44 then
            eq.SelfCast(389)
        elseif e.other:GetLevel() >= 34 then
            eq.SelfCast(431)
        elseif e.other:GetLevel() >= 24 then
            eq.SelfCast(649)
        elseif e.other:GetLevel() >= 14 then
            eq.SelfCast(283)
        elseif e.other:GetLevel() >= 5 then
            eq.SelfCast(274)
        end
        -- STR
        --  1 - Strengthen [40]
        --  19 - Spirit Strength [147]
        --  29 - Raging Strength [151]
        --  39 - Furious Strength [153]
        --  49 - Strength [159]
        --  57 - Maniacal Strength [1593]
        if e.other:GetLevel() >= 57 then
            eq.SelfCast(1593)
        elseif e.other:GetLevel() >= 49 then
            eq.SelfCast(159)
        elseif e.other:GetLevel() >= 39 then
            eq.SelfCast(153)
        elseif e.other:GetLevel() >= 29 then
            eq.SelfCast(151)
        elseif e.other:GetLevel() >= 19 then
            eq.SelfCast(147)
        else
            eq.SelfCast(40)
        end
        -- STA
        --  9 - Spirit of Bear [279]
        --  14 - Spirit of Ox [149]
        --  34 - Health [161]
        --  44 - Stamina [158]
        --  54 - Riotous Health [1595]
        if e.other:GetLevel() >= 54 then
            eq.SelfCast(1595)
        elseif e.other:GetLevel() >= 44 then
            eq.SelfCast(158)
        elseif e.other:GetLevel() >= 34 then
            eq.SelfCast(161)
        elseif e.other:GetLevel() >= 14 then
            eq.SelfCast(149)
        elseif e.other:GetLevel() >= 9 then
            eq.SelfCast(279)
        end
        -- DEX
        --  1 - Dexterous Aura [266]
        --  24 - Spirit of Monkey [146]
        --  29 - Rising Dexterity [349]
        --  39 - Deftness [152]
        --  49 - Dexterity [157]
        --  58 - Mortal Deftness [1596]
        if e.other:GetLevel() >= 58 then
            eq.SelfCast(1596)
        elseif e.other:GetLevel() >= 49 then
            eq.SelfCast(157)
        elseif e.other:GetLevel() >= 39 then
            eq.SelfCast(152)
        elseif e.other:GetLevel() >= 29 then
            eq.SelfCast(349)
        elseif e.other:GetLevel() >= 24 then
            eq.SelfCast(146)
        else
            eq.SelfCast(266)
        end
        -- AGI
        --  5 - Feet like Cat [269]
        --  19 - Spirit of Cat [148]
        --  44 - Agility [154]
        --  53 - Deliriously Nimble [1594]
        if e.other:GetLevel() >= 53 then
            eq.SelfCast(1594)
        elseif e.other:GetLevel() >= 44 then
            eq.SelfCast(154)
        elseif e.other:GetLevel() >= 19 then
            eq.SelfCast(148)
        elseif e.other:GetLevel() >= 5 then
            eq.SelfCast(269)
        end
        -- CHA
        --  14 - Spirit of Snake [284]
        --  39 - Glamour [155]
        --  49 - Charisma [156]
        --  59 - Unfailing Reverence [1597]
        if e.other:GetLevel() >= 59 then
            eq.SelfCast(1597)
        elseif e.other:GetLevel() >= 49 then
            eq.SelfCast(156)
        elseif e.other:GetLevel() >= 39 then
            eq.SelfCast(155)
        elseif e.other:GetLevel() >= 14 then
            eq.SelfCast(284)
        end
        -- Haste
        --  29 - Quickness [39]
        --  44 - Alacrity [170]
        --  56 - Celerity [171]
        if e.other:GetLevel() >= 56 then
            eq.SelfCast(171)
        elseif e.other:GetLevel() >= 44 then
            eq.SelfCast(170)
        elseif e.other:GetLevel() >= 29 then
            eq.SelfCast(39)
        end
        -- Regen
        --  24 - Regeneration [144]
        --  39 - Chloroplast [145]
        --  52 - Regrowth [1568]
        if e.other:GetLevel() >= 52 then
            eq.SelfCast(1568)
        elseif e.other:GetLevel() >= 39 then
            eq.SelfCast(145)
        elseif e.other:GetLevel() >= 24 then
            eq.SelfCast(144)
        end
        -- SoW
        --  9 - Spirit of Wolf [278]
        if e.other:GetLevel() >= 9 then
            eq.SelfCast(278)
        end
        -- CR
        --  1 - Endure Cold [225]
        --  24 - Resist Cold [61]
        if e.other:GetLevel() >= 24 then
            eq.SelfCast(61)
        else
            eq.SelfCast(225)
        end
        -- FR
        --  5 - Endure Fire [224]
        --  29 - Resist Fire [60]
        if e.other:GetLevel() >= 29 then
            eq.SelfCast(60)
        elseif e.other:GetLevel() >= 5 then
            eq.SelfCast(224)
        end
        -- DR
        --  9 - Endure Disease [226]
        --  34 - Resist Disease [63]
        if e.other:GetLevel() >= 34 then
            eq.SelfCast(63)
        elseif e.other:GetLevel() >= 9 then
            eq.SelfCast(226)
        end
        -- PR
        --  14 - Endure Poison [227]
        --  39 - Resist Poison [62]
        if e.other:GetLevel() >= 39 then
            eq.SelfCast(62)
        elseif e.other:GetLevel() >= 14 then
            eq.SelfCast(227)
        end
        -- MR
        --  19 - Endure Magic [228]
        --  44 - Resist Magic [64]
        if e.other:GetLevel() >= 44 then
            eq.SelfCast(64)
        elseif e.other:GetLevel() >= 19 then
            eq.SelfCast(228)
        end
        -- HP
        --  1 - Inner Fire [267]
        --  60 - Focus of Spirit [1432] -- Velious Only
        if (e.other:GetLevel() >= 60 and eq.is_the_scars_of_velious_enabled()) then -- Velious Only
            eq.SelfCast(1432)
        else
            eq.SelfCast(267)
        end
    elseif (e.message:findi("bind")) then
		e.other:Message(MT.Say, "Binding your soul. You will return here when you die.");
		e.self:CastSpell(2049,e.other:GetID(),0,1); -- Spell: Bind Affinity
    else
        local plat = get_money_amount(e.other)
        if plat > 0 then
            e.other:Message(MT.Say, "As a shaman guildmaster, for a fee of " .. plat .. " platinum pieces, I can provide you with [" .. eq.say_link("buffs", true) .. "] or [" .. eq.say_link("bind", true) .. "] to assist you in your adventures.")
        else
            e.other:Message(MT.Say, "As a shaman guildmaster, for no fee, I can provide you with [" .. eq.say_link("buffs", true) .. "] or [" .. eq.say_link("bind", true) .. "] to assist you in your adventures.")
        end
    end
end

---@param e NPCEventSay
function wizard_ports(e)
    local antonica_zones = {}
    antonica_zones["Cazic Thule"] = 546
    antonica_zones["Nektulos Forest"] = 545
    antonica_zones["North Ro"] = 547
    antonica_zones["Western Commonlands"] = 544
    antonica_zones["Western Karana"] = 548
    local faydwer_zones = {}
    faydwer_zones["Greater Faydark"] = 543
    local odus_zones = {}
    odus_zones["Toxxulia Forest"] = 541
    local planar_zones = {}
    planar_zones["Plane of Hate"] = 666
    planar_zones["Plane of Sky"] = 674
    local kunark_zones = {} -- Kunark Only
    if (eq.is_the_ruins_of_kunark_enabled()) then
        kunark_zones["Dreadlands"] = 1325
        kunark_zones["Emerald Jungle"] = 1739
        kunark_zones["Skyfire Mountains"] = 1738
    end
    local velious_zones = {} -- Velious Only
    if (eq.is_the_scars_of_velious_enabled()) then
        velious_zones["Cobalt Scar"] = 2028
        velious_zones["Iceclad Ocean"] = 1417
        velious_zones["The Great Divide"] = 2026
        velious_zones["Wakening Lands"] = 2027
    end

    local luclin_zones = {} -- Luclin Only
    if (eq.is_the_shadows_of_luclin_enabled()) then
        luclin_zones["Grimling Forest"] = 2418
        luclin_zones["Twilight Sea"] = 2423
        luclin_zones["Dawnshroud Peaks"] = 2428
        luclin_zones["Nexus"] = 2945
    end

    if (eq.is_the_planes_of_power_enabled()) then
        planar_zones["Plane of Knowledge"] = 3183
    end


    local god_zones = {} -- Gates of Discord Only
    if (eq.is_gates_of_discord_enabled()) then
        god_zones["Natimbi"] = 4963
        god_zones["Barindu"] = 5734
    end

    local oow_zones = {} -- Omens of War Only
    if (eq.is_omens_of_war_enabled()) then
        oow_zones["Bloodfields"] = 6181
        oow_zones["Wall of Slaughter"] = 6176
    end

    local dodh_zones = {} -- Depths of Darkhollow Only
    if (eq.is_depths_of_darkhollow_enabled()) then
        dodh_zones["Undershore"] = 8238
    end

    local por_zones = {} -- Prophecy of Ro Only
    if (eq.is_prophecy_of_ro_enabled()) then
        por_zones["Arcstone"] = 8968
    end

    local tss_zones = {} -- The Serpent's Spine Only
    if (eq.is_the_serpents_spine_enabled()) then
        tss_zones["Icefall Glacier"] = 10876
        tss_zones["Sunderock Springs"] = 10879
        tss_zones["Blightfire Moores"] = 10882
    end

    local tbs_zones = {} -- The Buried Sea Only
    if (eq.is_the_buried_sea_enabled()) then
        tbs_zones["Katta Castrum"] = 11985
    end

    local sof_zones = {} -- Secrets of Faydwer Only
    if (eq.is_secrets_of_faydwer_enabled()) then
        sof_zones["Dragonscale Hills"] = 15891
    end

    local hot_zones = {} -- House of Thule Only
    if (eq.is_house_of_thule_enabled()) then
        hot_zones["Grounds"] = 17885
    end

    if (e.message:findi("teleport")) then
        e.other:Message(MT.Say, "I can teleport you to the following continents: " .. build_say_links(continents))
    elseif (e.message:findi("antonica")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(antonica_zones))
    elseif (e.message:findi("faydwer")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(faydwer_zones))
    elseif (e.message:findi("odus")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(odus_zones))
    elseif (e.message:findi("planar")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(planar_zones))
    elseif (e.message:findi("kunark")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(kunark_zones))
    elseif (e.message:findi("velious")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(velious_zones))
    elseif (e.message:findi("luclin")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(luclin_zones))
    elseif (e.message:findi("gates")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(god_zones))
    elseif (e.message:findi("omens")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(oow_zones))
    elseif (e.message:findi("depths")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(dodh_zones))
    elseif (e.message:findi("prophecy")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(por_zones))
    elseif (e.message:findi("serpents")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(tss_zones))
    elseif (e.message:findi("buried")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(tbs_zones))
    elseif (e.message:findi("secret")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(sof_zones))
    elseif (e.message:findi("house")) then
        e.other:Message(MT.Say, "I can teleport you to the following zones: " .. build_say_links(hot_zones))
    elseif (e.message:findi("bind")) then
		e.other:Message(MT.Say, "Binding your soul. You will return here when you die.");
		e.self:CastSpell(2049,e.other:GetID(),0,1); -- Spell: Bind Affinity
    else
        local all_zones = {}
        merge_tables(all_zones, antonica_zones, faydwer_zones, odus_zones, planar_zones, kunark_zones, velious_zones, luclin_zones, god_zones, oow_zones, dodh_zones, por_zones, tss_zones, tbs_zones, sof_zones, hot_zones)
        for k, v in pairs(all_zones) do
            if (e.message:findi(k)) then
                if k == "Plane of Hate" or k == "Plane of Sky" then
                    if (e.other:GetLevel() < 46) then
                        e.other:Message(MT.Say, "I'm sorry, I cannot teleport you unless you are level 46 or higher.")
                        return
                    end
                    if e.other:IsGrouped() then
                        e.other:Message(MT.Say, "I'm sorry, I cannot teleport you unless you are not in a group.")
                        return
                    end
                end
                if (take_money(e.other)) then
                    eq.SelfCast(v)
                    return
                end
                e.other:Message(MT.Say, "I'm sorry, I cannot teleport you unless you have sufficient money.")
                return
            end
        end

        local plat = get_money_amount(e.other)
        if plat > 0 then
            e.other:Message(MT.Say, "As a wizard guildmaster, for a fee of " .. plat .. " platinum pieces, I can [" .. eq.say_link("teleport", true) .. "] or [" .. eq.say_link("bind", true) .. "] you.")
        else
            e.other:Message(MT.Say, "As a wizard guildmaster, for no fee, I can [" .. eq.say_link("teleport", true) .. "] or [" .. eq.say_link("bind", true) .. "] you.")
        end
    end
end

-- Helper functions
function pairs_by_keys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
    end
    return iter
end

function merge_tables (t1, ...)
    for i,v in ipairs(arg) do
        for k, v in pairs(v) do
            t1[k] = v
        end
    end
end

function build_say_links(t)
    local buff_links = ""
    for k, v in pairs_by_keys(t) do
        buff_links = buff_links .. "[" .. eq.say_link(k) .. "] "
    end

    return buff_links
end
