local mighty_multiplier = {}

---@param ally Client
---@param enemy NPC
---@return string, number
function mighty_multiplier.good_damage_bonus(ally, enemy)
    local multiplier = 1
    local mighty = ally:GetBucket("boost_mighty")
    local mighty_solo = ally:GetBucket("boost_mighty_solo")
    if mighty ~= "ON" then
        if mighty_solo ~= "ON" then
            return "1x (normal)", multiplier
        end
    end
    local msg = ""

    if mighty == "ON" then
        multiplier = 2
        msg = "2x (normal)"

        if enemy:GetLevel() >= 40 then
            multiplier = 4
            msg = "4x (>40)"
        end
        if enemy:GetLevel() >= 50 then
            multiplier = 6
            msg = "6x (>50)"
        end
        if enemy:GetLevel() >= 60 then
            multiplier = 8
            msg = "8x (>60)"
        end

        if enemy:GetLevel() >= 70 then
            multiplier = 10
            msg = "10x (>70)"
        end

        if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
            multiplier = 12
            msg = "12x (raid)"
            if enemy:GetLevel() >= 60 then
                multiplier = 24
                msg = "24x (raid >60)"
            end
        end
    end


    if mighty_solo == "ON" then
        if msg ~= "" then
            msg = msg .. " + "
        end
        local scale_multi = enemy:GetMaxHP()/3300
        msg = string.format("%s%d/%d=%.2fx (solo scale) = %0.2fx total", msg, enemy:GetMaxHP(), 3300, scale_multi, multiplier + scale_multi)
        multiplier = multiplier + scale_multi
    end

    return msg, multiplier
end

---@param ally Client
---@param enemy NPC
---@return string, number
function mighty_multiplier.bad_damage_penalty(ally, enemy)
    local multiplier = 1
    local mighty = ally:GetBucket("boost_mighty")
    local mighty_solo = ally:GetBucket("boost_mighty_solo")
    local msg = "1.0 (normal)"
    if mighty ~= "ON" then
        if mighty_solo ~= "ON" then
            return msg, multiplier
        end
    end

    if mighty == "ON" then
        multiplier = 0.4
        msg = "0.4x (normal)"

        if enemy:IsNPC() and enemy:CastToNPC():IsRaidTarget() then
            multiplier = 0.3
            msg = "0.3x (raid)"
        end
    end

    if mighty_solo == "ON" then
        if msg ~= "" then
            msg = msg .. " - "
        end
        local scale_multi = multiplier / 2
        msg = string.format("%s%.2fx (solo scale) = %0.2fx total", msg, scale_multi, multiplier - scale_multi)
        multiplier = multiplier - scale_multi
    end

    return msg, multiplier
end

return mighty_multiplier
