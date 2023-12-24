using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function kol_per!(r)
    W,S =kol_numsteps!(r, West), kol_numsteps!(r, Sud)
    if !isborder(r, Nord)
        move!(r, Nord)
    else
        return 0
    end
    s=snake!(r)
    kol_numsteps!(r,Nord,S)
    kol_numsteps!(r,Ost,W)
    return s
end

function kol_numsteps!(r, Side)::Int
    kol=0
    while !isborder(r, Side)
        move!(r, Side)
        kol+=1
    end
    return kol
end

function snake!(r)
    kol=0
    Side=Ost
    while !isborder(r,Nord)
        x=state_numsteps!(r,Side)
        move!(r, Nord)
        Side=inverse(Side)
        kol+=x
    end
    n+=state_numsteps!(r, Side)
    return kol
end

function state_numsteps!(r, Side)
    x=0
    y=0
    while !isborder(r, Side)
        if isborder(r, Sud)
            y=1
        else
            x+=y
            y=0
        end
        move!(r, Side)
    end
    x+=y
    return x
end

kol_per!(r)
