using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function mark_kross_x!(r)
    for Side in ((Nord,West),(Nord,Ost),(Sud,West),(Sud,Ost))
        kols=0
        while !isborder_2(r,Side)
            kols+=mark_and_numsteps!(r,Side)
        end
        putmarker!(r)
        back!(r,Side::Tuple,kols)
    end
end

function back!(robot,Sides::Tuple,kols)
    for x in range(0,kols-1)
        for Side in Sides
            move!(r,inverse(Side))
        end
    end
end

function mark_and_numsteps!(r,Sides::Tuple)
    num_steps=0
    putmarker!(r)
    for Side in Sides
        move!(r,Side)
        num_steps+=1
    end
    return num_steps//2
end

function isborder_2(r,Sides::Tuple)
    Side1, Side2=Sides
    if (isborder(r,Side1)==0)&&(isborder(r,Side2)==0)
        return false
    else
        return true
    end
end

mark_kross_x!(r)
