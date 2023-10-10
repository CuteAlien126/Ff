using HorizonSideRobots
r=Robot(animate=true)
inverse(s::HorizonSide)=HorizonSide(mod(Int(s)+2,4))
inverse3(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+3,4))

function mark_per_2(r::Robot)
    kol_sud,kol_west=bot_left_kol!(r)
    for Side in (Nord,Ost,Sud,West)
        per_pl!(r,Side)
    end
    find_border!(r,Ost)
    for Side in (Nord,West,Sud,Ost)
        per_pl_2!(r,Side)
    end
    bot_left_kol!(r)
    back!(r,kol_sud,kol_west)
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

function per_pl!(r,Side)
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
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

function per_pl_2!(r::Robot,Side::HorizonSide)
    while isborder(r,Side)
        putmarker!(r)
        move!(r,inverse3(Side))
    end
    putmarker!(r)
    move!(r,Side)  
end

function back!(r,kolsnord,kolsost)
    for x in range(0,kolsnord-1)
        move!(r, Nord)
    end
    for x in range(0,kolsost-1)
        move!(r,Ost)
    end
end

mark_per_2(r)