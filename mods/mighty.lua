
---@param e ModCheckHitChance
function CheckHitChance(e)

    local multiplier = 1

    local is_good = false
    local ally = e.self
    local enemy = e.other
    if not ally.valid then
        return e
    end
    if not enemy.valid then
        return e
    end
    if not ally:IsClient() then
        if ally:HasOwner() and ally:GetOwner():IsClient() then
            ally = ally:GetOwner() -- pet
        else
            is_good = true
            ally = e.other
            enemy = e.self
            if not ally:IsClient() then
                if not ally:HasOwner() then
                    return e
                end
                if not ally:GetOwner():IsClient() then
                    return e
                end
                ally = ally:GetOwner() -- pet
            end
        end
    end


    local mighty = ally:GetBucket("boost_mighty")
    if mighty == "ON" then
        if is_good then
            multiplier = 2
            -- if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
            --     multiplier = 20
            --
        else
            multiplier = 0.5
            if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
                 multiplier = 0.5
            end
            if e.hit.skill == 10 then -- bash
                eq.debug("Bash")
                multiplier = 0.1
            end
        end
    end



    local is_debug = ally:GetBucket("mighty_debug")


    local ohit = e.hit.tohit
    -- local obase_damage = e.hit.base_damage
    -- local obase_damage_done = e.hit.damage_done

    e.hit.tohit = e.hit.tohit * multiplier
    -- e.hit.base_damage = e.hit.base_damage * multiplier
    -- e.hit.damage_done = e.hit.damage_done * multiplier
    -- if obase_damage_done > 0 and e.hit.damage_done < 1 then
    --     e.hit.damage_done = 1
    -- end

    if not is_debug or is_debug ~= "ON" then
        return e
    end

    if is_good then
        --- ally:Message(MT.OtherHitsYou, string.format("Outgoing mighty hit (%d * %0.1f) = %d, dmg (%d * %0.1f) = %d, dmg_done (%d * %0.1f) = %d", ohit, multiplier, e.hit.tohit,  obase_damage, multiplier, e.hit.base_damage, obase_damage_done, multiplier, e.hit.damage_done))
        ally:Message(MT.OtherHitsYou, string.format("Outgoing mighty hit (%d * %0.1f) = %d", ohit, multiplier, e.hit.tohit))
        return e
    end
    ---ally:Message(MT.OtherHitsYou, string.format("Incoming mighty hit (%d * %0.1f) = %d, dmg (%d * %0.1f) = %d, dmg_done (%d * %0.1f) = %d", ohit, multiplier, e.hit.tohit,  obase_damage, multiplier, e.hit.base_damage, obase_damage_done, multiplier, e.hit.damage_done))
    ally:Message(MT.OtherHitsYou, string.format("Incoming mighty hit (%d * %0.1f) = %d", ohit, multiplier, e.hit.tohit))
    return e
end

---@param e ModHealDamage
function HealDamage(e)
    local multiplier = 1

    local ally = e.self:CastToClient()
    if not ally.valid or not ally:IsClient() then
        if ally:HasOwner() and ally:GetOwner():IsClient() then
            ally = ally:GetOwner():CastToClient() -- pet
        end
    end
    if not ally.valid then
        return e
    end

    local mighty = ally:GetBucket("boost_mighty")
    if mighty == "ON" then
        multiplier = 2
    end

    local spell_name = "unknown"

    local spell = eq.get_spell(e.spell_id)
    if spell then
        spell_name = spell:Name()
    end

    if eq.is_lifetap_spell(e.spell_id) then
        multiplier = 1
    end
    if e.spell_id == 65535 then
        multiplier = 1
    end

    local is_debug = ally:GetBucket("mighty_debug")

    e.return_value = e.value * multiplier
    if not is_debug or is_debug ~= "ON" then
        return e
    end

    ally:Message(MT.Spells, string.format("Incoming mighty heal %s (%d * %0.1f) = %d", spell_name, e.value, multiplier, e.return_value))
    return e
end

