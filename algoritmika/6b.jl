using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function four_pos_per!(r)
    state, S, W=move_angle_kol!(r, Sud, West)
    osnov_dvij!(r, Sud, S, West, W)
    move_angle!(r,Sud,West)
    back!(r,Nord,Ost,state)
end

function move_angle_kol!(r, Side1, Side2)
    state=""
    n1,n2=0,0
    while !(isborder(r, Side1) & isborder(r, Side2))
        if !isborder(r, Side1)
            move!(r, Side1)
            state=state* "0" 
            n1+=1
        end    
        if !isborder(r, Side2)
            move!(r, Side2) 
            state=state*"1"
            n2+=1
        end  
    end 
    return state, n1, n2
end

function move_angle!(r, Side1, Side2)
    while !(isborder(r, Side1) & isborder(r, Side2))
        if !isborder(r, Side1)
            move!(r, Side1)
        end    
        if !isborder(r, Side2)
            move!(r, Side2) 
        end  
    end 
end

function osnov_dvij!(r, Side1, n1, Side2, n2)
    for x in [Side2, inverse(Side2)]
        move_angle!(r, Side1, x)
        return!(r, inverse(Side1), n1)
        putmarker!(r)
    end
    for x in [Side1, inverse(Side1)]
        move_angle!(r, Side2, x)
        return!(r, inverse(Side2), n2)
        putmarker!(r)
    end
end

function return!(r, Side, n)
    for x in 1:n
        move!(r, Side)
    end
end

function back!(r, Side1, Side2, state::String)
    state= reverse(state)
    for x in state
        if x=='0'
            move!(r, Side1)
        else
            move!(r, Side2)
        end
    end
end

four_pos_per!(r)

