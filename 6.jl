using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide) = HorizonSide(mod(Int(Side)+2,4)) 
right(Side::HorizonSide) = HorizonSide(mod(Int(Side)+1,4)) 
left(Side::HorizonSide ) = HorizonSide(mod(Int(Side)-1,4)) 

function per_pl!(r::Robot)
    kol_sud,kol_west=bot_left_kol!(r)
    for Side in (Nord,Ost,Sud,West)
        perimetr!(r,Side)
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

function perimetr!(r::Robot,Side::HorizonSide)
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
    end
    putmarker!(r)
end

function back!(r,kolsnord,kolsost)
    for x in range(0,kolsnord-1)
        move!(r, Nord)
    end
    for x in range(0,kolsost-1)
        move!(r,Ost)
    end
end

per_pl!(r)