---@param e ModCommonDamage
function CommonDamage(e)
    local multiplier = 1

    local dt_spells = {
        982, -- cazic touch
        1948, -- Destroy
        2156, -- Deadly Curse of Noqufiel
        7599, -- Gargoyle Glance
        8436, -- Touch of Terror
        8999, -- Runic Backlash
        9019, -- Backlash of Rage
        9272, -- Avalanche's Torrent of Ice
        9273, -- Glacial Assault
        9376, -- Touch of the Phantom Effect
        12465, -- Infinite Pain
        13031, -- Boom
        13318, -- Harvest Fungus Patch Doom
        17816, -- Scalding Steam Blast
        17832, -- Whirring Copter Blades
        21761, -- Focused Rage
        27522, -- Barrier of Insanity
        27939, -- Battle Orb Explosion
        32450, -- Soul Shatter
        32531, -- Corruptive Crud Direct Damage
        32974, -- Stab of Chaos
        37550, -- Icerain Explosion
        39055, -- Frozen Dread
        39066, -- Fright Force II
        39083, -- Cazic's Displeasure
        39103, -- Eruption
        39180, -- Death Touch
        39224, -- Cold Shock
        42046, -- Bleeding Out
        42049, -- Dehydrated
        42050, -- Demoralized
        42071, -- Raging Tempest
        42161, -- Blazebeam
    }

    for _, v in pairs(dt_spells) do
        if e.spell_id == v and e.self:IsClient() then
            e.self:Message(MT.Say, string.format("%s just tried to death touch you, but jamfest nerfed it to 100 damage.", e.attacker:GetCleanName()));
            e.return_value = 100
            e.ignore_default = true
            return e
        end
    end



    if e.value < 0 then
        return e
    end
    local is_good = false
    local ally = e.self
    local enemy = e.attacker
    if not ally.valid then
        return e
    end
    if not enemy.valid then
        return e
    end
    if not ally:IsClient() then
        if ally:HasOwner() and ally:GetOwner():IsClient() then
            ally = ally:GetOwner() -- pet
        else
            is_good = true
            ally = e.attacker
            enemy = e.self
            if not ally:IsClient() then
                if not ally:HasOwner() then
                    return e
                end
                if not ally:GetOwner():IsClient() then
                    return e
                end
                ally = ally:GetOwner() -- pet
            end
        end
    end
    if not enemy:IsNPC() then
        return e
    end

    local mighty = ally:GetBucket("boost_mighty")
    if mighty == "ON" then
        if is_good then
            multiplier = 2
            if enemy:GetLevel() >= 40 then
                multiplier = 3
            end
            if enemy:GetLevel() >= 50 then
                multiplier = 4
            end
            if enemy:GetLevel() >= 60 then
                multiplier = 5
            end

            if enemy:GetLevel() >= 70 then
                multiplier = 6
            end

            if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
                multiplier = 12
                if enemy:GetLevel() >= 60 then
                    multiplier = 24
                end
            end
        else
            multiplier = 0.4
            if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
                multiplier = 0.3
            end
        end
    end

    local is_debug = ally:GetBucket("mighty_debug")

    e.return_value = e.value * multiplier
    e.ignore_default = true

    if not is_debug or is_debug ~= "ON" then
        return e
    end

    if is_good then
        ally:Message(MT.Spells, string.format("Outgoing mighty damage (%d * %0.1f) = %d", e.value, multiplier, e.return_value))
        return e
    end
    ally:Message(MT.Spells, string.format("Incoming mighty damage (%d * %0.1f) = %d", e.value, multiplier, e.return_value))
    return e
end

