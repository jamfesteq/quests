
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

    if not enemy:IsNPC() then
        return e
    end

    local mighty = ally:GetBucket("boost_mighty")
    if mighty == "ON" then
        if is_good then
            multiplier = 2
            -- if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
            --     multiplier = 20
            -- end
        else
            multiplier = 0.5
            if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
                 multiplier = 0.5
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

    local is_debug = ally:GetBucket("mighty_debug")

    e.return_value = e.value * multiplier
    if not is_debug or is_debug ~= "ON" then
        return e
    end

    ally:Message(MT.Spells, string.format("Outgoing mighty (%d * %0.1f) = %d", e.value, multiplier, e.return_value))
    return e
end


---@param e ModCommonDamage
function CommonDamage(e)
    local multiplier = 1


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
            if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
                multiplier = 20
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

    if not is_debug or is_debug ~= "ON" then
        return e
    end

    if is_good then
        ally:Message(MT.Spells, string.format("Outgoing mighty (%d * %0.1f) = %d", e.value, multiplier, e.return_value))
        return e
    end
    ally:Message(MT.Spells, string.format("Incoming mighty (%d * %0.1f) = %d", e.value, multiplier, e.return_value))
    return e
end
