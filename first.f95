!trying out fortran
program bookanalysis
implicit none
character(1024) :: buffer
character(50), dimension(53, 9) :: data_array
character(10) :: date_added, date_read
integer, dimension(3) :: date1, date2
integer :: day1, day2, i, j, pos, pos2, pages_read
integer, dimension(12) :: days_in_month
real :: read_speed

days_in_month = (/31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31/)

open(10, file="books2016.csv")
open(11, file="fictionbooksreadbyday.csv")
open(12, file="nonfictionbooksreadbyday.csv")
open(13, file="technicalbooksreadbyday.csv")

read(10, *) !header

do i = 1, 52
  	
	read(10,"(A)") buffer
 	do j = 1,9
		pos = index(buffer, ',')
        if(pos == 0) then
	   		pos = LEN(buffer)
		end if
        data_array(i, j) =  buffer( : pos)
        buffer = buffer(pos + 1: )
	end do

	date_added = data_array(i, 8)
    date_read = data_array(i, 7)

	print *, date_added
    print *, date_read

	do j = 1,2
		pos = index(date_added, '/')
        read(date_added( : pos - 1),*)date1(j)
        date_added = date_added(pos + 1: )
        
        pos2 = index(date_read, '/')
        read(date_read( : pos2 - 1),*)date2(j)
        date_read = date_read(pos2 + 1: )
    end do 

    ! calculate length in days 
  	day1 = date1(1)
    day2 = date2(1)

    do j = 1, (date1(2) - 1)
		day1 = day1 + days_in_month(j)
    end do

    do j = 1, (date2(2) - 1)
		day2 = day2 + days_in_month(j)
    end do

	read(data_array(i, 4),*)pages_read

    print *, day1, ",", day2, ",", pages_read
    
    read_speed = pages_read / (1  + day2 - day1)

	if("Fiction" == trim(data_array(i,9))) then
		write(11,*) day2, ",", read_speed
    else if("Technical" == trim(data_array(i,9))) then
      	write(13,*) day2, ",", read_speed
	else
		write(12,*) day2, ",", read_speed    	
    end if
end do

close(10)
close(11)
close(12)
close(13)

end program bookanalysis

!http://www.moreisdifferent.com/2015/07/16/why-physicsts-still-use-fortran/
!http://www.fortrantutorial.com/