---@param e ModResistSpellRoll
function ResistSpellRoll(e)
    local is_good = false
    local ally = e.self
    local enemy = e.caster
    if not ally.valid then
        return e
    end
    if not enemy.valid then
        return e
    end
    if not ally:IsClient() then
        if ally:HasOwner() and ally:GetOwner():IsClient() then
            ally = ally:GetOwner() -- pet
        else
            is_good = true
            ally = e.caster
            enemy = e.self
            if not ally:IsClient() then
                if not ally:HasOwner() then
                    return e
                end
                if not ally:GetOwner():IsClient() then
                    return e
                end
                ally = ally:GetOwner() -- pet
            end
        end
    end


    local multiplier = 1
    local mighty = ally:GetBucket("boost_mighty")
    if mighty == "ON" then
        if is_good then
            if enemy:IsNPC() then
                --multiplier = 2
                multiplier = 1
                if enemy:CastToNPC():IsRaidTarget() then
                    --multiplier = 4
                end
            end
        else
            multiplier = 0.4
            if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
                multiplier = 0.3
            end
        end
    end

    local is_debug = ally:GetBucket("mighty_debug")

    e.return_value = e.roll * multiplier
    e.ignore_default = true
    if e.return_value > e.roll_max then
        e.return_value = e.roll_max
    end


    if not is_debug or is_debug ~= "ON" then
        return e
    end

    local context = "resist"
    local is_overrode = false
    local overrode_text = ""
    if not is_good and e.return_value > e.resist_chance then
        local roll = math.random(1, 100)

        local chance = 50

        local resists = {}
        resists[3] = "snare resist"
        resists[11] = "slow resist"
        --resists[15] = "mana drain resist"
        resists[20] = "blind resist"
        resists[21] = "stun resist"
        resists[22] = "charm resist"
        resists[23] = "fear resist"
        resists[27] = "cancel magic resist"
        resists[31] = "mez resist"
        resists[35] = "disease resist"
        resists[36] = "poison resist"
        resists[64] = "spin resist"
        resists[96] = "silence resist"
        resists[99] = "root resist"
        resists[209] = "dispel beneficial resist"
        resists[380] = "knockback resist"
        resists[502] = "fearstun resist"

        local spell = eq.get_spell(e.spell_id)
        if spell then

            for i = 1, 12 do
                for effect_id, effect_name in pairs(resists) do
                    if spell:EffectID(i) == effect_id then
                        context = effect_name
                        eq.debug(effect_name)
                        chance = 90
                    end
                end
            end
        end

        if roll <= chance then
            is_overrode = true
            overrode_text = string.format(", overrode to %d", e.resist_chance)
        end
    end


    local banish_spells = {
        853, --	Burning Touch II
        854, --	Burning Touch
        788, --	Reality Warp
        866, --	Verdict of the Tribunal
        1087, --	Mechinetic Dislocation I
        1088, --	Mechinetic Dislocation II
        1089, --	Mechinetic Dislocation III
        1090, --	Mechinetic Dislocation IV
        1091, --	Mechinetic Dislocation V
        1092, --	Mechinetic Dislocation VI
        1093, --	Mechinetic Dislocation VII
        1094, --	Mechinetic Dislocation VIII
        1095, --	Mechinetic Dislocation IX
        1096, --	Mechinetic Dislocation X
        1124, --	Penance of Flame
        1125, --	Penance of the Whip
        1127, --	Penance of Execution
        1128, --	Penance of Stone
        1129, --	Penance of Torture
        1164, --	Crusader's Banishment
        1476, --	The Dain's Justice
    }

    for _, v in pairs(banish_spells) do
        if e.spell_id == v and e.self:IsClient() then
            e.self:Message(MT.Spells, string.format("%s just tried to banish you, but jamfest resisted it.", e.caster:GetCleanName()));
            e.return_value = e.resist_chance
            e.ignore_default = true
            return e
        end
    end


    local landed = "landed"
    if e.return_value < e.resist_chance or is_overrode then
        landed = "resisted"
    end

    if is_good then
        ally:Message(MT.Spells, string.format("Outgoing mighty resist (%d * %0.1f) = %d%s vs %d (%s)", e.roll, multiplier, e.return_value, overrode_text, e.resist_chance, landed))
        if is_overrode then
            e.return_value = e.resist_chance
        end
        return e
    end
    ally:Message(MT.Spells, string.format("Incoming mighty %s (%d * %0.1f) = %d%s vs %d (%s)", context, e.roll, multiplier, e.return_value, overrode_text, e.resist_chance, landed))
    if is_overrode then
        e.return_value = e.resist_chance
    end
    return e
end
