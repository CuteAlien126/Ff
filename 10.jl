using HorizonSideRobots
r=Robot(animate=true)

function chess_marker_n(r, n)
    sud_steps=num_steps_along!(r,Sud)
    west_steps=num_steps_along!(r,West)
    count=0
    flag=1
    flag_height=1
    flag_end=0
    while true
        for i in 1:n
            count = 0
            flag=flag_height
            while !isborder(r,Ost)
                if count<n && flag==1
                    putmarker!(r)
                end
                move!(r, Ost)

                count+=1

                if count==n
                    if flag==1
                        flag=0
                    else
                        flag=1
                    end
                    count=0
                end
            end
            if isborder(r,Ost) && flag==1
                putmarker!(r)
            end
            num_steps_along!(r,West)

            if isborder(r, Nord)
                flag_end=1
                break
            end

            move!(r, Nord)
        end
        if flag_end == 1
            break
        end
        if flag_height == 1
            flag_height = 0
        else
            flag_height = 1
        end
    end

    num_steps_along!(r, Sud)
    num_steps_along!(r, West)
    along!(r, Nord, sud_steps)
    along!(r, Ost, west_steps)
end

function num_steps_along!(r, direct)::Int
    num_steps = 0
    while !isborder(r, direct)
        move!(r, direct)
        num_steps += 1
    end
    return num_steps
end

function along!(r, direct, num_steps)::Nothing
    for x in 1:num_steps
        move!(r, direct)
    end
end

chess_marker_n(r, 2)