using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+2,4))
right(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+1, 4))

function two_per!(r)
    kol_sud,kol_west=bot_left_kol!(r)
    for Side in (Nord,Ost,Sud,West)
        first_per!(r,Side)
    end
    find_border!(r,Ost)
    for Side in (Nord,Ost,Sud,West)
        second_per!(r,Side)
        putmarker!(r)
        move!(r,Side)
    end
    bot_left_kol!(r)
    return!(r,kol_sud,kol_west)
end

function first_per!(r,Side)::Nothing
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
    end
end

function second_per!(r,Side)
    while isborder(r,Side)
        putmarker!(r)
        move!(r,right(Side))
    end
end

function find_border!(r::Robot,Side)
    while find_in_row!(r,Side)==false
        move!(r,Nord)
        Side=inverse(Side)
    end
end

function find_in_row!(r::Robot,Side::HorizonSide)
    while !isborder(r,Nord) && !isborder(r,Side)
        move!(r,Side)
    end
    return isborder(r,Nord)
end

function bot_left_kol!(r::Robot)
    kol_sud=kol_west=0
    while !isborder(r,Sud) || !isborder(r,West)
        kol_sud+=move_!border!(r,Sud)
        kol_west+=move_!border!(r,West)
    end
    return(kol_sud,kol_west)
end

function move_!border!(r::Robot, Side::HorizonSide)
    kol=0
    while !isborder(r,Side)
        move!(r,Side)
        kol+=1
    end
    return kol
end

function return!(r,kolsnord,kolsost)
    for x in 1:kolsnord
        move!(r,Nord)
    end
    for x in 1:kolsost
        move!(r,Ost)
    end
end

two_per!(r)


